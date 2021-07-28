# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 1.  To run these tests, testcase 1 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
import numpy as np
import time
from examples.python import testcase1
from examples.python import testcase1_scenario

class ExampleProportionalPython(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of proportional feedback controller in Python.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.

        '''

        # Run test
        custom_kpi_config_path = os.path.join(utilities.get_root_path(), 'examples', 'python', 'custom_kpi', 'custom_kpis_example.config')
        kpi,df_res,customizedkpis_result = testcase1.run(customized_kpi_config=custom_kpi_config_path)
        # Check kpis
        df = pd.DataFrame.from_dict(kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_python.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Check trajectories
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_python.csv')
        self.compare_ref_timeseries_df(df_res,ref_filepath)
        # Check customized kpi trajectories
        df = pd.DataFrame()
        for x in customizedkpis_result.keys():
                if x != 'time':
                    df = pd.concat((df,pd.DataFrame(data=customizedkpis_result[x], index=customizedkpis_result['time'], columns=[x])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'customizedkpis.csv')
        self.compare_ref_timeseries_df(df,ref_filepath)

class ExampleScenarioPython(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of feedback controller with scenario options in Python.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi results.

        '''

        # Run test
        kpi = testcase1_scenario.run(plot=False)
        # Check kpis
        df = pd.DataFrame.from_dict(kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_python_scenario.csv')
        self.compare_ref_values_df(df, ref_filepath)

class ExampleProportionalJulia(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of proportional feedback controller in Julia.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.

        '''

        # Run test
        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'kpi_testcase1.csv')
        res_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'result_testcase1.csv')
        # Check kpis
        df = pd.read_csv(kpi_path).transpose()
        # Check kpis
        df.columns = ['value']
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_julia.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Check trajectories
        df = pd.read_csv(res_path, index_col = 'time')
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_julia.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)

class ExampleProportionalJavaScript(unittest.TestCase, utilities.partialChecks):
    '''Tests the example test of proportional feedback controller in JavaScript.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        pass

    def test_run(self):
        '''Runs the example and tests the kpi and trajectory results.

        '''

        # Run test
        kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'kpi_testcase1.csv')
        res_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'result_testcase1.csv')
        # Check kpis
        df = pd.read_csv(kpi_path, index_col = 'keys')
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_javascript.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Check trajectories
        df = pd.read_csv(res_path, index_col = 'time')
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_javascript.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)


