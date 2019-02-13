# -*- coding: utf-8 -*-
"""
This module runs unit tests for the parer.

"""

import unittest
import requests
from examples import testcase2_supervisory

root_dir = '/home/dhbubu/git/ibpsa/project1-boptest/project1-boptest/'
url = 'http://127.0.0.1:5000'
    
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
        kpi,res = testcase2_supervisory.run()
        # Check kpis
        self.assertEqual(kpi['Heating Energy'], 469467198.2194152)
        
class API(unittest.TestCase):
    '''Tests the api for testcase 1.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        self.name_ref = 'wrapped'
        self.inputs_ref = [u'oveTSetRooCoo_activate', u'oveTSetRooHea_activate', u'oveTSetRooHea_u', u'oveTSetRooCoo_u', u'time']
        self.measurements_ref = [u'PFan_y', u'ETotCoo_y', u'ETotFan_y', u'ETotHea_y', u'TRooAir_y', u'PCoo_y', u'ETotPum_y', u'time', u'PHea_y', u'PPum_y', u'ETotHVAC_y']
        self.step_ref = 3600.0
        
    def test_get_name(self):
        '''Test getting the name of test.
        
        '''

        name = requests.get('{0}/name'.format(url)).json()
        self.assertEqual(name, self.name_ref)
        
    def test_get_inputs(self):
        '''Test getting the input list of tests.
        
        '''
        
        inputs = requests.get('{0}/inputs'.format(url)).json()
        self.assertEqual(len(inputs), len(self.inputs_ref))
        for i in inputs:
            self.assertTrue(i in self.inputs_ref)

    def test_get_measurements(self):
        '''Test getting the measurement list of test.
        
        '''

        measurements = requests.get('{0}/measurements'.format(url)).json()
        self.assertEqual(len(measurements), len(self.measurements_ref))
        for i in measurements:
            self.assertTrue(i in self.measurements_ref)
        
    def test_get_step(self):
        '''Test getting the communication step of test.
        
        '''

        step = requests.get('{0}/step'.format(url)).json()
        self.assertEqual(step, self.step_ref)
        
    def test_set_step(self):
        '''Test setting the communication step of test.
        
        '''

        step = 101
        requests.put('{0}/step'.format(url), data={'step':step})
        step_set = requests.get('{0}/step'.format(url)).json()
        self.assertEqual(step, step_set)
        requests.put('{0}/step'.format(url), data={'step':self.step_ref})
        
    def test_reset(self):
        '''Test reseting of test.
        
        '''

        requests.put('{0}/reset'.format(url))

    def test_get_results(self):
        '''Test geting of test result trajectories.
        
        '''
        
        res = requests.get('{0}/results'.format(url)).json()
        
if __name__ == '__main__':
    unittest.main()