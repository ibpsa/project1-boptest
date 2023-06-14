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

        self.name = 'multizone_office_simple_air'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['chi_reaPChi_y', 'heaPum_reaPHeaPum_y',
                             'hvac_reaZonCor_TZon_y', 'hvac_reaZonNor_TZon_y',
                             'hvac_reaZonWes_TZon_y', 'hvac_reaZonSou_CO2Zon_y',
                             'hvac_reaZonEas_CO2Zon_y',
                             'hvac_reaAhu_PFanSup_y', 'hvac_reaAhu_TMix_y',
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

        self.name = 'multizone_office_simple_air'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'hvac_oveAhu_TSupSet_activate': 0,
                      'hvac_oveAhu_TSupSet_u': 273.15 + 22}
        self.measurement = 'hvac_reaAhu_PPumHea_y'
        self.forecast_point = 'EmissionsElectricPower'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
