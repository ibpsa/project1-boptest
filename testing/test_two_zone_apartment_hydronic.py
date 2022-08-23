# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase
bestest_air must already be deployed.

"""

import unittest
import os
import utilities

class Run(unittest.TestCase, utilities.partialTestTimePeriod):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'two_zone_apartment_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['dayZon_reaTRooAir_y','nigZon_reaTRooAir_y',
			     'hydronicSystem_reaPeleHeaPum_y','dayZon_reaPowFlooHea_y',
			     'nigZon_reaPowFlooHea_y','nigZon_reaTsupFloHea_y',
			     'dayZon_reaTsupFloHea_y','dayZon_reaPowQint_y',
			     'nigZon_reaPowQint_y']

    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')


class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'two_zone_apartment_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 900.0
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
