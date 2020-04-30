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

class Run(unittest.TestCase, utilities.partialChecks):
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

        # Initialize test case
        res_initialize = requests.put('{0}/initialize'.format(self.url), data={'start_time':0, 'warmup_period':0})
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
        df = self.results_to_df(res_results)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'bestest_air', 'run.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))