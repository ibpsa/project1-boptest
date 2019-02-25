# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 2.  To run these tests, testcase 2 must 
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
from examples import szvav_sup

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
        self.assertEqual(kpi['energy'], 132.40084858017514)
        self.assertEqual(kpi['comfort'], 4.610775885198207)
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

        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = [u'oveTSetRooCoo_activate', u'oveTSetRooHea_activate', u'oveTSetRooHea_u', u'oveTSetRooCoo_u', u'time']
        self.measurements_ref = [u'PFan_y', u'ETotCoo_y', u'ETotFan_y', u'ETotHea_y', u'TRooAir_y', u'PCoo_y', u'ETotPum_y', u'time', u'PHea_y', u'PPum_y', u'ETotHVAC_y']
        self.step_ref = 3600.0

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))