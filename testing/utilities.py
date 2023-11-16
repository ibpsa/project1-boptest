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
import re
import matplotlib.pyplot as plt
from datetime import datetime


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

def run_tests(test_file_name, test_names=[]):
    '''Run tests and save results for specified test file.

    Parameters
    ----------
    test_file_name : str
        Test file name (ends in .py)
    test_names : list or tuple of str
        List of test functions or classes to run present within test module.

    '''

    # Load tests
    test_loader = unittest.TestLoader()
    suite = test_loader.discover(os.path.join(get_root_path(),'testing'), pattern = test_file_name)
    num_cases = suite.countTestCases()
    # Run tests
    if test_names:
        print('\nRunning only these tests within {0}: {1}. Skipping others.\n\nRunning...'.format(test_file_name, test_names))
    else:
        print('\nRunning all {0} tests within {1}.\n\nRunning...'.format(num_cases, test_file_name))
    result = unittest.TextTestRunner(verbosity = 1).run(suite);
    # Parse and save results
    num_failures = len(result.failures)
    num_errors = len(result.errors)
    num_skipped = len(result.skipped)
    num_passed = num_cases - num_errors - num_failures - num_skipped
    log_json = {'TestFile':test_file_name, 'NCases':num_cases, 'NPassed':num_passed, 'NErrors':num_errors, 'NFailures':num_failures, 'NSkipped':num_skipped, 'Failures':{}, 'Errors':{}}
    for i, failure in enumerate(result.failures):
        log_json['Failures'][i]= failure[1]
    for i, error in enumerate(result.errors):
        log_json['Errors'][i]= error[1]
    log_file = os.path.splitext(test_file_name)[0] + '.log'
    with open(os.path.join(get_root_path(),'testing',log_file), 'w') as f:
        json.dump(log_json, f)


def compare_references(vars_timeseries = ['reaTRoo_y'],
                       refs_old = 'multizone_residential_hydronic_old',
                       refs_new = 'multizone_residential_hydronic'):
    '''Method to perform visual inspection on how references have changed
    with respect to a previous version.

    Parameters
    ----------
    vars_timeseries : list
        List with strings indicating the variables to be plotted in time
        series graphs.
    refs_old : str
        Name of the folder containing the old references.
    refs_new : str
        Name of the folder containing the new references.

    '''

    dir_old = os.path.join(get_root_path(), 'testing', 'references', refs_old)

    for subdir, _, files in os.walk(dir_old):
        for filename in files:
            f_old = os.path.join(subdir, filename)
            f_new = os.path.join(subdir.replace(refs_old,refs_new), filename)
            if not os.path.exists(f_new):
                print('File: {} has not been compared since it does not exist anymore.'.format(f_new))

            elif not f_old.endswith('.csv'):
                print('File: {} has not been compared since it is not a csv file.'.format(f_old))

            else:
                df_old = pd.read_csv(f_old)
                df_new = pd.read_csv(f_new)

                if not('time' in df_old.columns or 'keys' in df_old.columns):
                    print('File: {} has not been compared because the format is not recognized.'.format(f_old))
                else:
                    if 'time' in df_old.columns:
                        df_old.drop('time', axis=1, inplace=True)
                        df_new.drop('time', axis=1, inplace=True)
                        kind = 'line'
                        vars_to_plot = vars_timeseries
                    elif 'keys' in df_old.columns:
                        df_old = df_old.set_index('keys')
                        df_new = df_new.set_index('keys')
                        kind = 'bar'
                        vars_to_plot = df_old.columns

                    if 'kpis_' in filename:
                        fig, axs = plt.subplots(nrows=1, ncols=len(df_old.index), figsize=(10,8))
                        for i,k in enumerate(df_old.index):
                            axs[i].bar(0, df_old.loc[k,'value'], label='old', alpha=0.5, color='orange')
                            axs[i].bar(0, df_new.loc[k,'value'], label='new', alpha=0.5, color='blue')
                            axs[i].set_title(k)
                        fig.suptitle(str(f_new))
                        plt.legend()
                    else:
                        if any([v in df_old.keys() for v in vars_to_plot]):
                            for v in vars_to_plot:
                                if v in df_old.keys():
                                    _, ax = plt.subplots(1, figsize=(10,8))
                                    df_old[v].plot(ax=ax, label='old '+v, kind=kind, alpha=0.5, color='orange')
                                    df_new[v].plot(ax=ax, label='new '+v, kind=kind, alpha=0.5, color='blue')
                                    ax.set_title(str(f_new))
                                    ax.legend()
                        else:
                            print('File: {} has not been compared because it does not contain any of the variables to plot'.format(f_old))

    plt.show()

