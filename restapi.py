# -*- coding: utf-8 -*-
"""
This module implements the REST API used to interact with the test case.  
The API is implemented using the ``flask`` package.  

"""

# GENERAL PACKAGE IMPORT
# ----------------------
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
import logging
import argparse
# ----------------------

# LOGGING SETTING
# ----------------
parser = argparse.ArgumentParser()
parser.add_argument("-l", "--log", dest="logLevel", choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'],help="Provide logging level. Example --log DEBUG'")

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
api = Api(app)

# ------------------

# INSTANTIATE TEST CASE
# ---------------------
case = TestCase()
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
#``forecast_parameters`` interface
parser_forecast_parameters = reqparse.RequestParser()
forecast_parameters = ['horizon','interval']
for arg in forecast_parameters:
    parser_forecast_parameters.add_argument(arg)
# -----------------------

# DEFINE REST REQUESTS
# --------------------
class Advance(Resource):
    '''Interface to advance the test case simulation.'''    
    
    def post(self):
        '''POST request with input data to advance the simulation one step 
        and receive current measurements.'''
                
        parse = request.get_json(silent = True)
        
        if parse is None:
                    
            return {'message':'fail to advance: invalid json input','result':None}        
        
        u = parser_advance.parse_args()
        
        app.logger.info("Receiving a new advance request: {}".format(u)) 
                
        result = case.advance(u)
        
        if result['message'] == 'success':

            app.logger.info("Advanced the simulation")
        
        else:
        
            app.logger.error("Fail to advanced the simulation")   
                    
        return result        

class Initialize(Resource):
    '''Interface to initialize the test case simulation.'''
    
    def put(self):
        '''PUT request to initialize the test.'''
        
        parse = request.get_json(silent = True)
        
        if parse is None:
                    
            return {'message':'fail to initialize: invalid json input','result':None}  
               
        args = parser_initialize.parse_args()
        
        app.logger.info("Receiving a new initialize request: {}".format(args)) 
        
        try: 
        
            start_time = float(args['start_time'])
            
            warmup_period = float(args['warmup_period'])
            
        except TypeError:
        
            return {'message':'fail to initialize: insufficient input','result':None}
             
        except ValueError:
        
            return {'message':'fail to initialize: invalid input','result':None}               
            
        result = case.initialize(start_time,warmup_period)  

        if result['message'] == 'success':

            app.logger.info("Reset the simulation start time to: {}".format(start_time)) 
        
        else:
        
            app.logger.error("Fail to initialize the simulation")                          
        
        return result

class Step(Resource):
    '''Interface to test case simulation step size.'''
    
    def get(self):
        '''GET request to receive current simulation step in seconds.'''
                
        app.logger.info("Receiving a new query for step") 
        
        step = case.get_step()
        return step

    def put(self):
        '''PUT request to set simulation step in seconds.'''
               
        parse = request.get_json(silent = True)
        
        if parse is None:
                    
            return {'message':'fail to set step: invalid json input','result':None}          
        
        args = parser_step.parse_args()
        
        app.logger.info("Receiving a new set step request: {}".format(args)) 
        
        step = args['step']
        
        result = case.set_step(step)

        if result['message'] == 'success':

            app.logger.info("Set the step to {}".format(step))
        
        else:
        
            app.logger.error("Fail to set the step")   
                                     
        return result
        
class Inputs(Resource):
    '''Interface to test case inputs.'''
    
    def get(self):
        '''GET request to receive list of available inputs.'''

        app.logger.info("Receiving a new query for input list")         
        
        u_list = case.get_inputs()
        
        return u_list
        
class Measurements(Resource):
    '''Interface to test case measurements.'''
    
    def get(self):
        '''GET request to receive list of available measurements.'''
        
        app.logger.info("Receiving a new query for output list")           
        
        y_list = case.get_measurements()
        return y_list
        
class Results(Resource):
    '''Interface to test case result data.'''
    
    def get(self):
        '''GET request to receive measurement data.'''
        
        app.logger.info("Receiving a new query for outputs")          
        
        Y = case.get_results()
        return Y
        
class KPI(Resource):
    '''Interface to test case KPIs.'''
    
    def get(self):
        '''GET request to receive KPI data.'''
        
        app.logger.info("Receiving a new query for KPI")            
        
        kpi = case.get_kpis()
        return kpi
    
class Forecast_Parameters(Resource):
    '''Interface to test case forecast parameters.'''
    
    def get(self):
        '''GET request to receive forecast parameters.'''
        
        app.logger.info("Receiving a new query for forecast parameters")           
        
        forecast_parameters = case.get_forecast_parameters()
        return forecast_parameters
    
    def put(self):
        '''PUT request to set forecast horizon and interval inseconds.'''
        
        parse = request.get_json(silent = True)
        
        if parse is None:
                    
            return {'message':'fail to set forecast: invalid json input','result':None}  

        args = parser_forecast_parameters.parse_args()

        app.logger.info("Receiving a new request for setting the forecast: ()".format(args))   
             
        horizon  = args['horizon']
        
        interval = args['interval']
        
        result = case.set_forecast_parameters(horizon, interval)
        
        if result['message'] == 'success':

            app.logger.info("Set the forecast parameters to horizon: {} and interval: {}".format(horizon, interval))
        
        else:
        
            app.logger.error("Fail to set the forecast")   

        return result
    
class Forecast(Resource):
    '''Interface to test case forecast data.'''
    
    def get(self):
        '''GET request to receive forecast data.'''
        
        app.logger.info("Receiving a new query for forecast")            
        
        forecast = case.get_forecast()
        return forecast
        
class Name(Resource):
    '''Interface to test case name.'''
    
    def get(self):
        '''GET request to receive test case name.'''
        
        app.logger.info("Receiving a new query for case name")           
        
        name = case.get_name()
        return name
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
api.add_resource(Name, '/name')
# --------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)