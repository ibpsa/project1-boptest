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
            
    '''

    def test_get_forecast_default(self):
        '''Check that the forecaster is able to retrieve the data
        
        '''       

        # Load the data into the test case
        forecast = self.forecaster.get_forecast()

        # Set reference file path
        ref_filepath = self.ref_forecast_default
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
        
    def test_get_forecast_interval(self):
        '''Check that the forecaster is able to retrieve the data
        
        '''       

        # Load the data into the test case
        forecast = self.forecaster.get_forecast(horizon=2*24*3600,
                                                interval=123)

        # Set reference file path
        ref_filepath = self.ref_forecast_interval
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)

class ForecasterSingleZoneTest(unittest.TestCase, utilities.partialChecks,
                               PartialForecasterTest):
    '''Tests the Forecaster class in a single-zone example.
        
    '''

    def setUp(self):
        '''Setup for each test.
    
        '''
        
        # Change directory to testcase 2
        os.chdir(os.path.join(testing_root_dir,'testcase2'))
        from testcase2.testcase import TestCase
        self.case=TestCase()
        
        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case)
        
        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase2','tc2_forecast_default.csv')
        
        self.ref_forecast_interval = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase2', 'tc2_forecast_interval.csv')

class ForecasterMultiZoneTest(unittest.TestCase, utilities.partialChecks,
                              PartialForecasterTest):
    '''Tests the Forecaster class in a multi-zone example.
        
    '''

    def setUp(self):
        '''Setup for each test.
    
        '''

        # Change directory to testcase 3
        os.chdir(os.path.join(testing_root_dir,'testcase3'))
        from testcase3.testcase import TestCase
        self.case=TestCase()
        
        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case)

        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_default.csv')
        
        self.ref_forecast_interval = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_interval.csv')

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__)) 
