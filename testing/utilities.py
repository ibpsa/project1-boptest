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
import pandas as pd

def get_root_path():
    '''Returns the path to the root repository directory.
    
    '''
    
    testing_path = os.path.dirname(os.path.realpath(__file__));
    root_path = os.path.split(testing_path)[0]
    
    return root_path;

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
    with open(os.path.join(get_root_path(),'testing',log_file), 'w') as f:
        json.dump(log_json, f)
                
class partialTimeseries(object):
    '''This partial class implements common API testing timeseries data.
    
    '''
    
    def compare_ref_timeseries_df(self, df, ref_filepath):
        '''Compare a timeseries dataframe to a reference csv.
        
        Parameters
        ----------
        df : pandas DataFrame
            Test dataframe with "time" as index.
        ref_filepath : str
            Reference file path relative to testing directory.
            
        Returns
        -------
        None
        
        '''
        
        # Check time is index
        assert(df.index.name == 'time')
        # Perform test
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath, index_col='time')           
            for key in df.columns:
                y_test = self.create_test_points(df[key]).get_values()
                y_ref = self.create_test_points(df_ref[key]).get_values()
                results = self.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], '{0} Key is {1}.'.format(results['Message'],key))
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)
            
        return None
    
    def check_trajectory(self, y_test, y_ref):
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
                    result['Message'] = 'Max error ({0}) in trajectory greater than tolerance ({1}) at index {2}. y_test: {3}, y_ref:{4}'.format(err_max, tol, i_max, y_test[i_max], y_ref[i_max])
        
        return result
    
    def create_test_points(self, s,n=500):
        '''Create interpolated points to test of a certain number.
        
        Useful to reduce number of points to test and to avoid failed tests from
        event times being slightly different.
    
        Parameters
        ----------
        s : pandas Series
            Series containing test points to create, with index as time floats.
        n : int, optional
            Number of points to create
            Default is 500
            
        Returns
        -------
        s_test : pandas Series
            Series containing interpolated data    
    
        '''
        
        # Get data
        data = s.get_values()
        index = s.index.values
        # Make interpolated index
        t_min = index.min()
        t_max = index.max()
        t = np.linspace(t_min, t_max, n)
        # Interpolate data
        data_interp = np.interp(t,index,data)
        # Use at most 8 significant digits
        data_interp = [ float('{:.8g}'.format(x)) for x in data_interp ]
        # Make Series
        s_test = pd.Series(data=data_interp, index=t)
        
        return s_test

class partialTestAPI(partialTimeseries):
    '''This partial class implements common API tests for test cases.
    
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
        for inp in inputs:
            self.assertTrue(inp in self.inputs_ref)
            self.assertTrue(inputs[inp]['Unit'] == self.inputs_ref[inp]['Unit'])
            self.assertTrue(inputs[inp]['Description'] == self.inputs_ref[inp]['Description'])
            self.assertTrue(inputs[inp]['Minimum'] == self.inputs_ref[inp]['Minimum'])
            self.assertTrue(inputs[inp]['Maximum'] == self.inputs_ref[inp]['Maximum'])

    def test_get_measurements(self):
        '''Test getting the measurement list of test.
        
        '''

        measurements = requests.get('{0}/measurements'.format(self.url)).json()
        self.assertEqual(len(measurements), len(self.measurements_ref))
        for measurement in measurements:
            self.assertTrue(measurement in self.measurements_ref)
            self.assertTrue(measurements[measurement]['Unit'] == self.measurements_ref[measurement]['Unit'])
            self.assertTrue(measurements[measurement]['Description'] == self.measurements_ref[measurement]['Description'])
            self.assertTrue(measurements[measurement]['Minimum'] == self.measurements_ref[measurement]['Minimum'])
            self.assertTrue(measurements[measurement]['Maximum'] == self.measurements_ref[measurement]['Maximum'])

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
        
        start_time = 2*24*3600
        warmup_period = 1*24*3600
        requests.put('{0}/reset'.format(self.url), data={'start_time':start_time, 'warmup_period':warmup_period})
        forecast = requests.get('{0}/forecast'.format(self.url)).json()
        self.assertTrue(forecast['time'][0] == start_time)

    def test_advance_no_data(self):
        '''Test advancing of simulation with no input data.

        This is a basic test of functionality.  
        Tests for advancing with overwriting are done in the example tests.

        '''

        requests.put('{0}/reset'.format(self.url), data={'start_time':0, 'warmup_period':0})
        y = requests.post('{0}/advance'.format(self.url), data=dict()).json()
        for key in y.keys():
            self.assertAlmostEqual(y[key], self.y_ref[key], places=3)

    def test_advance_false_overwrite(self):
        '''Test advancing of simulation with overwriting as false.

        This is a basic test of functionality.  
        Tests for advancing with overwriting are done in the example tests.

        '''

        requests.put('{0}/reset'.format(self.url), data={'start_time':0, 'warmup_period':0})
        if self.name == 'testcase1':
            u = {'oveAct_u':0, 'oveAct_activate':1500}
        elif self.name == 'testcase2':
            u = {'oveTSetRooHea_activate':0, 'oveTSetRooHea_u':273.15+22}
        requests.put('{0}/reset'.format(self.url))
        y = requests.post('{0}/advance'.format(self.url), data=u).json()
        for key in y.keys():
            self.assertAlmostEqual(y[key], self.y_ref[key], places=3)

    def test_get_forecast_default(self):
        '''Check that the forecaster is able to retrieve the data.
        
        Default forecast parameters for testcase used.

        '''

        requests.put('{0}/reset'.format(self.url), data={'start_time':0, 'warmup_period':0})
        
        # Test case forecast
        forecast = requests.get('{0}/forecast'.format(self.url)).json()
        
        # Set reference file path
        ref_filepath = self.forecast_default_ref
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')

        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
        
    def test_put_and_get_parameters(self):
        '''Check PUT and GET of forecast settings.

        '''

        # Set forecast parameters
        ret = requests.put('{0}/forecast_parameters'.format(self.url), 
                           data=self.forecast_parameters_ref)
        
        # Get forecast parameters
        forecast_parameters = requests.get('{0}/forecast_parameters'.format(self.url)).json()
        
        # Check the forecast parameters
        self.assertDictEqual(forecast_parameters, self.forecast_parameters_ref)
        # Check the return on the put request
        self.assertDictEqual(ret.json(), self.forecast_parameters_ref)
        
    def test_get_forecast_with_parameters(self):
        '''Check that the forecaster is able to retrieve the data.
        
        Custom forecast parameters used.
        
        '''  

        requests.put('{0}/reset'.format(self.url), data={'start_time':0, 'warmup_period':0})
        
        # Set forecast parameters
        requests.put('{0}/forecast_parameters'.format(self.url), 
                     data=self.forecast_parameters_ref)
        
        # Test case forecast
        forecast = requests.get('{0}/forecast'.format(self.url)).json()
        
        # Set reference file path
        ref_filepath = self.forecast_with_parameters_ref
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')

        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
