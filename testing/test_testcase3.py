# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 3.  To run these tests, testcase 3 must
already be deployed.

"""

import requests
import unittest
import pandas as pd
import os
import utilities
from examples.python import testcase3

class ExampleProportionalPython(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of proportional feedback controller with
    two zones in Python.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.

        '''

        # Run test
        kpi,df_res,custom_kpi_result = testcase3.run()
        # Check kpis
        df = pd.DataFrame.from_dict(kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase3', 'kpis_python.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase3', 'results_python.csv')
        self.compare_ref_timeseries_df(df_res,ref_filepath)

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 3.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'testcase3'
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
        self.step_ref = 60.0
        self.testid = API.testid
        self.test_time_period = 'test_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
