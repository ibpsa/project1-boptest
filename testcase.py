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
import time
from scipy import interpolate

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
                        u_list.append(key)
                        u_trajectory = np.vstack((u_trajectory, value))
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
                description = 'Time of simulation'
            elif '_activate' in var:
                unit = None
                description = fmu.get_variable_description(var)
            else:
                unit = fmu.get_variable_unit(var)
                description = fmu.get_variable_description(var)
            var_metadata[var] = {'Unit':unit,
                                 'Description':description}

        return var_metadata
    
    def get_forecast(self, horizon=24*3600, interval=None,
                     category=None, index=None, plot=False,
                     data_file_name='test_case_data.csv'):
        '''Retrieve forecast data from the fmu. The data
        is stored within the data_file_name file that 
        is located in the resources folder of the wrapped.fmu.
        
        Parameters
        ----------
        horizon : int
            Length of the requested forecast in seconds 
        interval: int (optional)
            resampling time interval in seconds. If None,
            the test case step will be used instead
        category : string (optional)
            Type of data to retrieve from the test case.
            If None it will return all available data in the
            file without filtering it by any category. 
            Possible options are 'weather', 'price',
            'emissions', 'occupancy', 'setpoints'
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
        
        # First read the test case data if not read yet
        if not hasattr(self, 'data'):    
            self.load_data(data_file_name)
        
        # Filter the requested data columns
        if category is not None:
            data_slice = self.data.loc[:,self.categories[category]]
        else:
            data_slice = self.data
            
        # If no index use horizon and interval 
        if index is None:
            # Use the test case start time 
            start = self.start_time
            stop  = start + horizon
            # Reindex to the desired interval. Use step if none
            if interval is None:
                interval=self.step
            index = np.arange(start,stop,interval).astype(int)
            
        # Reindex to the desired index
        data_slice_reindexed = data_slice.reindex(index)
        
        for key in data_slice_reindexed.keys():
            # Use linear interpolation for continuous variables
            if key in self.weather_keys:
                f = interpolate.interp1d(self.data.index,
                    self.data[key], kind='linear')
                data_slice_reindexed.loc[:,key] = f(index)
            # Use forward fill for discrete variables
            else:
                f = interpolate.interp1d(self.data.index,
                    self.data[key], kind='zero')
                data_slice_reindexed.loc[:,key] = f(index)
        
        if plot:
            if category is None:
                to_plot = data_slice_reindexed.keys()
            else: 
                to_plot = self.categories[category]
            for var in to_plot:
                data_slice_reindexed[var].plot()
                plt.legend()
                plt.show()
        
        # Reset the index to keep the 'time' column in the data
        # Transform data frame to dictionary
        return data_slice_reindexed.reset_index().to_dict('list')
    
    def load_data(self, data_file_name='test_case_data.csv'):
        '''Load the data from the resources folder of the fmu.
        Resample it with the specified time interval.
        
        Parameters
        ----------
        data_file_name : string
            Name of the data file from where the data is 
            retrieved. Notice that this file should be within
            the resources folder of the wrapped.fmu
        '''
        
        # Define the column keys and group them by categories
        self.weather_keys   = ['pAtm','nTot','nOpa','HGloHor',
                               'HDifHor','HDirNor','celHei','winSpe',
                               'HHorIR','winDir','cloTim','solTim',
                               'TDewPoi','relHum','TDryBul','TWetBul',
                               'solAlt','solZen','solDec','solHouAng',
                               'lon','lat','TBlaSky']
        self.price_keys     = ['PriceElectricPowerConstant', 
                               'PriceElectricPowerDynamic', 
                               'PriceElectricPowerHighlyDynamic',
                               'PriceGasPower',
                               'PriceBiomassPower',
                               'PriceSolarThermalPower']
        self.emissions_keys  = ['EmissionsElectricPower',
                               'EmissionsDistrictHeatingPower',
                               'EmissionsGasPower',
                               'EmissionsBiomassPower'
                               'EmissionsSolarThermalPower'] 
        self.occupancy_keys = ['occupancy']
        self.setpoint_keys  = ['LowerSetp', 'UpperSetp']
        
        # Save the categories within a dictionary:
        self.categories = {}
        self.categories['weather']   = self.weather_keys
        self.categories['price']     = self.price_keys
        self.categories['emissions']  = self.emissions_keys
        self.categories['occupancy'] = self.occupancy_keys
        self.categories['setpoint']  = self.setpoint_keys
        
        # Point to the fmu zip file
        z_fmu = zipfile.ZipFile(self.fmupath, 'r')
        # The following will work in any OS because the zip format 
        # specifies a forward slash.
        self.data=pd.read_csv(z_fmu.open('resources/'+data_file_name))
        
        # Convert any convert any string formatted
        # numbers to floats.
        self.data = self.data.applymap(float)
        
        # Set time as index 
        self.data = self.data.astype({'time':int})
        self.data = self.data.set_index('time')
        
        # Close the fmu
        z_fmu.close()
        
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
        