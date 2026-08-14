# -*- coding: utf-8 -*-
"""
This module implements unit tests testcase.py.

"""

import os
import logging
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

class LogLevels(unittest.TestCase):
    '''Unit tests for the log level arguments of testcase.TestCase.

    '''

    def test_defaults_are_unchanged(self):
        '''Test that the defaults are the levels earlier versions hard-coded.

        '''

        case = self._make()
        self.assertEqual(case.fmu.get_log_level(), 7)
        self.assertEqual(logging.getLogger().level, logging.DEBUG)

    def test_levels_are_applied(self):
        '''Test that both levels are set to what was asked for.

        '''

        case = self._make(fmu_log_level=0, log_level=logging.WARNING)
        self.assertEqual(case.fmu.get_log_level(), 0)
        self.assertEqual(logging.getLogger().level, logging.WARNING)

    def _make(self, **kwargs):
        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        return TestCase(fmupath='testcases/bestest_air/models/wrapped.fmu', **kwargs)


if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
