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
from scipy.integrate import trapz

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
        kpis : dict
            Dictionary containing KPI names and values.
            {<kpi_name>:<kpi_value>}
        
        '''
        
        kpis = dict()
        # Calculate each KPI using json for signalsand save in dictionary
        for kpi in self.kpi_json.keys():
            print(kpi, type(kpi))
            if kpi == 'energy':
                # Calculate total energy [KWh - assumes measured in J]
                E = 0
                for signal in self.kpi_json[kpi]:
                    E = E + self.y_store[signal][-1]
                # Store result in dictionary
                kpis[kpi] = E*2.77778e-7 # Convert to kWh
            elif kpi == 'comfort':
                # Calculate total discomfort [K-h = assumes measured in K]
                tot_dis = 0
                heat_setpoint = 273.15+20
                for signal in self.kpi_json[kpi]:
                    data = np.array(self.y_store[signal])
                    dT_heating = heat_setpoint - data
                    dT_heating[dT_heating<0]=0
                    tot_dis = tot_dis + trapz(dT_heating,self.y_store['time'])/3600
                # Store result in dictionary
                kpis[kpi] = tot_dis
            else:
                print('No calculation for KPI named "{0}".'.format(kpi))

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