class MinMax(unittest.TestCase):
    '''Test the use of min/max attributes to truncate the controller input.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.url = 'http://127.0.0.1:5000'

    def test_min(self):
        '''Tests that if input is below min, input is set to min.

        '''

        # Run test
        requests.put('{0}/initialize'.format(self.url), data={'start_time':0, 'warmup_period':0})
        y = requests.post('{0}/advance'.format(self.url), data={"oveAct_activate":1,"oveAct_u":-500000}).json()
        # Check kpis
        value = float(y['PHea_y'])
        self.assertAlmostEqual(value, 10101.010101010103, places=3)

    def test_max(self):
        '''Tests that if input is above max, input is set to max.

        '''

        # Run test
        requests.put('{0}/initialize'.format(self.url), data={'start_time':0, 'warmup_period':0})
        y = requests.post('{0}/advance'.format(self.url), data={"oveAct_activate":1,"oveAct_u":500000}).json()
        # Check kpis
        value = float(y['PHea_y'])
        self.assertAlmostEqual(value, 10101.010101010103, places=3)

class Scenario(unittest.TestCase, utilities.partialChecks):
    '''Test details about setting the scenario.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'testcase1'
        self.url = 'http://127.0.0.1:5000'

    def test_extra_step(self):
        '''Test that simulation stops if try to take extra step than scenario.

        '''

        scenario = {'time_period':'test_day'}
        requests.put('{0}/scenario'.format(self.url), data=scenario)
        # Try simulating past test period
        step = 7*24*3600
        requests.put('{0}/step'.format(self.url), data={'step':step})
        for i in [0,1,2]:
            y = requests.post('{0}/advance'.format(self.url), data={}).json()
        # Check y[2] indicates no simulation (empty dict)
        self.assertDictEqual(y,dict())
        # Check results
        measurements = requests.get('{0}/measurements'.format(self.url)).json()
        df = self.results_to_df(measurements.keys(), -np.inf, np.inf, self.url)
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'results_time_period_end_extra_step.csv')
        self.compare_ref_timeseries_df(df,ref_filepath)

    def test_larger_step(self):
        '''Test that simulation stops if try to take larger step than scenario.

        '''

        scenario = {'time_period':'test_day'}
        requests.put('{0}/scenario'.format(self.url), data=scenario)
        # Try simulating past test period
        step = 5*7*24*3600
        requests.put('{0}/step'.format(self.url), data={'step':step})
        requests.post('{0}/advance'.format(self.url), data={}).json()
        # Check results
        measurements = requests.get('{0}/measurements'.format(self.url)).json()
        df = self.results_to_df(measurements.keys(), -np.inf, np.inf, self.url)
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'results_time_period_end_larger_step.csv')
        self.compare_ref_timeseries_df(df,ref_filepath)

    def test_longer_initialize(self):
        '''Test that simulation has no end time if use /initialize directly.

        '''
        start_time = 14*86400
        requests.put('{0}/initialize'.format(self.url), data={'start_time':start_time, 'warmup_period':0}).json()
        # Try simulating past a typical test period
        step = 5*7*24*3600
        requests.put('{0}/step'.format(self.url), data={'step':step})
        y = requests.post('{0}/advance'.format(self.url), data={}).json()
        # Check results
        self.assertEqual(y['time'], start_time+step)

    def test_return(self):
        '''Test that scenario returns properly.

        '''

        scenario_both = {'time_period':'test_day',
                         'electricity_price':'dynamic'}
        scenario_time = {'time_period':'test_day'}
        scenario_elec = {'electricity_price':'dynamic'}
        # Both
        res = requests.put('{0}/scenario'.format(self.url), data=scenario_both).json()
        # Check return is valid for electricity price
        self.assertTrue(res['electricity_price'])
        # Check return is valid for time period
        df = pd.DataFrame.from_dict(res['time_period'], orient = 'index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'initial_values_set_scenario.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Time only
        res = requests.put('{0}/scenario'.format(self.url), data=scenario_time).json()
        # Check return is valid for electricity price
        self.assertTrue(res['electricity_price'] is None)
        # Check return is valid for time period
        df = pd.DataFrame.from_dict(res['time_period'], orient = 'index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', self.name, 'initial_values_set_scenario.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Electricity price only
        res = requests.put('{0}/scenario'.format(self.url), data=scenario_elec).json()
        # Check return is valid for electricity price
        self.assertTrue(res['electricity_price'])
        # Check return is valid for time period
        self.assertTrue(res['time_period'] is None)

class ComputationalTimeRatio(unittest.TestCase):
    '''Test the computational time ratio KPI explicitly.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.url = 'http://127.0.0.1:5000'

    def test_constant_step(self):
        '''Tests the calculation of the kpi with a constant step.

        '''

        # Run test
        requests.put('{0}/initialize'.format(self.url), data={'start_time':0, 'warmup_period':0})
        step = requests.get('{0}/step'.format(self.url)).json()
        for i in range(5):
            requests.post('{0}/advance'.format(self.url), data={}).json()
            time.sleep(2)
        # Check kpis
        kpi = requests.get('{0}/kpi'.format(self.url)).json()
        self.assertAlmostEqual(kpi['time_rat'], 2.0/step, places=2)
        requests.put('{0}/step'.format(self.url), data={'step':step})

    def test_variable_step(self):
        '''Tests the calculation of the kpi with a variable step.

        '''

        # Run test
        requests.put('{0}/initialize'.format(self.url), data={'start_time':0, 'warmup_period':0})
        step = requests.get('{0}/step'.format(self.url)).json()
        for i in range(5):
            if i > 2:
                requests.put('{0}/step'.format(self.url), data={'step':2*step})
            requests.post('{0}/advance'.format(self.url), data={}).json()
            time.sleep(2)
        # Check kpis
        kpi = requests.get('{0}/kpi'.format(self.url)).json()
        self.assertAlmostEqual(kpi['time_rat'], (3*2.0/step+2*2.0/(2*step))/5, places=2)
        requests.put('{0}/step'.format(self.url), data={'step':step})

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 1.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'testcase1'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 60.0
        self.test_time_period = 'test_day'

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
