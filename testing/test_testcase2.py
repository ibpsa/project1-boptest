# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 2.  To run these tests, testcase 2 must 
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
from examples.python import szvav_sup

root_dir = utilities.get_root_path()
kpi_ref = {'energy' : 147.135331884, 'comfort' : 0.001831087016403562}

class ExampleSupervisoryPython(unittest.TestCase):
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
        self.assertAlmostEqual(kpi['energy'], kpi_ref['energy'], places=5)
        self.assertAlmostEqual(kpi['comfort'], kpi_ref['comfort'], places=5)
        # Check trajectories
        # Make dataframe
        df = pd.DataFrame(data=res['y']['time'], columns=['time'])
        for s in ['y','u']:
            for x in res[s].keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=res[s][x], columns=[x])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_python.csv')
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath)
            for key in df.columns:
                y_test = df[key].get_values()
                y_ref = df_ref[key].get_values()
                results = utilities.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], results['Message'])
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)

class ExampleSupervisoryJulia(unittest.TestCase):
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
        self.assertAlmostEqual(kpi['energy'].get_values()[0], kpi_ref['energy'], places=5)
        self.assertAlmostEqual(kpi['comfort'].get_values()[0], kpi_ref['comfort'], places=5)
        # Check trajectories
        df = pd.read_csv(res_path)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_julia.csv')
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath)
            for key in df.columns:
                y_test = df[key].get_values()
                y_ref = df_ref[key].get_values()
                results = utilities.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], results['Message'])
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)

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
        self.measurements_ref = {"ETotCoo_y": {"Unit": "J", 
                                               "Description": "Cooling electrical energy",
                                               "Minimum":None,
                                               "Maximum":None}, 
                                 "ETotFan_y": {"Unit": "J", 
                                               "Description": "Fan energy", 
                                               "Minimum":None,
                                               "Maximum":None},
                                 "ETotHVAC_y": {"Unit": "J", 
                                                "Description": "Total HVAC energy",
                                                "Minimum":None,
                                                "Maximum":None},
                                 "ETotHea_y": {"Unit": "J", 
                                               "Description": "Heating energy",
                                               "Minimum":None,
                                               "Maximum":None}, 
                                 "ETotPum_y": {"Unit": "J", 
                                               "Description": "Pump electrical energy",
                                               "Minimum":None,
                                               "Maximum":None}, 
                                 "PCoo_y": {"Unit": "W", 
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
                                               "Maximum":None}}
        self.step_ref = 3600.0
        self.y_ref = {u'PFan_y': 5.231953892667217, 
                      u'ETotCoo_y': 0.0, 
                      u'ETotFan_y': 18835.034013601995, 
                      u'ETotHea_y': 6369084.093412709, 
                      u'TRooAir_y': 293.0823301149466, 
                      u'time': 3600.0, 
                      u'ETotPum_y': 0.0, 
                      u'PCoo_y': 0.0, 
                      u'PHea_y': 1913.8957388829822, 
                      u'PPum_y': -0.0, 
                      u'ETotHVAC_y': 6387919.127426311}


if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))