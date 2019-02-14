# -*- coding: utf-8 -*-
"""
This module runs tests for testcase 2.  To run these tests, testcase 2 must 
already be deployed.

"""

import unittest
import utilities
from examples import testcase2_supervisory

root_dir = utilities.get_root_path()
    
class ExampleSupervisoryPython(unittest.TestCase):
    '''Tests the example test of a supervisory controller in Python.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        pass
        
    def test_run(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''
        
        # Run test
        kpi,res = testcase2_supervisory.run()
        # Check kpis
        self.assertEqual(kpi['Heating Energy'], 469467198.2194152)
        
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
        self.inputs_ref = [u'oveTSetRooCoo_activate', u'oveTSetRooHea_activate', u'oveTSetRooHea_u', u'oveTSetRooCoo_u', u'time']
        self.measurements_ref = [u'PFan_y', u'ETotCoo_y', u'ETotFan_y', u'ETotHea_y', u'TRooAir_y', u'PCoo_y', u'ETotPum_y', u'time', u'PHea_y', u'PPum_y', u'ETotHVAC_y']
        self.step_ref = 3600.0

if __name__ == '__main__':
    unittest.main()