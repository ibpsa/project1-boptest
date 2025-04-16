# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_hydronic.  To run these tests,
testcase bestest_hydronic must already be deployed.

"""

import unittest
import os
import utilities
import requests

class Run(unittest.TestCase, utilities.partialTestTimePeriod, utilities.partialTestSeason):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'bestest_hydronic'
        self.url = 'http://127.0.0.1:80'
        self.points_check = ['reaQHea_y', 'reaTRoo_y',
                             'ovePum_u', 'reaPPum_y',
                             'oveTSetSup_u', 'weaSta_reaWeaTDryBul_y']
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    def test_summer(self):
        self.run_season('summer')

    def test_shoulder(self):
        self.run_season('shoulder')

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'bestest_hydronic'
        self.url = 'http://127.0.0.1:80'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'oveTSetSup_activate': 0,
                      'oveTSetSup_u': 273.15+60,
                      'ovePum_activate': 0,
                      'ovePum_u': 1}
        self.measurement = 'reaQHea_y'
        self.forecast_point = 'EmissionsElectricPower'
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
