# -*- coding: utf-8 -*-
"""
This module implements unit tests testcase.py.

"""

import os
import unittest
import numpy as np
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

class WarmupInterval(unittest.TestCase, utilities.partialChecks):
    '''Unit tests for the warmup_interval argument of testcase.TestCase.initialize.

    '''

    def test_warmup_grid(self):
        '''Test that the warmup period uses the requested grid, that omitting
        the argument keeps 30 s, and that the test period stays on 30 s.

        '''

        start_time, warmup_period, step, nsteps = 24*3600, 3600, 900, 4
        for warmup_interval, expected in [(None, 30), (30, 30), (900, 900)]:
            kwargs = {} if warmup_interval is None else \
                {'warmup_interval': warmup_interval}
            self.testcase.initialize(start_time, warmup_period, **kwargs)
            self.testcase.set_step(step)
            for _ in range(nsteps):
                self.testcase.advance(u={})
            # Split the stored trajectory at the start time
            times = np.array(self.testcase.y_store['time'])
            warmup_times = times[times <= start_time]
            test_times = times[times >= start_time]
            np.testing.assert_array_equal(np.unique(np.diff(warmup_times)),
                                          [expected])
            np.testing.assert_array_equal(np.unique(np.diff(test_times)), [30])
            self.assertEqual(test_times[-1], start_time + nsteps*step)

    def test_rejects_invalid(self):
        '''Test that a grid that is not a positive number gives a 400.

        '''

        for value in [0, -30, 'abc']:
            status, message, payload = \
                self.testcase.initialize(24*3600, 3600, warmup_interval=value)
            self.assertEqual(status, 400)
            self.assertEqual(payload, None)
            self.assertTrue('warmup_interval' in message)

    def test_kpi_integration_starts_at_the_start_time(self):
        '''Test that the warmup samples are excluded from the KPI integration
        whatever grid they were recorded on.

        '''

        start_time, warmup_period = 24*3600, 3600
        for warmup_interval in [30, 900]:
            self.testcase.initialize(start_time, warmup_period,
                                     warmup_interval=warmup_interval)
            self.testcase.cal.initialize()
            i = self.testcase.cal.i_last_tdis
            self.assertTrue(self.testcase.y_store['time'][i] >= start_time)
            self.assertTrue(self.testcase.y_store['time'][i-1] < start_time)

    def setUp(self):
        '''Set up for unit tests.  Uses bestest_air.

        '''

        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        self.testcase = TestCase(fmupath='testcases/bestest_air/models/wrapped.fmu')


if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
