# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase
bestest_air must already be deployed.

"""

import unittest
import os
import utilities
import requests

class Run(unittest.TestCase, utilities.partialTestTimePeriod):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'bestest_air'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['fcu_reaPCoo_y', 'fcu_reaFloSup_y',
                             'fcu_oveTSup_u', 'fcu_oveFan_u',
                             'zon_reaPPlu_y', 'fcu_reaPFan_y',
                             'fcu_reaPHea_y', 'zon_reaPLig_y',
                             'zon_reaTRooAir_y', 'zon_reaCO2RooAir_y',
                             'zon_weaSta_reaWeaTDryBul_y']

    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    def test_peak_cool_day(self):
        self.run_time_period('peak_cool_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    def test_typical_cool_day(self):
        self.run_time_period('typical_cool_day')

    def test_mix_day(self):
        self.run_time_period('mix_day')

    def test_scenario_flag(self):
        '''Ensures the scenario flag is set properly.

        Parameters
        ----------
        None

        Returns
        -------
        None

        '''

        length = 86400*14
        # Get current step
        step_current = requests.get('{0}/step'.format(self.url)).json()['payload']
        # Initialize test case scenario
        requests.put('{0}/scenario'.format(self.url), json={'time_period':'peak_heat_day'})
        # Set simulation step
        requests.put('{0}/step'.format(self.url), json={'step':length})
        # Simulation Loop
        requests.post('{0}/advance'.format(self.url), json=dict())
        # Try submit results to dashboard
        status = requests.post("{0}/submit".format(self.url), json={"api_key": 'valid_key',
                                                                     "unit_test":"True"}).json()['status']
        # Check result
        self.assertEqual(status,200)
        # Return scenario and step to original
        requests.put('{0}/step'.format(self.url), json={'step':step_current})

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'bestest_air'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'fcu_oveTSup_activate': 0, 'fcu_oveTSup_u': 290}
        self.measurement = 'zon_weaSta_reaWeaSolHouAng_y'
        self.forecast_point = 'EmissionsElectricPower'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
