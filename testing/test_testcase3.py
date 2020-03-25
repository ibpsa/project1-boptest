# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 3.  To run these tests, testcase 3 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
from examples.python import twozones_p

kpi_ref = {'tdis_tot': 21.7322321131,
           'idis_tot': 1030.34989641,
           'ener_tot': 43.8117652678,
           'cost_tot': 3.06682356874,
           'emis_tot': 8.76235305355,
           'time_rat_python': 0.0013958666984129834}

class ExampleProportionalPython(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test of proportional feedback controller with 
    two zones in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''
        
        # Run test
        kpi,res = twozones_p.run()
        # Check kpis
        self.assertAlmostEqual(kpi['ener_tot'], kpi_ref['ener_tot'], places=3)
        self.assertAlmostEqual(kpi['tdis_tot'], kpi_ref['tdis_tot'], places=3)
        self.assertAlmostEqual(kpi['idis_tot'], kpi_ref['idis_tot'], places=3)
        self.assertAlmostEqual(kpi['cost_tot'], kpi_ref['cost_tot'], places=3)
        self.assertAlmostEqual(kpi['time_rat'], kpi_ref['time_rat_python'], places=3)
        self.assertAlmostEqual(kpi['emis_tot'], kpi_ref['emis_tot'], places=3)
        
        # Check trajectories
        # Make dataframe
        df = pd.DataFrame()
        for s in ['y','u']:
            for x in res[s].keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=res[s][x], index=res['y']['time'],columns=[x])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase3', 'results_python.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)     

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 3.  
    
    Actual test methods implemented in utilities.partialTestAPI.  Set self 
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.
        
        '''
        
        self.name = 'testcase3'
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = {"oveActNor_activate": {"Unit": None, 
                                               "Description": "Activation for Heater thermal power of north zone",
                                               "Minimum":None,
                                               "Maximum":None}, 
                           "oveActNor_u": {"Unit": "W", 
                                        "Description": "Heater thermal power of north zone",
                                        "Minimum":-10000,
                                        "Maximum":10000},
                           "oveActSou_activate": {"Unit": None, 
                                               "Description": "Activation for Heater thermal power of south zone",
                                               "Minimum":None,
                                               "Maximum":None}, 
                           "oveActSou_u": {"Unit": "W", 
                                        "Description": "Heater thermal power of south zone",
                                        "Minimum":-10000,
                                        "Maximum":10000}}
        self.measurements_ref = {"PHeaNor_y": {"Unit": "W", 
                                            "Description": "Heater power of north zone",
                                            "Minimum":None,
                                            "Maximum":None},
                                 "TRooAirNor_y": {"Unit": "K", 
                                               "Description": "Zone air temperature of north zone",
                                               "Minimum":None,
                                               "Maximum":None},
                                "CO2RooAirNor_y": {"Unit": "ppm", 
                                               "Description": "Zone air CO2 concentration of north zone",
                                               "Minimum":None,
                                               "Maximum":None},
                                "PHeaSou_y": {"Unit": "W", 
                                            "Description": "Heater power of south zone",
                                            "Minimum":None,
                                            "Maximum":None},
                                 "TRooAirSou_y": {"Unit": "K", 
                                               "Description": "Zone air temperature of south zone",
                                               "Minimum":None,
                                               "Maximum":None},
                                "CO2RooAirSou_y": {"Unit": "ppm", 
                                               "Description": "Zone air CO2 concentration of south zone",
                                               "Minimum":None,
                                               "Maximum":None}}
        self.step_ref = 60.0
        self.y_ref = {u'PHeaNor_y': 0.0, 
                      u'TRooAirNor_y': 293.15015556512265,
                      u'CO2RooAirNor_y': 751.091,
                      u'PHeaSou_y': 0.0, 
                      u'TRooAirSou_y': 293.15015556512265,
                      u'CO2RooAirSou_y': 751.091,
                      u'time': 60.0}
        self.forecast_default_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_default.csv')
        self.forecast_parameters_ref = {'horizon':172800, 'interval':123}
        self.forecast_with_parameters_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_interval.csv')


if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))