# -*- coding: utf-8 -*-
"""
This module runs tests for multizone_residential_hydronic.  To run
these tests, testcase multizone_residential_hydronic must already be
deployed.

"""

import requests
import unittest
import os
import utilities

class Run(unittest.TestCase, utilities.partialTestTimePeriod, utilities.partialTestSeason):
    '''Tests the example test case.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'multizone_residential_hydronic'
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
        self.points_check = ['boi_reaGasBoi_y', 'boi_reaPpum_y',
                             'conHeaBth_reaTZon_y', 'conHeaLiv_reaTZon_y',
                             'conHeaRo1_reaTZon_y', 'conHeaRo2_reaTZon_y',
                             'conHeaRo3_reaTZon_y', 'reaTHal_y',
                             'extLiv_reaCO2RooAir_y', 'conCooBth_reaPCoo_y',
                             'conCooHal_reaPCoo_y', 'conCooLiv_reaPCoo_y',
                             'conCooRo1_reaPCoo_y', 'conCooRo2_reaPCoo_y',
                             'conCooRo3_reaPCoo_y', 'conHeaBth_reaActHea_y',
                             'conHeaLiv_reaActHea_y',
                             'conHeaRo1_reaActHea_y', 'conHeaRo2_reaActHea_y',
                             'conHeaRo3_reaActHea_y']

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

    @classmethod
    def setUpClass(cls):
        cls.name = 'multizone_residential_hydronic'
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
        self.step_ref = 3600
        self.testid = API.testid
        self.test_time_period = 'peak_heat_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
