# -*- coding: utf-8 -*-
"""
This module defines the API to the test case used by the REST requests to
perform functions such as advancing the simulation, retreiving test case
information, and calculating and reporting results.

"""

from pyfmi import load_fmu
import numpy as np
import copy
import config
import time
from data.data_manager import Data_Manager
from forecast.forecaster import Forecaster
from kpis.kpi_calculator import KPI_Calculator

class TestCase(object):
    '''Class that implements the test case.

    '''

    def __init__(self):
        '''Constructor.

        '''

        # Get configuration information
        con = config.get_config()
        # Define name
        self.name = con['name']
        # Define simulation model
        self.fmupath = con['fmupath']
        # Load fmu
        self.fmu = load_fmu(self.fmupath)
        self.fmu.set_log_level(7)
        # Get version and check is 2.0
        self.fmu_version = self.fmu.get_version()
        if self.fmu_version != '2.0':
            raise ValueError('FMU must be version 2.0.')
        # Instantiate a data manager for this test case
        self.data_manager = Data_Manager(testcase=self)
        # Load data and the kpis_json for the test case
        self.data_manager.load_data_and_jsons()
        # Instantiate a forecaster for this test case
        self.forecaster = Forecaster(testcase=self)
        # Get available control inputs and outputs
        self.input_names = self.fmu.get_model_variables(causality = 2).keys()
        self.output_names = self.fmu.get_model_variables(causality = 3).keys()
        # Get input and output meta-data
        self.inputs_metadata = self._get_var_metadata(self.fmu, self.input_names, inputs=True)
        self.outputs_metadata = self._get_var_metadata(self.fmu, self.output_names)
        # Initialize simulation data arrays
        self.__initilize_data()
        # Instantiate a KPI calculator for the test case
        self.cal = KPI_Calculator(testcase=self)
        # Set default communication step
        self.set_step(con['step'])
        # Set default forecast parameters
        self.set_forecast_parameters(con['horizon'], con['interval'])
        # Set default price scenario
        self.set_scenario(con['scenario'])
        # Set default fmu simulation options
        self.options = self.fmu.simulate_options()
        self.options['CVode_options']['rtol'] = 1e-6
        # Assign initial testing time
        self.initial_time = 0
        # Set initial fmu simulation start
        self.start_time = 0
        self.initialize_fmu = True
        self.options['initialize'] = self.initialize_fmu
        self.elapsed_control_time = []

    def __initilize_data(self):
        '''Initializes objects for simulation data storage.

        Uses self.output_names and self.input_names to create
        self.y, self.y_store, self.u, and self.u_store.

        Parameters
        ----------
        None

        Returns
        -------
        None

        '''

        # Outputs data
        self.y = {'time':np.array([])}
        for key in self.output_names:
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
        # Simulate fmu
        try:
             res = self.fmu.simulate(start_time = start_time,
                                     final_time = end_time,
                                     options=self.options,
                                     input=input_object)
        except Exception as e:
            return None
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
            Set to true if desired to store initial point.

        '''

        # Determine if store initial point
        if store_initial:
            i = 0
        else:
            i = 1
        # Get result and store measurement
        for key in self.y.keys():
            self.y[key] = res[key][-1]
            if store:
                self.y_store[key] = np.append(self.y_store[key], res[key][i:])

        # Store control inputs
        if store:
            for key in self.u.keys():
                self.u_store[key] = np.append(self.u_store[key], res[key][i:])

    def advance(self,u):
        '''Advances the test case model simulation forward one step.

        Parameters
        ----------
        u : dict
            Defines the control input data to be used for the step.
            {<input_name> : <input_value>}

        Returns
        -------
        y : dict
            Contains the measurement data at the end of the step.
            {<measurement_name> : <measurement_value>}
            If empty, simulation end time has been reached.

        '''

        # Calculate and store the elapsed time
        if hasattr(self, 'tic_time'):
            self.tac_time = time.time()
            self.elapsed_control_time.append(self.tac_time-self.tic_time)

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
                        value = float(u[key])
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
            res = self.__simulation(self.start_time,self.final_time,input_object)
            # Process results
            if res is not None:
                # Get result and store measurement and control inputs
                self.__get_results(res, store=True, store_initial=False)
                # Advance start time
                self.start_time = self.final_time
                # Raise the flag to compute time lapse
                self.tic_time = time.time()

                return self.y

            else:
                # Error in simulation
                return None
        else:
            # Simulation at end time
            return dict()



    def initialize(self, start_time, warmup_period, end_time=np.inf):
        '''Initialize the test simulation.

        Parameters
        ----------
        start_time: int
            Start time of simulation to initialize to in seconds.
        warmup_period: int
            Length of time before start_time to simulate for warmup in seconds.
        end_time: int, optional
            Specifies a finite end time to allow simulation to continue
            Default value is infinite.

        Returns
        -------
        y : dict
            Contains the measurement data at the end of the initialization.
            {<measurement_name> : <measurement_value>}

        '''

        # Reset fmu
        self.fmu.reset()
        # Reset simulation data storage
        self.__initilize_data()
        self.elapsed_control_time = []
        # Record initial testing time
        self.initial_time = start_time
        # Record end testing time
        self.end_time = end_time
        # Set fmu intitialization
        self.initialize_fmu = True
        # Simulate fmu for warmup period.
        # Do not allow negative starting time to avoid confusions
        res = self.__simulation(max(start_time-warmup_period,0), start_time)
        # Process result
        if res is not None:
            # Get result
            self.__get_results(res, store=True, store_initial=True)
            # Set internal start time to start_time
            self.start_time = start_time
            # Initialize KPI Calculator
            self.cal.initialize()
            return self.y

        else:

            return None

    def get_step(self):
        '''Returns the current simulation step in seconds.'''

        return self.step

    def set_step(self,step):
        '''Sets the simulation step in seconds.

        Parameters
        ----------
        step : int
            Simulation step in seconds.

        Returns
        -------
        None

        '''

        self.step = float(step)

        return None

    def get_inputs(self):
        '''Returns a dictionary of control inputs and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        inputs : dict
            Dictionary of control inputs and their meta-data.

        '''

        inputs = self.inputs_metadata

        return inputs

    def get_measurements(self):
        '''Returns a dictionary of measurements and their meta-data.

        Parameters
        ----------
        None

        Returns
        -------
        measurements : dict
            Dictionary of measurements and their meta-data.

        '''

        measurements = self.outputs_metadata

        return measurements

    def get_results(self, var, start_time, final_time):
        '''Returns measurement and control input trajectories.

        Parameters
        ----------
        var : str
            Name of variable.
        start_time : float
            Start time of data to return in seconds.
        final_time : float
            Start time of data to return in seconds.

        Returns
        -------
        Y : dict or None
            Dictionary of variable trajectories with time as lists.
            {'time':[<time_data>],
             'var':[<var_data>]
            }
            Returns None if no variable can be found

        '''

        # Get correct point
        if var in self.y_store.keys():
            Y = {'time':self.y_store['time'],
                 var:self.y_store[var]
                 }
        elif var in self.u_store.keys():
            Y = {'time':self.u_store['time'],
                 var:self.u_store[var]
                 }
        else:
            Y = None
            return Y

        # Get correct time
        time1 = Y['time']
        for key in [var,'time']:
            Y[key] = Y[key][time1>=start_time]
            time2 = time1[time1>=start_time]
            Y[key] = Y[key][time2<=final_time]

        return Y

    def get_kpis(self):
        '''Returns KPI data.

        Requires standard sensor signals.

        Parameters
        ----------
        None

        Returns
        -------
        kpis : dict
            Dictionary containing KPI names and values.
            {<kpi_name>:<kpi_value>}

        '''

        # Set correct price scenario for cost
        if self.scenario['electricity_price'] == 'constant':
            price_scenario = 'Constant'
        elif self.scenario['electricity_price'] == 'dynamic':
            price_scenario = 'Dynamic'
        elif self.scenario['electricity_price'] == 'highly_dynamic':
            price_scenario = 'HighlyDynamic'
        # Calculate the core kpis
        kpis = self.cal.get_core_kpis(price_scenario=price_scenario)

        return kpis

    def set_forecast_parameters(self,horizon,interval):
        '''Sets the forecast horizon and interval, both in seconds.

        Parameters
        ----------
        horizon : int
            Forecast horizon in seconds.
        interval : int
            Forecast interval in seconds.

        Returns
        -------
        None

        '''

        self.horizon = float(horizon)
        self.interval = float(interval)

        return None

    def get_forecast_parameters(self):
        '''Returns the current forecast horizon and interval parameters.'''

        forecast_parameters = dict()
        forecast_parameters['horizon'] = self.horizon
        forecast_parameters['interval'] = self.interval

        return forecast_parameters

    def get_forecast(self):
        '''Returns the test case data forecast

        Parameters
        ----------
        None

        Returns
        -------
        forecast : dict
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
            where <variable_name> is a string with the variable
            key and <variable_forecast_trajectory> is a list with
            the forecasted values. 'time' is included as a variable

        '''

        # Get the forecast
        forecast = self.forecaster.get_forecast(horizon=self.horizon,
                                                interval=self.interval)

        return forecast

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
        result : dict
            {'electricity_price': if succeeded in changing then True, else None,
             'time_period': if succeeded then initial measurements, else None
             }
        '''

        result = {'electricity_price':None,
                  'time_period':None}

        if not hasattr(self,'scenario'):
            self.scenario = {}
        # Handle electricity price
        if scenario['electricity_price']:
            try:
                self.scenario['electricity_price'] = scenario['electricity_price']
                result['electricity_price'] = True
            except Exception as e:
                pass
        # Handle timeperiod
        if scenario['time_period']:
            try:
                self.scenario['time_period'] = scenario['time_period']
                warmup_period = 7*24*3600
                key = self.scenario['time_period']
                start_time = self.days_json[key]*24*3600-7*24*3600
                end_time = start_time + 14*24*3600
                result['time_period'] = self.initialize(start_time, warmup_period, end_time=end_time)
            except Exception as e:
                pass

        # It's needed to reset KPI Calculator when scenario is changed
        self.cal.initialize()

        return result

    def get_scenario(self):
        '''Returns the current case scenario.'''

        scenario = self.scenario

        return scenario

    def get_name(self):
        '''Returns the name of the test case fmu.

        Parameters
        ----------
        None

        Returns
        -------
        name : dict
            Name of test case as {'name': <str>}

        '''

        name = {'name':self.name}

        return name

    def get_elapsed_control_time(self):
        '''Returns the elapsed control time vector for the case.

        Parameters
        ----------
        None

        Returns
        -------
        elapsed_control_time : list of floats
            elapsed_control_time for each control step.

        '''

        elapsed_control_time = self.elapsed_control_time

        return elapsed_control_time

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
            print('WARNING: Value of {0} for {1} is above maximum of {2}.  Using {2}.'.format(value, var, maxi))
        elif value < mini:
            checked_value = mini
            print('WARNING: Value of {0} for {1} is below minimum of {2}.  Using {2}.'.format(value, var, mini))
        else:
            checked_value = value

        return checked_value
