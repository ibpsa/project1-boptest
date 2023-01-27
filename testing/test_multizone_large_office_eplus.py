# -*- coding: utf-8 -*-
"""
This module runs tests for bestest_air.  To run these tests, testcase
bestest_air must already be deployed.

"""

import unittest
import os
import utilities

class Run(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase.

    Actual test methods implemented in utilities.partialTestAPI.  Set self
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.

        '''

        self.name = 'multizone_large_office_eplus'
        self.url = 'http://127.0.0.1:5000'
        self.step_ref = 3600

    def test_get_version(self):
        self.test_get_version(self)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
