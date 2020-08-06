# -*- coding: utf-8 -*-
"""
This module runs tests for the Data Generator. The data
generator requires as an input an fmu path where the data is to be stored
such that it can be loaded into a test case afterwards.  It also requires
the use of JModelica to compile the weather FMU. 

"""

import unittest
import os
import pandas as pd
import utilities
from data.data_generator import Data_Generator

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

class DataGeneratorTest(unittest.TestCase, utilities.partialChecks):
    '''Tests the data generator class
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        resources_dir = os.path.join(testing_root_dir,'testcase2','models','Resources')
        self.gen = Data_Generator(resources_dir)
         
    def test_generate_weather(self):
        '''Runs the generate weather data method and compares
        trajectories with references.
           
        '''
           
        # Generate weather file
        self.gen.generate_weather()
        os.chdir(testing_root_dir)
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir, 
                                    'weather.csv')
           
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 
            'references', 'data', 'testcase2', 'default_weather.csv')
          
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
          
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
          
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)
         
    def test_generate_prices(self):
        '''Runs the generate prices method and compares trajectories 
        with references.
        
        '''
        
        # Generate weather file
        self.gen.generate_prices()
        
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir,
                                    'prices.csv')
        
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir,
            'references', 'data', 'testcase2', 'default_prices.csv')
        
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
        
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
        
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)      
        
    def test_generate_emissions(self):
        '''Runs the generate emissions method and compares 
        trajectories with references.
        
        '''
        
        # Generate weather file
        self.gen.generate_emissions()
        
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir,
                                    'emissions.csv')
        
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 
            'references', 'data', 'testcase2', 'default_emissions.csv')
        
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
        
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
        
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)

    def test_generate_occupancy(self):
        '''Runs the generate occupancy method and compares 
        trajectories with references.
        
        '''
        
        # Generate weather file
        self.gen.generate_occupancy(occ_num=10)
        
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir,
                                    'occupancy.csv')
        
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 
            'references', 'data', 'testcase2', 'default_occupancy.csv')
        
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
        
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
        
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)
        
    def test_generate_internalGains(self):
        '''Runs the generate internal gains method and compares 
        trajectories with references.
        
        '''
        
        # Generate weather file
        self.gen.generate_internalGains()
        
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir,
                                    'internalGains.csv')
        
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 
            'references', 'data', 'testcase2', 'default_internalGains.csv')
        
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
        
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
        
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)
        
    def test_generate_setpoints(self):
        '''Runs the generate setpoints method for testcase 2 and 
        compares trajectories with references.
        
        '''
        
        # Generate weather file
        self.gen.generate_setpoints()
        
        # Set generated file path
        gen_filepath = os.path.join(self.gen.resources_dir,
                                    'setpoints.csv')
        
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 
            'references', 'data', 'testcase2', 'default_setpoints.csv')
        
        # Check the data file has been created
        self.assertTrue(os.path.exists(gen_filepath))
        
        # Read data into data frame
        df_gen = pd.read_csv(gen_filepath).set_index('time')
        
        # Check trajectories 
        self.compare_ref_timeseries_df(df_gen, ref_filepath)   
    
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))