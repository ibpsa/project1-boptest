# -*- coding: utf-8 -*-
"""
This module implements the REST API used to interact with the test case.
The API is implemented using the ``flask`` package.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
from flask import Flask, request, jsonify
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
import logging
import argparse


def construct(status, message, payload):
    return {"status": status, "message": message, "payload": payload}


# LOGGING SETTING
# ----------------
parser = argparse.ArgumentParser()
parser.add_argument("-l", "--log", dest="logLevel", choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'],
                    help="Provide logging level. Example --log DEBUG'")
log_level = parser.parse_args()
logging.basicConfig(level=log_level.logLevel)
error_number_input = "{} cannot be blank and it should be a number"
# ----------------

# TEST CASE IMPORT
# ----------------
from testcase import TestCase

# ----------------

# FLASK REQUIREMENTS
# ------------------
app = Flask(__name__)
cors = CORS(app, resources={r"*": {"origins": "*"}})
api = Api(app)
# ------------------

# INSTANTIATE TEST CASE
# ---------------------
try:
    case = TestCase()
except Exception as ex:
    message = "Failed to instantiate the fmu: {}".format(ex)
    app.logger.error(message)

# ---------------------

# DEFINE ARGUMENT PARSERS
# -----------------------
# ``step`` interface
parser_step = reqparse.RequestParser()
parser_step.add_argument('step',type=float,required=True,help=error_number_input.format('step'))
# ``initialize`` interface
parser_initialize = reqparse.RequestParser()
parser_initialize.add_argument('start_time',type=float,required=True,help=error_number_input.format('start time'))
parser_initialize.add_argument('warmup_period',type=float,required=True,help=error_number_input.format('warmup period'))
# ``advance`` interface
parser_advance = reqparse.RequestParser()
for key in case.u.keys():
    parser_advance.add_argument(key)
# ``forecast_parameters`` interface
parser_forecast_parameters = reqparse.RequestParser()
forecast_parameters = ['horizon', 'interval']
for arg in forecast_parameters:
    parser_forecast_parameters.add_argument(arg,type=float,required=True,help=error_number_input.format(arg))
# ``price_scenario`` interface
parser_scenario = reqparse.RequestParser()
parser_scenario.add_argument('electricity_price',type=str,help="invalid price")
parser_scenario.add_argument('time_period',type=str,help="invalid time preriod")
# ``results`` interface
results_var = reqparse.RequestParser()
results_var.add_argument('point_name',type=str,required=True,help="point name cannot be blank")
results_var.add_argument('start_time',type=float,required=True,help=error_number_input.format('start time'))
results_var.add_argument('final_time',type=float,required=True,help=error_number_input.format('final time'))
# -----------------------

# DEFINE REST REQUESTS
# --------------------


class Advance(Resource):
    '''Interface to advance the test case simulation.'''

    def post(self):
        '''POST request with input data to advance the simulation one step
        and receive current measurements.'''
        u = parser_advance.parse_args()
        app.logger.info("Receiving a new advance request: {}".format(u))        
        status, message, payload = case.advance(u)
        return construct(status, message, payload)


class Initialize(Resource):
    '''Interface to initialize the test case simulation.'''

    def put(self):
        '''PUT request to initialize the test.'''
        args = parser_initialize.parse_args()
        app.logger.info("Receiving a new initialize request: {}".format(args))
        start_time = float(args['start_time'])
        warmup_period = float(args['warmup_period']) 
        status, message, payload = case.initialize(start_time, warmup_period)
        return construct(status, message, payload)


class Step(Resource):
    '''Interface to test case simulation step size.'''

    def get(self):
        '''GET request to receive current simulation step in seconds.'''
        app.logger.info("Receiving a new query for step")
        status, message, payload = case.get_step()
        return construct(status, message, payload)

    def put(self):
        '''PUT request to set simulation step in seconds.'''
        args = parser_step.parse_args()
        app.logger.info("Receiving a new set step request: {}".format(args))
        step = args['step']
        status, message, payload = case.set_step(step)
        return construct(status, message, payload)


class Inputs(Resource):
    '''Interface to test case inputs.'''

    def get(self):
        '''GET request to receive list of available inputs.'''
        app.logger.info("Receiving a new query for input list")
        status, message, payload = case.get_inputs()
        return construct(status, message, payload)


class Measurements(Resource):
    '''Interface to test case measurements.'''

    def get(self):
        '''GET request to receive list of available measurements.'''
        app.logger.info("Receiving a new query for output list")
        status, message, payload = case.get_measurements()
        return construct(status, message, payload)


class Results(Resource):
    '''Interface to test case result data.'''

    def put(self):
        '''GET request to receive measurement data.'''
        app.logger.info("Receiving a new query for results")  
        args = results_var.parse_args(strict=True) 
        var = args['point_name']
        start_time = float(args['start_time'])
        final_time = float(args['final_time'])
        status, message, payload = case.get_results(var, start_time, final_time)
        return construct(status, message, payload)


class KPI(Resource):
    '''Interface to test case KPIs.'''

    def get(self):
        '''GET request to receive KPI data.'''
        app.logger.info("Receiving a new query for KPI")
        status, message, payload = case.get_kpis()
        return construct(status, message, payload)


class Forecast_Parameters(Resource):
    '''Interface to test case forecast parameters.'''

    def get(self):
        '''GET request to receive forecast parameters.'''
        app.logger.info("Receiving a new query for forecast parameters")
        status, message, payload = case.get_forecast_parameters()
        return construct(status, message, payload)

    def put(self):
        '''PUT request to set forecast horizon and interval inseconds.'''    
        args = parser_forecast_parameters.parse_args()
        app.logger.info("Receiving a new request for setting the forecast: ()".format(args))           
        horizon = args['horizon']
        interval = args['interval']
        status, message, payload = case.set_forecast_parameters(horizon, interval)
        return construct(status, message, payload)


class Forecast(Resource):
    '''Interface to test case forecast data.'''

    def get(self):
        '''GET request to receive forecast data.'''
        app.logger.info("Receiving a new query for forecast")
        status, message, payload = case.get_forecast()
        return construct(status, message, payload)


class Scenario(Resource):
    '''Interface to test case scenario.'''

    def get(self):
        '''GET request to receive current scenario.'''
        app.logger.info("Receiving a new query for scenario")
        status, message, payload = case.get_scenario()
        return construct(status, message, payload)

    def put(self):
        '''PUT request to set scenario.'''          
        scenario = parser_scenario.parse_args(strict=True)
        app.logger.info("Receiving a new request for setting the scenario: {}".format(scenario))
        status, message, payload = case.set_scenario(scenario)
        return construct(status, message, payload)


class Name(Resource):
    '''Interface to test case name.'''

    def get(self):
        '''GET request to receive test case name.'''
        app.logger.info("Receiving a new query for case name")
        status, message, payload = case.get_name()
        return construct(status, message, payload)


class Version(Resource):
    '''Interface to BOPTEST version.'''

    def get(self):
        status, message, payload = case.get_version()
        return construct(status, message, payload)

    # --------------------


# ADD REQUESTS TO API WITH URL EXTENSION
# --------------------------------------
api.add_resource(Advance, '/advance')
api.add_resource(Initialize, '/initialize')
api.add_resource(Step, '/step')
api.add_resource(Inputs, '/inputs')
api.add_resource(Measurements, '/measurements')
api.add_resource(Results, '/results')
api.add_resource(KPI, '/kpi')
api.add_resource(Forecast_Parameters, '/forecast_parameters')
api.add_resource(Forecast, '/forecast')
api.add_resource(Scenario, '/scenario')
api.add_resource(Name, '/name')
api.add_resource(Version, '/version')
# --------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
