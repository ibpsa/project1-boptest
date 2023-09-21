import sys
import os
import shutil
import tarfile
from datetime import datetime
import boto3
import redis
import numpy as np
import msgpack
from boptest.lib.testcase import TestCase

class Job:
    def __init__(self, parameters):
        self.testid = parameters.get("testid")
        self.testKey = "tests:%s" % self.testid
        self.testcaseKey = parameters.get("testcaseKey")
        self.keep_running = True
        # abort True will end the run loop without cleanup
        self.abort = False
        self.last_message_time = datetime.now()

        self.redis = redis.Redis(host=os.environ["BOPTEST_REDIS_HOST"])
        self.redis_pubsub = self.redis.pubsub()

        if not self.redis.hexists(self.testKey, "status"):
            self.abort = True
            # no need to do further initialization
            # run method will return immediately without cleanup
            return

        self.timeout = float(os.environ["BOPTEST_TIMEOUT"])

        # Download the testcase FMU
        self.test_dir = os.path.join("/simulate", self.testid)
        self.fmu_path = os.path.join(self.test_dir, "model.fmu")

        if not os.path.exists(self.test_dir):
            os.makedirs(self.test_dir)

        self.s3 = boto3.resource(
            "s3", region_name=os.environ["BOPTEST_REGION"], endpoint_url=os.environ["BOPTEST_INTERNAL_S3_URL"]
        )
        self.s3_bucket = self.s3.Bucket(os.environ["BOPTEST_S3_BUCKET"])
        self.s3_bucket.download_file(self.testcaseKey, self.fmu_path)

        self.tc = TestCase(self.fmu_path)

        # subscribe to messages related to this test
        self.message_handlers = {}
        self.register_message_handler("initialize", self.initialize)
        self.register_message_handler("advance", self.advance)
        self.register_message_handler("get_name", self.get_name)
        self.register_message_handler("get_inputs", self.get_inputs)
        self.register_message_handler("get_measurements", self.get_measurements)
        self.register_message_handler("get_results", self.get_results)
        self.register_message_handler("get_kpis", self.get_kpis)
        self.register_message_handler("get_scenario", self.get_scenario)
        self.register_message_handler("set_scenario", self.set_scenario)
        self.register_message_handler("get_forecast", self.get_forecast)
        self.register_message_handler("get_forecast_points", self.get_forecast_points)
        self.register_message_handler("get_step", self.get_step)
        self.register_message_handler("set_step", self.set_step)
        self.register_message_handler("stop", self.stop)
        self.register_message_handler("post_results_to_dashboard", self.post_results_to_dashboard)
        self.subscribe()

        self.init_sim_status()

    # This is the main Job entry point
    def run(self):
        while self.keep_running and not self.abort:
            self.process_messages()
            self.check_idle_time()

        if not self.abort:
            self.cleanup()

    def check_idle_time(self):
        idle_time = datetime.now() - self.last_message_time
        if idle_time.total_seconds() > self.timeout:
            print("Testid '%s' is terminating due to inactivity." % self.testid)
            self.keep_running = False

    # Begin methods for message passing between web and worker ###
    # See comment in web/server/src/controllers/redis.js
    # for a description of how messages between web and worker are designed
    def get_request_channel(self):
        return self.testid + ":request"

    def get_response_channel(self):
        return self.testid + ":response"

    def subscribe(self):
        request_channel = self.get_request_channel()
        self.redis_pubsub.subscribe(request_channel)

    def unsubscribe(self):
        self.redis_pubsub.unsubscribe()

    def register_message_handler(self, method, callback):
        self.message_handlers[method] = callback

    def unpack(self, data):
        return msgpack.unpackb(data)

    def pack(self, data):
        # use_bin_type=False is because this is running in python 2,
        # it should be avoided in the future.
        # Also, python 2, means this is falling back to a pure python
        # ipmlementation which is slower.
        return msgpack.packb(data)

    class InvalidRequestError(Exception):
        pass

    def call_message_handler(self, method, params):
        handler = self.message_handlers.get(method)
        if not handler:
            raise Job.InvalidRequestError("Invalid method, '%s', called" % method)
        try:
            return handler(params)
        except Exception as e:
            raise Job.InvalidRequestError(e)

    def process_messages(self):
        request_id = False
        response_channel = self.get_response_channel()
        try:
            message = self.redis_pubsub.get_message()
            if message:
                message_type = message["type"]
                if message_type == "message":
                    message_data = self.unpack(message.get("data"))

                    request_id = message_data["requestID"]
                    method = message_data.get("method")
                    params = message_data.get("params")

                    callback_result = self.call_message_handler(method, params)
                    packed_result = self.pack({"requestID": request_id, "payload": callback_result})
                    self.redis.publish(response_channel, packed_result)

                    self.last_message_time = datetime.now()
        except Job.InvalidRequestError as e:
            payload = {"status": 400, "message": "Bad Request", "payload": str(e)}
            packed_result = self.pack({"requestID": request_id, "payload": payload})
            self.redis.publish(response_channel, packed_result)
        except Exception:
            # Generic exceptions are an internal error
            error_message = str(sys.exc_info()[1])
            print(error_message)

    # End methods for message passing

    # Utility method to package BOPTEST's testcase.py responses
    # Most BOPTEST methods return a multivalue response, that is received as a tuple
    # This function packages the response, into dictionary
    def package_response(self, response):
        return {"status": response[0], "message": response[1], "payload": response[2]}

    # Begin message handling methods
    # These are called when a message is received,
    # See Job::register_message_handler
    def initialize(self, params):
        start_time = params.get("start_time")
        warmup_period = params.get("warmup_period")
        final_time = params.get("final_time")
        final_time = float(final_time) if final_time else np.inf

        return self.package_response(self.tc.initialize(start_time, warmup_period, final_time))

    def get_name(self, params):
        return self.package_response(self.tc.get_name())

    def get_inputs(self, params):
        return self.package_response(self.tc.get_inputs())

    def get_measurements(self, params):
        return self.package_response(self.tc.get_measurements())

    def get_results(self, params):
        point_names = params["point_names"]
        start_time = params["start_time"]
        final_time = params["final_time"]

        return self.package_response(self.tc.get_results(point_names, start_time, final_time))

    def get_kpis(self, params):
        return self.package_response(self.tc.get_kpis())

    def get_scenario(self, params):
        return self.package_response(self.tc.get_scenario())

    def set_scenario(self, params):
        if not 'electricity_price' in params:
            params['electricity_price'] = None
        if not 'time_period' in params:
            params['time_period'] = None
        return self.package_response(self.tc.set_scenario(params))

    def get_forecast(self, params):
        point_names = params["point_names"]
        horizon = params["horizon"]
        interval = params["interval"]

        return self.package_response(self.tc.get_forecast(point_names, horizon, interval))

    def get_forecast_points(self, params):
        return self.package_response(self.tc.get_forecast_points())

    def get_step(self, params):
        return self.package_response(self.tc.get_step())

    def set_step(self, params):
        step = params["step"]
        return self.package_response(self.tc.set_step(step))

    def advance(self, params):
        return self.package_response(self.tc.advance(params))

    def stop(self, params):
        self.keep_running = False

    def post_results_to_dashboard(self, params):
        api_key  = params['api_key']
        unit_test=False
        tags = []
        for key in params:
            if ('tag' in key) and (params[key] is not None):
                tags.append(params[key])
            if key=='unit_test':
                if params[key] == "True":
                    unit_test = True
                else:
                    unit_test = False

        return self.package_response(self.tc.post_results_to_dashboard(api_key, tags, unit_test))

    # End message handlers

    def reset(self, tarinfo):
        tarinfo.uid = tarinfo.gid = 0
        tarinfo.uname = tarinfo.gname = "root"
        return tarinfo

    # cleanup after the simulation is stopped
    def cleanup(self):
        user = self.redis.hget(self.testKey, "user")
        userTestsKey = "users:%s:tests" % user
        self.redis.delete(self.testKey)
        self.redis.srem(userTestsKey, self.testid)
        self.unsubscribe()

        tarname = "%s.tar.gz" % self.testid
        tar = tarfile.open(tarname, "w:gz")
        tar.add(self.test_dir, filter=self.reset, arcname=self.testid)
        tar.close()

        uploadkey = "simulated/%s" % tarname
        self.s3_bucket.upload_file(tarname, uploadkey)
        os.remove(tarname)

        shutil.rmtree(self.test_dir)

    def to_camel_case(self, snake_str):
        components = snake_str.split("_")
        # We capitalize the first letter of each component except the first one
        # with the 'title' method and join them together.
        return components[0] + "".join(x.title() for x in components[1:])

    def keys_to_camel_case(self, a_dict):
        result = {}
        for key, value in a_dict.items():
            result[self.to_camel_case(key)] = value
        return result

    def init_sim_status(self):
        self.redis.hset(self.testKey, "status", "Running")
