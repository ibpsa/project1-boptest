import sys
import json
import os
import shutil
import tarfile
import time
import uuid
from datetime import datetime
import boto3
import pytz
import redis
import numpy as np
from pymongo import MongoClient
import requests
from boptest.lib.testcase import TestCase


class Job:
    def __init__(self, parameters):
        self.key = parameters.get('key')
        self.testcaseid = parameters.get('testcaseid')
        self.testid = parameters.get('testid')
        self.keep_running = True

        self.s3 = boto3.resource('s3', region_name='us-east-1', endpoint_url=os.environ['S3_URL'])
        self.redis = redis.Redis(host=os.environ['REDIS_HOST'])
        self.redis_pubsub = self.redis.pubsub()

        # Initiate Mongo Database
        mongo_client = MongoClient(os.environ['MONGO_URL'])
        self.mongo_db = mongo_client[os.environ['MONGO_DB_NAME']]
        self.mongo_db_sims = self.mongo_db.sims

        # Download the testcase FMU
        self.test_dir = os.path.join('/simulate', self.testcaseid)
        self.fmu_path = os.path.join(self.test_dir, 'model.fmu')

        if not os.path.exists(self.test_dir):
            os.makedirs(self.test_dir)

        self.s3_bucket = self.s3.Bucket('alfalfa')
        self.s3_bucket.download_file(self.key, self.fmu_path)

        self.tc = TestCase(self.fmu_path)

        # subscribe to channels related to this test
        self.redis_pubsub.psubscribe(str(self.testid) + "*")
        self.message_handlers = {}
        self.register_message_handler('initialize', self.initialize)
        self.register_message_handler('advance', self.advance)
        self.register_message_handler('get_results', self.get_results)
        self.register_message_handler('get_kpis', self.get_kpis)
        self.register_message_handler('get_scenario', self.get_scenario)
        self.register_message_handler('set_scenario', self.set_scenario)
        self.register_message_handler('get_forecast_parameters', self.get_forecast_parameters)
        self.register_message_handler('set_forecast_parameters', self.set_forecast_parameters)
        self.register_message_handler('get_forecast', self.get_forecast)
        self.register_message_handler('get_step', self.get_step)
        self.register_message_handler('set_step', self.set_step)
        self.register_message_handler('stop', self.stop)

        self.init_sim_status()

    # This is the main Job entry point
    def run(self):
        while self.keep_running:
            message = self.handle_messages()

        self.cleanup()

    # Begin methods for message passing between web and worker ###
    # See comment in web/server/src/controllers/just-in-time-data.js
    # for a description of how messages between web and worker are designed
    def get_request_channel(self, message_type):
        return (self.testid + ":" + message_type + ":request")

    def get_response_channel(self, message_type):
        return (self.testid + ":" + message_type + ":response")

    def register_message_handler(self, name, callback):
        request_channel = self.get_request_channel(name)
        self.redis_pubsub.subscribe(request_channel)
        self.message_handlers[request_channel] = {
            'name': name,
            'callback': callback
        }

    def handle_messages(self):
        message = self.redis_pubsub.get_message()
        if message:
            message_type = message['type']
            if message_type == 'message':
                request_channel = message['channel']
                handler = self.message_handlers.get(request_channel)
                if handler:
                    name = handler['name']
                    params = json.loads(message['data'])
                    callback = handler['callback']
                    response_channel = self.get_response_channel(name)
                    response_data = callback(params)
                    self.redis.hset(self.testid, name, json.dumps(response_data))
                    self.redis.publish(response_channel, 'ready')
        return message
    # End methods for message passing

    # Begin message handling methods
    # These are called when a message is received,
    # See Job::register_message_handler
    def initialize(self, params):
        start_time = params.get('start_time')
        warmup_period = params.get('warmup_period')
        end_time = params.get('end_time')

        start_time = float(start_time) if start_time else 0.0
        warmup_period = float(warmup_period) if warmup_period else 0.0
        end_time = float(end_time) if end_time else np.inf
        return self.tc.initialize(start_time, warmup_period, end_time)

    def get_results(self, params):
        point_name = params['point_name']
        results_start_time = float(params['start_time'])
        results_final_time = float(params['final_time'])

        results = self.tc.get_results(point_name, results_start_time, results_final_time)
        for key in results:
            results[key] = results[key].tolist()
        return results

    def get_kpis(self, params):
        return self.tc.get_kpis()

    def get_scenario(self, params):
        return self.tc.get_scenario()

    def set_scenario(self, params):
        scenario = params['scenario']
        return self.tc.set_scenario(scenario)

    def get_forecast_parameters(self, params):
        return self.tc.get_forecast_parameters()

    def set_forecast_parameters(self, params):
        horizon = params['horizon']
        interval = params['interval']
        self.tc.set_forecast_parameters(horizon, interval)
        return self.tc.get_forecast_parameters()

    def get_forecast(self, params):
        return self.tc.get_forecast()

    def get_step(self, params):
        return self.tc.get_step()

    def set_step(self, params):
        step = params['step']
        self.tc.set_step(step)
        return self.tc.get_step()

    def advance(self, params):
        u = params['u']
        return self.tc.advance(u)

    def stop(self, params):
        self.keep_running = False
        return { 'status': 'ok' }
    # End message handlers

    def reset(self, tarinfo):
        tarinfo.uid = tarinfo.gid = 0
        tarinfo.uname = tarinfo.gname = "root"
        return tarinfo

    # cleanup after the simulation is stopped
    def cleanup(self):
        kpis = self.tc.get_kpis()
        kpidump = json.dumps(kpis)

        self.redis_pubsub.punsubscribe(str(self.testid) + "*")
        self.redis_pubsub.unsubscribe()
        self.redis.delete(self.testid)

        sim_id = str(uuid.uuid4())
        tarname = "%s.tar.gz" % sim_id
        tar = tarfile.open(tarname, "w:gz")
        tar.add(self.test_dir, filter=self.reset, arcname=sim_id)
        tar.close()

        uploadkey = "simulated/%s" % tarname
        self.s3_bucket.upload_file(tarname, uploadkey)
        os.remove(tarname)

        time = str(datetime.now(tz=pytz.UTC))
        self.mongo_db_sims.insert_one({"_id": sim_id, "testid": self.testid, "simStatus": "Complete", "timeCompleted": time, "s3Key": uploadkey, "results": str(kpidump)})
        #self.post_results_to_dashboard(kpis, time)

        shutil.rmtree(self.test_dir)

    def post_results_to_dashboard(self, kpis, time):
        # dashboard requires KPIs as ints, however this likely needs to change to float
        payload = {
          "results": [
            {
              "dateRun": time,
              "isShared": True,
              "uid": self.testid,
              "account": {
                "apiKey": "jerrysapikey"
              },
              "thermalDiscomfort": int(round(kpis['tdis_tot'])),
              "energyUse": int(round(kpis['ener_tot'])),
              "cost": int(round(kpis['cost_tot'])),
              "emissions": int(round(kpis['emis_tot'])),
              "iaq": int(round(kpis['idis_tot'])),
              "timeRatio": int(round(kpis['time_rat'])),
              "tags": {},
              "testTimePeriodStart": "2020-09-28T20:39:03.366Z",
              "testTimePeriodEnd": "2020-09-28T20:39:03.366Z",
              "controlStep": "controlStep",
              "priceScenario": "priceScenario",
              "weatherForecastUncertainty": "forecast-unknown",
              "controllerType": "controllerType1",
              "problemFormulation": "problem1",
              "modelType": "modelType1",
              "numStates": 15,
              "predictionHorizon": 700,
              "buildingType": {
                "id": 1,
                "uid": "buildingType-1",
                "name": "BIG Building",
                "parsedHTML": "<html></html>",
                "detailsURL": "bigbuilding.com"
              }
            }
          ]
        }
        dashboard_url = "%s/api/results" % os.environ['DASHBOARD_URL']
        try:
            requests.post(dashboard_url, json=payload)
        except:
            print("Unable to post results to dashboard located at: %s" % dashboard_url)

    def init_sim_status(self):
        self.redis.hset(self.testid, 'testcaseid', self.testcaseid)
        self.redis.hset(self.testid, 'status', 'Running')

