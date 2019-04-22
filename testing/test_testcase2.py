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
    
class ExampleSupervisoryPython(unittest.TestCase):
    '''Tests the example test of a supervisory controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''
        
        # Run test
        kpi,res = szvav_sup.run()
        # Check kpis
        self.assertAlmostEqual(kpi['energy'], 147.135331884, places=5)
        self.assertAlmostEqual(kpi['comfort'], 0.001831087016403562, places=5)
        # Check trajectories
        # Make dataframe
        df = pd.DataFrame(data=res['y']['time'], columns=['time'])
        for s in ['y','u']:
            for x in res[s].keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=res[s][x], columns=[x])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results.csv')
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
                                                      "Description": "Activation for Cooling setpoint"}, 
                           "oveTSetRooCoo_u": {"Unit": "K",
                                               "Description": "Cooling setpoint"}, 
                           "oveTSetRooHea_activate": {"Unit": None,
                                                      "Description": "Activation for Heating setpoint"}, 
                           "oveTSetRooHea_u": {"Unit": "K",
                                               "Description": "Heating setpoint"}}
        self.measurements_ref = {"ETotCoo_y": {"Unit": "J", "Description": "Cooling electrical energy"}, 
                                 "ETotFan_y": {"Unit": "J", "Description": "Fan energy"},
                                 "ETotHVAC_y": {"Unit": "J", "Description": "Total HVAC energy"},
                                 "ETotHea_y": {"Unit": "J", "Description": "Heating energy"}, 
                                 "ETotPum_y": {"Unit": "J", "Description": "Pump electrical energy"}, 
                                 "PCoo_y": {"Unit": "W", "Description": "Cooling electrical power"}, 
                                 "PFan_y": {"Unit": "W", "Description": "Fan electrical power"}, 
                                 "PHea_y": {"Unit": "W", "Description": "Heater power"}, 
                                 "PPum_y": {"Unit": "W", "Description": "Pump electrical power"}, 
                                 "TRooAir_y": {"Unit": "K", "Description": "Room air temperature"}}
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