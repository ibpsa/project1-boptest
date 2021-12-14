# -*- coding: utf-8 -*-
"""
This module implements the REST API used to interact with the test case.
The API is implemented using the ``flask`` package.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
import logging
import argparse

# ----------------------

# LOGGING SETTING
# ----------------
parser = argparse.ArgumentParser()
parser.add_argument("-l", "--log", dest="logLevel", choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'],
                    help="Provide logging level. Example --log DEBUG'")
log_level = parser.parse_args()
logging.basicConfig(level=getattr(logging, log_level.logLevel))
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
except Exception as e:
    app.logger.error("Failed to instantiate the fmu: {}".format(e))
    pass
# ---------------------

# DEFINE ARGUMENT PARSERS
# -----------------------
# ``step`` interface
parser_step = reqparse.RequestParser()
parser_step.add_argument('step')
# ``initialize`` interface
parser_initialize = reqparse.RequestParser()
parser_initialize.add_argument('start_time')
parser_initialize.add_argument('warmup_period')
# ``advance`` interface
parser_advance = reqparse.RequestParser()
for key in case.u.keys():
    parser_advance.add_argument(key)
# ``forecast_parameters`` interface
parser_forecast_parameters = reqparse.RequestParser()
forecast_parameters = ['horizon', 'interval']
for arg in forecast_parameters:
    parser_forecast_parameters.add_argument(arg)
# ``price_scenario`` interface
parser_scenario = reqparse.RequestParser()
parser_scenario.add_argument('electricity_price')
parser_scenario.add_argument('time_period')
# ``results`` interface
results_var = reqparse.RequestParser()
results_var.add_argument('point_name')
results_var.add_argument('start_time')
results_var.add_argument('final_time')

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
        result = case.advance(u)
        if result['message'] == 'success':
            app.logger.info("Advanced the simulation")
            return {'message': 'success', 'error': None, 'result': result['result']}
        else:
            app.logger.error("Fail to advanced the simulation: {}".format(result['error']))
            return {'message': 'failure', 'error': result['error'], 'result': None}


class Initialize(Resource):
    '''Interface to initialize the test case simulation.'''

    def put(self):
        '''PUT request to initialize the test.'''
        args = parser_initialize.parse_args()
        app.logger.info("Receiving a new initialize request: {}".format(args))
        try:
            start_time = float(args['start_time'])
            warmup_period = float(args['warmup_period'])
        except TypeError as ex:
            app.logger.error("Receiving {} when processing a initialize request".format(e))
            return {'message': 'failure', 'error': ex, 'result': None}
        except ValueError as ex:
            app.logger.error("Receiving {} when processing a initialize request".format(e))
            return {'message': 'failure', 'error': ex, 'result': None}
        except KeyError as ex:
            app.logger.error("Receiving {} when processing a initialize request".format(e))
            return {'message': 'failure', 'error': ex, 'result': None}
        except Exception as ex:
            app.logger.error("Receiving {} when processing a initialize request".format(e))
            return {'message': 'failure', 'error': ex, 'result': e}
        result = case.initialize(start_time, warmup_period)
        if result['message'] == 'success':
            app.logger.info("Reset the simulation start time to: {}".format(start_time))
            return {'message': 'success', 'error': None, 'result': None}
        else:
            app.logger.error("Fail to initialize the simulation:{}".format(result['error']))
            return {'message': 'failure', 'error': result['error'], 'result': None}
        return result


class Step(Resource):
    '''Interface to test case simulation step size.'''

    def get(self):
        '''GET request to receive current simulation step in seconds.'''
        app.logger.info("Receiving a new query for step")
        try:
            step = case.get_step()
        except Exception as e:
            app.logger.error("Fail to return the simulation step:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': step}

    def put(self):
        '''PUT request to set simulation step in seconds.'''
        args = parser_step.parse_args()
        app.logger.info("Receiving a new set step request: {}".format(args))
        step = args['step']
        try:
            step = case.set_step(step)
        except Exception as e:
            app.logger.error("Fail to set the simulation step:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': step}


class Inputs(Resource):
    '''Interface to test case inputs.'''

    def get(self):
        '''GET request to receive list of available inputs.'''
        app.logger.info("Receiving a new query for input list")
        try:
            u_list = case.get_inputs()
        except Exception as e:
            app.logger.error("Fail to return the inputs:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': u_list}


class Measurements(Resource):
    '''Interface to test case measurements.'''

    def get(self):
        '''GET request to receive list of available measurements.'''
        app.logger.info("Receiving a new query for output list")
        try:
            y_list = case.get_measurements()
        except Exception as e:
            app.logger.error("Fail to return the outputs:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': y_list}


class Results(Resource):
    '''Interface to test case result data.'''

    def put(self):
        '''GET request to receive measurement data.'''
        app.logger.info("Receiving a new query for results")               
        try:
            args = results_var.parse_args(strict=True) 
            var = args['point_name']
            start_time  = float(args['start_time'])
            final_time  = float(args['final_time'])
            Y = case.get_results(var, start_time, final_time)
            for key in Y:
                  Y[key] = Y[key].tolist() 
        except Exception as e:
            app.logger.error("Fail to return the results:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': Y}


class KPI(Resource):
    '''Interface to test case KPIs.'''

    def get(self):
        '''GET request to receive KPI data.'''
        app.logger.info("Receiving a new query for KPI")
        try:
            kpi = case.get_kpis()
        except Exception as e:
            app.logger.error("Fail to return the KPI:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': kpi}


class Forecast_Parameters(Resource):
    '''Interface to test case forecast parameters.'''

    def get(self):
        '''GET request to receive forecast parameters.'''
        app.logger.info("Receiving a new query for forecast parameters")
        try:
            forecast_parameters = case.get_forecast_parameters()
        except Exception as e:
            app.logger.error("Fail to return the forecast parameters:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': forecast_parameters}

    def put(self):
        '''PUT request to set forecast horizon and interval inseconds.'''    
        args = parser_forecast_parameters.parse_args()
        app.logger.info("Receiving a new request for setting the forecast: ()".format(args))           
        horizon = args['horizon']
        interval = args['interval']
        try:
            result = case.set_forecast_parameters(horizon, interval)
        except Exception as e:
            app.logger.error("Fail to return the KPI:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': result}


class Forecast(Resource):
    '''Interface to test case forecast data.'''

    def get(self):
        '''GET request to receive forecast data.'''
        app.logger.info("Receiving a new query for forecast")
        try:
            forecast = case.get_forecast()
        except Exception as e:
            app.logger.error("Fail to return the forecast:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'result': forecast, 'error': None}

class Scenario(Resource):
    '''Interface to test case scenario.'''

    def get(self):
        '''GET request to receive current scenario.'''
        app.logger.info("Receiving a new query for scenario")
        try:        
            scenario = case.get_scenario()
        except Exception as e:
            app.logger.error("Fail to return the scenario:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'result': scenario, 'error': None}

    def put(self):
        '''PUT request to set scenario.'''          
        scenario = parser_scenario.parse_args(strict=True)
        app.logger.info("Receiving a new request for setting the scenario: ()".format(scenario)) 
        try:        
            result = case.set_scenario(scenario)
        except Exception as e:
            app.logger.error("Fail to set the scenario:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'error': None, 'result': result}

class Name(Resource):
    '''Interface to test case name.'''

    def get(self):
        '''GET request to receive test case name.'''
        app.logger.info("Receiving a new query for case name")
        try:
            name = case.get_name()
        except Exception as e:
            app.logger.error("Fail to return the case name:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}
        return {'message': 'success', 'result': name, 'error': None}


class Version(Resource):
    '''Interface to BOPTEST version.'''

    def get(self):

        try:
            version = case.get_version()
        except Exception as e:
            app.logger.error("Fail to return the case name:{}".format(e))
            return {'message': 'failure', 'error': e, 'result': None}

        return {'message': 'success', 'result': version, 'error': None}

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