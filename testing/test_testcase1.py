# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 1.  To run these tests, testcase 1 must
already be deployed.

"""

import unittest
import utilities
from examples import testcase1_proportional

root_dir = utilities.get_root_path()
    
class ExampleProportionalPython(unittest.TestCase):
    '''Tests the example test of proportional feedback controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''
        
        # Run test
        kpi,res = testcase1_proportional.run()
        # Check kpis
        self.assertEqual(kpi['Heating Energy'], 47760585.403377)
        
class API(unittest.TestCase, utilities.partialTestAPI):
    '''Tests the api for testcase 2.  
    
    Actual test methods implemented in utilities.partialTestAPI.  Set self 
    attributes defined there for particular testcase in setUp method here.

    '''

    def setUp(self):
        '''Setup for testcase.
        
        '''
        
        self.url = 'http://127.0.0.1:5000'
        self.name_ref = 'wrapped'
        self.inputs_ref = [u'oveAct_u', u'oveAct_activate', u'time']
        self.measurements_ref = [u'PHea_y', u'TRooAir_y', u'ETotHea_y', u'time']
        self.step_ref = 60.0
        
if __name__ == '__main__':
    unittest.main()