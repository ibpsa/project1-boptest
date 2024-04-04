# -*- coding: utf-8 -*-
"""
This module implements the REST API used to interact with the test case.
The API is implemented using the ``flask`` package.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
from flask import Flask, make_response
from flask_restful import Resource, Api, reqparse
import flask_restful
from flask_cors import CORS
import six
# ----------------------


# GENERAL HTTP RESPONSE
# ----------------------
def construct(status, message, payload):
    response = {'status': status,
                'message': message,
                'payload': payload}
    return make_response(response, status)
# ----------------------


# TEST CASE IMPORT
# ----------------
from testcase import TestCase
# ----------------

# FLASK REQUIREMENTS
# ------------------


class CustomArgument(reqparse.Argument):

    def handle_validation_error(self, error, bundle_errors):
        '''Customizes inherited class with general HTTP response ``construct``.

        Called when an error is raised while parsing. Aborts the request
        with a 400 status and an error message

        :param error: the error that was raised
        :param bundle_errors: do not abort when first error occurs, return a
            dict with the name of the argument and the error message to be
            bundled

        '''

        error_str = six.text_type(error)
        msg = 'Bad input for parameter {}. '.format(self.name) + error_str
        flask_restful.abort(construct(400, msg, None))

app = Flask(__name__)
cors = CORS(app, resources={r"*": {"origins": "*"}})
api = Api(app)
# ------------------

# INSTANTIATE TEST CASE
# ---------------------
case = TestCase()
# ---------------------

# DEFINE ARGUMENT PARSERS
# -----------------------
# ``step`` interface
parser_step = reqparse.RequestParser(argument_class=CustomArgument)
parser_step.add_argument('step', required=True)

# ``initialize`` interface
parser_initialize = reqparse.RequestParser(argument_class=CustomArgument)
parser_initialize.add_argument('start_time', required=True)
parser_initialize.add_argument('warmup_period', required=True)
# ``advance`` interface
parser_advance = reqparse.RequestParser(argument_class=CustomArgument)
for key in case.u.keys():
    if key != 'time':
        parser_advance.add_argument(key, type=float)
# ``price_scenario`` interface
parser_scenario = reqparse.RequestParser(argument_class=CustomArgument)
parser_scenario.add_argument('electricity_price', type=str)
parser_scenario.add_argument('time_period', type=str)
# ``forecast`` interface
parser_forecast_points = reqparse.RequestParser(argument_class=CustomArgument)
parser_forecast_points.add_argument('point_names', type=list, action='append', required=True)
forecast_parameters = ['horizon', 'interval']
for arg in forecast_parameters:
    parser_forecast_points.add_argument(arg, required=True)
# ``results`` interface
results_var = reqparse.RequestParser(argument_class=CustomArgument)
results_var.add_argument('point_names', type=list, action='append', required=True)
results_var.add_argument('start_time', required=True)
results_var.add_argument('final_time', required=True)
# ``submit`` interface
submit_var = reqparse.RequestParser(argument_class=CustomArgument)
submit_var.add_argument('api_key', type=str, required=True)
    # add up to 10 tags
for i in range(10):
    submit_var.add_argument('tag{0}'.format(i+1), type=str)
submit_var.add_argument('unit_test')
# -----------------------


# DEFINE REST REQUESTS
# --------------------
class Advance(Resource):
    '''Interface to advance the test case simulation.'''

    def post(self):
        '''POST request with input data to advance the simulation one step
        and receive current measurements.'''
        u = parser_advance.parse_args(strict=True)
        status, message, payload = case.advance(u)
        return construct(status, message, payload)


class Initialize(Resource):
    '''Interface to initialize the test case simulation.'''

    def put(self):
        '''PUT request to initialize the test.'''
        args = parser_initialize.parse_args()
        start_time = args['start_time']
        warmup_period = args['warmup_period']
        status, message, payload = case.initialize(start_time, warmup_period)
        return construct(status, message, payload)


class Step(Resource):
    '''Interface to test case simulation step size.'''

    def get(self):
        '''GET request to receive current simulation step in seconds.'''
        status, message, payload = case.get_step()
        return construct(status, message, payload)

    def put(self):
        '''PUT request to set simulation step in seconds.'''
        args = parser_step.parse_args()
        step = args['step']
        status, message, payload = case.set_step(step)
        return construct(status, message, payload)


class Inputs(Resource):
    '''Interface to test case inputs.'''

    def get(self):
        '''GET request to receive list of available inputs.'''
        status, message, payload = case.get_inputs()
        return construct(status, message, payload)


class Measurements(Resource):
    '''Interface to test case measurements.'''

    def get(self):
        '''GET request to receive list of available measurements.'''
        status, message, payload = case.get_measurements()
        return construct(status, message, payload)

class Forecast_Points(Resource):
    '''Interface to test case forecast points.'''

    def get(self):
        '''GET request to receive list of available forecast points.'''
        status, message, payload = case.get_forecast_points()
        return construct(status, message, payload)

class Results(Resource):
    '''Interface to test case result data.'''

    def put(self):
        '''PUT request to receive measurement data.'''
        args = results_var.parse_args(strict=True)
        point_names = []
        for point_name in args['point_names']:
            point_names.append(''.join(point_name))
        start_time = args['start_time']
        final_time = args['final_time']
        status, message, payload = case.get_results(point_names, start_time, final_time)
        return construct(status, message, payload)

class KPI(Resource):
    '''Interface to test case KPIs.'''

    def get(self):
        '''GET request to receive KPI data.'''
        status, message, payload = case.get_kpis()
        return construct(status, message, payload)


class Forecast(Resource):
    '''Interface to test case forecast data.'''

    def put(self):
        '''PUT request to receive forecast data.'''
        args = parser_forecast_points.parse_args()
        horizon = args['horizon']
        interval = args['interval']
        point_names = []
        for point_name in args['point_names']:
            point_names.append(''.join(point_name))
        status, message, payload = case.get_forecast(point_names, horizon, interval)
        return construct(status, message, payload)

class Scenario(Resource):
    '''Interface to test case scenario.'''

    def get(self):
        '''GET request to receive current scenario.'''
        status, message, payload = case.get_scenario()
        return construct(status, message, payload)

    def put(self):
        '''PUT request to set scenario.'''
        scenario = parser_scenario.parse_args(strict=True)
        status, message, payload = case.set_scenario(scenario)
        return construct(status, message, payload)

class Name(Resource):
    '''Interface to test case name.'''

    def get(self):
        '''GET request to receive test case name.'''
        status, message, payload = case.get_name()
        return construct(status, message, payload)

class Version(Resource):
    '''Interface to BOPTEST version.'''

    def get(self):
        '''GET request to receive BOPTEST version.'''
        status, message, payload = case.get_version()
        return construct(status, message, payload)

class Submit(Resource):
    '''Submit results to dashboard.'''

    def post(self):
        '''POST request to submit results to online dashboard.'''
        args = submit_var.parse_args(strict=True)
        api_key  = args['api_key']
        unit_test=False
        tags = []
        for key in args:
            if ('tag' in key) and (args[key] is not None):
                tags.append(args[key])
            if key=='unit_test':
                if args[key] == "True":
                    unit_test = True
                else:
                    unit_test = False
        status, message, payload = case.post_results_to_dashboard(api_key, tags, unit_test)
        return construct(status, message, payload)
# --------------------

# ADD REQUESTS TO API WITH URL EXTENSION
# --------------------------------------
api.add_resource(Advance, '/advance')
api.add_resource(Initialize, '/initialize')
api.add_resource(Step, '/step')
api.add_resource(Inputs, '/inputs')
api.add_resource(Measurements, '/measurements')
api.add_resource(Forecast_Points, '/forecast_points')
api.add_resource(Results, '/results')
api.add_resource(KPI, '/kpi')
api.add_resource(Forecast, '/forecast')
api.add_resource(Scenario, '/scenario')
api.add_resource(Name, '/name')
api.add_resource(Version, '/version')
api.add_resource(Submit, '/submit')
# --------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0')
