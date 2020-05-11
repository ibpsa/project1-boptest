# -*- coding: utf-8 -*-
"""
This module implements a simple P controller.

"""

def compute_control(y,
                    LowerSetpNor,
                    UpperSetpNor,
                    LowerSetpSou,
                    UpperSetpSou):
    '''Compute the control input from the measurement.
    
    Parameters
    ----------
    y : dict
        Contains the current values of the measurements.
        {<measurement_name>:<measurement_value>}
    LowerSetpNor : float
        Lower temperature set point for north zone.
    UpperSetpNor : float
        Upper temperature set point for north zone.
    LowerSetpSou : float
        Lower temperature set point for south zone.
    UpperSetpSou : float
        Upper temperature set point for south zone.
    
    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}
    
    '''
    
    # Controller parameters
    k_p = 2000
    
    # Compute control for north zone
    if y['TRooAirNor_y']<LowerSetpNor:
        eNor = LowerSetpNor - y['TRooAirNor_y']
    elif y['TRooAirNor_y']>UpperSetpNor:
        eNor = UpperSetpNor - y['TRooAirNor_y']
    else:
        eNor = 0
        
    # Compute control for south zone
    if y['TRooAirSou_y']<LowerSetpSou:
        eSou = LowerSetpSou - y['TRooAirSou_y']
    elif y['TRooAirSou_y']>UpperSetpSou:
        eSou = UpperSetpSou - y['TRooAirSou_y']
    else:
        eSou = 0
    
    valueNor = k_p*eNor
    valueSou = k_p*eSou
    u = {'oveActNor_u':valueNor,
         'oveActNor_activate': 1,
         'oveActSou_u':valueSou,
         'oveActSou_activate': 1}
    
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
    
    u = {'oveActNor_u':0,
         'oveActNor_activate': 1,
         'oveActSou_u':0,
         'oveActSou_activate': 1}
    
    return u
