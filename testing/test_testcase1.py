# -*- codin5000g: utf-8 -*-
"""
This module runs tests for testcase 1.  To run these tests, testcase 1 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
from examples.python import testcase1
from boptest_client import BoptestClient

## class ExampleProportionalPython(unittest.TestCase, utilities.partialChecks):
##     '''Tests the example test of proportional feedback controller in Python.
## 
##     '''
## 
##     def setUp(self):
##         '''Setup for each test.
## 
##         '''
## 
##         pass
## 
##     def test_run(self):
##         '''Runs the example and tests the kpi and trajectory results.
## 
##         '''
## 
##         # Run test
##         custom_kpi_config_path = os.path.join(utilities.get_root_path(), 'examples', 'python', 'custom_kpi', 'custom_kpis_example.config')
##         kpi,df_res,customizedkpis_result = testcase1.run(customized_kpi_config=custom_kpi_config_path)
##         # Check kpis
##         df = pd.DataFrame.from_dict(kpi, orient='index', columns=['value'])
##         df.index.name = 'keys'
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_python.csv')
##         self.compare_ref_values_df(df, ref_filepath)
##         # Check trajectories
##         # Set reference file path
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_python.csv')
##         self.compare_ref_timeseries_df(df_res,ref_filepath)
##         # Check customized kpi trajectories
##         df = pd.DataFrame()
##         for x in customizedkpis_result.keys():
##                 if x != 'time':
##                     df = pd.concat((df,pd.DataFrame(data=customizedkpis_result[x], index=customizedkpis_result['time'], columns=[x])), axis=1)
##         df.index.name = 'time'
##         # Set reference file path
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'customizedkpis.csv')
##         self.compare_ref_timeseries_df(df,ref_filepath)
## 
## class ExampleProportionalJulia(unittest.TestCase, utilities.partialChecks):
##     '''Tests the example test of proportional feedback controller in Julia.
## 
##     '''
## 
##     def setUp(self):
##         '''Setup for each test.
## 
##         '''
## 
##         pass
## 
##     def test_run(self):
##         '''Runs the example and tests the kpi and trajectory results.
## 
##         '''
## 
##         # Run test
##         kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'kpi_testcase1.csv')
##         res_path = os.path.join(utilities.get_root_path(), 'examples', 'julia', 'result_testcase1.csv')
##         # Check kpis
##         df = pd.read_csv(kpi_path).transpose()
##         # Check kpis
##         df.columns = ['value']
##         df.index.name = 'keys'
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_julia.csv')
##         self.compare_ref_values_df(df, ref_filepath)
##         # Check trajectories
##         df = pd.read_csv(res_path, index_col = 'time')
##         # Set reference file path
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_julia.csv')
##         # Test
##         self.compare_ref_timeseries_df(df,ref_filepath)
## 
## class ExampleProportionalJavaScript(unittest.TestCase, utilities.partialChecks):
##     '''Tests the example test of proportional feedback controller in JavaScript.
## 
##     '''
## 
##     def setUp(self):
##         '''Setup for each test.
## 
##         '''
## 
##         pass
## 
##     def test_run(self):
##         '''Runs the example and tests the kpi and trajectory results.
## 
##         '''
## 
##         # Run test
##         kpi_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'kpi_testcase1.csv')
##         res_path = os.path.join(utilities.get_root_path(), 'examples', 'javascript', 'result_testcase1.csv')
##         # Check kpis
##         df = pd.read_csv(kpi_path, index_col = 'keys')
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'kpis_javascript.csv')
##         self.compare_ref_values_df(df, ref_filepath)
##         # Check trajectories
##         df = pd.read_csv(res_path, index_col = 'time')
##         # Set reference file path
##         ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'testcase1', 'results_javascript.csv')
##         # Test
##         self.compare_ref_timeseries_df(df,ref_filepath)
## 
## 
## class MinMax(unittest.TestCase):
##     '''Test the use of min/max attributes to truncate the controller input.
## 
##     '''
##     @classmethod
##     def setUpClass(cls):
##         cls.name = 'testcase1'
##         cls.url = 'http://127.0.0.1:80'
##         client = BoptestClient(cls.url)
##         cls.testid = client.submit('testcases/{0}/models/wrapped.fmu'.format(cls.name))
## 
##     def setUp(self):
##         '''Setup for each test.
## 
##         '''
## 
##         self.url = MinMax.url
##         self.testid = MinMax.testid
## 
##     def tearDown(self):
##         requests.put('{0}/stop/{1}'.format(self.url, self.testid))
## 
##     def test_min(self):
##         '''Tests that if input is below min, input is set to min.
## 
##         '''
## 
##         # Run test
##         requests.put('{0}/initialize/{1}'.format(self.url, self.testid))
##         y = requests.post('{0}/advance/{1}'.format(self.url, self.testid), data={"oveAct_activate":1,"oveAct_u":-500000}).json()
##         # Check kpis
##         value = float(y['PHea_y'])
##         self.assertAlmostEqual(value, 10101.010101010103, places=3)
## 
##     def test_max(self):
##         '''Tests that if input is above max, input is set to max.
## 
##         '''
## 
##         # Run test
##         requests.put('{0}/initialize/{1}'.format(self.url, self.testid))
##         y = requests.post('{0}/advance/{1}'.format(self.url, self.testid), data={"oveAct_activate":1,"oveAct_u":500000}).json()
##         # Check kpis
##         value = float(y['PHea_y'])
##         self.assertAlmostEqual(value, 10101.010101010103, places=3)

class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 1.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''
    @classmethod
    def setUpClass(cls):
        cls.name = 'testcase1'
        cls.url = 'http://127.0.0.1:80'
        client = BoptestClient(cls.url)
        cls.testid = client.submit('testcases/{0}/models/wrapped.fmu'.format(cls.name))

    def setUp(self):
        '''Setup for testcase.

        '''
        self.name = API.name
        self.url = API.url
        self.name_ref = 'wrapped'
        self.step_ref = 60.0
        self.testid = API.testid

    def tearDown(self):
        requests.put('{0}/stop/{1}'.format(self.url, self.testid))

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
