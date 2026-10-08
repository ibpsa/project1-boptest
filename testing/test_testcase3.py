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
        # <u_variable>_activate is meant to be 0 for the
        # test_advance_false_overwrite API test.
        self.input = {
            'ctrReaBlo_1_ctrReaBloNested_1_oveAct_activate': 0,
            'ctrReaBlo_1_ctrReaBloNested_1_oveAct_u': 1500
        }
        self.measurement = 'PheaCooVec_1_y'
        self.forecast_point = 'EmissionsBiomassPower'
        self.testid = requests.post("{0}/testcases/{1}/select".format(self.url, self.name)).json()["testid"]

    def tearDown(self):
        requests.put("{0}/stop/{1}".format(self.url, self.testid))

    def test_array_signal_exchange(self):
        '''Tests the metadata of the four nested overwrite blocks and
        checks that distinct commands reach the corresponding zones for
        two time steps.

        '''

        expected = {
            1: ('ctrReaBlo_1_ctrReaBloNested_1_oveAct_u', 10000, 2000),
            2: ('ctrReaBlo_1_ctrReaBloNested_2_oveAct_u', 11000, 4000),
            3: ('ctrReaBlo_2_ctrReaBloNested_1_oveAct_u', 12000, 6000),
            4: ('ctrReaBlo_2_ctrReaBloNested_2_oveAct_u', 13000, 8000)
        }

        # Check advertised input metadata.
        inputs = requests.get(
            '{0}/inputs/{1}'.format(self.url, self.testid)
        ).json()['payload']
        for zone, (point, pnom, command) in expected.items():
            self.assertIn(point, inputs)
            self.assertIn(point[:-2] + '_activate', inputs)
            self.assertEqual(inputs[point]['Unit'], 'W')
            self.assertEqual(
                inputs[point]['Description'],
                'Heater thermal power of zone'
            )
            self.assertAlmostEqual(inputs[point]['Minimum'], -pnom, places=3)
            self.assertAlmostEqual(inputs[point]['Maximum'], pnom, places=3)

        # Check that each zone has a power measurement.
        measurements = requests.get(
            '{0}/measurements/{1}'.format(self.url, self.testid)
        ).json()['payload']
        for zone in expected:
            point = 'PheaCooVec_{0}_y'.format(zone)
            self.assertIn(point, measurements)
            self.assertEqual(measurements[point]['Unit'], 'W')

        # Apply a different overwrite command to each zone.
        u = {}
        for zone, (point, pnom, command) in expected.items():
            u[point] = command
            u[point[:-2] + '_activate'] = 1

        requests.put(
            '{0}/initialize/{1}'.format(self.url, self.testid),
            json={'start_time': 0, 'warmup_period': 0}
        )
        requests.put(
            '{0}/step/{1}'.format(self.url, self.testid),
            json={'step': self.step_ref}
        )

        for step in range(2):
            y = requests.post(
                '{0}/advance/{1}'.format(self.url, self.testid),
                json=u
            ).json()['payload']

            for zone, (point, pnom, command) in expected.items():
                with self.subTest(step=step, zone=zone):
                    power_point = 'PheaCooVec_{0}_y'.format(zone)
                    self.assertIn(power_point, y)
                    self.assertAlmostEqual(
                        y[power_point], command / 0.99, places=3
                    )

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
