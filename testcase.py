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
        self.set_step(int(self.config_json['step']))
        # Set default forecast parameters
        self.set_forecast_parameters(int(self.config_json['horizon']), int(self.config_json['interval']))
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
        self.initialize(int(self.config_json['start_time']), int(self.config_json['warmup_period']))
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
            {<input_name>_activate : bool,
             <input_name>_u        : float}

        Returns
        -------
        status: int
            Indicates whether an advance request has been completed.
            If 200, simulation advance was completed.
            If 400, invalid inputs (non-numeric) were identified.
            If 500, a simulation error occurred.
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
        # Calculate and store the elapsed time
        if hasattr(self, 'tic_time'):
            self.tac_time = time.time()
            self.elapsed_control_time_ratio = np.append(self.elapsed_control_time_ratio, (self.tac_time-self.tic_time)/self.step)

        # Set final time
        self.final_time = self.start_time + self.step
        alert_message = ''
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
                    if key not in self.input_names and key != 'time':
                        status = 400
                        message = "Unexpected input variable: {}".format(key)
                        logging.error(message)
                        return status, message, None                        
                    if key != 'time' and u[key]:                                                 
                        if '_u' in key:
                            if isinstance(u[key], float):
                                value = u[key]
                            else:
                                status = 400
                                message = "Invalid value for {} - value must be a float but is {}".format(key, type(u[key]))
                                logging.error(message)
                                return status, message, None  
                            # Check min/max if not activation input                                
                            checked_value, message = self._check_value_min_max(key, value)
                            if message is not None:
                                logging.warning(message)
                                alert_message = alert_message +'; '+ message    
                        else:
                            if isinstance(u[key], float):
                                value = u[key]
                            else:                            
                                status = 400
                                message = "Invalid value for {} - value must be a float but is {}".format(key, type(u[key]))
                                logging.error(message)            
                                return status, message, None
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
                if alert_message == '':
                    message = "Advancing simulation successfully."
                else:
                    message = alert_message               
                logging.info(message)
                return status, message, payload

            else:
                # Errors in the simulation
                status = 500
                message = "Failed to advance simulation: {}".format(res)
                payload = res
                logging.error(message)
                return status, message, payload
        else:
            # Simulation at end time
            payload = dict()
            message = "End of test case scenario time period reached."
            logging.info(message)

            return status, message, payload

    def initialize(self, start_time, warmup_period, end_time=np.inf):
        '''Initialize the test simulation.

        Parameters
        ----------
        start_time: int
            Start time of simulation to initialize to in seconds.
        warmup_period: int
            Length of time before start_time to simulate for warmup in seconds.
        end_time: int, optional
            Specifies a finite end time to allow the simulation to continue
            Default value is infinite.

        Returns
        -------
        status: int
            Indicates whether an initialization request has been completed.
            If 200, initialization was completed successfully.
            If 400, an invalid start time or warmup period (non-numeric) was identified.
            If 500, an error occurred during the initialization simulation.
        message: str
            Includes detailed debugging information.
        payload: dict
            Contains the full state of measurement and input data at the end
            of the initialization period.
            {<point_name> : <point_value>}.
            If None, an error occurred during the initialization simulation.

        '''

        status = 200
        payload = None
        # Reset fmu
        self.fmu.reset()
        # Reset simulation data storage
        self.__initilize_data()
        self.elapsed_control_time_ratio = np.array([])
        # Check if the inputs are valid
        if not isinstance(start_time, (int,float)):
            status = 400
            message = "Parameter 'start_time' for initializing the test simulation expects an integer but is {}.".format(type(start_time))
            logging.error(message)            
            return status, message, payload
        if not isinstance(warmup_period, (int,float)):
            status = 400
            message = "Parameter 'warmup_period' for initializing the test simulation expects an integer but is {}.".format(type(warmup_period))
            logging.error(message) 
            return status, message, payload
        if start_time < 0:
            status = 400
            message = "Parameter 'start_time' for initializing the test simulation cannot be negative."
            logging.error(message)                         
            return status, message, payload
        if warmup_period < 0:
            status = 400
            message = "Parameter 'warmup_period' for initializing the test simulation cannot be negative."
            logging.error(message)            
            return status, message, payload
        # Check if the inputs are float
        alert_message = ''
        if isinstance(start_time, float):
            message = "WARNING: Parameter 'start_time' for initializing the test simulation expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '         
        if isinstance(warmup_period, float):
            message = "WARNING: Parameter 'warmup_period' for initializing the test simulation expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '
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
            message = alert_message + "Test simulation initialized successfully."
            logging.info(message)

            return status, message, payload

        else:
            payload = None
            status = 500
            message = "Failed to initialize test simulation: {}".format(res)
            logging.error(message)

            return status, message, payload

    def get_step(self):
        '''Returns the current control step in seconds.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the control step has been completed.
            If 200, the step was successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information.
        payload: int
            The current control step.
            None if error during query.

        '''

        status = 200
        message = "Queried the control step successfully."
        payload = None
        try:
            payload = self.step
            logging.info(message)            
        except:
            status = 500
            message = "Failed to query the simulation step: {}.".format(traceback.format_exc())
            logging.error(message)
               
        return status, message, payload

    def set_step(self, step):
        '''Sets the control step in seconds.

        Parameters
        ----------
        step: int
            Control step in seconds.

        Returns
        -------
        status: int
            Indicates whether a request for setting the control step has been completed.
            If 200, the step was successfully set.
            If 400, an invalid simulation step (non-numeric) was identified.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information.
        payload:
            None

        '''

        status = 200
        message = "Control step set successfully."
        payload = None
        if not isinstance(step, (int,float)):
            payload = None
            status = 400
            message = "Parameter 'step' expects an integer but is {}".format(type(step))
            logging.error(message)
            return status, message, payload
        if step < 0:
            status = 400
            message = "Negative value for the control step is not supported"
            logging.error(message)
            return status, message, payload
        alert_message = ''
        if isinstance(step, float):
            message_step = "WARNING: Parameter 'step' expects an integer but is given a float, which is accepted"
            logging.warning(message_step)
            alert_message =  alert_message + message_step +'; '             
        try:      
            self.step = step
            logging.info(alert_message+message)
        except:
            payload = None
            status = 500
            message = "Failed to set the control step: {}.".format(traceback.format_exc())
            logging.error(message)
            return status, message, payload
        logging.info(message)

        return status, message, payload

    def get_inputs(self):
        '''Returns a dictionary of control inputs and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the inputs has been completed.
            If 200, the inputs were successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information.
        payload: dict
            Dictionary of control inputs and their meta-data.
            Returns None if error in getting inputs and meta-data.

        '''

        status = 200
        message = "Queried the inputs successfully."
        payload = None
        try:
            payload = self.inputs_metadata
            logging.info(message)
        except:
            status = 500
            message = "Failed to query the input list: {}.".format(traceback.format_exc()) 
            logging.error(message)         
        
        return status, message, payload

    def get_measurements(self):
        '''Returns a dictionary of measurements and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        status: int
            Indicates whether a request for querying the outputs has been completed.
            If 200, the outputs were successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information.
        payload : dict
            Dictionary of measurements and their meta-data.
            Returns None if error in getting measurements and meta-data.

        '''

        status = 200
        message = "Queried the measurements successfully."
        payload = None
        try:
            payload = self.outputs_metadata
            logging.info(message)
        except:
            status = 500
            message = "Failed to query the measurement list: {}.".format(traceback.format_exc()) 
            logging.error(message)        
        
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
            Indicates whether a request for querying the results has been completed.
            If 200, the results were successfully queried.
            If 400, invalid start time and/or invalid final time (non-numeric) were identified.
            If 500, an internal error occured.
        message: str
            Includes detailed debugging information.
        payload : dict
            Dictionary of variable trajectories with time as lists.
            {'time':[<time_data>],
             'var':[<var_data>]
            }
            Returns None if no variable can be found or a simulation error occurs.

        '''

        status = 200
        if not isinstance(start_time, (int,float)):
            status = 400
            message = "Parameter 'start_time' for getting the results expects an integer but is {}.".format(type(start_time))
            logging.error(message)
            return status, message, None
        if not isinstance(final_time,(int,float)):
            status = 400
            message = "Parameter 'final_time' for getting the results expects an integer but is {}.".format(type(final_time))
            logging.error(message)
            return status, message, None
        alert_message = ''
        if isinstance(start_time, float):
            message = "WARNING: Parameter 'start_time' for getting the results expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '         
        if isinstance(final_time, float):
            message = "WARNING: Parameter 'final_time' for getting the results expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '            
        message = alert_message + "Queried results data successfully for point {}".format(var)
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
            Indicates whether a request for querying the KPIs has been completed.
            If 200, the KPIs were successfully queried.
            If 500, an internal error occured.
        message: str
            Includes detailed debugging information
        payload : dict
            Dictionary containing KPI names and values.
            {<kpi_name>:<kpi_value>}.
            Returns None if error during calculation.

        '''

        status = 200
        message = "Queried KPIs successfully."
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
            payload = None
            status = 500
            message = "Failed to query KPIs: {}".format(traceback.format_exc())
            logging.error(message)
        logging.info(message) 

        return status, message, payload

    def set_forecast_parameters(self, horizon, interval):
        '''Sets the forecast horizon and interval, both in seconds.

        Parameters
        ----------
        horizon: int
            Forecast horizon in seconds.
        interval: int
            Forecast interval in seconds.

        Returns
        -------
        status: int
            Indicates whether a request for setting the forecast parameters has been completed.
            If 200, the parameters were successfully set.
            If 400, invalid horizon and/or interval (non-numeric) were identified.
            If 500, an internal error occured.
        message: str
            Includes detailed debugging information.
        payload : dict
            Dictionary containing forecast parameters names and values:
            {<parameter_name>:<parameter_value>}.
            Returns None if error during setting.

        '''

        status = 200
        message = "Forecast horizon and interval were set successfully."
        payload = dict()
        if isinstance(horizon, (int,float)):
            self.horizon = horizon
        else:
            status = 400
            message = "Parameter 'horizon' for setting the simulation scenario expects an integer but is {}.".format(type(horizon))
            logging.error(message)
            return status, message, payload
        if isinstance(interval, (int,float)):
            self.interval = interval
        else:
            payload = None
            status = 400
            message = "Parameter 'interval' for setting the simulation scenario expects an integer but is {}.".format(type(interval))
            logging.error(message)
            return status, message, payload
        alert_message = ''
        if isinstance(horizon, float):
            message = "WARNING: Parameter 'horizon' for setting the simulation scenario expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '         
        if isinstance(interval, float):
            message = "WARNING: Parameter 'interval' for setting the simulation scenario expects an integer but is given a float, which is accepted"
            logging.warning(message)
            alert_message =  alert_message + message +'; '             
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
            Indicates whether a request for querying the forecast parameters has been completed.
            If 200, the forecast parameters were successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information .
        payload: dict
            Dictionary containing forecast parameters names and values.
            {<parameter_name>:<parameter_value>}

        '''

        status = 200
        message = "Queried the forecast parameters successfully."
        payload = dict()
        if self.horizon is not None and self.interval is not None:
            payload['horizon'] = self.horizon
            payload['interval'] = self.interval
        else:
            status = 500
            message = "Failed to query the forecast parameters: {}".format(traceback.format_exc())
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
            Indicates whether a request for querying the forecast has been successfully completed.
            If 200, the forecast was successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information
        payload: dict
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
            where <variable_name> is a string with the variable
            key and <variable_forecast_trajectory> is a list with
            the forecasted values. 'time' is included as a variable.

        '''

        # Get the forecast
        status = 200
        message = "Queried the forecast data successfully."
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
        '''Sets the test case scenario.

        Parameters
        ----------
        scenario : dict
            {'electricity_price': <'constant' or 'dynamic' or 'highly_dynamic'>,
             'time_period': see available <str> keys for test case
            }
            If any value is None, it will not change existing.

        Returns
        -------
        status: int
            Indicates whether a request for setting the scenario has been completed
            If 200, the scenario was successfully set.
            If 400, invalid electricity_price and/or time_period (non-numeric) were identified.
            If 500, an internal error occurred.
        message: str
            Includes the detailed debug information
        payload: dict
            {'electricity_price': if succeeded in changing then True, else None,
             'time_period': if succeeded then initial measurements, else None
            }
        '''

        status = 200
        message = "Test case scenario was set successfully."
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
                    message = "Scenario parameter electricy_price is: {} " \
                              "but should be 'constant', 'dynamic', or 'highly_dynamic'.". \
                              format(scenario['electricity_price'])
                    logging.error(message)
                    return status, message, payload
                self.scenario['electricity_price'] = scenario['electricity_price']
                payload['electricity_price'] = True
            # Handle timeperiod
            if scenario['time_period']:
                if scenario['time_period'] not in self.days_json:
                    status = 400
                    message = "Scenario parameter time_period is: {} but " \
                              "should one of following: {}". \
                              format(scenario['time_period'], list(self.days_json.keys()))
                    logging.error(message)                              
                    return status, message, payload
                self.scenario['time_period'] = scenario['time_period']
                warmup_period = 7*24*3600.
                key = self.scenario['time_period']
                start_time = self.days_json[key]*24*3600.-7*24*3600.
                end_time = start_time + 14*24*3600.
        except:
            status = 400
            message = "Invalid values for the scenario parameters: {}".format(traceback.format_exc())
            logging.error(message)
            return status, message, payload
        try:
            if scenario['time_period']:
                initialize_payload = self.initialize(int(start_time), int(warmup_period), end_time=end_time)
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
            message = "Failed to set the test case scenario: {}".format(traceback.format_exc())
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
            If 200, the scenario was successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information
        payload: dict
            {'electricity_price': <str>,
             'time_period': <str>
             }

        '''
        
        payload = None
        status = 200
        message = "Querying current test case for scenario successfully."
        try:
            payload = self.scenario
        except:
            status = 500
            message = "Failed to find a current test case scenario setting.  Check it was set properly.: {}".format(traceback.format_exc())
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
            Indicate whether a request for querying the name of the test case has been successfully completed.
            If 200, the name was successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information
        payload :  dict
            Name of test case as {'name': <str>}

        '''

        status = 200
        message = "Queried the name of the test case successfully."
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
            Indicate whether a request for querying the version number of BOPTEST has been completed.
            If 200, the version was successfully queried.
            If 500, an internal error occurred.
        message: str
            Includes detailed debugging information
        payload:  dict
            Version of BOPTEST as {'version': <str>}

        '''

        status = 200
        message = "Queried the version number successfully."
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
        message: str
            Alert messages that input value is truncated to min/max
        '''

        # Get minimum and maximum for variable
        mini = self.inputs_metadata[var]['Minimum']
        maxi = self.inputs_metadata[var]['Maximum']
        message = None
        # Check the value and truncate if necessary
        if value > maxi:
            checked_value = maxi
            message = 'WARNING: value of {0} for {1} is above maximum of {2}.  Using {2}. '.format(value, var, maxi)
        elif value < mini:
            checked_value = mini
            message = 'WARNING: value of {0} for {1} is below minimum of {2}.  Using {2}. '.format(value, var, mini)          
        else:
            checked_value = value

        return checked_value, message

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
