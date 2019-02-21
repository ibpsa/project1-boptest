# -*- coding: utf-8 -*-
"""
This module contains testing utilities used throughout test scripts, including
common functions and partial classes.

"""

import os
import requests
import unittest
import numpy as np
import json

def get_root_path():
    '''Returns the path to the root repository directory.
    
    '''
    
    testing_path = os.path.dirname(os.path.realpath(__file__));
    root_path = os.path.split(testing_path)[0]
    
    return root_path;
    
def check_trajectory(y_test, y_ref):
    '''Check a numeric trajectory against a reference with a tolerance.
    
    Parameters
    ----------
    y_test : list-like of numerics
        Test trajectory
    y_ref : list-like of numerics
        Reference trajectory
        
    Returns
    -------
    result : dict
        Dictionary of result of check.
        {'Pass' : bool, True if ErrorMax <= tol, False otherwise.
         'ErrorMax' : float or None, Maximum error, None if fail length check
         'IndexMax' : int or None, Index of maximum error,None if fail length check
         'Message' : str or None, Message if failed check, None if passed.
        }
    
    '''
    
    # Set tolerance
    tol = 1e-3
    # Initialize return dictionary
    result =  {'Pass' : True,
               'ErrorMax' : None,
               'IndexMax' : None,
               'Message' : None}
    # First, check that trajectories are same length
    if len(y_test) != len(y_ref):
        result['Pass'] = False
        result['Message'] = 'Test and reference trajectory not the same length.'
    else:
        # Initialize error arrays
        err_abs = np.zeros(len(y_ref))
        err_rel = np.zeros(len(y_ref))
        err_fun = np.zeros(len(y_ref))
        # Calculate errors
        for i in range(len(y_ref)):
            # Absolute error
            err_abs[i] = np.absolute(y_test[i] - y_ref[i])
            # Relative error
            if (abs(y_ref[i]) > 10 * tol):
                err_rel[i] = err_abs[i] / abs(y_ref[i])
            else:
                err_rel[i] = 0
            # Total error
            err_fun[i] = err_abs[i] + err_rel[i]
            # Assess error
            err_max = max(err_fun);
            i_max = np.argmax(err_fun);
            if err_max > tol:
                result['Pass'] = False
                result['ErrorMax'] = err_max,
                result['IndexMax'] = i_max,
                result['Message'] = 'Max error ({0}) in trajectory greater than tolerance ({1}) at index {2}.'.format(err_max, tol, i_max)
    
    return result
    
def clean_up(dir_path):
    '''Cleans up the .fmu, .mo, .txt, .mat, .json files from directory.

    Parameters
    ----------
    dir_path : str
        Directory path to clean up
        
    '''

    files = os.listdir(dir_path)
    for f in files:
        if f.endswith('.fmu') or f.endswith('.mo') or f.endswith('.txt') or f.endswith('.mat') or f.endswith('.json'):
            os.remove(os.path.join(dir_path, f))
            
def run_tests(test_file_name):
    '''Run tests and save results for specified test file.
    
    Parameters
    ----------
    test_file_name : str
        Test file name (ends in .py)
    
    '''

    # Load tests
    test_loader = unittest.TestLoader()
    suite = test_loader.discover(os.path.join(get_root_path(),'testing'), pattern = test_file_name)
    num_cases = suite.countTestCases()
    # Run tests
    print('\nFound {0} tests to run in {1}.\n\nRunning...'.format(num_cases, test_file_name))
    result = unittest.TextTestRunner(verbosity = 1).run(suite);
    # Parse and save results
    num_failures = len(result.failures)
    num_errors = len(result.errors)
    num_passed = num_cases - num_errors - num_failures
    log_json = {'TestFile':test_file_name, 'NCases':num_cases, 'NPassed':num_passed, 'NErrors':num_errors, 'NFailures':num_failures, 'Failures':{}, 'Errors':{}}
    for i, failure in enumerate(result.failures):
        log_json['Failures'][i]= failure[1]
    for i, error in enumerate(result.errors):
        log_json['Errors'][i]= error[1]
    log_file = os.path.splitext(test_file_name)[0] + '.log'
    with open(log_file, 'w') as f:
        json.dump(log_json, f)
                
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