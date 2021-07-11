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
from pymongo import MongoClient
import requests
from boptest.lib.testcase import TestCase


class Job:
    def __init__(self, parameters):
        self.key = parameters.get('key')
        self.testcaseid = parameters.get('testcaseid')
        start_time = parameters.get('start_time')
        warmup_period = parameters.get('warmup_period')

        self.start_time = float(start_time) if start_time else 0.0
        self.warmup_period = float(warmup_period) if warmup_period else 0.0
        self.site_ref = self.testcaseid

        self.s3 = boto3.resource('s3', region_name='us-east-1', endpoint_url=os.environ['S3_URL'])
        self.redis = redis.Redis(host=os.environ['REDIS_HOST'])
        self.redis_pubsub = self.redis.pubsub()

        # Initiate Mongo Database
        mongo_client = MongoClient(os.environ['MONGO_URL'])
        self.mongo_db = mongo_client[os.environ['MONGO_DB_NAME']]
        self.mongo_db_sims = self.mongo_db.sims

        self.test_dir = os.path.join('/simulate', self.testcaseid)
        self.fmu_path = os.path.join(self.test_dir, 'model.fmu')

        if not os.path.exists(self.test_dir):
            os.makedirs(self.test_dir)

        # download the tar file and tag file
        self.s3_bucket = self.s3.Bucket('alfalfa')
        self.s3_bucket.download_file(self.key, self.fmu_path)

        self.tc = TestCase(self.fmu_path)
        self.init_test()

        # simtime
        self.simtime = 0

        # subscribe to channels related to this test
        self.redis_pubsub.psubscribe(str(self.site_ref) + "*")

        self.init_sim_status()


    def results_request_channel(self):
        return (self.site_ref + ":results:request")

    def results_response_channel(self):
        return (self.site_ref + ":results:response")

    def kpis_request_channel(self):
        return (self.site_ref + ":kpis:request")

    def kpis_response_channel(self):
        return (self.site_ref + ":kpis:response")

    def forecast_request_channel(self):
        return (self.site_ref + ":forecast:request")

    def forecast_response_channel(self):
        return (self.site_ref + ":forecast:response")

    def scenario_result_request_channel(self):
        return (self.site_ref + ":scenario_result:request")

    def scenario_result_response_channel(self):
        return (self.site_ref + ":scenario_result:response")

    def run(self):
        while True:
            data = None
            channel = None
            message = self.redis_pubsub.get_message()
            if message:
                channel = message['channel']
                data = message['data']
                message_type = message['type']
            if channel == self.site_ref and data == 'stop':
                break
            if channel == self.results_request_channel() and message_type == 'pmessage':
                result_params = json.loads(data)
                point_name = result_params['point_name']
                results_start_time = float(result_params['start_time'])
                results_final_time = float(result_params['final_time'])
                self.update_results(point_name, results_start_time, results_final_time)
                self.redis.publish(self.results_response_channel(), 'ready')
            if channel == self.kpis_request_channel() and message_type == 'pmessage':
                self.update_kpis()
                self.redis.publish(self.kpis_response_channel(), 'ready')
            if channel == self.forecast_request_channel() and message_type == 'pmessage':
                self.update_forecast()
                self.redis.publish(self.forecast_response_channel(), 'ready')
            if channel == self.scenario_result_request_channel() and message_type == 'pmessage':
                self.update_scenario()
                self.redis.publish(self.scenario_result_response_channel(), 'ready')
            if channel == self.site_ref and data == 'advance':
                self.step()
                self.redis.publish(self.site_ref, 'complete')
                self.set_idle_state()

        self.cleanup()

    def reset(self, tarinfo):
        tarinfo.uid = tarinfo.gid = 0
        tarinfo.uname = tarinfo.gname = "root"
        return tarinfo

    # cleanup after the simulation is stopped
    def cleanup(self):
        kpis = self.tc.get_kpis()
        kpidump = json.dumps(kpis)

        self.redis.hset(self.site_ref, 'status', 'Stopped')
        self.redis.hdel(self.site_ref, 'time')
        self.redis.hdel(self.site_ref, 'scenario')
        self.redis.hdel(self.site_ref, 'scenario_result')

        self.clear_forecast()

        sim_id = str(uuid.uuid4())
        tarname = "%s.tar.gz" % sim_id
        tar = tarfile.open(tarname, "w:gz")
        tar.add(self.test_dir, filter=self.reset, arcname=sim_id)
        tar.close()

        uploadkey = "simulated/%s" % tarname
        self.s3_bucket.upload_file(tarname, uploadkey)
        os.remove(tarname)

        time = str(datetime.now(tz=pytz.UTC))
        self.mongo_db_sims.insert_one({"_id": sim_id, "siteRef": self.site_ref, "simStatus": "Complete", "timeCompleted": time, "s3Key": uploadkey, "results": str(kpidump)})
        #self.post_results_to_dashboard(kpis, time)

        shutil.rmtree(self.test_dir)

    def post_results_to_dashboard(self, kpis, time):
        # dashboard requires KPIs as ints, however this likely needs to change to float
        payload = {
          "results": [
            {
              "dateRun": time,
              "isShared": True,
              "uid": self.site_ref,
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

    def init_test(self):
        scenario = self.redis.hget(self.site_ref, 'scenario')
        if scenario:
            self.tc.initialize(self.start_time, self.warmup_period)
            self.update_scenario()
        else:
            y_output = self.tc.initialize(self.start_time, self.warmup_period)
            self.update_y(y_output)

    def update_y(self, y):
        self.redis.hset(self.site_ref, 'y', json.dumps(y))

    def get_u(self):
        ustring = self.redis.hget(self.site_ref, 'u')
        return json.loads(ustring)

    def update_forecast(self):
        forecast_parameters = self.redis.hget(self.site_ref, 'forecast_parameters')
        if forecast_parameters:
            forecast_parameters = json.loads(forecast_parameters)
            horizon = forecast_parameters['horizon']
            interval = forecast_parameters['interval']
            self.tc.set_forecast_parameters(horizon, interval)
            
        forecast = self.tc.get_forecast()
        self.redis.hset(self.site_ref, 'forecast', json.dumps(forecast))

    def update_scenario(self):
        scenario = self.redis.hget(self.site_ref, 'scenario')
        scenario = json.loads(scenario)
        scenario_result = self.tc.set_scenario(scenario)
        self.redis.hset(self.site_ref, 'scenario_result', json.dumps(scenario_result))

    def update_kpis(self):
        kpis = self.tc.get_kpis()
        kpis = json.dumps(kpis)
        self.redis.hset(self.site_ref, 'kpis', kpis)

    def update_results(self, point_name, results_start_time, results_final_time):
        results = self.tc.get_results(point_name, results_start_time, results_final_time)
        for key in results:
            results[key] = results[key].tolist()
        results = json.dumps(results)
        self.redis.hset(self.site_ref, 'results', results)

    def clear_forecast(self):
        self.redis.hdel(self.site_ref, 'forecast')

    def set_idle_state(self):
        self.redis.hset(self.site_ref, 'control', 'idle')

    def init_sim_status(self):
        self.set_idle_state()
        self.redis.hset(self.site_ref, 'status', 'Running')
        self.redis.hset(self.site_ref, 'time', self.simtime)

    def update_sim_status(self):
        self.simtime = self.tc.final_time
        self.redis.hset(self.site_ref, 'status', 'Running')
        self.redis.hset(self.site_ref, 'time', self.simtime)

    def step(self):
        # look for a change in step size
        redis_step_size = self.redis.hget(self.site_ref, 'step')
        current_step_size = self.tc.get_step()
        if redis_step_size and (current_step_size != redis_step_size):
            self.tc.set_step(redis_step_size)

        u = self.get_u()
        y_output = self.tc.advance(u)
        self.update_y(y_output)
        self.update_sim_status()
