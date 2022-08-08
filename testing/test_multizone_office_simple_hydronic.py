# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase
multizone_office_simple_air must already be deployed.

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

        self.name = 'multizone_office_simple_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['heating_cooling_reaPProCoo_y', 'heating_cooling_reaPProHea_y',
                             'structure_reaTZonNz_y', 'structure_reaTZonSz_y',
                             'structure_reaCO2ZonNz_y', 'structure_reaCO2ZonSz_y',
                             'ventilation_reaPAhuSupNz_y', 'ventilation_reaPAhuSupSz_y',
                             'bms_oveTZonSetMinNz_u', 'bms_oveTZonSetMinSz_u',
                             'bms_oveTZonSetMaxNz_u', 'bms_oveTZonSetMaxSz_u',
                             'weaSta_reaWeaTDryBul_y', 'weaSta_reaWeaHGloHor_y']

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

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'multizone_office_simple_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
