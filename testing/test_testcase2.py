# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 2.  To run these tests, testcase 2 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
from examples.python import testcase2

class ExampleSupervisoryPython(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of a supervisory controller in Python.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.

        '''

        # Run test
        kpi,df_res,customizedkpis_result = testcase2.run()
        # Check kpis
        df = pd.DataFrame.from_dict(kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'kpis_python.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Check trajectories
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_python.csv')
        self.compare_ref_timeseries_df(df_res,ref_filepath)
        # Check customized kpi trajectories
        df = pd.DataFrame()
        for x in customizedkpis_result.keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=customizedkpis_result[x], index=customizedkpis_result['time'], columns=[x])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'customizedkpis.csv')
        self.compare_ref_timeseries_df(df,ref_filepath)

#class ExampleSupervisoryJulia(unittest.TestCase, utilities.partialChecks):
#    '''Tests the example test of a supervisory controller in Julia.
#
#    '''
#
#    def setUp(self):
#        '''Setup for each test.
#
#        '''
#
#        pass
#
#    def test_run(self):
#        '''Runs the example and tests the kpi and trajectory results.
#
#        '''
#
#        # Run test
#        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'kpi_testcase2.csv')
#        res_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'result_testcase2.csv')
#        # Check kpis
#        df = pd.read_csv(kpi_path).transpose()
#        # Check kpis
#        df.columns = ['value']
#        df.index.name = 'keys'
#        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'kpis_julia.csv')
#        self.compare_ref_values_df(df, ref_filepath)
#        # Check trajectories
#        df = pd.read_csv(res_path, index_col = 'time')
#        # Set reference file path
#        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_julia.csv')
#        # Test
#        self.compare_ref_timeseries_df(df,ref_filepath)

#class ExampleSupervisoryJavaScript(unittest.TestCase, utilities.partialChecks):
#    '''Tests the example test of a supervisory controller in JavaScript.
#
#    '''
#
#    def setUp(self):
#        '''Setup for each test.
#
#        '''
#
#        pass
#
#    def test_run(self):
#        '''Runs the example and tests the kpi and trajectory results.
#
#        '''
#
#        # Run test
#        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'kpi_testcase2.csv')
#        res_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'result_testcase2.csv')
#        # Check kpis
#        df = pd.read_csv(kpi_path, index_col = 'keys')
#        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'kpis_javascript.csv')
#        self.compare_ref_values_df(df, ref_filepath)
#        # Check trajectories
#        df = pd.read_csv(res_path, index_col = 'time')
#        # Set reference file path
#        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase2', 'results_javascript.csv')
#        # Test
#        self.compare_ref_timeseries_df(df,ref_filepath)


class MinMax(unittest.TestCase):
    '''Test the use of min/max attributes to truncate the controller input.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'testcase2'
        cls.url = 'http://127.0.0.1:80'
        cls.testid = requests.post('{0}/testcases/{1}/select'.format(cls.url, cls.name)).json()['testid']

    @classmethod
    def tearDownClass(cls):
        requests.put('{0}/stop/{1}'.format(cls.url, cls.testid))

    def setUp(self):
        '''Setup for each test.

        '''

        self.url = MinMax.url

    def test_min(self):
        '''Tests that if input is below min, input is set to min.

        '''

        # Run test
        requests.put('{0}/initialize/{1}'.format(self.url, self.testid), data={'start_time':0, 'warmup_period':0})
        y = requests.post('{0}/advance/{1}'.format(self.url, self.testid), data={"oveTSetRooHea_activate":1,"oveTSetRooHea_u":273.15}).json()['payload']
        # Check kpis
        value = float(y['oveTSetRooHea_u'])
        self.assertAlmostEqual(value, 273.15+10, places=3)

    def test_max(self):
        '''Tests that if input is above max, input is set to max.

        '''

        # Run test
        requests.put('{0}/initialize/{1}'.format(self.url, self.testid), data={'start_time':0, 'warmup_period':0})
        y = requests.post('{0}/advance/{1}'.format(self.url, self.testid), data={"oveTSetRooHea_activate":1,"oveTSetRooHea_u":310.15}).json()['payload']
        # Check kpis
        value = float(y['oveTSetRooHea_u'])
        self.assertAlmostEqual(value, 273.15+35, places=3)

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 2.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    @classmethod
    def setUpClass(cls):
        cls.name = 'testcase2'
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
        self.testid = API.testid
        self.step_ref = 3600.0
        self.test_time_period = 'test_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
