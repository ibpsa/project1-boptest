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
    'area'     : float, test case building floor area in m^2
    'kpipath'  : string, location of kpi json
    'horizon'  : int, default forecast horizon in seconds
    'interval' : int, default forecast interval in seconds
    'scenario' : dict, default electricity_price and time_period
    }

    '''

    config = {
    # Enter configuration information
    'name'     : 'multizone_residential_hydronic',
    'fmupath'  : 'models/wrapped.fmu',
    'area'     : 81.08,
    'step'     : 3600,
    'horizon'  : 86400,
    'interval' : 3600,
    'scenario' : {'electricity_price':'constant',
                  'time_period':None}
    }

    return config
