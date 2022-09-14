# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase
bestest_air must already be deployed.

"""

import unittest
import os
import requests
import utilities
import pandas as pd

class Run(unittest.TestCase, utilities.partialTestTimePeriod, utilities.partialTestSeason):
    '''Tests the example test case.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'singlezone_commercial_hydronic'
        cls.url = 'http://127.0.0.1:80'
        cls.testid = requests.post('{0}/testcases/{1}/select'.format(cls.url, cls.name)).json()['testid']

    @classmethod
    def tearDownClass(cls):
        requests.put('{0}/stop/{1}'.format(cls.url, cls.testid))

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = Run.name
        self.url = Run.url
        self.points_check = ['oveTZonSet_u','oveTSupSet_u',
                             'reaCO2Zon_y','reaTZon_y',
                             'reaPFan_y','reaPPum_y',
                             'reaQHea_y','ahu_reaTSupAir_y',
                             'ahu_reaTRetAir_y']


    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    def test_summer(self):
        self.run_season('summer')

    def test_shoulder(self):
        self.run_season('shoulder')

    def test_zero_flow(self):
        '''Runs the example to test for ability to turn off pump.

        Parameters
        ----------
        None

        Returns
        -------
        None

        '''

        start_time = 15*24*3600
        length = 48*3600/12
        # Initialize test case
        requests.put('{0}/initialize/{1}'.format(self.url, self.testid), data={'start_time':start_time, 'warmup_period':7*24*3600})
        # Get default simulation step
        step_def = requests.get('{0}/step/{1}'.format(self.url, self.testid)).json()['payload']
        # Simulation Loop
        for i in range(int(length/step_def)):
            # Advance simulation
            #switch pump on/off for each timestep
            pump = 0 if (i % 2) == 0 else 1
            u = {'ovePum_activate':1, 'ovePum_u':pump}
            requests.post('{0}/advance/{1}'.format(self.url, self.testid), data=u).json()['payload']
        # Check results
        points = self.get_all_points()
        df = self.results_to_df(points, start_time, start_time+length, self.url)
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'results_zero_flow_test.csv')
        self.compare_ref_timeseries_df(df,ref_filepath)

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'singlezone_commercial_hydronic'
        cls.url = 'http://127.0.0.1:80'
        cls.testid = requests.post('{0}/testcases/{1}/select'.format(cls.url, cls.name)).json()['testid']

    @classmethod
    def tearDownClass(cls):
        requests.put('{0}/stop/{1}'.format(cls.url, cls.testid))

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = API.name
        self.url = API.url
        self.testid = API.testid
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
