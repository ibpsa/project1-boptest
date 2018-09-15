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
    'u'        : list of strings, available control signals
    'y'        : list of strings, available sensor signals
    'step'     : int, default control step size in seconds
    }
    
    '''
        
    config = {
    # Enter configuration information
    'fmupath'  : 'models/SingleZoneVAV_TestCaseSupervisory.fmu',
    'u'        : ['TSetRooHea', 'TSetRooCoo'],
    'y'        : ['time', 'TRooAir', 'PFan', 'PCoo', 'PHea', 'PPum',
                  'ETotFan', 'ETotCoo', 'ETotHea', 'ETotPum', 'ETotHVAC'],                     
    'step'     : 3600
    }
    
    return config