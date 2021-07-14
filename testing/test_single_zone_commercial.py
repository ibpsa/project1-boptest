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

        self.name = 'single_zone_commercial'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['readTzonesetpoint_y','readTsupsetpoint_y',
                             'readCO2_y','readTzone_y',
                             'readQelfan_y','readQelpump_y',
                             'readQh_y','airHandlingUnit_readTsupair_y',
                             'airHandlingUnit_readTretair_y']


    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    #def test_peak_cool_day(self):
    #    self.run_time_period('peak_cool_day')

    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    #def test_typical_cool_day(self):
    #    self.run_time_period('typical_cool_day')

    #def test_mix_day(self):
    #    self.run_time_period('mix_day')

    #def test_summer(self):
    #    self.run_season('summer')

    #def test_shoulder(self):
    #    self.run_season('shoulder')


class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'single_zone_commercial'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
