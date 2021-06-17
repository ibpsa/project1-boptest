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
    'name'     : string, name of test case
    'fmupath'  : string, location of model fmu
    'area'     : float, test case building floor area in m^2
    'kpipath'  : string, location of kpi json
    'horizon'  : int, default forecast horizon in seconds
    'interval' : int, default forecast interval in seconds
    'price_scenario' : string, default price_scenario
    }

    '''

    config = {
    # Enter configuration information
    'name'     : 'bestest_hydronic_heat_pump',
    'fmupath'  : 'models/wrapped.fmu',
    'area'     : 12.0*16.0,
    'step'     : 3600,
    'horizon'  : 86400,
    'interval' : 3600,
    'scenario' : {'electricity_price':'constant',
                  'time_period':None}
    }

    return config
