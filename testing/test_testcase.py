# -*- coding: utf-8 -*-
"""
Created on Wed May 31 06:45:55 2023

@author: dhbubu18
"""

import utilities
import os
import unittest
import testcase

class Advance(unittest.TestCase):
    '''Unit tests for the testcase.TestCase.advance API.

    '''

    def test_check_key(self):
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
        print(payload)

    def setUp(self):
        '''Set up for unit tests.  Uses bestest_air.

        '''

        self.testcase = testcase.TestCase(fmupath='testcases/bestest_air/models/wrapped.fmu')

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
