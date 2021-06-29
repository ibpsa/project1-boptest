import sys
import json
import os
import shutil
import tarfile
import time
import uuid
import zipfile
from datetime import datetime
import boto3
import pytz
import redis
from pymongo import MongoClient
import requests
from boptest.lib.test_config import get_test_config
from boptest.lib.testcase import TestCase


class RunFMUSite:
    def __init__(self, parameters):
        self.parameters = parameters
        self.s3 = boto3.resource('s3', region_name='us-east-1', endpoint_url=os.environ['S3_URL'])
        self.redis = redis.Redis(host=os.environ['REDIS_HOST'])
        self.redis_pubsub = self.redis.pubsub()

        # Initiate Mongo Database
        mongo_client = MongoClient(os.environ['MONGO_URL'])
        self.mongo_db = mongo_client[os.environ['MONGO_DB_NAME']]
        self.mongo_db_recs = self.mongo_db.recs
        self.write_arrays = self.mongo_db.writearrays
        self.mongo_db_sims = self.mongo_db.sims

        self.site_ref = parameters.get('site_ref')
        self.site = self.mongo_db_recs.find_one({"_id": self.site_ref})

        # build the path for zipped-file, fmu, json
        sim_path = '/simulate'
        self.directory = os.path.join(sim_path, self.site_ref)
        tar_name = "%s.tar.gz" % self.site_ref
        key = "parsed/%s" % tar_name
        tarpath = os.path.join(self.directory, tar_name)
        fmupath = os.path.join(self.directory, 'model.fmu')
        tagpath = os.path.join(self.directory, 'tags.json')

        if not os.path.exists(self.directory):
            os.makedirs(self.directory)

        # download the tar file and tag file
        self.s3_bucket = self.s3.Bucket('alfalfa')
        self.s3_bucket.download_file(key, tarpath)

        tar = tarfile.open(tarpath)
        tar.extractall(sim_path)
        tar.close()

        zzip = zipfile.ZipFile(fmupath)
        zzip.extract('resources/kpis.json', self.directory)

        # initiate the testcase
        get_test_config(fmupath)
        self.tc = TestCase()
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

        self.clear_forecast()

        self.sim_id = str(uuid.uuid4())
        tarname = "%s.tar.gz" % self.sim_id
        tar = tarfile.open(tarname, "w:gz")
        tar.add(self.directory, filter=self.reset, arcname=self.sim_id)
        tar.close()

        uploadkey = "simulated/%s" % tarname
        self.s3_bucket.upload_file(tarname, uploadkey)
        os.remove(tarname)

        time = str(datetime.now(tz=pytz.UTC))
        name = self.site.get("rec", {}).get("dis", "Test Case").replace('s:', '')
        self.mongo_db_sims.insert_one({"_id": self.sim_id, "name": name, "siteRef": self.site_ref, "simStatus": "Complete", "timeCompleted": time, "s3Key": uploadkey, "results": str(kpidump)})
        #self.post_results_to_dashboard(kpis, time)

        shutil.rmtree(self.directory)

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
            scenario = json.loads(scenario)
            scenario_result = self.tc.set_scenario(scenario)
            self.redis.hset(self.site_ref, 'scenario_result', json.dumps(scenario_result))
        else:
            start_time = float(self.parameters.get('start_time'))
            warmup_period = float(self.parameters.get('warmup_period'))
            y_output = self.tc.initialize(start_time, warmup_period)
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


if __name__ == "__main__":
    parameters = json.loads(sys.argv[1])
    runFMUSite = RunFMUSite(parameters)
    runFMUSite.run()
