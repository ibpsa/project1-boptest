# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 3.  To run these tests, testcase 3 must
already be deployed.

"""

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

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'testcase3'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 60
        self.test_time_period = 'test_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'oveActNor_activate': 0, 'oveActNor_u': 1500,
                      'oveActSou_activate': 0, 'oveActSou_u': 1500}
        self.measurement = 'CO2RooAirSou_y'
        self.forecast_point = 'EmissionsBiomassPower'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
