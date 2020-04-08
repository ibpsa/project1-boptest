# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase 
bestest_air must already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests

class Run(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the example test case.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        self.url = 'http://127.0.0.1:5000'
        self.length = 48*3600
        
    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.
        
        '''

        # Reset test case
        res_reset = requests.put('{0}/reset'.format(self.url))
        # Get default simulation step
        step_def = requests.get('{0}/step'.format(self.url)).json()
        # Simulation Loop
        for i in range(int(self.length/step_def)):
            # Advance simulation
            y = requests.post('{0}/advance'.format(self.url), data={}).json()
        # Report KPIs
        res_kpi = requests.get('{0}/kpi'.format(self.url)).json()
        # Report results
        res_results = requests.get('{0}/results'.format(self.url)).json()
        # Check trajectories
        # Make dataframe
        df = pd.DataFrame()
        for s in ['y','u']:
            for x in res_results[s].keys():
                if x != 'time':
                    d = pd.DataFrame(data=res_results[s][x], index=res_results['y']['time'], columns=[x])
                    s_n = self.create_test_points(d[x])
                    s_n.name = x
                    df = pd.concat((df,s_n), axis=1)
        df.index.name = 'time'
        
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'bestest_air', 'run.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))