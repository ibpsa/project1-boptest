# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 1.  To run these tests, testcase 1 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
from examples.python import twoday_p

kpi_ref = {'tdis_tot': 10.6329491656,
           'ener_tot': 21.474759625,
           'cost_tot': 1.50323317375,
           'emis_tot': 4.294951925,
           'time_rat_python': 0.000226274950913,
           'time_rat_julia':  7.32503600742506e-05 }

class ExampleProportionalPython(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test of proportional feedback controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''
        
        # Run test
        kpi,res = twoday_p.run()
        # Check kpis
        self.assertAlmostEqual(kpi['ener_tot'], kpi_ref['ener_tot'], places=3)
        self.assertAlmostEqual(kpi['tdis_tot'], kpi_ref['tdis_tot'], places=3)
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
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_python.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)
            
class ExampleProportionalJulia(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test of proportional feedback controller in Julia.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''
        
        # Run test
        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'kpi_testcase1.csv')
        res_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'result_testcase1.csv')
        # Check kpis
        kpi = pd.read_csv(kpi_path)
        self.assertAlmostEqual(kpi['ener_tot'].get_values()[0], kpi_ref['ener_tot'], places=3)
        self.assertAlmostEqual(kpi['tdis_tot'].get_values()[0], kpi_ref['tdis_tot'], places=3)
        self.assertAlmostEqual(kpi['cost_tot'].get_values()[0], kpi_ref['cost_tot'], places=3)
        self.assertAlmostEqual(kpi['time_rat'].get_values()[0], kpi_ref['time_rat_julia'], places=3)
        self.assertAlmostEqual(kpi['emis_tot'].get_values()[0], kpi_ref['emis_tot'], places=3)
        
        # Check trajectories
        df = pd.read_csv(res_path, index_col = 'time')
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_julia.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)
            
class MinMax(unittest.TestCase):
    '''Test the use of min/max attributes to truncate the controller input.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        self.url = 'http://127.0.0.1:5000'
        
    def test_min(self):
        '''Tests that if input is below min, input is set to min.
        
        '''
        
        # Run test
        requests.put('{0}/reset'.format(self.url))
        y = requests.post('{0}/advance'.format(self.url), data={"oveAct_activate":1,"oveAct_u":-500000}).json()
        # Check kpis
        value = float(y['PHea_y'])
        self.assertAlmostEqual(value, 10101.010101010103, places=3)
        
    def test_max(self):
        '''Tests that if input is above max, input is set to max.
        
        '''
        
        # Run test
        requests.put('{0}/reset'.format(self.url))
        y = requests.post('{0}/advance'.format(self.url), data={"oveAct_activate":1,"oveAct_u":500000}).json()
        # Check kpis
        value = float(y['PHea_y'])
        self.assertAlmostEqual(value, 10101.010101010103, places=3)
        
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 1.  
    
    Actual test methods implemented in utilities.partialTestAPI.  Set self 
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.
        
        '''
        
        self.name = 'testcase1'
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = {"oveAct_activate": {"Unit": None, 
                                               "Description": "Activation for Heater thermal power",
                                               "Minimum":None,
                                               "Maximum":None}, 
                           "oveAct_u": {"Unit": "W", 
                                        "Description": "Heater thermal power",
                                        "Minimum":-10000,
                                        "Maximum":10000}}
        self.measurements_ref = {"PHea_y": {"Unit": "W", 
                                            "Description": "Heater power",
                                            "Minimum":None,
                                            "Maximum":None},
                                 "TRooAir_y": {"Unit": "K", 
                                               "Description": "Zone air temperature",
                                               "Minimum":None,
                                               "Maximum":None}}
        self.step_ref = 60.0
        self.y_ref = {u'PHea_y': 0.0, 
                      u'TRooAir_y': 293.15015556512265,
                      u'time': 60.0}
        self.forecast_default_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'tc1_forecast_default.csv')
        self.forecast_parameters_ref = {'horizon':172800, 'interval':123}
        self.forecast_with_parameters_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'tc1_forecast_interval.csv')

        
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))