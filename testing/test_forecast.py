# -*- coding: utf-8 -*-
"""
This module runs tests for the Forecaster module. The Forecaster requires 
a test case as an input to retrieve data from it. testcase2 is used 
to test the Forecaster in a single-zone building example. testcase3 is 
used to test the Forecaster in a multi-zone building example. 

"""

import unittest
import os
import pandas as pd
import utilities
from forecast.forecaster import Forecaster
import testcase
        
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
        
        # Mimic testcase2 as in boptest container
        utilities.create_mimic_boptest('testcase2')
        os.chdir(utilities.get_root_path())
        self.case=testcase.TestCase()
        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case)
        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase2','tc2_forecast_default.csv')
        self.ref_forecast_interval = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase2', 'tc2_forecast_interval.csv')
        
    def tearDown(self):
        '''Tear down for each test.
        
        '''
        
        utilities.remove_mimic_boptest()

class ForecasterMultiZoneTest(unittest.TestCase, utilities.partialChecks,
                              PartialForecasterTest):
    '''Tests the Forecaster class in a multi-zone example.
        
    '''

    def setUp(self):
        '''Setup for each test.
    
        '''

        # Mimic testcase3 as in boptest container
        utilities.create_mimic_boptest('testcase3')
        os.chdir(utilities.get_root_path())
        self.case=testcase.TestCase()
        # Instantiate a forecaster
        self.forecaster = Forecaster(self.case)
        # Specify test references
        self.ref_forecast_default  = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_default.csv')
        self.ref_forecast_interval = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'testcase3', 'tc3_forecast_interval.csv')
        
    def tearDown(self):
        '''Tear down for each test.
        
        '''
        
        utilities.remove_mimic_boptest()

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__)) 
