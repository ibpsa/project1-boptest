# -*- coding: utf-8 -*-
"""
This module runs tests for the KPI Calculator. 

"""

import unittest
import os
import pandas as pd
import utilities
from collections import OrderedDict
from kpis.kpi_calculator import KPI_Calculator
from testcase import TestCase

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

tdis_tot_ref = 6.04428540467
idis_tot_ref = 0.00
ener_tot_ref = 147.224341889
cost_tot_ref = 29.4448683777
emis_tot_ref = 73.6121709444
time_rat_ref = 2.778238720364041e-07

tdis_dict_ref =  OrderedDict([('TRooAir_dTlower_y', 5.1747363118961944), 
                              ('TRooAir_dTupper_y', 0.86954909277880887)])
idis_dict_ref =  OrderedDict([('CO2RooAir_dIupper_y', 0.00)])
ener_dict_ref = OrderedDict([('PCoo_y', 2.579012665272586), 
                             ('PFan_y', 1.2243760177843268), 
                             ('PHea_y', 143.38544897227666), 
                             ('PPum_y', 0.035504233405456678)])
cost_dict_ref = OrderedDict([('PCoo_y', 0.51580253305451729), 
                             ('PFan_y', 0.24487520355686537), 
                             ('PHea_y', 28.67708979445533), 
                             ('PPum_y', 0.0071008466810913353)])
emis_dict_ref = OrderedDict([('PCoo_y', 1.289506332636293), 
                             ('PFan_y', 0.6121880088921634), 
                             ('PHea_y', 71.692724486138331), 
                             ('PPum_y', 0.017752116702728339)])

class KpiCalculatorTest(unittest.TestCase):
    '''Tests the KPI Calculator class
    
    '''
    
    def setUp(self):
        '''Setup for each test.
        
        '''
        
        self.case=TestCase()
        
        # Instantiate a KPI calculator linked to an empty case
        self.cal = KPI_Calculator(self.case)
        
        # Read the reference data
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'testcase2', 'results_python.csv')
        df = pd.read_csv(ref_filepath)
        
        # Fill the test case with the refernce data
        for var in df.keys():
            # Assign time
            if var=='time':
                self.case.y_store[var] = df.loc[:,var]
            # Assign inputs
            elif var.endswith('_u'):
                self.case.u_store[var] = df.loc[:,var]
            # Assign outputs
            elif var.endswith('_y'):
                self.case.y_store[var] = df.loc[:,var]
    
    def test_get_thermal_discomfort(self):
        '''Uses the KPI calculator to calculate the thermal discomfort 
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_thermal_discomfort()
        self.assertAlmostEqual(self.case.tdis_tot, tdis_tot_ref, places=3)
        self.assertDictEqual(self.case.tdis_dict, tdis_dict_ref)

    def test_get_iaq_discomfort(self):
        '''Uses the KPI calculator to calculate the IAQ discomfort 
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_iaq_discomfort()
        self.assertAlmostEqual(self.case.idis_tot, idis_tot_ref, places=3)
        self.assertDictEqual(self.case.idis_dict, idis_dict_ref)

    def test_get_energy(self):
        '''Uses the KPI calculator to calculate the energy use
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_energy()
        
        # Compare with references
        self.assertAlmostEqual(self.case.ener_tot, ener_tot_ref, places=3)
        self.assertDictEqual(self.case.ener_dict, ener_dict_ref)
    
    def test_get_cost(self):
        '''Uses the KPI calculator to calculate the operational cost
        and compares with references.
           
        '''
           
        # Calculate operational cost
        self.cal.get_cost()
        
        # Compare with references
        self.assertAlmostEqual(self.case.cost_tot, cost_tot_ref, places=3)
        self.assertDictEqual(self.case.cost_dict, cost_dict_ref)
        
    def test_get_emissions(self):
        '''Uses the KPI calculator to calculate the emissions
        and compares with references.
           
        '''
        
        # Calculate emissions
        self.cal.get_emissions()
        
        # Compare with references
        self.assertAlmostEqual(self.case.emis_tot, emis_tot_ref, places=3)
        self.assertDictEqual(self.case.emis_dict, emis_dict_ref)
        
    def test_get_computational_time_ratio(self):
        '''Uses the KPI calculator to calculate the computational time ratio
        and compares with references.
           
        '''
        
        # Reset test-case
        self.case.reset()
        
        # Advance three simulation steps to compute elapsed times
        for _ in range(3):
            self.case.advance(u={})
        
        # Calculate computational time ratio
        self.cal.get_computational_time_ratio()
        
        # Compare with references
        self.assertAlmostEqual(self.case.time_rat, time_rat_ref, places=3)
        
if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))