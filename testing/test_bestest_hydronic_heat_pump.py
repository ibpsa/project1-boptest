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

class Run(unittest.TestCase, utilities.partialTestTimePeriod, utilities.partialTestSeason):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'bestest_hydronic_heat_pump'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['reaPFan_y', 'reaQHeaPumCon_y',
                             'reaTRet_y', 'reaQHeaPumEva_y',
                             'reaPum_y', 'reaTZon_y',
                             'reaTSup_y', 'reaPPumEmi_y',
                             'reaFan_y', 'reaPHeaPum_y',
                             'reaHeaPumY_y', 'reaQFloHea_y',
                             'reaCOP_y']

    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    def test_summer(self):
        self.run_season('summer')

    def test_shoulder(self):
        self.run_season('shoulder')

    def test_event(self):
        '''Runs the example to test for correct event handling.

        Parameters
        ----------
        None

        Returns
        -------
        None

        '''

        start_time = 118*24*3600
        length = 48*3600/12
        # Initialize test case
        requests.put('{0}/initialize'.format(self.url), data={'start_time':start_time, 'warmup_period':0})
        # Get default simulation step
        step_def = requests.get('{0}/step'.format(self.url)).json()
        # Simulation Loop
        for i in range(int(length/step_def)):
            # Advance simulation
            #switch pump on/off for each timestep
            pump = 0 if (i % 2) == 0 else 1
            u = {'ovePum_activate':1, 'ovePum_u':pump}
            requests.post('{0}/advance'.format(self.url), data=u).json()
        # Check results
        points = self.get_all_points(self.url)
        df = self.results_to_df(points, start_time, start_time+length, self.url)
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'results_event_test.csv')
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
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
