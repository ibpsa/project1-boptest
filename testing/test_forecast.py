# -*- coding: utf-8 -*-
"""
This module runs tests for the Forecaster module. To run these tests, 
testcase 2 must already be deployed. 

"""

import requests
import unittest
import os
import pandas as pd
import utilities

root_dir = utilities.get_root_path()

class ForecasterTest(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the Forecaster class
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        # Set URL for testcase
        self.url = 'http://127.0.0.1:5000'
        
    def test_get_forecast_default(self):
        '''Check that the forecaster is able to retrieve the data
        with default forecast parameters.
        
        '''       
        
        # Test case forecast
        forecast = requests.get('{0}/forecast'.format(self.url)).json()
        
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'tc2_forecast_default.csv')
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
        
    def test_put_and_get_parameters(self):
        '''Check that it is possible to put and get the forecast settings
        in a test case. 
        
        '''       
        
        # Define the reference forecast parameters
        forecast_parameters_ref = {'horizon':172800, 'interval':123}
        
        # Set forecast parameters
        requests.put('{0}/forecast_parameters'.format(self.url), 
                     data=forecast_parameters_ref)
        
        # Get forecast parameters
        forecast_parameters = requests.get('{0}/forecast_parameters'.format(self.url)).json()
        
        # Check the forecast parameters
        self.assertDictEqual(forecast_parameters, forecast_parameters_ref)
        
    def test_get_forecast_with_parameters(self):
        '''Check that it is possible to get the forecast setting first 
        customized forecast parameters.
        
        '''       
        
        # Set forecast parameters
        requests.put('{0}/forecast_parameters'.format(self.url), 
                     data={'horizon':172800, 'interval':123})
        
        # Test case forecast
        forecast = requests.get('{0}/forecast'.format(self.url)).json()
        
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'forecast', 'tc2_forecast_with_parameters.csv')
        
        # Check the forecast
        df_forecaster = pd.DataFrame(forecast).set_index('time')
        self.compare_ref_timeseries_df(df_forecaster, ref_filepath)
    
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))