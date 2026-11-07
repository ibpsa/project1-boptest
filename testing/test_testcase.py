# -*- coding: utf-8 -*-
"""
This module implements unit tests testcase.py.

"""

import os
import unittest
import pandas as pd
import testcase
import utilities

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

reference_result_directory = 'testcase'

class Advance(unittest.TestCase, utilities.partialChecks):
    '''Unit tests for the testcase.TestCase.advance API.

    '''

    def test_check_input_for_zero(self):
        '''Test that an overwrite value of 0 given in float is used.

        '''

        self.testcase.set_step(60)
        # Advance first wih fan speed of 0.5, then with fan speed of 0.0.
        u = {'fcu_oveFan_u': 0.5,
             'fcu_oveFan_activate':1}
        status, message, payload = self.testcase.advance(u)
        u = {'fcu_oveFan_u': 0.0,
             'fcu_oveFan_activate':1}
        status, message, payload = self.testcase.advance(u)
        # Get results
        status, message, payload = self.testcase.get_results(['fcu_reaPFan_y', 'fcu_oveFan_u'],
                                                             0,
                                                             payload['time'])
        # Test results
        df = pd.DataFrame(payload).set_index('time')
        ref_filepath = os.path.join(testing_root_dir, 'references', reference_result_directory, 'check_input_for_zero.csv')
        self.compare_ref_timeseries_df(df, ref_filepath)

    def setUp(self):
        '''Set up for unit tests.  Uses bestest_air.

        '''

        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        self.testcase = TestCase(fmupath='testcases/bestest_air/models/wrapped.fmu')

class GetKpis(unittest.TestCase, utilities.partialChecks):
    '''Unit tests for the testcase.TestCase.get_kpis API.

    '''

    def test_all_kpis_by_default(self):
        '''Test that omitting names returns every core KPI, as before.

        '''

        status, message, payload = self.testcase.get_kpis()
        self.assertEqual(status, 200)
        self.assertEqual(list(payload.keys()),
                         self.testcase.cal.get_core_kpi_names())

    def test_subset_of_kpis(self):
        '''Test that naming KPIs returns those and only those, with the same
        values a request for all of them gives.

        '''

        names = ['cost_tot', 'tdis_tot']
        status, message, payload_all = self.testcase.get_kpis()
        self.assertEqual(status, 200)
        status, message, payload_sub = self.testcase.get_kpis(names)
        self.assertEqual(status, 200)
        self.assertEqual(sorted(payload_sub.keys()), sorted(names))
        for name in names:
            self.assertEqual(payload_sub[name], payload_all[name],
                             '{0} differs when requested on its own.'.format(name))

    def test_single_kpi_as_string(self):
        '''Test that a single name may be given as a string.

        '''

        status, message, payload = self.testcase.get_kpis('cost_tot')
        self.assertEqual(status, 200)
        self.assertEqual(list(payload.keys()), ['cost_tot'])

    def test_invalid_kpi_name(self):
        '''Test that an unknown KPI name is reported as a bad request rather
        than silently ignored or raised as an internal error.

        '''

        status, message, payload = self.testcase.get_kpis(['cost_tot', 'not_a_kpi'])
        self.assertEqual(status, 400)
        self.assertIsNone(payload)
        self.assertTrue('not_a_kpi' in message)

    def setUp(self):
        '''Set up for unit tests.  Uses bestest_air.

        '''

        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        self.testcase = TestCase(fmupath='testcases/bestest_air/models/wrapped.fmu')
        self.testcase.initialize(0, 0)
        self.testcase.set_step(3600)
        self.testcase.advance(u={})

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
