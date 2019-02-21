# -*- coding: utf-8 -*-
"""
This module runs unit tests for the parer.

"""

import unittest
import filecmp
import os
import pandas as pd
import json
import utilities
from parser import parser, simulate

root_dir = utilities.get_root_path()

# Define test model
model_path = 'SimpleRC'
mo_path = os.path.join(root_dir,'parser', 'SimpleRC.mo')
# Define read and overwrite block instances in test model
read_blocks = ['EHeat', 'PHeat', 'TZone', 'setZone']
overwrite_blocks = ['oveAct', 'oveSet']

class GetInstances(unittest.TestCase):
    '''Tests the get_instance method of parser.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        # Run the get_instance method
        self.instances = parser.get_instances(model_path, [mo_path])
        
    def test_get_instances(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''

        instances = self.instances
        # Checks
        for key in instances.keys():
            if key is 'Read':
                # Check there are 4 Read blocks
                self.assertEqual(len(instances[key]),4)
                for instance in instances[key]:
                    # Check each Read block instance is identified correctly
                    self.assertTrue(instance in read_blocks)
            elif key is 'Overwrite':
                # Check there are 2 Overwrite blocks
                self.assertEqual(len(instances[key]),2)
                for instance in instances[key]:
                    # Check each Overwrite block instance is identified correctly
                    self.assertTrue(instance in overwrite_blocks)
            else:
                # Check that only Read and Overwrite blocks are included
                self.assertTrue(False,msg='Key {0} should not be in instances.'.format(key))

    def test_wrong_key(self):
        '''Tests that the instances are only Read and Overwrite blocks.
        
        '''

        instances = self.instances
        instances['NotReadOverwrite'] = 1
        # Checks
        for key in instances.keys():
            if key is 'Read':
                # Check there are 4 Read blocks
                self.assertEqual(len(instances[key]),4)
                for instance in instances[key]:
                    # Check each Read block instance is identified correctly
                    self.assertTrue(instance in read_blocks)
            elif key is 'Overwrite':
                # Check there are 2 Overwrite blocks
                self.assertEqual(len(instances[key]),2)
                for instance in instances[key]:
                    # Check each Overwrite block instance is identified correctly
                    self.assertTrue(instance in overwrite_blocks)
            else:
                # Check that only Read and Overwrite blocks are included
                with self.assertRaises(AssertionError):
                    self.assertTrue(False,msg='Key {0} should not be in instances.'.format(key))

    def tearDown(self):
        '''Teardown for each test.
        
        '''
        
        # Delete leftover files
        testing_path = os.path.join(utilities.get_root_path(),'testing')
        utilities.clean_up(testing_path)

class WriteWrapper(unittest.TestCase):
    '''Tests the write_wrapper method of parser.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        # Get signal exchange instances
        instances = parser.get_instances(model_path, [mo_path])
        # Write wrapper and export as fmu
        self.fmu_path, self.wrapped_path = parser.write_wrapper(model_path, [mo_path], instances)
        
    def test_create_wrapped(self):
        self.assertEqual(self.fmu_path, os.path.join(root_dir, 'testing', '.', 'wrapped.fmu'))
        self.assertEqual(self.wrapped_path, os.path.join('wrapped.mo'))
        self.assertTrue(filecmp.cmp(self.wrapped_path, os.path.join(root_dir, 'testing', 'references', 'parser', 'wrapped.mo')))

    def tearDown(self):
        '''Teardown for each test.
        
        '''
        
        # Delete leftover files
        testing_path = os.path.join(utilities.get_root_path(),'testing')
        utilities.clean_up(testing_path)
        
class ExportSimulate(unittest.TestCase):
    '''Tests the export of a wrapper fmu and simulation of it.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        # Parse and export fmu to working directory
        self.fmu_path = parser.export_fmu(model_path, [mo_path])

    def test_simulate_no_overwrite(self):
        '''Test simulation with no overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite=None)
        # Check results
        df = pd.DataFrame()
        for key in ['time', 'TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], columns=[key])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'parser', 'results_no_overwrite.csv')
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath)
            for key in df.columns:
                y_test = df[key].get_values()
                y_ref = df_ref[key].get_values()
                results = utilities.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], results['Message'])
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)
        
    def test_simulate_set_overwrite(self):
        '''Test simulation with setpoint overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite='set')
        # Check results
        df = pd.DataFrame()
        for key in ['time', 'TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], columns=[key])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'parser', 'results_set_overwrite.csv')
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath)
            for key in df.columns:
                y_test = df[key].get_values()
                y_ref = df_ref[key].get_values()
                results = utilities.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], results['Message'])
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)

    def test_simulate_act_overwrite(self):
        '''Test simulation with actuator overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite='act')
        # Check results
        df = pd.DataFrame()
        for key in ['time', 'TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], columns=[key])), axis=1)
        # Set reference file path
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'parser', 'results_act_overwrite.csv')
        if os.path.exists(ref_filepath):
            # If reference exists, check it
            df_ref = pd.read_csv(ref_filepath)
            for key in df.columns:
                y_test = df[key].get_values()
                y_ref = df_ref[key].get_values()
                results = utilities.check_trajectory(y_test, y_ref)
                self.assertTrue(results['Pass'], results['Message'])
        else:
            # Otherwise, save as reference
            df.to_csv(ref_filepath)
            
    def tearDown(self):
        '''Teardown for each test.
        
        '''
        
        # Delete leftover files
        testing_path = os.path.join(utilities.get_root_path(),'testing')
        utilities.clean_up(testing_path)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))