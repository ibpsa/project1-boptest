# -*- coding: utf-8 -*-
"""
This module runs unit tests for the parer.

"""

import unittest
import filecmp
import os
import pandas as pd
import utilities
from parsing import parser, simulate

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

# Define test model
model_path = 'SimpleRC'
mo_path = os.path.join(testing_root_dir,'parsing', 'SimpleRC.mo')
# Define read and overwrite block instances in test model
read_blocks = {'EHeat':{'Unit':'J', 
                        'Description': 'Heater electrical energy',
                        'Minimum': None,
                        'Maximum': None}, 
               'PHeat':{'Unit':'W', 
                        'Description': 'Heater electrical power',
                        'Minimum': None,
                        'Maximum': None}, 
               'TZone':{'Unit':'K', 
                        'Description': 'Zone temperature',
                        'Minimum': None,
                        'Maximum': None}, 
               'setZone':{'Unit':'K', 
                          'Description': 'Zone temperature setpoint',
                          'Minimum': None,
                          'Maximum': None}}
overwrite_blocks = {'oveAct':{'Unit':'W', 
                              'Description': 'Heater thermal power',                              
                              'Minimum': 0,
                              'Maximum': 3000},
                    'oveSet':{'Unit':'K', 
                              'Description': 'Zone temperature setpoint',
                              'Minimum': 273.15+10,
                              'Maximum': 273.15+35}}
kpi1_outputs = ['PHeat_y', 'TZone_y']
kpi2_outputs = ['EHeat_y', 'PHeat_y']

class ParseInstances(unittest.TestCase):
    '''Tests the parse_instances method of parser.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''

        # Run the parse_instances method
        self.instances, self.kpis = parser.parse_instances(model_path, [mo_path])
        
    def test_parse_instances(self):
        '''Tests that Read and Overwrite blocks identified correctly.
        
        '''

        instances = self.instances
        # Checks
        for key in instances.keys():
            if key is 'Read':
                # Check there are 4 Read blocks
                self.assertEqual(len(instances[key]),4)
                for instance in instances[key].keys():
                    # Check each Read block instance is identified correctly
                    self.assertTrue(instance in read_blocks)
                    # Check that units are identified correctly
                    self.assertTrue(instances[key][instance]['Unit'] == read_blocks[instance]['Unit'])
                    # Check that description is identified correctly
                    self.assertTrue(instances[key][instance]['Description'] == read_blocks[instance]['Description'])
                    # Check that minimum is identified correctly
                    self.assertTrue(instances[key][instance]['Minimum'] == read_blocks[instance]['Minimum'])
                    # Check that maximum is identified correctly
                    self.assertTrue(instances[key][instance]['Maximum'] == read_blocks[instance]['Maximum'])
            elif key is 'Overwrite':
                # Check there are 2 Overwrite blocks
                self.assertEqual(len(instances[key]),2)
                for instance in instances[key].keys():
                    # Check each Overwrite block instance is identified correctly
                    self.assertTrue(instance in overwrite_blocks)
                    # Check that units are identified correctly
                    self.assertTrue(instances[key][instance]['Unit'] == overwrite_blocks[instance]['Unit'])
                    # Check that description are identified correctly
                    self.assertTrue(instances[key][instance]['Description'] == overwrite_blocks[instance]['Description'])
                    # Check that minimum are identified correctly
                    self.assertTrue(instances[key][instance]['Minimum'] == overwrite_blocks[instance]['Minimum'])
                    # Check that maximum are identified correctly
                    self.assertTrue(instances[key][instance]['Maximum'] == overwrite_blocks[instance]['Maximum'])
            else:
                # Check that only Read and Overwrite blocks are included
                self.assertTrue(False,msg='Key {0} should not be in instances.'.format(key))
                
    def test_parse_kips(self):
        '''Tests that KPIs parsed correctly.
        
        '''

        kpis = self.kpis
        # Checks
        for key in kpis.keys():
            if key == 'kpi1':
                # Check there are 2 outputs
                self.assertEqual(len(kpis[key]),2)
                for output in kpis[key]:
                    # Check each ouput is identified correctly
                    self.assertTrue(output in kpi1_outputs)
            elif key == 'kpi2':
                # Check there are 2 outputs
                self.assertEqual(len(kpis[key]),2)
                for output in kpis[key]:
                    # Check each Overwrite block instance is identified correctly
                    self.assertTrue(output in kpi2_outputs)
            else:
                # Check that only kpi1 and kpi2 are included
                self.assertTrue(False,msg='KPI {0} should not be in kpis.'.format(key))

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
        utilities.clean_up(testing_root_dir)

class WriteWrapper(unittest.TestCase):
    '''Tests the write_wrapper method of parser.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        # Get signal exchange instances
        instances, kpis = parser.parse_instances(model_path, [mo_path])
        # Write wrapper and export as fmu
        self.fmu_path, self.wrapped_path = parser.write_wrapper(model_path, [mo_path], instances)
        
    def test_create_wrapped(self):
        self.assertEqual(self.fmu_path, os.path.join(testing_root_dir, '.', 'wrapped.fmu'))
        self.assertEqual(self.wrapped_path, os.path.join('wrapped.mo'))
        with open(self.wrapped_path, 'rU') as f_test:         
            with open(os.path.join(testing_root_dir, 'references', 'parser', 'wrapped.mo'), 'rU') as f_ref:
                line_test = f_test.readline()
                i = 1
                while line_test:
                    line_ref = f_ref.readline()
                    self.assertTrue(line_test==line_ref, 'Not the same on line {0} of reference file.\nTest Line: {1}\nRef Line:  {2}'.format(i,line_test, line_ref))
                    line_test = f_test.readline()
                    i = i + 1

    def tearDown(self):
        '''Teardown for each test.
        
        '''
        
        # Delete leftover files
        utilities.clean_up(testing_root_dir)
        