class partialChecks(object):
    '''This partial class implements common ref data check methods.

    '''

    def compare_ref_timeseries_df(self, df, ref_filepath):
        '''Compare a timeseries dataframe to a reference csv.

        Parameters
        ----------
        df : pandas DataFrame
            Test dataframe with "time" as index.
        ref_filepath : str
            Reference file path.

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
            # Check all keys in reference are in test
            for key in df_ref.columns.to_list():
                self.assertTrue(key in df.columns.to_list(), 'Reference key {0} not in test data.'.format(key))
            # Check all keys in test are in reference
            for key in df.columns.to_list():
                self.assertTrue(key in df_ref.columns.to_list(), 'Test key {0} not in reference data.'.format(key))
            # Check trajectories
            for key in df.columns:
                y_test = self.create_test_points(df[key]).to_numpy()
                y_ref = self.create_test_points(df_ref[key]).to_numpy()
                results = self.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], '{0} Key is {1}.'.format(results['Message'],key))
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)

        return None

    def compare_ref_json(self, json_test, ref_filepath):
            '''Compare a json to a reference json saved as .json.

            Parameters
            ----------
            json_test : Dict
                Test json in the form of a dictionary.
            ref_filepath : str
                Reference .json file path relative to testing directory.

            Returns
            -------
            None

            '''

            # Perform test
            if os.path.exists(ref_filepath):
                # If reference exists, check it
                with open(ref_filepath, 'r') as f:
                    json_ref = json.load(f)
                self.assertTrue(json_test==json_ref, 'json_test:\n{0}\ndoes not equal\njson_ref:\n{1}'.format(json_test, json_ref))
            else:
                # Otherwise, save as reference
                with open(ref_filepath, 'w') as f:
                    json.dump(json_test,f)

            return None

    def compare_ref_values_df(self, df, ref_filepath):
        '''Compare a values dataframe to a reference csv.

        Parameters
        ----------
        df : pandas DataFrame
            Test dataframe with a number of keys as index paired with values.
        ref_filepath : str
            Reference file path relative to testing directory.

        Returns
        -------
        None

        '''

        # Check keys is index
        assert(df.index.name == 'keys')
        assert(df.columns.to_list() == ['value'])
        # Perform test
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath, index_col='keys')
            for key in df.index.values:
                y_test = [df.loc[key,'value']]
                y_ref = [df_ref.loc[key,'value']]
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
        data = s.to_numpy()
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

    def results_to_df(self, points, start_time, final_time, url='http://127.0.0.1:5000'):
        '''Convert results from boptest into pandas DataFrame timeseries.

        Parameters
        ----------
        points: list of str
            List of points to retrieve from boptest api.
        start_time: int
            Starting time of data to get in seconds.
        final_time: int
            Ending time of data to get in seconds.
        url: str
            URL pointing to deployed boptest test case.
            Default is http://127.0.0.1:5000.

        Returns
        -------
        df: pandas DataFrame
            Timeseries dataframe object with "time" as index in seconds.

        '''

        res = requests.put('{0}/results'.format(url), json={'point_names':points,'start_time':start_time, 'final_time':final_time}).json()['payload']
        df = pd.DataFrame.from_dict(res)
        df = df.set_index('time')

        return df

    def get_all_points(self, url='localhost:5000'):
        '''Get all of the input and measurement point names from boptest.

        Parameters
        ----------
        url: str, optional
            URL pointing to deployed boptest test case.
            Default is localhost:5000.

        Returns
        -------
        points: list of str
            List of available point names.

        '''

        measurements = requests.get('{0}/measurements'.format(url)).json()['payload']
        inputs = requests.get('{0}/inputs'.format(url)).json()['payload']
        points = list(measurements.keys()) + list(inputs.keys())

        return points

    def compare_error_code(self, response, message=None, code_ref=400):
        status_code = response.status_code
        if message is None:
            message = response.message
        self.assertEqual(status_code, code_ref, message)


class partialTestAPI(partialChecks):
    '''This partial class implements common API tests for test cases.

    References to self attributes for the tests should be set in the setUp
    method of the particular testclass test.  They are:

    url : str
        URL to deployed testcase.
    name : str
        Name given to test
    inputs_ref : list of str
        List of names of inputs
    measurements_ref : list of str
        List of names of measurements
    step_ref : numeric
        Default simulation step

    '''

    def test_get_version(self):
        '''Test getting the version of BOPTEST.

        '''

        # Get version from BOPTEST API
        version = requests.get('{0}/version'.format(self.url)).json()['payload']
        # Create a regex object as three decimal digits seperated by period
        r_num = re.compile('\d.\d.\d')
        r_dev = re.compile('0.5.0-dev\n')
        # Test that the returned version matches the expected string format
        if r_num.match(version['version']) or r_dev.match(version['version']):
            self.assertTrue(True)
        else:
            self.assertTrue(False, '/version did not return correctly. Returned {0}.'.format(version))

    def test_get_name(self):
        '''Test getting the name of test.

        '''

        name = requests.get('{0}/name'.format(self.url)).json()['payload']
        self.assertEqual(name['name'], self.name)

    def test_get_inputs(self):
        '''Test getting the input list of tests.

        '''

        inputs = requests.get('{0}/inputs'.format(self.url)).json()['payload']
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'get_inputs.json')
        self.compare_ref_json(inputs, ref_filepath)

    def test_get_measurements(self):
        '''Test getting the measurement list of test.

        '''

        measurements = requests.get('{0}/measurements'.format(self.url)).json()['payload']
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'get_measurements.json')
        self.compare_ref_json(measurements, ref_filepath)

    def test_get_step(self):
        '''Test getting the communication step of test.

        '''

        step = requests.get('{0}/step'.format(self.url)).json()['payload']
        df = pd.DataFrame(data=[step], index=['step'], columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'get_step.csv')
        self.compare_ref_values_df(df, ref_filepath)

    def test_set_step(self):
        '''Test setting the communication step of test.

        '''

        step_current = requests.get('{0}/step'.format(self.url)).json()['payload']
        step = 101
        requests.put('{0}/step'.format(self.url), json={'step':step})
        step_set = requests.get('{0}/step'.format(self.url)).json()['payload']
        self.assertEqual(step, step_set)
        requests.put('{0}/step'.format(self.url), json={'step':step_current})

    def test_initialize(self):
        '''Test initialization of test simulation.

        '''

        # Get measurements and inputs
        points = self.get_all_points(self.url)
        # Get current step
        step = requests.get('{0}/step'.format(self.url)).json()['payload']
        # Initialize
        start_time = 0.5*24*3600
        y = requests.put('{0}/initialize'.format(self.url), json={'start_time':start_time, 'warmup_period':0.5*24*3600}).json()['payload']
        # Check that initialize returns the right initial values and results
        df = pd.DataFrame.from_dict(y, orient = 'index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'initial_values.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Check trajectories
        df = self.results_to_df(points, 0, start_time, self.url)
        # Set reference file path
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'results_initialize_initial.csv')
        # Check results
        self.compare_ref_timeseries_df(df,ref_filepath)
        # Check kpis
        res_kpi = requests.get('{0}/kpi'.format(self.url)).json()['payload']
        df = pd.DataFrame.from_dict(res_kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'kpis_initialize_initial.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Advance
        step_advance = 1*24*3600
        requests.put('{0}/step'.format(self.url), json={'step':step_advance})
        y = requests.post('{0}/advance'.format(self.url), json=dict()).json()['payload']
        # Check trajectories
        df = self.results_to_df(points, start_time, start_time+step_advance, self.url)
        # Set reference file path
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'results_initialize_advance.csv')
        # Check results
        self.compare_ref_timeseries_df(df,ref_filepath)
        # Check kpis
        res_kpi = requests.get('{0}/kpi'.format(self.url)).json()['payload']
        df = pd.DataFrame.from_dict(res_kpi, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'kpis_initialize_advance.csv')
        self.compare_ref_values_df(df, ref_filepath)
        # Set step back to step
        requests.put('{0}/step'.format(self.url), json={'step':step})

    def test_advance_no_data(self):
        '''Test advancing of simulation with no input data.

        This is a basic test of functionality.
        Tests for advancing with overwriting are done in the example tests.

        '''

        requests.put('{0}/initialize'.format(self.url), json={'start_time':0, 'warmup_period':0})
        requests.put('{0}/step'.format(self.url), json={'step':self.step_ref})
        y = requests.post('{0}/advance'.format(self.url), json=dict()).json()['payload']
        df = pd.DataFrame.from_dict(y, orient = 'index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'advance_no_data.csv')
        self.compare_ref_values_df(df, ref_filepath)

    def test_advance_false_overwrite(self):
        '''Test advancing of simulation with overwriting as false.

        This is a basic test of functionality.
        Tests for advancing with overwriting are done in the example tests.

        '''

        u = self.input
        requests.put('{0}/initialize'.format(self.url), json={'start_time':0, 'warmup_period':0})
        requests.put('{0}/step'.format(self.url), json={'step': self.step_ref})
        y = requests.post('{0}/advance'.format(self.url), json=u).json()['payload']
        df = pd.DataFrame.from_dict(y, orient='index', columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'advance_false_overwrite.csv')
        self.compare_ref_values_df(df, ref_filepath)

    def test_get_forecast_all(self):
        '''Check that the forecaster is able to GET all the data.

        All available forecast points are checked.

        '''

        horizon = 7200
        interval = 1800
        # Initialize
        requests.put('{0}/initialize'.format(self.url), json={'start_time':0, 'warmup_period':0})
        # Test case forecast
        forecast_points = list(requests.get('{0}/forecast_points'.format(self.url)).json()['payload'].keys())
        forecast = requests.put('{0}/forecast'.format(self.url), json={'point_names':forecast_points, 'horizon':horizon, 'interval':interval}).json()['payload']
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        # Set reference file path
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'put_forecast_all.csv')
        # Check the forecast
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

    def test_get_forecast_one(self):
        '''Check that the forecaster is able to GET one variable.

        The first point retrieved is checked.

        '''

        horizon = 7200
        interval = 1800
        # Initialize
        requests.put('{0}/initialize'.format(self.url), json={'start_time':0, 'warmup_period':0})
        # Test case forecast
        forecast = requests.put('{0}/forecast'.format(self.url), json={'point_names':[self.forecast_point], 'horizon':horizon, 'interval':interval}).json()['payload']
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        # Set reference file path
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'put_forecast_one.csv')
        # Check the forecast
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

    def test_get_forecast_points(self):
        '''Check GET of forecast points.

        '''

        forecast_points = requests.get('{0}/forecast_points'.format(self.url)).json()['payload']
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'get_forecast_points.json')
        self.compare_ref_json(forecast_points, ref_filepath)

    def test_set_get_scenario(self):
        '''Test setting and getting the scenario of test.

        '''

        # Set scenario
        scenario_current = requests.get('{0}/scenario'.format(self.url)).json()['payload']
        scenario = {'electricity_price':'highly_dynamic',
                    'time_period':self.test_time_period}
        requests.put('{0}/scenario'.format(self.url), json=scenario)
        scenario_set = requests.get('{0}/scenario'.format(self.url)).json()['payload']
        self.assertEqual(scenario, scenario_set)
        # Check initialized correctly
        points = self.get_all_points(self.url)
        # Don't check weather
        points_check = []
        for key in points:
            if 'weaSta' not in key:
                points_check.append(key)
        df = self.results_to_df(points_check, -np.inf, np.inf, self.url)
        # Set reference file path
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'results_set_scenario.csv')
        # Check results
        self.compare_ref_timeseries_df(df,ref_filepath)
        # Return scenario to original
        requests.put('{0}/scenario'.format(self.url), json=scenario_current)

    def test_partial_results_inner(self):
        '''Test getting results for start time after and final time before.

        '''

        requests.put('{0}/initialize'.format(self.url), json={'start_time': 0, 'warmup_period': 0})
        requests.put('{0}/step'.format(self.url), json={'step': self.step_ref})
        measurements = requests.get('{0}/measurements'.format(self.url)).json()['payload']
        y = requests.post('{0}/advance'.format(self.url), json=dict()).json()['payload']
        point = self.measurement
        if point not in measurements:
            raise KeyError('Point {0} not in measurements list.'.format(point))
        res_inner = requests.put('{0}/results'.format(self.url), json={'point_names': [point],
                                                                       'start_time': self.step_ref*0.25,
                                                                       'final_time': self.step_ref*0.75}).json()['payload']
        df = pd.DataFrame.from_dict(res_inner).set_index('time')
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'partial_results_inner.csv')
        self.compare_ref_timeseries_df(df, ref_filepath)

    def test_partial_results_outer(self):
        '''Test getting results for start time before and final time after.

        '''

        requests.put('{0}/initialize'.format(self.url), json={'start_time': 0, 'warmup_period': 0})
        requests.put('{0}/step'.format(self.url), json={'step':self.step_ref})
        measurements = requests.get('{0}/measurements'.format(self.url)).json()['payload']
        y = requests.post('{0}/advance'.format(self.url), json=dict()).json()['payload']
        point = self.measurement
        if point not in measurements:
            raise KeyError('Point {0} not in measurements list.'.format(point))
        res_outer = requests.put('{0}/results'.format(self.url), json={'point_names': [point],
                                                                 'start_time': 0-self.step_ref,
                                                                 'final_time': self.step_ref*2}).json()['payload']
        df = pd.DataFrame.from_dict(res_outer).set_index('time')
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'partial_results_outer.csv')
        self.compare_ref_timeseries_df(df, ref_filepath)

    def test_submit(self):
        '''Test the submit API.

        '''

        # Get current scenario and step
        scenario_current = requests.get('{0}/scenario'.format(self.url)).json()['payload']
        step_current = requests.get('{0}/step'.format(self.url)).json()['payload']
        api_key = "valid_api_key"
        # Set testing scenario
        scenario = {"time_period":self.test_time_period,
                    "electricity_price":"dynamic"}
        # Set test case scenario
        y = requests.put("{0}/scenario".format(self.url),
                         json=scenario).json()["payload"]["time_period"]
        # Set step so doesn't take too long
        requests.put('{0}/step'.format(self.url), json={'step':86400})
        # Simulation Loop
        while y:
            # Compute control signal
            u = {}
            # Advance simulation with control signal
            y = requests.post("{0}/advance".format(self.url), json=u).json()["payload"]
        payload = requests.post("{0}/submit".format(self.url), json={"api_key": api_key,
                                                            "tag1":"baseline",
                                                            "tag2":"unit_test",
                                                            "unit_test":"True"}).json()['payload']
        payload['payload']['results'][0]['kpis']['time_rat'] = 0
        payload['payload']['results'][0]['uid'] = '1'
        payload['payload']['results'][0]['dateRun'] = str(datetime(2020, 5, 17))
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'submit.json')
        self.compare_ref_json(payload, ref_filepath)
        # Return scenario and step to original
        requests.put('{0}/scenario'.format(self.url), json=scenario_current)
        requests.put('{0}/step'.format(self.url), json={'step':step_current})

    def test_invalid_step(self):
        '''Test set step with invalid non-numeric and negative values returns a 400 error.

        '''

        # Try setting non-numeric step
        step = "5*7*24*3600"
        payload = requests.put('{0}/step'.format(self.url), json={'step': step})
        self.compare_error_code(payload, "Invalid step in set_step did not return 400 message.")
        # Try setting negative step
        step = -5*7*24*3600
        payload = requests.put('{0}/step'.format(self.url), json={'step': step})
        self.compare_error_code(payload, "Negative step int set_step did not return 400 message.")

    def test_invalid_forecast_parameters(self):
        '''Check that the setting forecast parameter with invalid start or horizon returns 400 error.

        '''

        forecast_points = requests.get('{0}/forecast_points'.format(self.url)).json()['payload']
        # Try setting non-numeric horizon
        forecast_parameters_ref = {'point_names':forecast_points,
                                   'horizon': 'foo',
                                   'interval': 300}
        payload = requests.put('{0}/forecast'.format(self.url),
                               data=forecast_parameters_ref)
        self.compare_error_code(payload, "Invalid non-numeric horizon in forecast request did not return 400 message.")
        # Try setting non-numeric interval
        forecast_parameters_ref = {'point_names':forecast_points,
                                   'horizon': 3600,
                                   'interval': 'foo'}
        payload = requests.put('{0}/forecast'.format(self.url),
                               data=forecast_parameters_ref)
        self.compare_error_code(payload, "Invalid non-numeric interval in forecast request did not return 400 message.")
        # Try setting negative horizon
        forecast_parameters_ref = {'point_names':forecast_points,
                                   'horizon': -3600,
                                   'interval': 300}
        payload = requests.put('{0}/forecast'.format(self.url),
                               data=forecast_parameters_ref)
        self.compare_error_code(payload, "Invalid negative horizon in forecast request did not return 400 message.")
        # Try setting negative interval
        forecast_parameters_ref = {'point_names':forecast_points,
                                   'horizon': 3600,
                                   'interval': -300}
        payload = requests.put('{0}/forecast'.format(self.url),
                               data=forecast_parameters_ref)
        self.compare_error_code(payload, "Invalid negative interval in forecast request did not return 400 message.")
        # Try setting invalid point name
        forecast_parameters_ref = {'point_names':['foo'],
                                   'horizon': 3600,
                                   'interval': 300}
        payload = requests.put('{0}/forecast'.format(self.url),
                               data=forecast_parameters_ref)
        self.compare_error_code(payload, "Invalid point_names in forecast request did not return 400 message.")

    def test_invalid_scenario(self):
        '''Test setting scenario with invalid identifier returns 400 error.

        '''

        # Set scenario
        scenario_current = requests.get('{0}/scenario'.format(self.url)).json()['payload']
        # Try setting invalid electricity price
        scenario = {'electricity_price': 'invalid_scenario', 'time_period': self.test_time_period}
        payload = requests.put('{0}/scenario'.format(self.url), json=scenario)
        self.compare_error_code(payload,
                                "Invalid value for electricity_price in set_scenario request did not return 400 message.")
        # Try setting invalid time period
        scenario = {'electricity_price': 'highly_dynamic', 'time_period': "invalid_time_period"}
        payload = requests.put('{0}/scenario'.format(self.url), json=scenario)
        self.compare_error_code(payload,
                               "Invalid value for time_period in set_scenario request did not return 400 message.")
        # Return scenario to original
        requests.put('{0}/scenario'.format(self.url), json=scenario_current)

    def test_invalid_initialize(self):
        '''Test initialization of test simulation with invalid start_time and warmup_period returns 400 error.

        '''

        # Try setting non-numeric start_time
        start_time = "0.5 * 24 * 3600"
        warmup_period = 0.5*24*3600
        y = requests.put('{0}/initialize'.format(self.url),
                         json={'start_time': start_time, 'warmup_period': warmup_period})
        self.compare_error_code(y,  "Invalid start_time to initialize request did not return 400 message.")
        # Try setting non-numeric warmup_period
        start_time = 0.5*24*3600
        warmup_period = "0.5 * 24 * 3600"
        y = requests.put('{0}/initialize'.format(self.url),
                         json={'start_time': start_time, 'warmup_period': warmup_period})
        self.compare_error_code(y, "Invalid warmup_period in initialize request did not return 400 message.")
        # Try setting negative start_time
        start_time = -0.5*24*3600
        warmup_period = 0.5*24*3600
        y = requests.put('{0}/initialize'.format(self.url),
                         json={'start_time': start_time, 'warmup_period': warmup_period})
        self.compare_error_code(y, "Negative start_time in initialize request did not return 400 message.")
        # Try setting negative warmup_period
        start_time = 0.5*24*3600
        warmup_period = -0.5*24*3600
        y = requests.put('{0}/initialize'.format(self.url),
                         json={'start_time': start_time, 'warmup_period': warmup_period})
        self.compare_error_code(y, "Negative warmup_period in initialize request did not return 400 message.")

    def test_invalid_advance_value(self):
        '''Test advancing of simulation with invalid input data type (non-numerical) will return 400 error.

        This is a basic test of functionality.

        '''

        u = self.input
        for key, value in u.items():
            if '_activate' in key:
                for value in ['invalid', 1.2, '1.2']:
                    u[key] = value
                    y = requests.post('{0}/advance'.format(self.url), json=u)
                    self.compare_error_code(y, "Invalid advance request for _activate did not return 400 message.")
            else:
                u[key] = "invalid"
                y = requests.post('{0}/advance'.format(self.url), json=u)
                self.compare_error_code(y, "Invalid advance request for _u did not return 400 message.")

    def test_invalid_advance_name(self):
        '''Test advancing of simulation with invalid input parameter name will return 400 error.

        This is a basic test of functionality.

        '''

        u = {'invalid': 0}
        y = requests.post('{0}/advance'.format(self.url), json=u)
        self.compare_error_code(y, "Invalid advance request for _u did not return 400 message.")


    def test_invalid_get_results(self):
        '''Test getting results for start time before and final time after.

        '''

        requests.put('{0}/initialize'.format(self.url), json={'start_time': 0, 'warmup_period': 0})
        requests.put('{0}/step'.format(self.url), json={'step':self.step_ref})
        measurements = requests.get('{0}/measurements'.format(self.url)).json()['payload']
        requests.post('{0}/advance'.format(self.url), json=dict()).json()['payload']
        point = self.measurement
        if point not in measurements:
            raise KeyError('Point {0} not in measurements list.'.format(point))
        # Try getting invalid start_time
        res = requests.put('{0}/results'.format(self.url), json={'point_names': [point],
                                                                 'start_time': "foo",
                                                                 'final_time': self.step_ref*2})
        self.compare_error_code(res, "Invalid start_time in get_results request did not return a 400 error.")
        # Try getting invalid final_time
        res = requests.put('{0}/results'.format(self.url), json={'point_names': [point],
                                                                 'start_time': 0.0 - self.step_ref,
                                                                 'final_time': "foo"})
        self.compare_error_code(res, "Invalid final_time in get_results request did not return a 400 error.")
        # Try getting invalid point_name
        res = requests.put('{0}/results'.format(self.url), json={'point_names': ["foo"],
                                                                 'start_time': 0.0 - self.step_ref,
                                                                 'final_time': self.step_ref*2.0})
        self.compare_error_code(res, "Invalid point_names in get_results request did not return a 400 error.")

    def test_invalid_submit(self):
        '''Test the submit API with invalid usage.

        '''

        # Get current scenario and step
        scenario_current = requests.get('{0}/scenario'.format(self.url)).json()['payload']
        step_current = requests.get('{0}/step'.format(self.url)).json()['payload']
        api_key = "valid_api_key"
        # Set testing scenario
        scenario = {"time_period":self.test_time_period,
                    "electricity_price":"dynamic"}
        # Set test case scenario
        y = requests.put("{0}/scenario".format(self.url),
                         json=scenario).json()["payload"]["time_period"]
        # Set step so doesn't take too long
        requests.put('{0}/step'.format(self.url), json={'step':86400})
        # Simulation Loop
        while y:
            # Compute control signal
            u = {}
            # Advance simulation with control signal but stop after one iteration
            y = requests.post("{0}/advance".format(self.url), json=u).json()["payload"]
            y = False
        res = requests.post("{0}/submit".format(self.url), json={"api_key": api_key,
                                                            "tag1":"baseline",
                                                            "tag2":"unit_test",
                                                            "unit_test":"True"})
        self.compare_error_code(res, "Invalid time run in submit request did not return a 500 error.", code_ref=500)
        # Continue simulation Loop
        y = True
        while y:
            # Compute control signal
            u = {}
            # Advance simulation to end of time period scenario
            y = requests.post("{0}/advance".format(self.url), json=u).json()["payload"]
        # Test invalid tag number
        res = requests.post("{0}/submit".format(self.url), json={"api_key": api_key,
                                                            "tag1":"1", "tag2":"2", "tag3":"3",
                                                            "tag4":"4", "tag5":"5", "tag6":"6",
                                                            "tag7":"7", "tag8":"2", "tag9":"3",
                                                            "tag10":"1", "tag11":"2",
                                                            "unit_test":"True"})
        self.compare_error_code(res, "Invalid tag number in submit request did not return a 400 error.")
        # Return scenario and step to original
        requests.put('{0}/scenario'.format(self.url), json=scenario_current)
        requests.put('{0}/step'.format(self.url), json={'step':step_current})

class partialTestTimePeriod(partialChecks):
    '''Partial class for testing the time periods for each test case

    '''

    def run_time_period(self, time_period):
        '''Runs the example and tests the kpi and trajectory results for time period.

        Parameters
        ----------
        time_period: str
            Name of test_period to run

        Returns
        -------
        None

        '''

        # Set time period scenario
        requests.put('{0}/scenario'.format(self.url), json={'time_period':time_period})
        # Simulation Loop
        y = 1
        while y:
            # Advance simulation
            y = requests.post('{0}/advance'.format(self.url), json={}).json()['payload']
        # Check results
        df = self.results_to_df(self.points_check, -np.inf, np.inf, self.url)
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'results_{0}.csv'.format(time_period))
        self.compare_ref_timeseries_df(df,ref_filepath)
        # For each price scenario
        for price_scenario in ['constant', 'dynamic', 'highly_dynamic']:
            # Set scenario
            requests.put('{0}/scenario'.format(self.url), json={'electricity_price':price_scenario})
            # Report kpis
            res_kpi = requests.get('{0}/kpi'.format(self.url)).json()['payload']
            # Check kpis
            df = pd.DataFrame.from_dict(res_kpi, orient='index', columns=['value'])
            df.index.name = 'keys'
            ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'kpis_{0}_{1}.csv'.format(time_period, price_scenario))
            self.compare_ref_values_df(df, ref_filepath)
        requests.put('{0}/scenario'.format(self.url), json={'electricity_price':'constant'})

class partialTestSeason(partialChecks):
    '''Partial class for testing the time periods for each test case

    '''

    def run_season(self, season):
        '''Runs the example and tests the kpi and trajectory results for a season.

        Parameters
        ----------
        season: str
            Name of season to run.
            'winter' or 'summer' or 'shoulder'

        Returns
        -------
        None

        '''

        if season == 'winter':
            start_time = 1*24*3600
        elif season == 'summer':
            start_time = 248*24*3600
        elif season == 'shoulder':
            start_time = 118*24*3600
        else:
            raise ValueError('Season {0} unknown.'.format(season))
        length = 48*3600
        # Initialize test case
        requests.put('{0}/initialize'.format(self.url), json={'start_time':start_time, 'warmup_period':0})
        # Get default simulation step
        step_def = requests.get('{0}/step'.format(self.url)).json()['payload']
        # Simulation Loop
        for i in range(int(length/step_def)):
            # Advance simulation
            requests.post('{0}/advance'.format(self.url), json={}).json()['payload']
        requests.put('{0}/scenario'.format(self.url), json={'electricity_price':'constant'})
        # Check results
        points = self.get_all_points(self.url)
        df = self.results_to_df(points, start_time, start_time+length, self.url)
        ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'results_{0}.csv'.format(season))
        self.compare_ref_timeseries_df(df,ref_filepath)
        # For each price scenario
        for price_scenario in ['constant', 'dynamic', 'highly_dynamic']:
            # Set scenario
            requests.put('{0}/scenario'.format(self.url), json={'electricity_price':price_scenario})
            # Report kpis
            res_kpi = requests.get('{0}/kpi'.format(self.url)).json()['payload']
            # Check kpis
            df = pd.DataFrame.from_dict(res_kpi, orient='index', columns=['value'])
            df.index.name = 'keys'
            ref_filepath = os.path.join(get_root_path(), 'testing', 'references', self.name, 'kpis_{0}_{1}.csv'.format(season, price_scenario))
            self.compare_ref_values_df(df, ref_filepath)
