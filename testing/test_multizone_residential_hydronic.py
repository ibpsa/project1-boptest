# -*- coding: utf-8 -*-
"""
This module runs tests for multizone_residential_hydronic.  To run
these tests, testcase multizone_residential_hydronic must already be
deployed.

"""

import unittest
import os
import utilities
import argparse

# Configure the argument parser
parser = argparse.ArgumentParser(description='Configure the unit tests that are run')
parser.add_argument("-s", "--specify", help="Specify test functions to run delimited by commas")
# Parse the arguments
args = parser.parse_args()
if args.specify is not None:
    test_names = args.specify.split(',')
else:
    test_names = []

class Run(unittest.TestCase, utilities.partialTestTimePeriod, utilities.partialTestSeason):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'multizone_residential_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.points_check = ['boi_reaGasBoi_y', 'boi_reaPpum_y',
                             'conHeaBth_reaTZon_y', 'conHeaLiv_reaTZon_y',
                             'conHeaRo1_reaTZon_y', 'conHeaRo2_reaTZon_y',
                             'conHeaRo3_reaTZon_y', 'reaTHal_y',
                             'extLiv_reaCO2RooAir_y', 'conCooBth_reaPCoo_y',
                             'conCooHal_reaPCoo_y', 'conCooLiv_reaPCoo_y',
                             'conCooRo1_reaPCoo_y', 'conCooRo2_reaPCoo_y',
                             'conCooRo3_reaPCoo_y', 'conHeaBth_oveActHea_u',
                             'conHeaLiv_oveActHea_u',
                             'conHeaRo1_oveActHea_u', 'conHeaRo2_oveActHea_u',
                             'conHeaRo3_oveActHea_u']

    @unittest.skipUnless(('test_peak_heat_day' in test_names) or not(test_names), 'Skipping test_peak_heat_day.')
    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    @unittest.skipUnless(('test_typical_heat_day' in test_names) or not(test_names), 'Skipping test_typical_heat_day.')
    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    @unittest.skipUnless(('test_summer' in test_names) or not(test_names), 'Skipping test_summer.')
    def test_summer(self):
        self.run_season('summer')

    @unittest.skipUnless(('test_shoulder' in test_names) or not(test_names), 'Skipping test_shoulder.')
    def test_shoulder(self):
        self.run_season('shoulder')

@unittest.skipUnless(('API' in test_names) or not(test_names), 'Skipping API.')
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'multizone_residential_hydronic'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'conHeaRo1_oveTSetHea_activate': 0,
                      'conHeaRo1_oveTSetHea_u': 273.15 + 22,
                      'oveEmiPum_activate': 0,
                      'oveEmiPum_u': 1}
        self.measurement = 'weatherStation_reaWeaWinSpe_y'
        self.forecast_point = 'EmissionsElectricPower'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__), test_names)
