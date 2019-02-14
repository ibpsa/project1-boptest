# -*- coding: utf-8 -*-
"""
This module contains testing utilities used throughout test scripts, including
common functions and partial classes.

"""

import os
import requests

def get_root_path():
    '''Returns the path to the root repository directory.
    
    '''
    
    testing_path = os.path.dirname(os.path.realpath(__file__));
    root_path = os.path.split(testing_path)[0]
    
    return root_path;
    
class partialTestAPI(object):
    '''This class implements common API tests for test cases.
    
    References to self attributes for the tests should be set in the setUp 
    method of the particular testclass test.  They are:

    url : str
        URL to deployed testcase.
    name_ref : str
        Name given to test
    inputs_ref : list of str
        List of names of inputs
    measurements_ref : list of str
        List of names of measurements
    step_ref : numeric
        Default simulation step
    
    '''
    
    def test_get_name(self):
        '''Test getting the name of test.
        
        '''

        name = requests.get('{0}/name'.format(self.url)).json()
        self.assertEqual(name, self.name_ref)
        
    def test_get_inputs(self):
        '''Test getting the input list of tests.
        
        '''
        
        inputs = requests.get('{0}/inputs'.format(self.url)).json()
        self.assertEqual(len(inputs), len(self.inputs_ref))
        for i in inputs:
            self.assertTrue(i in self.inputs_ref)

    def test_get_measurements(self):
        '''Test getting the measurement list of test.
        
        '''

        measurements = requests.get('{0}/measurements'.format(self.url)).json()
        self.assertEqual(len(measurements), len(self.measurements_ref))
        for i in measurements:
            self.assertTrue(i in self.measurements_ref)
        
    def test_get_step(self):
        '''Test getting the communication step of test.
        
        '''

        step = requests.get('{0}/step'.format(self.url)).json()
        self.assertEqual(step, self.step_ref)
        
    def test_set_step(self):
        '''Test setting the communication step of test.
        
        '''

        step = 101
        requests.put('{0}/step'.format(self.url), data={'step':step})
        step_set = requests.get('{0}/step'.format(self.url)).json()
        self.assertEqual(step, step_set)
        requests.put('{0}/step'.format(self.url), data={'step':self.step_ref})
        
    def test_reset(self):
        '''Test reseting of test.
        
        '''

        requests.put('{0}/reset'.format(self.url))

    def test_get_results(self):
        '''Test geting of test result trajectories.
        
        '''
        
        res = requests.get('{0}/results'.format(self.url)).json()