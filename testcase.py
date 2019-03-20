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
        # Get version
        self.fmu_version = self.fmu.get_version()
        # Get available control inputs and outputs
        if self.fmu_version == '2.0':
            input_names = self.fmu.get_model_variables(causality = 2).keys()
            output_names = self.fmu.get_model_variables(causality = 3).keys()
        else:
            raise ValueError('FMU must be version 2.0.')
        # Define KPIs
        self.kpipath = con['kpipath']
        # Load kpi json
        with open(self.kpipath, 'r') as f:
            json_str = f.read()
            self.kpi_json = json.loads(json_str)
        # Define measurements
        self.y = {'time':[]}
        for key in output_names:
            self.y[key] = []
        self.y_store = copy.deepcopy(self.y)
        # Define inputs
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
        '''Returns a list of control input names.
        
        Parameters
        ----------
        None
        
        Returns
        -------
        inputs : list
            List of control input names.
            
        '''

        inputs = self.u.keys()
        
        return inputs
        
    def get_measurements(self):
        '''Returns a list of measurement names.
        
        Parameters
        ----------
        None
        
        Returns
        -------
        measurements : list
            List of measurement names.
            
        '''

        measurements = self.y.keys()
        
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
        
    