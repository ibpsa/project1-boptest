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
import json
import cPickle as pickle
from kpis.kpi_calculator import KPI_Calculator
import zipfile
import pandas as pd
import matplotlib.pyplot as plt

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
        self.fmu = load_fmu(self.fmupath)
        # Get version and check is 2.0
        self.fmu_version = self.fmu.get_version()
        if self.fmu_version != '2.0':
            raise ValueError('FMU must be version 2.0.')
        # Get available control inputs and outputs
        input_names = self.fmu.get_model_variables(causality = 2).keys()
        output_names = self.fmu.get_model_variables(causality = 3).keys()
        # Get input and output meta-data
        self.inputs_metadata = self._get_var_metadata(self.fmu, input_names)
        self.outputs_metadata = self._get_var_metadata(self.fmu, output_names)
        # Define KPIs
        self.kpipath = con['kpipath']
        # Load kpi json
        with open(self.kpipath, 'r') as f:
            json_str = f.read()
            self.kpi_json = json.loads(json_str)
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
        
        # Set final time
        self.final_time = self.start_time + self.step
        # Set control inputs if they exist
        if u.keys():
            u_list = []
            u_trajectory = self.start_time
            for key in u.keys():
                if key != 'time':
                    value = float(u[key])
                    u_list.append(key)
                    u_trajectory = np.vstack((u_trajectory, value))
            input_object = (u_list, np.transpose(u_trajectory))
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
        
        cal = KPI_Calculator(self)
        kpis = cal.get_core_kpis()

        return kpis   
        
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
        
    def _get_var_metadata(self, fmu, var_list):
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
            {<var_name> :
                "Unit" : <units_str>
            }
            
        '''
        
        # Inititalize
        var_metadata = dict()
        # Get metadata        
        for var in var_list:
            # Units
            if var == 'time':
                unit = 's'
            elif '_activate' in var:
                unit = None
            else:
                unit = fmu.get_variable_unit(var)
            var_metadata[var] = {'Unit':unit}

        return var_metadata
    
    def get_forecast(self, horizon=24*3600, start=None,
                     interval=None, type=None, index=None, 
                     plot=False,
                     data_file_name='test_case_data.csv'):
        '''Retrieve forecast data from the fmu. The data
        is stored within the data_file_name file that 
        is located in the resources folder of the wrapped.fmu.
        
        Parameters
        ----------
        horizon : float
            Length of the requested forecast in seconds 
        interval: integer (optional)
            resampling time interval in seconds. If None,
            self.step will be used instead
        type : string (optional)
            Type of data to retrieve from the test case.
            If None it will return all available data in the
            file without filtering it by any category. 
            Possible options are 'weather', 'emissions', 
            'price_constant', 'price_dynamic', 
            'price_highly_dynamic', 'gains'
        start : float (optional)
            Starting time of the forecast. If None it
            will use the actual time, i.e.: self.start_time
        data_file_name : string
            Name of the data file from where the data is 
            retrieved. Notice that this file should be within
            the resources folder of the wrapped.fmu
            
        Returns
        -------
        data: dict 
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
        
        Notes
        -----
        The read and pre-process of the data happens only 
        once to reduce the computational load during the 
        co-simulation
        
        '''
        
        # First read the test case data if it has not been 
        # read before. 
        if not hasattr(self, 'data'):    
            z_fmu = zipfile.ZipFile(self.fmupath, 'r')
            # This will work in any OS because the zip format 
            # specifies a forward slash.
            self.data=pd.read_csv(z_fmu.open('resources/'+data_file_name),
                                  index_col='datetime', parse_dates=True)
            
            # Convert any convert any string formatted
            # numbers to floats.
            self.data = self.data.applymap(float)
            
            # Resample the data
            if interval is None:
                interval = self.step
            
            self.data = self.data.asfreq(freq=str(interval)+'S')
            self.data = self.data.interpolate(method='time')        

            # Get rid of the NaN's
            if np.isnan(self.data).any().any():
                self.data = self.data.fillna(method='ffill')
                if np.isnan(self.data).any().any():            
                    self.data = self.data.fillna(method='bfill')
            
            # Set time as index (fmu does not understand datetime)
            self.data['datetime'] = self.data.index
            self.data = self.data.set_index('time')
            
            # Close the fmu
            z_fmu.close()
        
        # If no index use horizon to slice the data
        if index is None:
            # If no start time specified use the test case start time
            if start is None:
                start = self.start_time
            end = start + horizon
            data_slice = self.data.loc[start:end, :]
        
        # If there is an index return the data slice on that index
        else:
            # TODO: Make distinction between weather and other data:
            # should call .interpolate(method='index') instead of fillna
            # for the weather data. 
            data_slice = self.data.reindex(index).fillna(method='ffill').fillna(method='bfill')
        
        if plot:
            to_plot=['energy_price_dynamic']
            data_slice.set_index('datetime')[to_plot].plot()
            plt.show()

        # Reset the index to keep the 'time' column in the data
        # Transform data frame to dictionary
        return data_slice.reset_index().to_dict('list')
    
    def save_test_case(self, file_name='tc_deployed'):
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
        
    def load_test_case(self, file_name='tc_deployed'):
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
        
        self.fmu = load_fmu(self.fmupath)

        tc = pickle.load(file(file_name, 'rb'))
        for k,v in tc.__dict__.iteritems():
            self.__dict__[k] = v

        return self   
        