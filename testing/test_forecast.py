# -*- coding: utf-8 -*-
"""
This module runs tests for the Forecaster module. To run these tests, 
testcase 2 must already be deployed. Forecaster requires of a test 
case as an input to retrieve data from it. 

"""

import unittest
import os
import pandas as pd
import utilities
from forecast.forecaster import Forecaster

root_dir = utilities.get_root_path()

class ForecasterTest(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the Forecaster class
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
         
        from testcase import TestCase
        case=TestCase()
        
        # Instantiate a forecaster
        self.forecaster = Forecaster(case)
        
    def test_get_forecast_default(self):
        '''Check that the forecaster is able to retrieve the data
        
        '''       
        
        # Load the data into the test case
        forecast = self.forecaster.get_forecast()
        
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'tc2_forecast_default.csv')
        
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
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'tc2_forecast_interval.csv')
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
    
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))