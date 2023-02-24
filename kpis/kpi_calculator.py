'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the KPI_Calculator class with methods for processing
the results of BOPTEST simulations and generating the corresponding key
performance indicators.

'''

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.integrate import trapz
from flask._compat import iteritems
from collections import OrderedDict

class KPI_Calculator(object):
    '''This class calculates the KPIs as a post-process after
    a test is complete. Upon deployment of the test case,
    the module first uses the KPI JSON file to
    associate model output names with the appropriate KPIs
    through the specified KPI annotations. Upon called to
    do so, the module is able to calculate and return the
    KPIs using data stored from the test case run.
    The core KPIs are a subset of the KPIs that can be
    obtained using this class and that are considered
    essential for the comparison between two or more
    test cases. This class also supports other methods for
    evaluation, plotting and post-processing of an already
    deployed test case.

    '''

    def __init__(self, testcase):
        '''Initialize the KPI_Calculator class. One KPI_Calculator
        is associated with one test case.

        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case that
            contains the data stored from the test case run

        '''

        # Point to the test case object
        self.case = testcase

        # Naming convention from the signal exchange package of IBPSA
        self.sources = ['AirZoneTemperature',
                        'RadiativeZoneTemperature',
                        'OperativeZoneTemperature',
                        'RelativeHumidity',
                        'CO2Concentration',
                        'ElectricPower',
                        'DistrictHeatingPower',
                        'GasPower',
                        'BiomassPower',
                        'SolarThermalPower',
                        'FreshWaterFlowRate']

        # Initialize KPI Calculator variables
        self.initialize_kpi_vars('tdis')
        self.initialize_kpi_vars('idis')
        self.initialize_kpi_vars('ener')
        self.initialize_kpi_vars('cost')
        self.initialize_kpi_vars('emis')
        self.initialize_kpi_vars('pele')
        self.initialize_kpi_vars('pgas')
        self.initialize_kpi_vars('pdih')

    def initialize_kpi_vars(self, label='ener'):
        '''Initialize variables required for KPI calculation

        '''
        # Initialize index
        self._set_last_index(label, set_initial=True)
        # Dictionary to store energy usage by element
        setattr(self, '{}_dict'.format(label), OrderedDict())
        # Dictionary to store energy usage by source
        setattr(self, '{}_dict_by_source'.format(label), OrderedDict())

        if label=='tdis':
            # Initialize sources of thermal discomfort
            self.sources_tdis = []
            for source in self.case.kpi_json.keys():
                if source.startswith('AirZoneTemperature') or \
                   source.startswith('OperativeZoneTemperature'):
                    self.sources_tdis.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.tdis_dict[signal[:-1]+'dTlower_y'] = 0.
                        self.tdis_dict[signal[:-1]+'dTupper_y'] = 0.

        elif label=='idis':
            # Initialize sources of indoor air quality discomfort
            self.sources_idis = []
            for source in self.case.kpi_json.keys():
                if source.startswith('CO2Concentration'):
                    self.sources_idis.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.idis_dict[signal[:-1]+'dIupper_y'] = 0.

        elif label=='ener':
            # Initialize sources of energy usage
            self.sources_ener = []
            for source in self.sources:
                if 'Power' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_ener.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.ener_dict[signal] = 0.
                        self.ener_dict_by_source[source+'_'+signal] = 0.

        elif label=='pele':
            # Initialize sources of electricity usage
            self.sources_pele = []
            for source in self.sources:
                if 'ElectricPower' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_pele.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.pele_dict[signal] = 0.

        elif label=='pgas':
            # Initialize sources of gas usage
            self.sources_pgas = []
            for source in self.sources:
                if 'GasPower' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_pgas.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.pgas_dict[signal] = 0.

        elif label=='pdih':
            # Initialize sources of district heating usage
            self.sources_pdih = []
            for source in self.sources:
                if 'DistrictHeatingPower' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_pdih.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.pdih_dict[signal] = 0.

        elif label=='cost':
            # Initialize sources of cost
            self.sources_cost = []
            for source in self.sources:
                if 'ElectricPower' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_cost.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.cost_dict[signal] = 0.
                        self.cost_dict_by_source[source+'_'+signal] = 0.
                elif 'Power' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_cost.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.cost_dict[signal] = 0.
                        self.cost_dict_by_source[source+'_'+signal] = 0.
                elif 'FreshWater' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_cost.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.cost_dict[signal] = 0.
                        self.cost_dict_by_source[source+'_'+signal] = 0.

        elif label=='emis':
            # Initialize sources of emissions
            self.sources_emis = []
            for source in self.sources:
                if 'Power' in source  and \
                source in self.case.kpi_json.keys():
                    self.sources_emis.append(source)
                    for signal in self.case.kpi_json[source]:
                        self.emis_dict[signal] = 0.
                        self.emis_dict_by_source[source+'_'+signal] = 0.

    def initialize(self):
        '''
        Method to reset all kpi variables while maintaining pointer to
        same test case.

        '''
        self.__init__(testcase=self.case)

    def get_core_kpis(self, price_scenario='Constant'):
        '''Return the core KPIs of a test case.

        Parameters
        ----------
        price_scenario : str, optional
            Price scenario for cost kpi calculation.
            'Constant' or 'Dynamic' or 'HighlyDynamic'.
            Default is 'Constant'.

        Returns
        -------
        ckpi = dict
            Dictionary with the core KPIs, i.e., the KPIs
            that are considered essential for the comparison between
            two test cases

        '''

        ckpi = OrderedDict()
        ckpi['tdis_tot'] = self.get_thermal_discomfort()
        ckpi['idis_tot'] = self.get_iaq_discomfort()
        ckpi['ener_tot'] = self.get_energy()
        ckpi['cost_tot'] = self.get_cost(scenario=price_scenario)
        ckpi['emis_tot'] = self.get_emissions()
        ckpi['pele_tot'] = self.get_peak_electricity()
        ckpi['pgas_tot'] = self.get_peak_gas()
        ckpi['pdih_tot'] = self.get_peak_district_heating()
        ckpi['time_rat'] = self.get_computational_time_ratio()

        return ckpi

    def get_thermal_discomfort(self, plot=False):
        '''The thermal discomfort is the integral of the deviation
        of the temperature with respect to the predefined comfort
        setpoint. Its units are of K*h.

        Parameters
        ----------
        plot: boolean, optional
            True to show a donut plot with the thermal discomfort metrics.
            Default is False.

        Returns
        -------
        tdis_tot: float
            total thermal discomfort accounted in this test case

        '''

        self.tdis_tot = 0.
        index = self._get_data_from_last_index('time',self.i_last_tdis)

        for source in self.sources_tdis:
            # This is a potential source of thermal discomfort
            zone_id = source.split('[')[1][:-1]

            for signal in self.case.kpi_json[source]:
                # Load temperature set points from test case data
                LowerSetp = np.array(self.case.data_manager.get_data(index=index,
                                    variables=['LowerSetp[{0}]'.format(zone_id)])
                                 ['LowerSetp[{0}]'.format(zone_id)])
                UpperSetp = np.array(self.case.data_manager.get_data(index=index,
                                    variables=['UpperSetp[{0}]'.format(zone_id)])
                                 ['UpperSetp[{0}]'.format(zone_id)])
                data = np.array(self._get_data_from_last_index(signal,self.i_last_tdis))
                dT_lower = LowerSetp - data
                dT_lower[dT_lower<0]=0
                dT_upper = data - UpperSetp
                dT_upper[dT_upper<0]=0
                self.tdis_dict[signal[:-1]+'dTlower_y'] += \
                    trapz(dT_lower,self._get_data_from_last_index('time',self.i_last_tdis))/3600.
                self.tdis_dict[signal[:-1]+'dTupper_y'] += \
                    trapz(dT_upper,self._get_data_from_last_index('time',self.i_last_tdis))/3600.
                self.tdis_tot = self.tdis_tot + \
                    self.tdis_dict[signal[:-1]+'dTlower_y']/len(self.sources_tdis) + \
                    self.tdis_dict[signal[:-1]+'dTupper_y']/len(self.sources_tdis) # Normalize total by number of sources

        self.case.tdis_tot  = self.tdis_tot
        self.case.tdis_dict = self.tdis_dict

        # Update last integration index
        self._set_last_index('tdis', set_initial=False)

        if plot:
            self.case.tdis_tree = self.get_dict_tree(self.tdis_dict)
            self.plot_nested_pie(self.case.tdis_tree, metric='discomfort',
                                 units='Kh', breakdonut=False)

        return self.tdis_tot

    def get_iaq_discomfort(self, plot=False):
        '''The IAQ discomfort is the integral of the deviation
        of the CO2 concentration with respect to the predefined comfort
        setpoint. Its units are of ppm*h.

        Parameters
        ----------
        plot: boolean, optional
            True to show a donut plot with the iaq discomfort metrics.
            Default is False.

        Returns
        -------
        idis_tot: float
            total IAQ discomfort accounted in this test case

        '''

        self.idis_tot = 0.
        index = self._get_data_from_last_index('time',self.i_last_idis)

        for source in self.sources_idis:
            # This is a potential source of iaq discomfort
            zone_id = source.replace('CO2Concentration[','')[:-1]

            for signal in self.case.kpi_json[source]:
                # Load CO2 set points from test case data
                UpperSetp = np.array(self.case.data_manager.get_data(index=index,
                            variables=['UpperCO2[{0}]'.format(zone_id)])
                                 ['UpperCO2[{0}]'.format(zone_id)])
                data = np.array( self._get_data_from_last_index(signal,self.i_last_idis))
                dI_upper = data - UpperSetp
                dI_upper[dI_upper<0]=0
                self.idis_dict[signal[:-1]+'dIupper_y'] += \
                    trapz(dI_upper, self._get_data_from_last_index('time',self.i_last_idis))/3600.
                self.idis_tot = self.idis_tot + \
                          self.idis_dict[signal[:-1]+'dIupper_y']/len(self.sources_idis) # Normalize total by number of sources

        self.case.idis_tot  = self.idis_tot
        self.case.idis_dict = self.idis_dict

        # Update last integration index
        self._set_last_index('idis', set_initial=False)

        if plot:
            self.case.idis_tree = self.get_dict_tree(self.idis_dict)
            self.plot_nested_pie(self.case.idis_tree, metric='IAQ discomfort',
                                 units='ppmh', breakdonut=False)

        return self.idis_tot

    def get_energy(self, plot=False, plot_by_source=False):
        '''This method returns the measure of the total building
        energy use in kW*h when accounting for the sum of all
        energy vectors present in the test case.

        Parameters
        ----------
        plot: boolean, optional
            True to show a donut plot with the energy use
            grouped by elements.
            Default is False.
        plot_by_source: boolean, optional
            True to show a donut plot with the energy use
            grouped by sources.
            Default is False.

        Returns
        -------
        ener_tot: float
            total energy use

        '''
        self.ener_tot = 0.
        # Calculate total energy from power
        # [returns KWh - assumes power measured in Watts]
        for source in self.sources_ener:
            if 'Power' in source:
                for signal in self.case.kpi_json[source]:
                    pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_ener))
                    self.ener_dict[signal] += \
                        trapz(pow_data,
                              self._get_data_from_last_index('time',self.i_last_ener))*2.77778e-7 # Convert to kWh
                    self.ener_dict_by_source[source+'_'+signal] += \
                        self.ener_dict[signal]
                    self.ener_tot = self.ener_tot + self.ener_dict[signal]/self.case._get_area() # Normalize total by floor area

        # Assign to case
        self.case.ener_tot            = self.ener_tot
        self.case.ener_dict           = self.ener_dict
        self.case.ener_dict_by_source = self.ener_dict_by_source

        # Update last integration index
        self._set_last_index('ener', set_initial=False)

        if plot:
            self.case.ener_tree = self.get_dict_tree(self.ener_dict)
            self.plot_nested_pie(self.case.ener_tree, metric='energy use',
                                 units='kWh')
        if plot_by_source:
            self.case.ener_tree_by_source = self.get_dict_tree(self.ener_dict_by_source)
            self.plot_nested_pie(self.case.ener_tree_by_source,
                                 metric='energy use by source', units='kWh')

        return self.ener_tot

    def get_peak_electricity(self):
        '''This method returns the measure of the total
        peak 15-minute electricity demand in kW/m^2.

        Parameters
        ----------
        None

        Returns
        -------
        pele_tot: float
            peak 15-minute electricity demand in kW/m^2.
            Returns None if no electrical power used in model.

        '''

        # If no electricity in model return None, otherwise calculate
        if len(self.sources_pele)==0:
            self.pele_tot = None
            self.pele_dict = None
        else:
            tim_data = np.array(self._get_data_from_last_index('time',self.i_last_pele))
            df_pow_data_all = pd.DataFrame(index=tim_data)
            # Calculate peak electricity
            # [returns KW/m^2 - assumes power measured in Watts]
            for source in self.sources_pele:
                for signal in self.case.kpi_json[source]:
                    pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_pele))
                    df_pow_data = pd.DataFrame(index=tim_data, data=pow_data, columns=[signal])
                    df_pow_data_all = pd.concat([df_pow_data_all, df_pow_data], axis=1)
            df_pow_data_all.index = pd.TimedeltaIndex(df_pow_data_all.index, unit='s')
            df_pow_data_all['total_demand'] = df_pow_data_all.sum(axis=1)
            df_pow_data_all = df_pow_data_all.resample('15T').mean()/self.case._get_area()/1000.
            i = df_pow_data_all['total_demand'].idxmax()
            peak = df_pow_data_all.loc[i,'total_demand']
            self.pele_tot = peak
            # Find contributions to peak by each signal
            for signal in self.case.kpi_json[source]:
                self.pele_dict[signal] = df_pow_data_all.loc[i,signal]
        # Assign to case
        self.case.pele_tot = self.pele_tot
        self.case.pele_dict = self.pele_dict

        # Don't update last integration index

        return self.pele_tot

    def get_peak_gas(self):
        '''This method returns the measure of the total
        peak 15-minute gas demand in kW/m^2.

        Parameters
        ----------
        None

        Returns
        -------
        pgas_tot: float
            peak 15-minute gas demand in kW/m^2.
            Returns None if no gas power used in model.

        '''

        # If no gas in model return None, otherwise calculate
        if len(self.sources_pgas)==0:
            self.pgas_tot = None
            self.pgas_dict = None
        else:
            tim_data = np.array(self._get_data_from_last_index('time',self.i_last_pgas))
            df_pow_data_all = pd.DataFrame(index=tim_data)
            # Calculate peak gas
            # [returns KW/m^2 - assumes power measured in Watts]
            for source in self.sources_pgas:
                for signal in self.case.kpi_json[source]:
                    pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_pgas))
                    df_pow_data = pd.DataFrame(index=tim_data, data=pow_data, columns=[signal])
                    df_pow_data_all = pd.concat([df_pow_data_all, df_pow_data], axis=1)
            df_pow_data_all.index = pd.TimedeltaIndex(df_pow_data_all.index, unit='s')
            df_pow_data_all['total_demand'] = df_pow_data_all.sum(axis=1)
            df_pow_data_all = df_pow_data_all.resample('15T').mean()/self.case._get_area()/1000.
            i = df_pow_data_all['total_demand'].idxmax()
            peak = df_pow_data_all.loc[i,'total_demand']
            self.pgas_tot = peak
            # Find contributions to peak by each signal
            for signal in self.case.kpi_json[source]:
                self.pgas_dict[signal] = df_pow_data_all.loc[i,signal]
        # Assign to case
        self.case.pgas_tot = self.pgas_tot
        self.case.pgas_dict = self.pgas_dict

        # Don't update last integration index

        return self.pgas_tot

    def get_peak_district_heating(self):
        '''This method returns the measure of the total
        peak 15-minute district heating demand in kW/m^2.

        Parameters
        ----------
        None

        Returns
        -------
        pdih_tot: float
            peak 15-minute district heating demand in kW/m^2.
            Returns None if no district heating power used in model.

        '''

        # If no gas in model return None, otherwise calculate
        if len(self.sources_pdih)==0:
            self.pdih_tot = None
            self.pdih_dict = None
        else:
            tim_data = np.array(self._get_data_from_last_index('time',self.i_last_pdih))
            df_pow_data_all = pd.DataFrame(index=tim_data)
            # Calculate peak gas
            # [returns KW/m^2 - assumes power measured in Watts]
            for source in self.sources_pdih:
                for signal in self.case.kpi_json[source]:
                    pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_pdih))
                    df_pow_data = pd.DataFrame(index=tim_data, data=pow_data, columns=[signal])
                    df_pow_data_all = pd.concat([df_pow_data_all, df_pow_data], axis=1)
            df_pow_data_all.index = pd.TimedeltaIndex(df_pow_data_all.index, unit='s')
            df_pow_data_all['total_demand'] = df_pow_data_all.sum(axis=1)
            df_pow_data_all = df_pow_data_all.resample('15T').mean()/self.case._get_area()/1000.
            i = df_pow_data_all['total_demand'].idxmax()
            peak = df_pow_data_all.loc[i,'total_demand']
            self.pdih_tot = peak
            # Find contributions to peak by each signal
            for signal in self.case.kpi_json[source]:
                self.pdih_dict[signal] = df_pow_data_all.loc[i,signal]
        # Assign to case
        self.case.pdih_tot = self.pdih_tot
        self.case.pdih_dict = self.pdih_dict

        # Don't update last integration index

        return self.pdih_tot

    def get_cost(self, scenario='Constant', plot=False,
                 plot_by_source=False):
        '''This method returns the measure of the total building operational
        energy cost in euros when accounting for the sum of all energy
        vectors present in the test case as well as other sources of cost
        like water.

        Parameters
        ----------
        scenario: string, optional
            There are three different scenarios considered for electricity:
            1. 'Constant': completely constant price
            2. 'Dynamic': day/night tariff
            3. 'HighlyDynamic': spot price changing every 15 minutes.
            Default is 'Constant'.
        plot: boolean, optional
            True to show a donut plot with the operational cost
            grouped by elements.
            Default is False.
        plot_by_source: boolean, optional
            True to show a donut plot with the operational cost
            grouped by sources.
            Default is False.

        Notes
        -----
        It is assumed that power is measured in Watts and water usage in m3

        '''

        self.cost_tot = 0.
        index=self._get_data_from_last_index('time',self.i_last_cost)

        for source in self.sources_cost:
            if 'ElectricPower' in source:
                # Data for the operational cost from electricity in this scenario
                source_price_data = \
                np.array(self.case.data_manager.get_data(index=index,
                        variables=['Price'+source+scenario])\
                         ['Price'+source+scenario])
                factor = 2.77778e-7 # Convert to kWh
            elif 'Power' in source:
                # Data for the operational cost from other power sources
                source_price_data = \
                np.array(self.case.data_manager.get_data(index=index,
                        variables=['Price'+source])\
                         ['Price'+source])
                factor = 2.77778e-7 # Convert to kWh
            elif 'FreshWater' in source:
                # Data for the operational cost from other sources
                source_price_data = \
                np.array(self.case.data_manager.get_data(index=index,
                        variables=['Price'+source])\
                         ['Price'+source])
                factor = 1 # No conversion needed

            # Calculate costs
            for signal in self.case.kpi_json[source]:
                pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_cost))
                self.cost_dict[signal] += \
                    trapz(np.multiply(source_price_data,pow_data),
                          self._get_data_from_last_index('time',self.i_last_cost))*factor
                self.cost_dict_by_source[source+'_'+signal] += \
                    self.cost_dict[signal]
                self.cost_tot = self.cost_tot + self.cost_dict[signal]/self.case._get_area() # Normalize total by floor area

        # Assign to case
        self.case.cost_tot            = self.cost_tot
        self.case.cost_dict           = self.cost_dict
        self.case.cost_dict_by_source = self.cost_dict_by_source

        # Update last integration index
        self._set_last_index('cost', set_initial=False)

        if plot:
            self.case.cost_tree = self.get_dict_tree(self.cost_dict)
            self.plot_nested_pie(self.case.cost_tree, metric='cost',
                                 units='euros')
        if plot_by_source:
            self.case.cost_tree_by_source = self.get_dict_tree(self.cost_dict_by_source)
            self.plot_nested_pie(self.case.cost_tree_by_source,
                                 metric='cost by source', units='euros')

        return self.cost_tot

    def get_emissions(self, plot=False, plot_by_source=False):
        '''This method returns the measure of the total building
        emissions in kgCO2 when accounting for the sum of all
        energy vectors present in the test case.

        Parameters
        ----------
        plot: boolean, optional
            True if it it is desired to make plots related with
            the emission metric.
            Default is False.
        plot_by_source: boolean, optional
            True to show a donut plot with the operational cost
            grouped by sources.
            Default is False.

        Notes
        -----
        It is assumed that power is measured in Watts

        '''

        self.emis_tot = 0.
        index=self._get_data_from_last_index('time',self.i_last_emis)

        for source in self.sources_emis:
            # Calculate the operational emissions from power sources
            if 'Power' in source:
                source_emissions_data = \
                np.array(self.case.data_manager.get_data(index=index,
                        variables=['Emissions'+source])\
                         ['Emissions'+source])
                for signal in self.case.kpi_json[source]:
                    pow_data = np.array(self._get_data_from_last_index(signal,self.i_last_emis))
                    self.emis_dict[signal] += \
                        trapz(np.multiply(source_emissions_data,pow_data),
                              self._get_data_from_last_index('time',self.i_last_emis))*2.77778e-7 # Convert to kWh
                    self.emis_dict_by_source[source+'_'+signal] += \
                        self.emis_dict[signal]
                    self.emis_tot = self.emis_tot + self.emis_dict[signal]/self.case._get_area() # Normalize total by floor area

        # Update last integration index
        self._set_last_index('emis', set_initial=False)

        # Assign to case
        self.case.emis_tot            = self.emis_tot
        self.case.emis_dict           = self.emis_dict
        self.case.emis_dict_by_source = self.emis_dict_by_source

        if plot:
            self.case.emis_tree = self.get_dict_tree(self.emis_dict)
            self.plot_nested_pie(self.case.emis_tree, metric='emissions',
                                 units='kgCO2')
        if plot_by_source:
            self.case.emis_tree_by_source = self.get_dict_tree(self.emis_dict_by_source)
            self.plot_nested_pie(self.case.emis_tree_by_source,
                                 metric='emissions by source', units='kgCO2')

        return self.emis_tot

    def get_computational_time_ratio(self, plot=False):
        '''Obtain the computational time ratio as the average ratio between
        the elapsed control time and the test case control step
        time. The elapsed control time is measured as the
        time between two emulator simulations. A time counter starts
        at the end of the 'advance' test case method and finishes at
        the beginning of the following call to the same method.
        Notice that the accounted time includes not only the
        controller computational time but also the signal exchange
        time with the controller through the RESTAPI interface.

        Parameters
        ----------
        plot: boolean, optional
            True if it is desired to make a plot of the elapsed
            controller time.
            Default is False.

        Returns
        -------
        time_rat: float
            computational time ratio of this test case

        '''

        elapsed_control_time_ratio = self.case._get_elapsed_control_time_ratio()
        time_rat = np.mean(elapsed_control_time_ratio)

        self.case.time_rat = time_rat

        if plot:
            plt.figure()
            n=len(elapsed_control_time_ratio)
            bgn=int(self.case.step)
            end=int(self.case.step + n*self.case.step)
            plt.plot(range(bgn,end,int(self.case.step)),
                     elapsed_control_time_ratio)
            plt.show()

        return time_rat

    def _set_last_index(self,label, set_initial=False):
        '''Set last index for kpi calcualtion.

        Parameters
        ----------
        label: str
            Suffix of last index variable for which to set.
        set_initial: boolean
            True to force index to be set at initial testing time.

        '''

        # Initialize index
        if len(self.case.y_store['time']) > 0:
            if set_initial:
                # Find initial testing time index
                i = len([x for x in self.case.y_store['time'] if x < self.case.initial_time])
            else:
                # Use index since last integration
                i = len(self.case.y_store['time'])-1
        else:
            i = 0
        setattr(self, 'i_last_{}'.format(label),i)

    def _get_data_from_last_index(self,point,i):
        '''Get data from last index indicated by i.

        Parameters
        ----------
        point: str
            Name of point to get data for from case.y_store
        i: int
            Integer to indicate the first time to get data

        Returns
        -------
        data: np array
            Array of data from key from i onward

        '''

        data=self.case.y_store[point][i:]

        return data

    def get_load_factors(self):
        '''Calculate the load factor for every power signal

        '''

        ldfs = OrderedDict()

        for signal in self.case.kpi_json['ElectricPower']:
            pow_data = np.array(self.case.y_store[signal])
            avg_pow = pow_data.mean()
            max_pow = pow_data.max()
            try:
                ldfs[signal]=avg_pow/max_pow
            except ZeroDivisionError as err:
                print("Error: {0}".format(err))
                return

        self.case.ldfs = ldfs

        return ldfs

    def get_power_peaks(self):
        '''Calculate the power peak for every power signal

        '''

        ppks = OrderedDict()

        for signal in self.case.kpi_json['ElectricPower']:
            pow_data = np.array(self.case.y_store[signal])
            max_pow = pow_data.max()
            ppks[signal]=max_pow

        self.case.ppks = ppks

        return ppks

    def get_dict_tree(self, dict_flat, sep='_',
                      remove_null=True, merge_branches=True):
        '''This method creates a dictionary tree from a
        flat dictionary. A dictionary tree is a nested
        dictionary where each element contains other
        dictionaries which keys are the following
        names of the strings in the keys of the
        original dictionary and that are separated
        from each other with a 'sep' string case that
        can be specified.

        Parameters
        ----------
        dict_flat: dict
            dictionary containing only one layer of
            complexity. This means that the values of
            the dictionary do not contain any other
            dictionaries.
        sep: string, optioanl
            string that indicates different layers in
            the keys of the original dictionary.
            Default is '_'.
        remove_null: Boolean, optional
            True if we don't want to include the null
            elements in the dictionary tree. These null
            elements create problems when plotting the
            nested pie chart.
            Default is True.
        merge_branches: Boolean, optional
            Merge the branches where a key has only one value.
            This resolves the problem of getting a plain
            dictionary with any key containing the 'sep'.
            Default is True.

        Returns
        -------
        dict_tree: dict
            nested dictionary with the different layers
            of complexity indicated by the 'sep' string
            in the keys of the original dictionary

        '''

        # Initialize the dictionary tree
        dict_tree = OrderedDict()
        # Remove the null elements from the flat dictionary
        if remove_null:
            dict_flat = self.remove_null_elements(dict_flat)
        # Each element of the flat dictionary is a branch of the tree
        for element in dict_flat.keys():
            # Create an auxiliary variable to go through the branches of the tree
            actual_layer = dict_tree
            # Read every component in the branch except the last '_y' term
            components = element.split(sep)[:-1]
            # Grow the branch with a new dictionary if not the last component
            for component in components[:-1]:
                # Check if this component is already in this layer
                if component not in actual_layer.keys():
                    # Create a dictionary in this layer to keep growing the branch
                    actual_layer[component]=OrderedDict()
                # Shift the actual layer by one component
                actual_layer = actual_layer[component]
            # If last component, assign the flat dictionary value
            actual_layer[components[-1]] = dict_flat[element]

        if merge_branches:
            dict_tree = self.merge_branches(dict_tree,sep=sep)

        return dict_tree

    def merge_branches(self, dictionary, sep='_'):
        '''Merge the branches where a key has only one value.
        This resolves the problem of getting a plain dictionary
        with any key containing the 'sep' element.

        Parameters
        ----------
        dictionary: dict
            dictionary for which we want to merge branches
        sep: string, optional
            string used to merge the key and the value of the
            elements of a dictionary in different layers.
            Default is '_'.

        Returns
        -------
        new_dict: dict
            a new dictionary with the branches merged

        '''

        for k,v in iteritems(dictionary):
            if isinstance(v, dict):
                if len(dictionary.keys())==1:
                    for vkey in v.keys():
                        dictionary[k+sep+vkey] = v[vkey]
                    dictionary.pop(k)

                self.merge_branches(v)

        return dictionary

    def sum_dict(self, dictionary):
        '''This method returns the sum of all values within a
        nested dictionary that can contain float numbers
        and/or other dictionaries containing the same type
        of elements. It works in a recursive way.

        Parameters
        ----------
        dictionary: dict or float
            dictionary containing other dictionaries and/or
            float numbers. If it's a float it will return
            its value directly

        Returns
        -------
        val: float
            value of the sum of all values within the
            nested dictionary

        '''

        # Initialize the sum
        val=0.
        # If dictionary is a float we have arrived to an
        # end point and we want to return its value
        if isinstance(dictionary, float):

            return dictionary

        # If dictionary is still a dictionary we should
        # keep searching for an end point with a float
        elif isinstance(dictionary, dict):
            for k in dictionary.keys():
                # Sum the values within this dictionary
                val += self.sum_dict(dictionary=dictionary[k])

            return val

    def count_elements(self, dictionary):
        '''This methods counts the number of end points in
        a nested dictionary. An end point is considered
        to be a float number instead of a new dictionary
        layer.

        Parameters
        ----------
        dictionary: dict
            dictionary for which we want to count the

        Returns
        -------
        n: integer
            number of total end points within the nested
            dictionary

        '''

        # Initialize the counter
        n=0
        # If dictionary is a float we have arrived to an
        # end point and we want to sum one element
        if isinstance(dictionary, float):

            return 1

        # If dictionary is still a dictionary we should
        # keep searching for an end point
        elif isinstance(dictionary, dict):
            for k in dictionary.keys():
                # Count the elements within this dictionary
                try:
                    n += self.count_elements(dictionary=dictionary[k])
                except:
                    pass

            return n

    def remove_null_elements(self, dictionary):
        '''This methods removes the null elements of a
        plain dictionary

        Parameters
        ----------
        dictionary: dict
            dictionary for which we want to remove the null elements

        Returns
        -------
        new_dict: dict
            a new dictionary without the null elements

        '''

        new_dict = OrderedDict()

        for k,v in iteritems(dictionary):
            if v!=0.:
                new_dict[k] = dictionary[k]

        return new_dict

    def parse_color_indexes(self, dictionary, min_index=0, max_index=260):
        '''This method parses the color indexes for a nested pie chart
        and according to the number of elements within the dictionary
        that is going to be plotted. It will provide an equally
        distributed range of color indexes between a minimum value
        and a maximum value. These indexes can then be used for a
        matplotlib color map in order to provide an smooth color
        variation within the chromatic circle. Notice that with
        min_index and max_index it can be customized the color range
        to be used in the chart. These indexes must lay between the
        minimum and maximum indexes of the color map used.

        Parameters
        ----------
        dictionary: dict
            dictionary for which the pie chart is going to be
            plotted
        min_index: integer, optional
            minimum value of the index that is going to be used.
            Default is 0.
        max_index: integer, optional
            maximum value of the index that is going to be used.
            Default is 260.

        '''

        n = self.count_elements(dictionary)

        return np.linspace(min_index, max_index, n+1).astype(int)

    def plot_nested_pie(self, dictionary, ax=None, radius=1., delta=0.2,
                        dontlabel=None, breakdonut=True,
                        metric = 'energy use', units = 'kW*h'):
        '''This method appends a pie plot from a nested dictionary
        to an axes of matplotlib object. If all the elements
        of the dictionary are float values it will make a simple
        pie plot with those values. If there are other nested
        dictionaries it will continue plotting them in a nested
        pie plot.

        Parameters
        ----------
        dictionary: dict
            dictionary containing other dictionaries and/or
            float numbers for which the pie plot is going to be
            created.
        ax: matplotlib axes object, optional
            axes object where the plot is going to be appended.
            Default is None.
        radius: float, optional
            radius of the outer layer of the pie plot.
            Default is 1.
        delta: float, optional
            desired difference between the radius of two
            consecutive pie plot layers.
            Default is 0.2.
        dontlabel: list, optional
            list of items to not be labeled for more clarity.
            Default is None.
        breakdonut: boolean, optional
            if true it will not show the non labeled slices.
            Default is True.
        metric: string, optional
            indicates the metric that is being plotted. Notice that
            this is only used for the title of the plot.
            Default is 'energy use'.
        units: string, optional
            indicates the units used for the metric. Notice that
            this is only used for the title of the plot.
            Default is 'kW*h'.

        '''

        # Initialize the pie plot if not initialized yet
        if ax is None:
            _, ax = plt.subplots()
        if dontlabel is None:
            dontlabel = []
        # Get the color map to be used in this pie
        cmap = plt.get_cmap('rainbow')
        labels=[]
        # Parse the color indexes to be used in this pie
        color_indexes  = self.parse_color_indexes(dictionary)
        # Initialize the color indexes to be used in this layer
        cindexes_layer = [0]
        # Initialize the list of values to plot in this layer
        vals = []
        # Initialize a new dictionary for the next inner layer
        new_dict = OrderedDict()
        # Initialize the shifts for the required indices
        shift = np.zeros(len(dictionary.keys()))
        # Initialize a counter for the loop
        i=0
        # Go through every component in this layer
        for k_outer,v_outer in iteritems(dictionary):
            # Calculate the slice size of this component
            vals.append(self.sum_dict(v_outer))
            # Append the new label if not end point (if not in dontlabel)
            last_key = k_outer.split('__')[-1]
            label = last_key if not any(k_outer.startswith(dntlbl) \
                                        for dntlbl in dontlabel) else ''
            labels.append(label)
            # Check if this component has nested dictionaries
            if isinstance(v_outer, dict):
                # If it has, add them to the new dictionary
                for k_inner,v_inner in iteritems(v_outer):
                    # Give a unique nested key name to it
                    new_dict[k_outer+'__'+k_inner] = v_inner
            # Check if this component is already a float end point
            elif isinstance(v_outer, float):
                # If it is, add it to the new dictionary
                new_dict[k_outer] = v_outer
            # Count the number of elements in this component
            n = self.count_elements(v_outer)
            # Append the index of this component according to its
            # number of components in order to follow a progressive
            # chromatic circle
            cindexes_layer.append(cindexes_layer[-1]+n)
            # Make a shift if this is not an end point to do not use
            # the same color as the underlying end points. Make this
            # shift something characteristic of this layer by making
            # use of its radius
            shift[i] = 0 if n==1 else 60*radius
            # Do not label this slice in the next layer if this was
            # already an end point or a null slice
            if n==1:
                dontlabel.append(k_outer)
            # Increase counter
            i+=1

        # Assign the colors to every component in this layer
        colors = cmap((color_indexes[[cindexes_layer[:-1]]] + \
                       shift).astype(int))

        # If breakdonut=True show a blank in the unlabeled items
        if breakdonut:
            for j,l in enumerate(labels):
                if l is '': colors[j]=[0., 0., 0., 0.]

        # Append the obtained slice values of this layer to the axes
        ax.pie(np.array(vals), radius=radius, labels=labels,
               labeldistance=radius, colors=colors,
               wedgeprops=dict(width=0.2, edgecolor='w', linewidth=0.3))

        # Keep nesting if there is still any dictionary between the values
        if not all(isinstance(v, float) for v in dictionary.values()):
            self.plot_nested_pie(new_dict, ax, radius=radius-delta,
                                 dontlabel=dontlabel, metric=metric,
                                 units=units)

        # Don't continue nesting if all components were float end points
        else:
            plt.title('Total {metric} = {value:.2f} {units}'.format(\
                metric=metric, value=self.sum_dict(dictionary), units=units))
            # Equal aspect ratio ensures that pie is drawn as a circle
            ax.axis('equal')
            plt.show()

if __name__ == "__main__":
    '''Nested pie chart example'''
    ene_dict = {'Heating_damper_y':50.,
                'Heating_HP_pump_y':160.,
                'Heating_pump_y':25.,
                'Cooling_fan_y':80.,
                'Heating_HP_fan_y':30.,
                'Heating_HP_prueba_y':0.,
                'Cooling_pump_y':80.,
                'Lighting_floor_1_zone1_lamp1_y':15.,
                'Lighting_floor_1_zone1_lamp2_y':23.,
                'Lighting_floor_1_zone2_y':87.,
                'Lighting_floor_2_y':37.}

    cal = KPI_Calculator(testcase=None)
    ene_tree = cal.get_dict_tree(ene_dict)
    cal.plot_nested_pie(ene_tree)
