# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 2.  To run these tests, testcase 2 must 
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
from examples.python import szvav_sup

kpi_ref = {'tdis_tot': 6.0386812587473635,
           'ener_tot': 147.1202022345602,
           'cost_tot': 29.42404044691204,
           'emis_tot': 73.5601011172801,
           'time_rat_python': 0.000198015450603,
           'time_rat_julia': 0.000198015450603}

class ExampleSupervisoryPython(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test of a supervisory controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''
        
        # Run test
        kpi,res = szvav_sup.run()
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
                    df = pd.concat((df,pd.DataFrame(data=res[s][x], index=res['y']['time'], columns=[x])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_python.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)

class ExampleSupervisoryJulia(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test of a supervisory controller in Julia.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''
        
        # Run test
        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'kpi_testcase2.csv')
        res_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'result_testcase2.csv')
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
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_julia.csv')
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
        y = requests.post('{0}/advance'.format(self.url), data={"oveTSetRooHea_activate":1,"oveTSetRooHea_u":273.15}).json()
        # Check kpis
        value = float(y['senTSetRooHea_y'])
        self.assertAlmostEqual(value, 273.15+10, places=3)
        
    def test_max(self):
        '''Tests that if input is above max, input is set to max.
        
        '''
        
        # Run test
        requests.put('{0}/reset'.format(self.url))
        y = requests.post('{0}/advance'.format(self.url), data={"oveTSetRooHea_activate":1,"oveTSetRooHea_u":310.15}).json()
        # Check kpis
        value = float(y['senTSetRooHea_y'])
        self.assertAlmostEqual(value, 273.15+35, places=3)
        
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 2.  
    
    Actual test methods implemented in utilities.partialTestAPI.  Set self 
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.
        
        '''

        self.name = 'testcase2'
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = {"oveTSetRooCoo_activate": {"Unit": None,
                                                      "Description": "Activation for Cooling setpoint",
                                                      "Minimum":None,
                                                      "Maximum":None}, 
                           "oveTSetRooCoo_u": {"Unit": "K",
                                               "Description": "Cooling setpoint",
                                               "Minimum":273.15+10,
                                               "Maximum":273.15+35}, 
                           "oveTSetRooHea_activate": {"Unit": None,
                                                      "Description": "Activation for Heating setpoint",
                                                      "Minimum":None,
                                                      "Maximum":None}, 
                           "oveTSetRooHea_u": {"Unit": "K",
                                               "Description": "Heating setpoint",
                                               "Minimum":273.15+10,
                                               "Maximum":273.15+35}}
        self.measurements_ref = {"PCoo_y": {"Unit": "W", 
                                            "Description": "Cooling electrical power",
                                            "Minimum":None,
                                            "Maximum":None}, 
                                 "PFan_y": {"Unit": "W", 
                                            "Description": "Fan electrical power",
                                            "Minimum":None,
                                            "Maximum":None}, 
                                 "PHea_y": {"Unit": "W", 
                                            "Description": "Heater power",
                                            "Minimum":None,
                                            "Maximum":None}, 
                                 "PPum_y": {"Unit": "W", 
                                            "Description": "Pump electrical power",                                            
                                            "Minimum":None,
                                            "Maximum":None}, 
                                 "TRooAir_y": {"Unit": "K", 
                                               "Description": "Room air temperature",                                               
                                               "Minimum":None,
                                               "Maximum":None},
                                 "senTSetRooCoo_y": {"Unit": "K", 
                                               "Description": "Room cooling setpoint",                                               
                                               "Minimum":None,
                                               "Maximum":None},
                                 "senTSetRooHea_y": {"Unit": "K", 
                                               "Description": "Room heating setpoint",                                               
                                               "Minimum":None,
                                               "Maximum":None}}
        self.step_ref = 3600.0
        self.y_ref = {u'PFan_y': 5.231953892667217,
                      u'TRooAir_y': 295.06442470392363, 
                      u'time': 3600.0, 
                      u'PCoo_y': 0.0, 
                      u'PHea_y': 2422.6914961978637,
                      u'PPum_y': -0.0,
                      u'senTSetRooCoo_y': 296.15,
                      u'senTSetRooHea_y': 295.15}
        self.forecast_default_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'tc2_forecast_default.csv')
        self.forecast_parameters_ref = {'horizon':172800, 'interval':123}
        self.forecast_with_parameters_ref = os.path.join(utilities.get_root_path(), 'testing', 'references', 'forecast', 'tc2_forecast_interval.csv')


if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))