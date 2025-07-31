# -*- coding: utf-8 -*-
"""
This module runs tests for multizone_office_complex_air.  To run these tests, testcase
multizone_office_complex_air must already be deployed.

"""

import unittest
import os
import utilities
import argparse
import requests

# Configure the argument parser
parser = argparse.ArgumentParser(description='Configure the unit tests that are run')
parser.add_argument("-s", "--specify", help="Specify test functions to run delimited by commas")
# Parse the arguments
args = parser.parse_args()
if args.specify is not None:
    test_names = args.specify.split(',')
else:
    test_names = []

class Run(unittest.TestCase, utilities.partialTestTimePeriod):
    '''Tests the example test case.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'multizone_office_complex_air'
        self.url = 'http://127.0.0.1:80'
        self.points_check = ['hva_reaChiWatSys_reaPChi_y', 'hva_reaHotWatSys_reaPBoi_y',
                            'hva_reaChiWatSys_reaPPum_y','hva_reaChiWatSys_reaPCooTow_y',
                            'hva_reaHotWatSys_reaPPum_y',
                             'hva_floor1_reaZonCor_TZon_y', 'hva_floor1_reaZonNor_TZon_y',
                             'hva_floor2_reaZonEas_TZon_y','hva_floor3_reaZonWes_TZon_y',
                             'hva_floor1_reaAHU_TMix_y','hva_floor2_reaAHU_TMix_y','hva_floor3_reaAHU_TMix_y',
                             'loaEnePlu_weaSta_reaWeaTDryBul_y', 'loaEnePlu_weaSta_reaWeaHGloHor_y']
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

    @unittest.skipUnless(('test_peak_heat_day' in test_names) or not(test_names), 'Skipping test_peak_heat_day.')
    def test_peak_heat_day(self):
        self.run_time_period('peak_heat_day')

    @unittest.skipUnless(('test_peak_cool_day' in test_names) or not(test_names), 'Skipping test_peak_cool_day.')
    def test_peak_cool_day(self):
        self.run_time_period('peak_cool_day')

    @unittest.skipUnless(('test_typical_heat_day' in test_names) or not(test_names), 'Skipping test_typical_heat_day.')
    def test_typical_heat_day(self):
        self.run_time_period('typical_heat_day')

    @unittest.skipUnless(('test_typical_cool_day' in test_names) or not(test_names), 'Skipping test_typical_cool_day.')
    def test_typical_cool_day(self):
        self.run_time_period('typical_cool_day')

    @unittest.skipUnless(('test_mix_day' in test_names) or not(test_names), 'Skipping test_mix_day.')
    def test_mix_day(self):
        self.run_time_period('mix_day')

@unittest.skipUnless(('API' in test_names) or not(test_names), 'Skipping API.')
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'multizone_office_complex_air'
        self.url = 'http://127.0.0.1:80'
        self.step_ref = 3600
        self.test_time_period = 'peak_heat_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'hva_floor1_TSupAirSet_activate': 0,
                      'hva_floor1_TSupAirSet_u': 273.15 + 22}
        self.measurement = 'hva_reaHotWatSys_reaPBoi_y'
        self.forecast_point = 'EmissionsElectricPower'
        self.points_check = ['hva_reaChiWatSys_reaPChi_y', 'hva_reaHotWatSys_reaPBoi_y',
                            'hva_reaChiWatSys_reaPPum_y','hva_reaChiWatSys_reaPCooTow_y',
                            'hva_reaHotWatSys_reaPPum_y',
                             'hva_floor1_reaZonCor_TZon_y', 'hva_floor1_reaZonNor_TZon_y',
                             'hva_floor2_reaZonEas_TZon_y','hva_floor3_reaZonWes_TZon_y',
                             'hva_floor1_reaAHU_TMix_y','hva_floor2_reaAHU_TMix_y','hva_floor3_reaAHU_TMix_y',
                             'loaEnePlu_weaSta_reaWeaTDryBul_y', 'loaEnePlu_weaSta_reaWeaHGloHor_y']
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
