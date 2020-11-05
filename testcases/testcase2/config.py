# -*- coding: utf-8 -*-
"""
This file is used to configure the test case.

"""

def get_config():
    '''Returns the configuration structure for the test case.
    
    Returns
    -------
    config : dict()
    Dictionary contatinin configuration information.
    {
    'fmupath'  : string, location of model fmu
    'step'     : int, default control step size in seconds
    'horizon'  : int, default forecast horizon in seconds
    'interval' : int, default forecast interval in seconds
    'price_scenario' : string, default price_scenario
    }
    
    '''
        
    config = {
    # Enter configuration information
    'fmupath'  : 'models/wrapped.fmu', 
    'step'     : 3600,
    'horizon'  : 86400,
    'interval' : 3600,
    'scenario' : {'electricity_price':'constant'}
    }
    
    return config
