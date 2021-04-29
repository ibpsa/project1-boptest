def get_config():
    '''Returns the configuration structure for the test case.

    Returns
    -------
    config : dict()
    Dictionary containing configuration information.
    {
    'name'     : string, name of test case
    'fmupath'  : string, location of model fmu
    'step'     : int, default control step size in seconds
    'horizon'  : int, default forecast horizon in seconds
    'interval' : int, default forecast interval in seconds
    'price_scenario' : string, default price_scenario
    }

    '''

    config = {
    # Enter configuration information
    'name'     : 'bestest_air',
    'fmupath'  : 'models/wrapped.fmu',
    'step'     : 3600,
    'horizon'  : 86400,
    'interval' : 3600,
    'scenario' : {'electricity_price':'constant',
                  'time_period':None}
    }

    return config
