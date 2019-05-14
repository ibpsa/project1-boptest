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
import cPickle as pickle
from kpis.kpi_calculator import KPI_Calculator
from forecast.forecaster import Forecaster

class TestCase(object):
    '''Class that implements the test case.
    
    '''
    
    def __init__(self):
        '''Constructor.
        
        '''
        
        # Get configuration information
        con = config.get_config()
        # Define simulation model
        self.fmupath = con['fmupath']
        # Load fmu
        self.fmu = load_fmu(self.fmupath, enable_logging=True)
        # Get version and check is 2.0
        self.fmu_version = self.fmu.get_version()
        if self.fmu_version != '2.0':
            raise ValueError('FMU must be version 2.0.')
        # Get available control inputs and outputs
        input_names = self.fmu.get_model_variables(causality = 2).keys()
        output_names = self.fmu.get_model_variables(causality = 3).keys()
        # Get input and output meta-data
        self.inputs_metadata = self._get_var_metadata(self.fmu, input_names, inputs=True)
        self.outputs_metadata = self._get_var_metadata(self.fmu, output_names)
        # Define outputs data
        self.y = {'time':[]}
        for key in output_names:
            self.y[key] = []
        self.y_store = copy.deepcopy(self.y)
        # Define inputs data
        self.u = {'time':[]}
        for key in input_names:
            self.u[key] = []
        self.u_store = copy.deepcopy(self.u)
        # Set default options
        self.options = self.fmu.simulate_options()
        self.options['CVode_options']['rtol'] = 1e-6 
        # Set default communication step
        self.set_step(con['step'])
        # Set initial simulation start
        self.start_time = 0
        self.initialize = True
        self.options['initialize'] = self.initialize
        self.elapsed_control_time = []
        
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
        # Simulate
        self.options['initialize'] = self.initialize
        res = self.fmu.simulate(start_time=self.start_time, 
                                final_time=self.final_time, 
                                options=self.options, 
                                input=input_object)
        # Get result and store measurement
        for key in self.y.keys():
            self.y[key] = res[key][-1]
            self.y_store[key] = self.y_store[key] + res[key].tolist()[1:]
        # Store control inputs
        for key in self.u.keys():
            self.u_store[key] = self.u_store[key] + res[key].tolist()[1:] 
        # Advance start time
        self.start_time = self.final_time
        # Prevent inialize
        self.initialize = False
        # Raise the flag to compute time lapse
        self.tic_time = time.time()
        
        return self.y

    def reset(self):
        '''Reset the test.
        
        '''
        
        self.__init__()

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
        
    def get_results(self):
        '''Returns measurement and control input trajectories.
        
        Parameters
        ----------
        None
        
        Returns
        -------
        Y : dict
            Dictionary of measurement and control input names and their 
            trajectories as lists.
            {'y':{<measurement_name>:<measurement_trajectory>},
             'u':{<input_name>:<input_trajectory>}
            }
        
        '''
        
        Y = {'y':self.y_store, 'u':self.u_store}
        
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
        
        # Instantiate a KPI calculator for the test case
        if not hasattr(self, 'cal'):
            self.cal = KPI_Calculator(self)
            
        kpis = self.cal.get_core_kpis()

        return kpis
    def get_forecast(self,horizon=24*3600, category=None, plot=False):
        '''Returns forecast of the test case data
        
        Parameters
        ----------
        horizon : int
            Length of the requested forecast in seconds 
        category : string (optional)
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category. 
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', 'setpoints'
        plot : boolean
            True if desired to plot the forecast
            
        Returns
        -------
        forecast: dict 
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
        
        '''
        
        # Instantiate a forecaster for the test case
        if not hasattr(self, 'forecaster'):
            self.forecaster = Forecaster(self)
        
        # Get the forecast
        forecast = self.forecaster.get_forecast(horizon=horizon,
                                                category=category,
                                                plot=plot)
        
        return forecast
        
    def get_name(self):
        '''Returns the name of the test case fmu.
        
        Parameters
        ----------
        None
        
        Returns
        -------
        name : str
            Name of test case fmu.
            
        '''
        
        name = self.fmupath[7:-4]
        
        return name
        
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
        
    def save_test_case(self, file_name='deployed.tc'):
        '''Save the deployed test case in a pickle.
        This method is going to delete the fmu from the
        object because it is not supported by pickle.
        
        Parameters
        ----------
        file_name: string
            name of the file where the test case is going
            to be pickled
        '''
        
        del self.fmu
        
        f=open(file_name,'wb')
        pickle.dump(self,f)
        f.close()

        return file_name
        
    def load_test_case(self, file_name='deployed.tc'):
        '''Load a deployed test case that has been 
        saved with 'save_test_case'
        
        Parameters
        ----------
        file_name: string
            name of the file where the test case is stored
            
        Returns
        -------
        self: TestCase 
            Instance with the attributes of a previously 
            deployed test case
        '''

        tc = pickle.load(file(file_name, 'rb'))
        for k,v in tc.__dict__.iteritems():
            self.__dict__[k] = v
            
        self.fmu = load_fmu(self.fmupath)

        return self   
        
