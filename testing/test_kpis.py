# -*- coding: utf-8 -*-
"""
This module runs tests for the KPI Calculator. Simulation results from
testcase2 and testcase3 are used to run the tests in a single-zone and a
multi-zone building example, respectively.

"""

import unittest
import os
import copy
import pandas as pd
import numpy as np
import utilities
from kpis.kpi_calculator import KPI_Calculator

testing_root_dir = os.path.join(utilities.get_root_path(), 'testing')

class partialKpiCalculatorTest(utilities.partialChecks):
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
        # Check results
        self._perform_test(self.case.tdis_tot, self.case.tdis_dict, 'tdis')

    def test_get_iaq_discomfort(self):
        '''Uses the KPI calculator to calculate the IAQ discomfort
        and compares with references.

        '''

        # Calculate iaq discomfort
        self.cal.get_iaq_discomfort()
        # Check results
        self._perform_test(self.case.idis_tot, self.case.idis_dict, 'idis')

    def test_get_energy(self):
        '''Uses the KPI calculator to calculate the energy use
        and compares with references.

        '''

        # Calculate energy
        self.cal.get_energy()
        # Check results
        self._perform_test(self.case.ener_tot, self.case.ener_dict, 'ener')

    def test_get_cost(self):
        '''Uses the KPI calculator to calculate the operational cost
        and compares with references.

        '''

        # Calculate operational cost default (Constant)
        self.cal.get_cost()
        # Check results
        self._perform_test(self.case.cost_tot, self.case.cost_dict, 'cost_constant')

        # Reset KPI Calculator
        self.cal.initialize()
        # Calculate operational cost dynamic
        self.cal.get_cost(scenario='Dynamic')
        # Check results
        self._perform_test(self.case.cost_tot, self.case.cost_dict, 'cost_dynamic')

        # Reset KPI Calculator
        self.cal.initialize()
        # Calculate operational cost highly dynamic
        self.cal.get_cost(scenario='HighlyDynamic')
        # Check results
        self._perform_test(self.case.cost_tot, self.case.cost_dict, 'cost_highly_dynamic')

    def test_get_emissions(self):
        '''Uses the KPI calculator to calculate the emissions
        and compares with references.

        '''

        # Calculate emissions
        self.cal.get_emissions()
        # Check results
        self._perform_test(self.case.emis_tot, self.case.emis_dict, 'emis')

    def test_get_computational_time_ratio(self):
        '''Uses the KPI calculator to calculate the computational time ratio
        and compares with references.

        '''

        # Initialize test-case
        self.case.initialize(0,0)
        # Advance three simulation steps to compute elapsed times
        for _ in range(3):
            self.case.advance(u={})
        # Calculate computational time ratio
        self.cal.get_computational_time_ratio()
        # Check results
        self._perform_test(self.case.time_rat, None, 'time_rat')

    def test_iterative_call(self):
        '''Tests KPI Calculator when being called iteratively. It first
        stores the full simulation test case data. Then, test case data
        is emptied and filled in progressively as when calling
        `testcase.advance` in co-simulation. Every iteration step new data
        is added, and the KPI Calculator is called to check that it can
        rely on the results from the previous iteration to perform the new
        integration needed to compute KPIs.

        '''

        # Store full simulation test case data
        y_store_full = copy.deepcopy(self.case.y_store)
        u_store_full = copy.deepcopy(self.case.u_store)

        # Empty test case data
        for var in self.case.y_store.keys():
            self.case.y_store[var] = []
        for var in self.case.u_store.keys():
            self.case.u_store[var] = []

        # Emulate a co-simulation with 10 iteration points
        for i in np.linspace(start=1,stop=len(y_store_full['time']),
                             num=10, endpoint=True):
            i=int(i)

            # Fill case with simulation data
            for var in self.case.y_store.keys():
                self.case.y_store[var] = y_store_full[var][:i]
            for var in self.case.u_store.keys():
                self.case.u_store[var] = u_store_full[var][:i]

            # Compute KPIs in this iteration
            self.cal.get_thermal_discomfort()
            self.cal.get_iaq_discomfort()
            self.cal.get_energy()
            self.cal.get_cost()
            self.cal.get_emissions()

        # Check results
        self._perform_test(self.case.tdis_tot, self.case.tdis_dict, 'tdis')
        self._perform_test(self.case.idis_tot, self.case.idis_dict, 'idis')
        self._perform_test(self.case.ener_tot, self.case.ener_dict, 'ener')
        self._perform_test(self.case.cost_tot, self.case.cost_dict, 'cost')
        self._perform_test(self.case.emis_tot, self.case.emis_dict, 'emis')

    def _perform_test(self, tot, dictionary, label):
        '''Common function for performing the tests.

        Parameters
        ----------
        tot: float
            Value of kpi "tot"
        dictionary: dict or None
            kpi "dict".
            If None, not used.
        label: str
            Label to describe KPI.

        '''

        # Check total
        df = pd.DataFrame(data=[tot], index=['{0}_tot'.format(label)], columns=['value'])
        df.index.name = 'keys'
        ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'kpis', '{0}_tot_{1}.csv'.format(label, self.name))
        self.compare_ref_values_df(df, ref_filepath)
        # Check dict
        if dictionary is not None:
            df = pd.DataFrame.from_dict(dictionary, orient = 'index', columns=['value'])
            df.index.name = 'keys'
            ref_filepath = os.path.join(utilities.get_root_path(), 'testing', 'references', 'kpis', '{0}_dict_{1}.csv'.format(label, self.name))
            self.compare_ref_values_df(df, ref_filepath)

class KpiCalculatorSingleZoneTest(unittest.TestCase, partialKpiCalculatorTest):
    '''Tests the Forecaster class in a single-zone example.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'SingleZone'
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

class KpiCalculatorMultiZoneTest(unittest.TestCase, partialKpiCalculatorTest):
    '''Tests the Forecaster class in a multi-zone example.

    '''

    def setUp(self):
        '''Setup for each test.

        '''

        self.name = 'MultiZone'
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

if __name__ == '__main__':
    utilities.run_tests(os.path.basename(__file__))
