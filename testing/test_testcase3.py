# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 3.  To run these tests, testcase 3 must
already be deployed.

"""

import unittest
import pandas as pd
import os
import utilities
import requests
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
        self.url = 'http://127.0.0.1:8000'
        self.step_ref = 60
        self.test_time_period = 'test_day'
        #<u_variable>_activate is meant to be 0 for the test_advance_false_overwrite API test
        self.input = {'oveActVec_1_activate': 0, 'oveActVec_1_u': 1500,
                      'oveActVec_2_activate': 0, 'oveActVec_2_u': 1500}
        self.measurement = 'CO2RooAirSou_y'
        self.forecast_point = 'EmissionsBiomassPower'
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

    def test_array_signal_exchange(self):
        '''Tests that signal exchange blocks declared as arrays, and blocks
        instantiated within arrays of models, are exposed with the metadata
        of the correct array element and are wired to that same element.

        '''

        expected = {
            'oveActVec_1_u': (-10000, 10000, 'Heater thermal power of north zone'),
            'oveActVec_2_u': (-15000, 15000, 'Heater thermal power of south zone'),
            'ctrReaBlo_1_oveAct_1_u': (-10000, 10000, 'Heater thermal power of north zone'),
            'ctrReaBlo_1_oveAct_2_u': (-5000, 5000, 'Heater thermal power of south zone'),
            'ctrReaBlo_2_oveAct_1_u': (-10000, 10000, 'Heater thermal power of north zone'),
            'ctrReaBlo_2_oveAct_2_u': (-5000, 5000, 'Heater thermal power of south zone'),
            'ctrReaBlo_1_ctrReaBloNested_1_oveAct_u': (-10000, 10000, 'Heater thermal power of north zone'),
            'ctrReaBlo_1_ctrReaBloNested_2_oveAct_u': (-10000, 10000, 'Heater thermal power of south zone'),
            'ctrReaBlo_2_ctrReaBloNested_1_oveAct_u': (-10000, 10000, 'Heater thermal power of north zone'),
            'ctrReaBlo_2_ctrReaBloNested_2_oveAct_u': (-10000, 10000, 'Heater thermal power of south zone'),
            'ctrReaBlo_1_ctrReaBloNested_1_oveActGenDes_u': (-10000, 10000, 'Overwrite the heating power of zone'),
            'ctrReaBlo_1_ctrReaBloNested_2_oveActGenDes_u': (-10000, 10000, 'Overwrite the heating power of zone'),
            'ctrReaBlo_2_ctrReaBloNested_1_oveActGenDes_u': (-10000, 10000, 'Overwrite the heating power of zone'),
            'ctrReaBlo_2_ctrReaBloNested_2_oveActGenDes_u': (-10000, 10000, 'Overwrite the heating power of zone')}
        # Array read points fed by the north and south CO2 sources respectively
        nor = ['CO2RooAirVec_1_y',
               'ctrReaBlo_1_CO2RooAir_1_y', 'ctrReaBlo_2_CO2RooAir_1_y',
               'ctrReaBlo_1_ctrReaBloNested_1_CO2RooAir_y',
               'ctrReaBlo_2_ctrReaBloNested_1_CO2RooAir_y']
        sou = ['CO2RooAirVec_2_y',
               'ctrReaBlo_1_CO2RooAir_2_y', 'ctrReaBlo_2_CO2RooAir_2_y',
               'ctrReaBlo_1_ctrReaBloNested_2_CO2RooAir_y',
               'ctrReaBlo_2_ctrReaBloNested_2_CO2RooAir_y']
        # Check advertised input metadata
        inputs = requests.get('{0}/inputs/{1}'.format(self.url, self.testid)).json()['payload']
        for point, (mini, maxi, description) in expected.items():
            self.assertIn(point, inputs)
            self.assertIn(point[:-2] + '_activate', inputs)
            self.assertEqual(inputs[point]['Unit'], 'W')
            self.assertEqual(inputs[point]['Description'], description)
            self.assertAlmostEqual(inputs[point]['Minimum'], mini, places=3)
            self.assertAlmostEqual(inputs[point]['Maximum'], maxi, places=3)
        # Check advertised measurement metadata
        measurements = requests.get('{0}/measurements/{1}'.format(self.url, self.testid)).json()['payload']
        for point in nor + sou:
            self.assertIn(point, measurements)
            self.assertEqual(measurements[point]['Unit'], 'ppm')
        for point in nor:
            self.assertEqual(measurements[point]['Description'], 'Zone air CO2 concentration of north zone')
        for point in sou:
            self.assertEqual(measurements[point]['Description'], 'Zone air CO2 concentration of south zone')
        # Advance one step with a distinct value on every element.  Values stay
        # within the bounds of every element so API clipping cannot confound.
        u = dict()
        for i, point in enumerate(sorted(expected.keys())):
            u[point] = 1000 + 100*i
            u[point[:-2] + '_activate'] = 1
        requests.put('{0}/initialize/{1}'.format(self.url, self.testid),
                     json={'start_time': 0, 'warmup_period': 0})
        requests.put('{0}/step/{1}'.format(self.url, self.testid), json={'step': self.step_ref})
        y = requests.post('{0}/advance/{1}'.format(self.url, self.testid), json=u).json()['payload']
        # An activated overwrite block echoes its input on its own output, so
        # each element must report back the value written to that same element
        for point in expected.keys():
            self.assertAlmostEqual(y[point[:-2] + '_u'], u[point], places=3)
        # The north and south CO2 sources are identical sinusoids offset by a
        # constant 50 ppm, so every read point must agree with the others fed
        # by the same source and differ from the opposite group by exactly 50
        for point in nor:
            self.assertAlmostEqual(y[point], y[nor[0]], places=3)
        for point in sou:
            self.assertAlmostEqual(y[point], y[sou[0]], places=3)
        self.assertAlmostEqual(y[nor[0]] - y[sou[0]], 50, places=3)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))