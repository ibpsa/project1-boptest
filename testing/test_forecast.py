# -*- coding: utf-8 -*-
"""
This module runs tests for the Forecaster module. To run these tests,
testcase2 and testcase3 must already be deployed. Forecaster requires
of a test case as an input to retrieve data from it. testcase2 is used
to test the Forecaster in a single-zone building example. testcase3 is
used to test the Forecaster in a multi-zone building example.

 """

import unittest
import os
import pandas as pd
import utilities
from forecast.forecaster import Forecaster

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

class PartialForecasterTest(object):
    '''This partial class implements common tests for the Forecaster class.

    References to self attributes for the tests should be set in the setUp
    method of the particular testclass test.  They are:

    forecaster : Forecaster
        A Forecaster instance pointing to a deployed testcase.
    ref_forecast_default : path
        Path to forecast reference with default parameters.
    ref_forecast_interval : path
        Path to forecast reference with specified interval parameters.
    ref_forecast_over_year : path
        Path to forecast reference over year's end
    ref_forecast_uncertain_low : path
        Path to forecast reference for including uncertainty low
    ref_forecast_uncertain_medium : path
        Path to forecast reference for including uncertainty medium
    ref_forecast_uncertain_high : path
        Path to forecast reference for including uncertainty high

    '''

    def test_get_forecast_default(self):
        '''Check that the forecaster is able to retrieve the data

        '''

        # Load the data into the test case
        forecast = self.forecaster.get_forecast(self.forecast_points)

        # Set reference file path
        ref_filepath = self.ref_forecast_default

        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

    def test_get_forecast_interval(self):
        '''Check that the forecaster is able to retrieve the data

        '''

        # Load the data into the test case
        forecast = self.forecaster.get_forecast(self.forecast_points,
                                                horizon=2*24*3600,
                                                interval=123)

        # Set reference file path
        ref_filepath = self.ref_forecast_interval

        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

    def test_get_forecast_over_year(self):
        '''Check that the forecaster is able to retrieve the data across
        the year

        '''
        self.case.initialize(364*24*3600, 0)
        # Load the data into the test case
        forecast = self.forecaster.get_forecast(self.forecast_points,
                                                horizon=2*24*3600,
                                                interval=1800)

        # Set reference file path
        ref_filepath = self.ref_forecast_over_year

        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

    def test_get_uncertain_forecast(self):
        '''Check that the forecaster is able to retrieve uncertain forecasts

        '''

        for level in ['low','medium','high']:
            self.case.initialize(0,0)
            # Load the data into the test case
            forecast = self.forecaster.get_forecast(self.forecast_points,
                                                    horizon=24*3600,
                                                    interval=3600,
                                                    wea_tem_dry_bul=level,
                                                    wea_sol_glo_hor=level,
                                                    seed=1)
            # Check the forecast
            df_forecaster = pd.DataFrame(forecast).set_index('time')
            self.compare_ref_timeseries_df(df_forecaster, '{0}_{1}.csv'.format(self.ref_forecast_uncertain[:-4],level))

class ForecasterSingleZoneTest(unittest.TestCase, utilities.partialChecks,
                               PartialForecasterTest):
    '''Tests the Forecaster class in a single-zone example.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        # Change directory to specific testcase2 folder
        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        forecast_uncertainty_params_path = os.path.join('forecast',
                                                        'forecast_uncertainty_params.json')
        self.case=TestCase(fmupath='testcases/testcase2/models/wrapped.fmu',
                           forecast_uncertainty_params_path=forecast_uncertainty_params_path)

        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case, forecast_uncertainty_params_path)

        # Specify forecast points to test
        self.forecast_points = list(self.case.get_forecast_points()[2].keys())

        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2','tc2_forecast_default.csv')

        self.ref_forecast_interval = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2', 'tc2_forecast_interval.csv')

        self.ref_forecast_over_year = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2', 'tc2_forecast_over_year.csv')

        self.ref_forecast_uncertain = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase2', 'tc2_forecast_uncertain.csv')

class ForecasterMultiZoneTest(unittest.TestCase, utilities.partialChecks,
                              PartialForecasterTest):
    '''Tests the Forecaster class in a multi-zone example.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        # Change directory to specific testcase3 folder
        os.chdir(os.path.join(testing_root_dir))
        os.chdir('..')
        from testcase import TestCase
        forecast_uncertainty_params_path = os.path.join('forecast',
                                                        'forecast_uncertainty_params.json')
        self.case=TestCase(fmupath='testcases/testcase3/models/wrapped.fmu',
                           forecast_uncertainty_params_path=forecast_uncertainty_params_path)

        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case, forecast_uncertainty_params_path)

        # Specify forecast points to test
        self.forecast_points = list(self.case.get_forecast_points()[2].keys())

        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_default.csv')

        self.ref_forecast_interval = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_interval.csv')

        self.ref_forecast_over_year = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_over_year.csv')

        self.ref_forecast_uncertain = os.path.join(utilities.get_root_path(),
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_uncertain.csv')

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
