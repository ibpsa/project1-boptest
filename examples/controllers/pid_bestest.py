# -*- coding: utf-8 -*-
"""
This module implements a simple PID controller.

"""

class PID(object):
    
    def __init__(self):
        self.gain = 0
        self.int  = 0
        self.e    = 0
    
    def compute_control(self, y):
        '''Compute the control input from the measurement.
        
        Parameters
        ----------
        y : dict
            Contains the current values of the measurements.
            {<measurement_name>:<measurement_value>}
            
        Returns
        -------
        u : dict
            Defines the control input to be used for the next step.
            {<input_name> : <input_value>}
        
        '''
        
        # Controller parameters
        setpoint = 273.15+22
        k_p = 12
        k_i = 5
        k_d = 0
        # Compute control
        e = setpoint - y['TRooAir_y']
        self.int   += e
        self.der    = (e - self.e)/3600
        self.e      = e

        gain = self.gain + k_p*self.e + k_i*self.int + k_d*self.der
        value = min( max(gain,273.15 + 20), 273.15 + 80)
        u = {'oveTsup_u':value,
             'oveTsup_activate': 1}
        
        return u
        
    def initialize(self):
        '''Initialize the control input u.
        
        Parameters
        ----------
        None
        
        Returns
        -------
        u : dict
            Defines the control input to be used for the next step.
            {<input_name> : <input_value>}
        
        '''
        
        u = {'oveTsup_u':310,
             'oveTsup_activate': 1}
        
        return u
