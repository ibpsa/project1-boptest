# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_hydronic_heat_pump.  
To run these tests, testcase bestest_hydronic_heat_pump must already 
be deployed.

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
        
        self.name = 'bestest_hydronic_heat_pump'
        self.url = 'http://127.0.0.1:5000'
        self.length = 48*3600
    
    def test_winter(self):
        self._run('winter')
        
    def test_summer(self):
        self._run('summer')
        
    def test_shoulder(self):
        self._run('shoulder')

    def _run(self, season):
        '''Runs the example and tests the kpi and trajectory results for season.
        
        Parameters
        ----------
        season: str
            'winter' or 'summer' or 'shoulder'
            
        Returns
        -------
        None
        
        '''

        if season == 'winter':
            start_time = 1*24*3600
        elif season == 'summer':
            start_time = 248*24*3600
        elif season == 'shoulder':
            start_time = 118*24*3600
        else:
            raise ValueError('Season {0} unknown.'.format(season))
        # Initialize test case
        res_initialize = requests.put('{0}/initialize'.format(self.url), data={'start_time':start_time, 'warmup_period':0})
        # Get default simulation step
        step_def = requests.get('{0}/step'.format(self.url)).json()
        # Simulation Loop
        for i in range(int(self.length/step_def)):
            # Advance simulation
            y = requests.post('{0}/advance'.format(self.url), data={}).json()
        # Report KPIs
        res_kpi = requests.get('{0}/kpi'.format(self.url)).json()
        # Check kpis
        df = pd.DataFrame.from_dict(res_kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'kpis_{0}.csv'.format(season))
        self.compare_ref_values_df(df, ref_filepath)
        # Report results
        res_results = requests.get('{0}/results'.format(self.url)).json()
        # Check results
        df = self.results_to_df(res_results)
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'results_{0}.csv'.format(season))
        self.compare_ref_timeseries_df(df,ref_filepath)
        
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.  
    
    Actual test methods implemented in utilities.partialTestAPI.  Set self 
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.
        
        '''
        
        self.name = 'bestest_hydronic_heat_pump'
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.step_ref = 3600

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))