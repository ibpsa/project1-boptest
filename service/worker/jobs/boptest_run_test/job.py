import sys
import json
import os
import shutil
import tarfile
from datetime import datetime
import boto3
import pytz
import redis
import numpy as np
import requests
from boptest.lib.testcase import TestCase


class Job:
    def __init__(self, parameters):
        self.key = parameters.get('key')
        self.testcaseid = parameters.get('testcaseid')
        self.testid = parameters.get('testid')
        self.api_key = parameters.get('api_key')
        self.keep_running = True
        self.last_message_time = datetime.now()

        self.s3 = boto3.resource('s3', region_name='us-east-1', endpoint_url=os.environ['S3_URL'])
        self.redis = redis.Redis(host=os.environ['REDIS_HOST'])
        self.redis_pubsub = self.redis.pubsub()

        # Download the testcase FMU
        self.test_dir = os.path.join('/simulate', self.testcaseid)
        self.fmu_path = os.path.join(self.test_dir, 'model.fmu')

        if not os.path.exists(self.test_dir):
            os.makedirs(self.test_dir)

        self.s3_bucket = self.s3.Bucket('alfalfa')
        self.s3_bucket.download_file(self.key, self.fmu_path)

        self.tc = TestCase(self.fmu_path)

        # subscribe to messages related to this test
        self.message_handlers = {}
        self.register_message_handler('initialize', self.initialize)
        self.register_message_handler('advance', self.advance)
        self.register_message_handler('get_name', self.get_name)
        self.register_message_handler('get_inputs', self.get_inputs)
        self.register_message_handler('get_measurements', self.get_measurements)
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
        self.subscribe()

        self.init_sim_status()

    # This is the main Job entry point
    def run(self):
        while self.keep_running:
            message = self.handle_messages()
            self.check_idle_time(message)

        self.cleanup()

    def check_idle_time(self, message):
        if not message:
            idle_time = datetime.now() - self.last_message_time
            if idle_time.total_seconds() > 900.0:
                print("Testid '%s' is terminating due to inactivity." % self.testid)
                self.keep_running = False

    # Begin methods for message passing between web and worker ###
    # See comment in web/server/src/controllers/redis.js
    # for a description of how messages between web and worker are designed
    def get_request_channel(self):
        return (self.testid + ":request")

    def get_response_channel(self):
        return (self.testid + ":response")

    def subscribe(self):
        request_channel = self.get_request_channel()
        self.redis_pubsub.subscribe(request_channel)

    def unsubscribe(self):
        self.redis_pubsub.unsubscribe()

    def register_message_handler(self, method, callback):
        self.message_handlers[method] = callback

    def get_message_data(self, message):
        return json.loads(message.get('data'))

    def handle_messages(self):
        handler = False
        method = False
        try:
            message = self.redis_pubsub.get_message()
            if message:
                message_type = message['type']
                if message_type == 'message':
                    message_data = self.get_message_data(message)
                    request_id = message_data.get('requestID')
                    method = message_data.get('method')
                    params = message_data.get('params')

                    handler = self.message_handlers.get(method)
                    callback_result = handler(params)

                    self.redis.hset(self.testid, method, json.dumps(callback_result))
                    message_response = { 'status': 'ok', 'requestID': request_id }
                    self.redis.publish(self.get_response_channel(), json.dumps(message_response))

                    self.last_message_time = datetime.now()
        except:
            error_message = str(sys.exc_info()[1])
            print(error_message)
            if handler and method:
                # If the error happened late, and we have a handler and method,
                # then try to send the error back to the client
                self.redis.hset(self.testid, method, error_message)
                response = { 'status': 'error', 'requestID': request_id }
                self.redis.publish(self.get_response_channel(), json.dumps(response))

    # End methods for message passing

    # Utility method to package BOPTEST's testcase.py responses
    # Most BOPTEST methods return a multivalue response, that is received as a tuple
    # This function packages the response, into dictionary
    def package_response(self, response):
        return {
            'status': response[0],
            'message': response[1],
            'payload': response[2]
        }

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
        return self.package_response(self.tc.initialize(start_time, warmup_period, end_time))

    def get_name(self, params):
        return self.package_response(self.tc.get_name())

    def get_inputs(self, params):
        return self.package_response(self.tc.get_inputs())

    def get_measurements(self, params):
        return self.package_response(self.tc.get_measurements())

    def get_results(self, params):
        point_name = params['point_name']
        results_start_time = float(params['start_time'])
        results_final_time = float(params['final_time'])

        return self.package_response(self.tc.get_results(point_name, results_start_time, results_final_time))

    def get_kpis(self, params):
        return self.package_response(self.tc.get_kpis())

    def get_scenario(self, params):
        return self.package_response(self.tc.get_scenario())

    def set_scenario(self, params):
        scenario = params['scenario']
        return self.package_response(self.tc.set_scenario(scenario))

    def get_forecast_parameters(self, params):
        return self.package_response(self.tc.get_forecast_parameters())

    def set_forecast_parameters(self, params):
        horizon = params['horizon']
        interval = params['interval']
        self.tc.set_forecast_parameters(horizon, interval)
        return self.package_response(self.tc.get_forecast_parameters())

    def get_forecast(self, params):
        return self.package_response(self.tc.get_forecast())

    def get_step(self, params):
        return self.package_response(self.tc.get_step())

    def set_step(self, params):
        step = params['step']
        self.tc.set_step(step)
        return self.package_response(self.tc.get_step())

    def advance(self, params):
        u = params['u']
        return self.package_response(self.tc.advance(u))

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
        self.redis.delete(self.testid)
        self.unsubscribe()

        tarname = "%s.tar.gz" % self.testid
        tar = tarfile.open(tarname, "w:gz")
        tar.add(self.test_dir, filter=self.reset, arcname=self.testid)
        tar.close()

        uploadkey = "simulated/%s" % tarname
        self.s3_bucket.upload_file(tarname, uploadkey)
        os.remove(tarname)

        shutil.rmtree(self.test_dir)

    def post_results_to_dashboard(self):
        dash_server = os.environ['BOPTEST_DASHBOARD_SERVER']

        if dash_server and self.api_key:
            payload = {
              "results": [
                {
                  "uid": self.testid,
                  "dateRun": str(datetime.now(tz=pytz.UTC)),
                  "boptestVersion": "0.1.0",
                  "isShared": True,
                  "controlStep": self.tc.get_step(),
                  "account": {
                    "apiKey": self.api_key
                  },
                  "tags": [],
                  "kpis": self.tc.get_kpis(),
                  "forecastParameters": self.tc.get_forecast_parameters(),
                  "scenario": self.add_forecast_uncertainty(self.keys_to_camel_case(self.tc.get_scenario())),
                  "buildingType": {
                    "uid": self.testcaseid
                  }
                }
              ]
            }
            dash_url = "%s/api/results" % dash_server
            try:
                result = requests.post(dash_url, json=payload)
            except:
                print("Unable to post results to dashboard located at: %s" % dash_url)

    def to_camel_case(self, snake_str):
        components = snake_str.split('_')
        # We capitalize the first letter of each component except the first one
        # with the 'title' method and join them together.
        return components[0] + ''.join(x.title() for x in components[1:])

    def keys_to_camel_case(self, a_dict):
        result = {}
        for key, value in a_dict.items():
            result[self.to_camel_case(key)] = value
        return result

    # weatherForecastUncertainty is required by the dashboard,
    # however some testcases don't report it.
    # This is a workaround
    def add_forecast_uncertainty(self, scenario):
        if not 'weatherForecastUncertainty' in scenario:
            scenario['weatherForecastUncertainty'] = 'deterministic'

        return scenario

    def init_sim_status(self):
        self.redis.hset(self.testid, 'testcaseid', self.testcaseid)
        self.redis.hset(self.testid, 'status', 'Running')

