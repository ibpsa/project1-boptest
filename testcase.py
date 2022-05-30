# -*- coding: utf-8 -*-
"""
This module defines the API to the test case used by the REST requests to
perform functions such as advancing the simulation, retrieving test case
information, and calculating and reporting results.

"""

from pyfmi import load_fmu
import numpy as np
import copy
import time
from data.data_manager import Data_Manager
from forecast.forecaster import Forecaster
from kpis.kpi_calculator import KPI_Calculator
import traceback
import logging

class TestCase(object):
    '''Class that implements the test case.

    '''

    def __init__(self, fmupath='models/wrapped.fmu'):
        '''Constructor.

        Parameters
        ----------
        fmupath : str, optional
            Path to the test case fmu.
            Default is assuming a particular directory structure.

        '''

        # Set BOPTEST version number
        with open('version.txt', 'r') as f:
            self.version = f.read()
        # Set test case fmu path
        self.fmupath = fmupath
        # Instantiate a data manager for this test case
        self.data_manager = Data_Manager(testcase=self)
        # Load data and the kpis_json for the test case
        self.data_manager.load_data_and_jsons()
        # Instantiate a forecaster for this test case
        self.forecaster = Forecaster(testcase=self)
        # Define name
        self.name = self.config_json['name']
        # Load fmu
        self.fmu = load_fmu(self.fmupath)
        # Configure the log
        logging.basicConfig(filename='boptest.log', level=logging.INFO)
        self.fmu.set_log_level(7)
        # Get version and check is 2.0
        self.fmu_version = self.fmu.get_version()
        if self.fmu_version != '2.0':
            raise ValueError('FMU must be version 2.0.')
        # Get building area
        self.area = self.config_json['area']
        # Get available control inputs and outputs
        self.input_names = self.fmu.get_model_variables(causality = 2).keys()
        self.output_names = self.fmu.get_model_variables(causality = 3).keys()
        # Set default communication step
        self.set_step(self.config_json['step'])
        # Set default forecast parameters
        self.set_forecast_parameters(self.config_json['horizon'], self.config_json['interval'])
        # Initialize simulation data arrays
        self.__initilize_data()
        # Set default fmu simulation options
        self.options = self.fmu.simulate_options()
        self.options['CVode_options']['rtol'] = 1e-6
        self.options['CVode_options']['store_event_points'] = False
        self.options['filter'] = self.output_names + self.input_names
        # Instantiate a KPI calculator for the test case
        self.cal = KPI_Calculator(testcase=self)
        # Initialize test case
        self.initialize(self.config_json['start_time'], self.config_json['warmup_period'])
        # Set default scenario
        self.set_scenario(self.config_json['scenario'])

    def __initilize_data(self):
        '''Initializes objects for simulation data storage.

        Uses self.output_names and self.input_names to create
        self.y, self.y_store, self.u, self.u_store,
        self.inputs_metadata, self.outputs_metadata.

        Parameters
        ----------
        None

        Returns
        -------
        None

        '''

        # Get input and output meta-data
        self.inputs_metadata = self._get_var_metadata(self.fmu, self.input_names, inputs=True)
        self.outputs_metadata = self._get_var_metadata(self.fmu, self.output_names)
        # Outputs data
        self.y = {'time': np.array([])}
        for key in self.output_names:
            # Do not store outputs that are current values of control inputs
            flag = False
            for key_u in self.input_names:
                if key[:-2] == key_u[:-2]:
                    flag = True
                    break
            if flag:
                # Remove outputs that are current values of control inputs
                # from outputs metadata dictionary
                self.outputs_metadata.pop(key)
            else:
                self.y[key] = np.array([])
        self.y_store = copy.deepcopy(self.y)
        # Inputs data
        self.u = {'time':np.array([])}
        for key in self.input_names:
            self.u[key] = np.array([])
        self.u_store = copy.deepcopy(self.u)

    def __simulation(self,start_time,end_time,input_object=None):
        '''Simulates the FMU using the pyfmi fmu.simulate function.

        Parameters
        ----------
        start_time: int
            Start time of simulation in seconds.
        final_time: int
            Final time of simulation in seconds.
        input_object: pyfmi input_object, optional
            Input object for simulation
            Default is None

        Returns
        -------
        res: pyfmi results object
            Results of the fmu simulation.

        '''

        # Set fmu initialization option
        self.options['initialize'] = self.initialize_fmu
        # Set sample rate
        self.options['ncp'] = int((end_time-start_time)/30)
        # Simulate fmu
        try:
            res = self.fmu.simulate(start_time=start_time,
                                    final_time=end_time,
                                    options=self.options,
                                    input=input_object)
        except:
            return traceback.format_exc()
        # Set internal fmu initialization
        self.initialize_fmu = False
        
        return res

    def __get_results(self, res, store=True, store_initial=False):
        '''Get results at the end of a simulation and throughout the
        simulation period for storage. This method assigns these results
        to `self.y` and, if `store=True`, also to `self.y_store` and
        to `self.u_store`.
        This method is used by `initialize()` and `advance()` to retrieve
        results. `initialize()` does not store results whereas `advance()`
        does.

        Parameters
        ----------
        res: pyfmi results object
            Results of the fmu simulation.
        store: boolean
            Set to true if desired to store results in `self.y_store` and
            `self.u_store`
        store_initial: boolean
            Set to true if desired to store the initial point.

        '''
        
        # Determine if store initial point
        if store_initial:
            i = 0
        else:
            i = 1
        # Store measurements
        for key in self.y.keys():
            self.y[key] = res[key][-1]
            if store:
                self.y_store[key] = np.append(self.y_store[key], res[key][i:])
        # Store control signals (will be baseline if not activated, test controller input if activated)
        for key in self.u.keys():
            # Replace '_u' and '_y' for key used to collect data and don't overwrite time
            if key[-2:] == '_u':
                key_data = key[:-2]+'_y'
            elif key == 'time':
                key_data = 'time'
            else:
                key_data = key
            self.u[key] = res[key_data][-1]
            if store:
                self.u_store[key] = np.append(self.u_store[key], res[key_data][i:])

    def advance(self, u):
        '''Advances the test case model simulation forward one step.

        Parameters
        ----------
        u : dict
            Defines the control input data to be used for the step.
            {<input_name> : <input_value>}

        Returns
        -------
        status: int
            Indicates whether an advance request has been completed
            If 200, advancing simulation is completed.
            If 400, invalid inputs (non-numeric) are identified.
            If 500, a simulation error has occurred.            
        message: str
            Includes the debug information
        payload: dict
            Contains the full state of measurement and input data at the end
            of the step.
            {<point_name> : <point_value>}
            If empty, simulation end time has been reached.
            If None, a simulation error has occurred.
        '''
        
        status = 200
        warnings = ""
        # Calculate and store the elapsed time
        if hasattr(self, 'tic_time'):
            self.tac_time = time.time()
            self.elapsed_control_time_ratio = np.append(self.elapsed_control_time_ratio, (self.tac_time-self.tic_time)/self.step)
        invalid_points = []
        for point in u.keys():
            if point not in self.u.keys():
                invalid_points.append(point)
        if invalid_points:
            status = 400
            message = "Invalid control input to advance simulation: {}".format(invalid_points)
            logging.error(message)
            return status, message, None
        # Set final time
        self.final_time = self.start_time + self.step
        # Set control inputs if they exist and are written
        # Check if possible to overwrite
        if u.keys():
            # If there are overwriting keys available
            # Check that any are overwritten
            written = False
            for key in u.keys():
                if u[key]:
                    written = True
                    break
            # If there are, create input object
            if written:
                u_list = []
                u_trajectory = self.start_time
                for key in u.keys():
                    if key != 'time' and u[key]:                        
                        try:
                            value = float(u[key])
                        except:
                            status = 400
                            message = "Invalid value for {} - value must be a float".format(key)
                            logging.error(message)
                            return status, message, None                            
                        # Check min/max if not activation input
                        if '_activate' not in key:
                            checked_value = self._check_value_min_max(key, value)
                        else:
                            checked_value = value
                        u_list.append(key)
                        u_trajectory = np.vstack((u_trajectory, checked_value))
                input_object = (u_list, np.transpose(u_trajectory))
            # Otherwise, input object is None
            else:
                input_object = None
        # Otherwise, input object is None
        else:
            input_object = None
        # Simulate if not end of test
        if self.start_time < self.end_time:
            # Make sure stop at end of test
            if self.final_time > self.end_time:
                self.final_time = self.end_time
            res = self.__simulation(self.start_time, self.final_time, input_object)
            # Process results
            if not isinstance(res, str):
                # Get result and store measurement and control inputs
                self.__get_results(res, store=True, store_initial=False)
                # Advance start time
                self.start_time = self.final_time
                # Raise the flag to compute time lapse
                self.tic_time = time.time()
                # Get full current state
                payload = self._get_full_current_state()
                message = "Advancing simulation successfully."
                logging.info(message)
                return status, message, payload

            else:
                # Error in
                status = 500
                message = "Failed to advancing simulation: {}"
                payload = res
                logging.error(message.format(res))
                return status, message, payload
        else:
            # Simulation at end time
            payload = dict()
            message = "Simulation completes."
            logging.info(message)
            
            return status, message, payload

    def initialize(self, start_time, warmup_period, end_time=np.inf):
        '''Initialize the test simulation.

        Parameters
        ----------
        start_time: float
            Start time of simulation to initialize to in seconds.
        warmup_period: float
            Length of time before start_time to simulate for warmup in seconds.
        end_time: float, optional
            Specifies a finite end time to allow the simulation to continue
            Default value is infinite.

        Returns
        -------
        status: int
            Indicates whether an initialization request has been completed
            If 200, initialization is completed.
            If 400, An invalid start time or warmup period (non-numeric) is identified.
            If 500, a simulation error has occurred.            
        message: str
            Includes the detailed debug information
        payload: dict
            Contains the full state of measurement and input data at the end
            of the initialization.
            {<point_name> : <point_value>}.
            If None, a simulation error has occurred.

        '''
        
        status = 200
        payload = None
        # Reset fmu
        self.fmu.reset()
        # Reset simulation data storage
        self.__initilize_data()
        self.elapsed_control_time_ratio = np.array([])
        # Check if the inputs are valid
        try:
            start_time = float(start_time)
        except:
            status = 400
            message = "parameter 'start_time' must be a float but is {}.".format(type(start_time))
            logging.error(message)            
            return status, message, payload
        try: 
            warmup_period = float(warmup_period)        
        except:
            status = 400
            message = "parameter 'warmup_period' must be a float but is {}.".format(type(warmup_period))
            return status, message, payload
        if start_time < 0:
            status = 400
            message = "parameter 'start_time' cannot be negative for initializing simulation."
            return status, message, payload
        if warmup_period < 0:
            status = 400
            message = "parameter 'warmup_period' cannot be negative for initializing simulation."
            return status, message, payload
        # Record initial testing time
        self.initial_time = start_time
        # Record end testing time
        self.end_time = end_time
        # Set fmu intitialization
        self.initialize_fmu = True
        # Simulate fmu for warmup period.
        # Do not allow negative starting time to avoid confusions
        res = self.__simulation(max(start_time-warmup_period, 0), start_time)
        # Process result
        if not isinstance(res, str):
            # Get result
            self.__get_results(res, store=True, store_initial=True)
            # Set internal start time to start_time
            self.start_time = start_time
            # Initialize KPI Calculator
            self.cal.initialize()
            # Get full current state
            payload = self._get_full_current_state()
            message = "Initializing simulation successfully."
            logging.info(message)
            
            return status, message, payload

        else:
            status = 500
            message = "Failed to initialize simulation : {}".format(res)
            logging.error(message)
            
            return status, message, {}

    def get_step(self):
        '''Returns the current simulation step in seconds.
               
        Parameters
        ----------
        None        

        Returns
        -------
        status: int
            Indicates whether a request for querying the simulation step has been completed
            If 200, the step is successfully queried.
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information
        payload: int
            The current simulation step.        
        
        '''
        
        status = 200
        message = "Querying the simulation step successfully."
        payload = None
        if self.step is not None:
            logging.info(message)
            payload = self.step
            return status, message, payload
        status = 400
        message = "Query the simulation step failed."
        logging.error(message)
               
        return status, message, payload

    def set_step(self, step):
        '''Sets the simulation step in seconds.

        Parameters
        ----------
        step: int
            Simulation step in seconds.

        Returns
        -------
        status: int
            Indicates whether a request for setting the simulation step has been completed
            If 200, the step is successfully set.
            If 400, an invalid simulation step (non-numeric) is identified.            
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information
        payload:
            None 

        '''
        
        status = 200
        message = "Setting the simulation step successfully."
        payload = None
        try:
            step = int(step)
        except:
            status = 400
            message = "parameter 'step' must be a number but is {}".format(type(step))
            logging.error(message)
            return status, message, payload
        if step < 0:
            status = 400
            message = "parameter 'step' can't be negative"
            logging.error(message)
            return status, message, payload
        try:
            self.step = step
        except:
            status = 500
            message = "Failed to set the simulation step: {}.".format(traceback.format_exc()) 
            logging.error(message)
            return status, message, payload
        logging.info(message)
        payload = None
        
        return status, message, payload

    def get_inputs(self):
        '''Returns a dictionary of control inputs and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicate whether a request for querying the inputs has been completed
            If 200, the inputs are successfully queried.           
            If 500, a internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload: dict
            Dictionary of control inputs and their meta-data.

        '''
        
        status = 200
        message = "Querying the input list successfully."
        payload = None
        if self.inputs_metadata is not None:
            payload = self.inputs_metadata
        else:
            status = 400
            message = "Failed to query the input list."
            logging.error(message)
        logging.info(message) 
        
        return status, message, payload

    def get_measurements(self):
        '''Returns a dictionary of measurements and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the outputs has been completed
            If 200, the outputs are successfully queried.           
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload : dict
            Dictionary of measurements and their meta-data.

        '''

        status = 200
        message = "Querying the measurement list successfully."
        payload = None
        if self.outputs_metadata is not None:
            payload = self.outputs_metadata
        else:
            status = 400
            message = "Failed to query the measurement list: {}"
            logging.error(message)
        logging.info(message)
        
        return status, message, payload

    def get_results(self, var, start_time, final_time):
        '''Returns measurement and control input trajectories.

        Parameters
        ----------
        var: str
            Name of variable.
        start_time : float
            Start time of data to return in seconds.
        final_time : float
            Start time of data to return in seconds.

        Returns
        -------
        status: int
            Indicates whether a request for querying the results has been completed
            If 200, the results are successfully queried.  
            If 400, invalid start time and/or invalid final time (non-numeric) are identified.                
            If 500, an internal error has occured.            
        message: str
            Includes the detailed debug information        
        payload : dict
            Dictionary of variable trajectories with time as lists.
            {'time':[<time_data>],
             'var':[<var_data>]
            }
            Returns None if no variable can be found or a simulation error occurs

        '''
        
        status = 200
        try:
            start_time = float(start_time)                                    
        except:
            status = 400
            message = "parameter 'start_time' must be a float but is {}.".format(type(start_time))
            logging.error(message)
            return status, message, None
        try:
            final_time = float(final_time)
        except:            
            status = 400
            message = "parameter 'final_time' must be a float but is {}.".format(type(final_time))
            logging.error(message)
            return status, message, None
        message = "Querying simulation results successfully."
        payload = []
        try:
            # Get correct point
            if var in self.y_store.keys():
                payload = {
                    'time': self.y_store['time'],
                     var: self.y_store[var]
                }
            elif var in self.u_store.keys():
                payload = {
                    'time': self.u_store['time'],
                     var: self.u_store[var]
                }
            else:
                status = 400
                message = "Problem in get_results, {} is not a valid point name".format(var)
                logging.error(message)
                return status, message, None

            # Get correct time
            if payload and 'time' in payload:
                time1 = payload['time']
                for key in [var, 'time']:
                    payload[key] = payload[key][time1>=start_time]
                    time2 = time1[time1>=start_time]
                    payload[key] = payload[key][time2<=final_time]
        except:
            status = 500
            message = "Failed to query simulation results: {}".format(traceback.format_exc())
            logging.error(message)
            return status, message, None            
        if not isinstance(payload, (list, type(None))):
            for key in payload:
                payload[key] = payload[key].tolist()
        logging.info(message)  
        
        return status, message, payload

    def get_kpis(self):
        '''Returns KPI data.

        Requires standard sensor signals.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the KPIs has been completed
            If 200, the KPIs are successfully queried.           
            If 500, a internal error has occured.            
        message: str
            Includes the detailed debug information        
        payload : dict        
            Dictionary containing KPI names and values.
            {<kpi_name>:<kpi_value>}

        '''
        
        status = 200
        message = "Querying simulation for KPIs successfulyl."
        payload = None
        try:
            # Set correct price scenario for cost
            if self.scenario['electricity_price'] == 'constant':
                price_scenario = 'Constant'
            elif self.scenario['electricity_price'] == 'dynamic':
                price_scenario = 'Dynamic'
            elif self.scenario['electricity_price'] == 'highly_dynamic':
                price_scenario = 'HighlyDynamic'
            # Calculate the core kpis
            payload = self.cal.get_core_kpis(price_scenario=price_scenario)
        except:
            status = 500
            message = "Failed to query KPIs: {}".format(traceback.format_exc())
            logging.error(message)
        logging.info(message) 

        return status, message, payload

    def set_forecast_parameters(self, horizon, interval):
        '''Sets the forecast horizon and interval, both in seconds.

        Parameters
        ----------
        horizon: float
            Forecast horizon in seconds.
        interval: float
            Forecast interval in seconds.

        Returns
        -------
        status: int
            Indicates whether a request for setting the forecast parameters has been completed
            If 200, the parameters are successfully set.  
            If 400, invalid forecast horizon and/or invalid interval (non-numeric) are identified.                
            If 500, a internal error has occured.            
        message: str
            Includes the detailed debug information        
        payload : dict        
            Dictionary containing forecast parameters names and values.
            {<parameter_name>:<parameter_value>}      

        '''
        
        status = 200
        message = "Setting forecast horizon and interval successfully."
        payload = dict()       
        try:
            self.horizon = float(horizon)
        except:
            status = 400
            message = "parameter 'horizon' must be a number but is {}.".format(type(horizon))
            logging.error(message)
            return status, message, payload
        try:            
            self.interval = float(interval)
        except:
            status = 400
            message = "parameter 'interval' must be a number but is {}.".format(type(interval))
            logging.error(message)
        try:
            payload['horizon'] = self.horizon
            payload['interval'] = self.interval
        except:
            status = 500
            message = "Failed to set forecast horizon and interval: {}".format(traceback.format_exc())
            logging.error(message)
        logging.info(message) 
        
        return status, message, payload

    def get_forecast_parameters(self):
        '''Returns the current forecast horizon and interval parameters.
        
        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the forecast parameters has been completed
            If 200, the forecast parameters are successfully queried.           
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload: dict        
            Dictionary containing forecast parameters names and values.
            {<parameter_name>:<parameter_value>} 
        
        '''
        
        status = 200
        message = "Querying simulation for forecast parameters successfully."
        payload = dict()
        if self.horizon is not None and self.interval is not None:
            payload['horizon'] = self.horizon
            payload['interval'] = self.interval
        else:
            status = 500
            message = "Failed to query the forecast parameters."
            logging.error(message)
        logging.info(message)
        
        return status, message, payload

    def get_forecast(self):
        '''Returns the test case data forecast

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the forecast has been successfully completed
            If 200, the forecast is successfully queried.                 
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload: dict        
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
            where <variable_name> is a string with the variable
            key and <variable_forecast_trajectory> is a list with
            the forecasted values. 'time' is included as a variable

        '''

        # Get the forecast
        status = 200
        message = "Querying simulation for forecast successfully."
        try:
            payload = self.forecaster.get_forecast(horizon=self.horizon,
                                                    interval=self.interval)
        except:
            status = 500
            message = "Failed to query the test case forecast data: {}".format(traceback.format_exc())
            payload = None
            logging.error(message)
        logging.info(message)
        
        return status, message, payload

    def set_scenario(self, scenario):
        '''Sets the case scenario.

        Parameters
        ----------
        scenario : dict
            {'electricity_price': <'constant' or 'dynamic' or 'highly_dynamic'>,
             'time_period': see available keys for test case
            }
            If any value is None, it will not change existing.

        Returns
        -------
        status: int
            Indicates whether a request for setting the scenario has been completed
            If 200, the scenario is successfully set.  
            If 400, invalid electricity_price and/or time_period (non-numeric) are identified.                
            If 500, an internal error has occurred.             
        message: str
            Includes the detailed debug information        
        payload: dict        
            {'electricity_price': if succeeded in changing then True, else None,
             'time_period': if succeeded then initial measurements, else None
            }
        '''
        
        status = 200
        message = "Setting simulation scenario successfully."
        payload = {
            'electricity_price': None,
            'time_period': None
        }
        if not hasattr(self, 'scenario'):
            self.scenario = {}                                    
        try:
            # Handle electricity price
            if scenario['electricity_price']:
                if scenario['electricity_price'] not in ['constant', 'dynamic', 'highly_dynamic']:
                    status = 400
                    message = "Scenario parameter electricy_price is {} " \
                              "but should be constant', 'dynamic', or 'highly_dynamic.". \
                              format(scenario['electricity_price'])
                    logging.error(message)
                    return status, message, payload
                self.scenario['electricity_price'] = scenario['electricity_price']
                payload['electricity_price'] = True
            # Handle timeperiod
            if scenario['time_period']:
                if scenario['time_period'] not in self.days_json:
                    status = 400
                    message = "Scenario parameter time_period is {} but " \
                              "should one of following: {}". \
                              format(scenario['time_period'], list(self.days_json.keys()))
                    return status, message, payload
                self.scenario['time_period'] = scenario['time_period']
                warmup_period = 7*24*3600
                key = self.scenario['time_period']
                start_time = self.days_json[key]*24*3600-7*24*3600
                end_time = start_time + 14*24*3600
        except:
            status = 400
            message = "Invalid values for the scenario parameters: {}".format(traceback.format_exc())
            logging.error(message)
            return status, message, payload
        try:
            if scenario['time_period']:
                initialize_payload = self.initialize(start_time, warmup_period, end_time=end_time)
                if initialize_payload[0] != 200:
                    status = 500
                    message = initialize_payload[1]
                    logging.error(message)
                    return status, message, payload
                payload['time_period'] = initialize_payload[2]
            # It's needed to reset KPI Calculator when scenario is changed
            self.cal.initialize()
        except:
            status = 500
            message = "Failed to set the case scenario: {}".format(traceback.format_exc())
            payload = None
            logging.error(message)
        logging.info(message)

        return status, message, payload

    def get_scenario(self):
        '''Returns the current case scenario.
        
        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the scenario has been successfully completed
            If 200, the scenario is successfully queried.                 
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload:  dict        
            {'electricity_price': if succeeded in changing then True, else None,
             'time_period': if succeeded then initial measurements, else None
             }
            
        '''
        
        payload = None
        status = 200
        message = "Querying simulation for scenario successfully."
        if self.scenario is not None:
            payload = self.scenario
        else:
            status = 500
            message = "Failed to query simulation for scenario."
            logging.error(message)
        logging.info(message)
        
        return status, message, payload

    def get_name(self):
        '''Returns the name of the test case fmu.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicate whether a request for querying the name of the test case fmu has been successfully completed
            If 200, the name is successfully queried.                 
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload :  dict  
            Name of test case as {'name': <str>}

        '''
        
        status = 200
        message = "Querying the name of the test case fmu successfully"
        payload = {'name': self.name}
        logging.info(message)
        
        return status, message, payload

    def get_elapsed_control_time_ratio(self):
        '''Returns the elapsed control time ratio vector for the case.

        Parameters
        ----------
        None

        Returns
        -------
        elapsed_control_time_ratio : np array of floats
            elapsed_control_time_ratio for each control step.

        '''

        elapsed_control_time_ratio = self.elapsed_control_time_ratio

        return elapsed_control_time_ratio

    def get_version(self):
        '''Returns the version number of BOPTEST.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicate whether a request for querying the version number of BOPTEST has been completed
            If 200, the name is successfully queried.                 
            If 500, an internal error has occurred.            
        message: str
            Includes the detailed debug information        
        payload:  dict
            Version of BOPTEST as {'version': <str>}

        '''

        status = 200
        message = "Querying the version number successfully"
        logging.info(message)
        payload = {'version': self.version}
        
        return status, message, payload

    def _get_var_metadata(self, fmu, var_list, inputs=False):
        '''Build a dictionary of variables and their metadata.

        Parameters
        ----------
        fmu : pyfmi fmu object
            FMU from which to get variable metadata
        var_list : list of str
            List of variable names

        Returns
        -------
        var_metadata : dict
            Dictionary of variable names as keys and metadata as fields.
            {<var_name_str> :
                "Unit" : str,
                "Description" : str,
                "Minimum" : float,
                "Maximum" : float
            }

        '''

        # Inititalize
        var_metadata = dict()
        # Get metadata
        for var in var_list:
            # Units
            if var == 'time':
                unit = 's'
                description = 'Time of simulation'
                mini = None
                maxi = None
            elif '_activate' in var:
                unit = None
                description = fmu.get_variable_description(var)
                mini = None
                maxi = None
            else:
                unit = fmu.get_variable_unit(var)
                description = fmu.get_variable_description(var)
                if inputs:
                    mini = fmu.get_variable_min(var)
                    maxi = fmu.get_variable_max(var)
                else:
                    mini = None
                    maxi = None
            var_metadata[var] = {'Unit':unit,
                                 'Description':description,
                                 'Minimum':mini,
                                 'Maximum':maxi}

        return var_metadata

    def _check_value_min_max(self, var, value):
        '''Check that the input value does not violate the min or max.

        Note that if it does, the value is truncated to the minimum or maximum.

        Parameters
        ----------
        var : str
            Name of variable
        value : numeric
            Specified value of variable

        Return
        ------
        checked_value : float
            Value of variable truncated by min and max.

        '''

        # Get minimum and maximum for variable
        mini = self.inputs_metadata[var]['Minimum']
        maxi = self.inputs_metadata[var]['Maximum']
        # Check the value and truncate if necessary
        if value > maxi:
            checked_value = maxi
            logging.warning('Value of {0} for {1} is above maximum of {2}.  Using {2}.'.format(value, var, maxi))
        elif value < mini:
            checked_value = mini
            logging.warning('Value of {0} for {1} is below minimum of {2}.  Using {2}.'.format(value, var, mini))            
        else:
            checked_value = value

        return checked_value

    def _get_area(self):
        '''Get the building floor area in m^2.

        Returns
        -------
        area: float
            Building floor area in m^2

        '''

        area = self.area

        return area

    def _get_full_current_state(self):
        '''Combines the self.y and self.u dictionaries into one.

        Returns
        -------
        z: dict
            Combination of self.y and self.u dictionaries.

        '''

        z = self.y.copy()
        z.update(self.u)

        return z