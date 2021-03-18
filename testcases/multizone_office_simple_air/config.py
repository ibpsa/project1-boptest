def get_config():
    '''Returns the configuration structure for the test case.

    Returns
    -------
    config : dict()
    Dictionary containing configuration information.
    {
    'fmupath'  : string, location of model fmu
    'step'     : int, default control step size in seconds
    'horizon'  : int, default forecast horizon in seconds
    'interval' : int, default forecast interval in seconds
    'scenario' : string, default price_scenario
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
