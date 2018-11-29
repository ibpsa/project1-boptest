# -*- coding: utf-8 -*-
"""
This module implements a simple P controller.

"""

def compute_control(y):
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
    setpoint = 273.15+20
    k_p = 2000
    # Compute control
    e = setpoint - y['TRooAir_y']
    value = max(k_p*e,0)
    u = {'oveAct_u':value,
         'oveAct_activate': 1}
    
    return u
    
def initialize():
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
    
    u = {'oveAct_u':0,
         'oveAct_activate': 1}
    
    return u