class ExportSimulate(unittest.TestCase, utilities.partialTimeseries):
    '''Tests the export of a wrapper fmu and simulation of it.
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        # Parse and export fmu to working directory
        self.fmu_path, self.kpi_path = parser.export_fmu(model_path, [mo_path])
        
    def test_kpis_json(self):
        '''Test that kpi json exported correctly.
        
        '''
        
        self.assertTrue(filecmp.cmp(self.kpi_path, os.path.join(testing_root_dir, 'references', 'parser', 'kpis.json')))

    def test_simulate_no_overwrite(self):
        '''Test simulation with no overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite=None)
        # Check results
        df = pd.DataFrame()
        for key in ['TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], index=res['time'],columns=[key])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 'references', 'parser', 'results_no_overwrite.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)
        
    def test_simulate_set_overwrite(self):
        '''Test simulation with setpoint overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite='set')
        # Check results
        df = pd.DataFrame()
        for key in ['TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], index=res['time'], columns=[key])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 'references', 'parser', 'results_set_overwrite.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)

    def test_simulate_act_overwrite(self):
        '''Test simulation with actuator overwriting.
        
        '''
        
        # Simulate wrapped fmu in working directory
        res = simulate.simulate(overwrite='act')
        # Check results
        df = pd.DataFrame()
        for key in ['TZone_y', 'PHeat_y', 'setZone_y']:
            df = pd.concat((df, pd.DataFrame(data=res[key], index=res['time'], columns=[key])), axis=1)
        df.index.name = 'time'
        # Set reference file path
        ref_filepath = os.path.join(testing_root_dir, 'references', 'parser', 'results_act_overwrite.csv')
        # Test
        self.compare_ref_timeseries_df(df,ref_filepath)
            
    def tearDown(self):
        '''Teardown for each test.
        
        '''
        
        # Delete leftover files
        utilities.clean_up(testing_root_dir)

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))