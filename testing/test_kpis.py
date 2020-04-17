# -*- coding: utf-8 -*-
"""
This module runs tests for the KPI Calculator. testcase2 and testcase3
are used to run the tests in a single-zone and a multi-zone building 
example, respectively. 

"""

import unittest
import os
import pandas as pd
import utilities
from collections import OrderedDict
from kpis.kpi_calculator import KPI_Calculator

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

class PartialKpiCalculatorTest(object):
    '''This partial class implements common tests for the KPI Calculator class.
       
    References to self attributes for the tests should be set in the setUp 
    method of the particular testclass test.  They are:

    cal : KPI_Calculator
        A KPI_Calculator instance pointing to a deployed testcase.
    tdis_tot_ref : float
        Reference for total thermal discomfort.
    idis_tot_ref : float
        Reference for total indoor air quality discomfort.
    ener_tot_ref : float
        Reference for total energy use.
    cost_tot_ref : float
        Reference for total cost.
    emis_tot_ref : float
        Reference for total emissions
    time_rat_ref : float
        Reference for time ratio
    tdis_dict_ref : dict
        Reference for thermal discomfort distribution
    idis_dict_ref : dict
        Reference for indoor air quality discomfort distribution
    ener_tot_ref : dict
        Reference for energy use distribution
    cost_dict_ref : dict
        Reference for cost distribution
    emis_dict_ref : dict
        Reference for emissions distribution
            
    '''
        
    def test_get_thermal_discomfort(self):
        '''Uses the KPI calculator to calculate the thermal discomfort 
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_thermal_discomfort()
        self.assertAlmostEqual(self.case.tdis_tot, self.tdis_tot_ref, places=3)
        self.assertDictEqual(self.case.tdis_dict, self.tdis_dict_ref)

    def test_get_iaq_discomfort(self):
        '''Uses the KPI calculator to calculate the IAQ discomfort 
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_iaq_discomfort()
        self.assertAlmostEqual(self.case.idis_tot, self.idis_tot_ref, places=3)
        self.assertDictEqual(self.case.idis_dict, self.idis_dict_ref)

    def test_get_energy(self):
        '''Uses the KPI calculator to calculate the energy use
        and compares with references.
           
        '''
           
        # Calculate thermal discomfort
        self.cal.get_energy()
        
        # Compare with references
        self.assertAlmostEqual(self.case.ener_tot, self.ener_tot_ref, places=3)
        self.assertDictEqual(self.case.ener_dict, self.ener_dict_ref)
    
    def test_get_cost(self):
        '''Uses the KPI calculator to calculate the operational cost
        and compares with references.
           
        '''
           
        # Calculate operational cost
        self.cal.get_cost()
        
        # Compare with references
        self.assertAlmostEqual(self.case.cost_tot, self.cost_tot_ref, places=3)
        self.assertDictEqual(self.case.cost_dict, self.cost_dict_ref)
        
    def test_get_emissions(self):
        '''Uses the KPI calculator to calculate the emissions
        and compares with references.
           
        '''
        
        # Calculate emissions
        self.cal.get_emissions()
        
        # Compare with references
        self.assertAlmostEqual(self.case.emis_tot, self.emis_tot_ref, places=3)
        self.assertDictEqual(self.case.emis_dict, self.emis_dict_ref)
        
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
        self.assertAlmostEqual(self.case.time_rat, self.time_rat_ref, places=3)

class KpiCalculatorSingleZoneTest(unittest.TestCase, PartialKpiCalculatorTest):
    '''Tests the Forecaster class in a single-zone example.
         
    '''
 
    def setUp(self):
        '''Setup for each test.
         
        '''
         
        # Change directory to testcase 2
        os.chdir(os.path.join(testing_root_dir,'testcase2'))
        from testcase2.testcase import TestCase
        self.case=TestCase()
                 
        # Instantiate a KPI calculator linked to an empty case
        self.cal = KPI_Calculator(self.case)
         
        # Read the reference data
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'kpis', 'tc2_results_python.csv')
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
                 
        self.tdis_tot_ref = 6.04428540467
        self.idis_tot_ref = 365.6911873402533
        self.ener_tot_ref = 147.224341889
        self.cost_tot_ref = 29.4448683777
        self.emis_tot_ref = 73.6121709444
        self.time_rat_ref = 2.778238720364041e-07
         
        self.tdis_dict_ref =  OrderedDict([('TRooAir_dTlower_y', 5.1747331046897154), 
                                           ('TRooAir_dTupper_y', 0.86954784517941663)])
        self.idis_dict_ref =  OrderedDict([('CO2RooAir_dIupper_y', 365.69118734025329)])
        self.ener_dict_ref = OrderedDict([('PCoo_y', 2.5790120993548213), 
                                          ('PFan_y', 1.2243750151212227), 
                                          ('PHea_y', 143.38535826054658), 
                                          ('PPum_y', 0.035504245658337034)])
        self.cost_dict_ref = OrderedDict([('PCoo_y', 0.5158024198709642), 
                                          ('PFan_y', 0.24487500302424459), 
                                          ('PHea_y', 28.677071652109316), 
                                          ('PPum_y', 0.0071008491316674072)])
        self.emis_dict_ref = OrderedDict([('PCoo_y', 1.2895060496774107), 
                                          ('PFan_y', 0.61218750756061135), 
                                          ('PHea_y', 71.692679130273291), 
                                          ('PPum_y', 0.017752122829168517)]) 
         
class KpiCalculatorMultiZoneTest(unittest.TestCase, PartialKpiCalculatorTest):
    '''Tests the Forecaster class in a multi-zone example.
        
    '''

    def setUp(self):
        '''Setup for each test.
        
        '''
        
        # Change directory to testcase 3
        os.chdir(os.path.join(testing_root_dir,'testcase3'))
        from testcase3.testcase import TestCase
        self.case=TestCase()
        
        # Instantiate a KPI calculator linked to an empty case
        self.cal = KPI_Calculator(self.case)
        
        # Read the reference data
        ref_filepath = os.path.join(utilities.get_root_path(), 
            'testing', 'references', 'kpis', 'tc3_results_python.csv')
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
                
        self.tdis_tot_ref = 21.7322321131
        self.idis_tot_ref = 1030.34989641
        self.ener_tot_ref = 43.8117652678
        self.cost_tot_ref = 3.06682356874
        self.emis_tot_ref = 8.76235305355
        self.time_rat_ref = 8.7420145670572913e-07
        
        self.maxDiff = None
        self.tdis_dict_ref =  OrderedDict([('TRooAirNor_dTlower_y', 8.2055849580534996), 
                                           ('TRooAirNor_dTupper_y', 2.8932777121529849), 
                                           ('TRooAirSou_dTlower_y', 6.8613721856065562),
                                           ('TRooAirSou_dTupper_y', 3.7719972572410261)])
        self.idis_dict_ref =  OrderedDict([('CO2RooAirSou_dIupper_y', 1016.9440316099603), 
                                           ('CO2RooAirNor_dIupper_y', 13.40586479855533)])
        self.ener_dict_ref = OrderedDict([('PHeaNor_y', 22.33656655950071), 
                                          ('PHeaSou_y', 21.475198708263587)])
        self.cost_dict_ref = OrderedDict([('PHeaNor_y', 1.5635596591650494), 
                                          ('PHeaSou_y', 1.503263909578451)])
        self.emis_dict_ref = OrderedDict([('PHeaNor_y', 4.4673133119001411), 
                                          ('PHeaSou_y', 4.2950397416527188)])

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
