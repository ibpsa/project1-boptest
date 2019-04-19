# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 1.  To run these tests, testcase 1 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
from examples import twoday_p

root_dir = utilities.get_root_path()
    
class ExampleProportionalPython(unittest.TestCase):
    '''Tests the example test of proportional feedback controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''
        
        # Run test
        kpi,res = twoday_p.run()
        # Check kpis
        self.assertAlmostEqual(kpi['energy'], 13.266839892179254, places=5)
        self.assertAlmostEqual(kpi['comfort'], 6.568340735543789, places=5)
        # Check trajectories
        # Make dataframe
        df = pd.DataFrame(data=res['y']['time'], columns=['time'])
        for s in ['y','u']:
            for x in res[s].keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=res[s][x], columns=[x])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results.csv')
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
        
        self.name = 'testcase1'
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = {"oveAct_activate": {"Unit": None, "Description": "Activation for Heater thermal power"}, 
                           "oveAct_u": {"Unit": "W", "Description": "Heater thermal power"}}
        self.measurements_ref = {"ETotHea_y": {"Unit": "J", "Description":"Heater energy"},
                                 "PHea_y": {"Unit": "W", "Description": "Heater power"},
                                 "TRooAir_y": {"Unit": "K", "Description": "Zone air temperature"}}
        self.step_ref = 60.0
        self.y_ref = {u'PHea_y': 0.0, 
                      u'TRooAir_y': 293.15015556512265, 
                      u'ETotHea_y': -2.18888639030113e-13, 
                      u'time': 60.0}

        
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))