'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the KPI_Calculator class with methods for processing
the results of BOPTEST simulations and generating the corresponding key
performance indicators.

'''

import numpy as np
import pandas as pd
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
        self.initialize_kpi_vars('atvl') # Initialize actuator travel (atvl)

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

        elif label=='atvl':
            # Initialize sources of actuator variables
            self.sources_atvl = []
            self.atvl_dict = {}
            self.atvl_dict_by_source = {}
            self.atvl_source_key_mapping = {}
            for source in self.case.kpi_json.keys():
                if source.startswith('ActuatorTravel'):
                    actuator_name = source.split('[')[1][:-1]  # Extract the name inside the brackets
                    self.sources_atvl.append(actuator_name)
                    for signal in self.case.kpi_json[source]:
                        self.atvl_dict[signal] = 0.0
                        self.atvl_dict_by_source['{0}_{1}'.format(actuator_name,signal)] = 0.
                        if actuator_name in self.atvl_source_key_mapping:
                            self.atvl_source_key_mapping[actuator_name].append(signal)
                        else:
                            self.atvl_source_key_mapping[actuator_name] = [signal]

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
#       ckpi['atvl_tot'] = self.get_actuator_travel()   // While implemented here, can't be used until test cases updated

        return ckpi

    def get_thermal_discomfort(self):
        '''The thermal discomfort is the integral of the deviation
        of the temperature with respect to the predefined comfort
        setpoint. Its units are of K*h.

        Parameters
        ----------
        None

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
                    np.trapezoid(dT_lower,self._get_data_from_last_index('time',self.i_last_tdis))/3600.
                self.tdis_dict[signal[:-1]+'dTupper_y'] += \
                    np.trapezoid(dT_upper,self._get_data_from_last_index('time',self.i_last_tdis))/3600.
                self.tdis_tot = self.tdis_tot + \
                    self.tdis_dict[signal[:-1]+'dTlower_y']/len(self.sources_tdis) + \
                    self.tdis_dict[signal[:-1]+'dTupper_y']/len(self.sources_tdis) # Normalize total by number of sources

        self.case.tdis_tot  = self.tdis_tot
        self.case.tdis_dict = self.tdis_dict

        # Update last integration index
        self._set_last_index('tdis', set_initial=False)

        return self.tdis_tot

    def get_iaq_discomfort(self):
        '''The IAQ discomfort is the integral of the deviation
        of the CO2 concentration with respect to the predefined comfort
        setpoint. Its units are of ppm*h.

        Parameters
        ----------
        None

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
                    np.trapezoid(dI_upper, self._get_data_from_last_index('time',self.i_last_idis))/3600.
                self.idis_tot = self.idis_tot + \
                          self.idis_dict[signal[:-1]+'dIupper_y']/len(self.sources_idis) # Normalize total by number of sources

        self.case.idis_tot  = self.idis_tot
        self.case.idis_dict = self.idis_dict

        # Update last integration index
        self._set_last_index('idis', set_initial=False)

        return self.idis_tot

    def get_energy(self):
        '''This method returns the measure of the total building
        energy use in kW*h when accounting for the sum of all
        energy vectors present in the test case.

        Parameters
        ----------
        None

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
                        np.trapezoid(pow_data,
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

    def get_cost(self, scenario='Constant'):
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
                    np.trapezoid(np.multiply(source_price_data,pow_data),
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

        return self.cost_tot

    def get_emissions(self):
        '''This method returns the measure of the total building
        emissions in kgCO2 when accounting for the sum of all
        energy vectors present in the test case.

        Parameters
        ----------
        None

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
                        np.trapezoid(np.multiply(source_emissions_data,pow_data),
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

        return self.emis_tot

    def get_computational_time_ratio(self):
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
        None

        Returns
        -------
        time_rat: float
            computational time ratio of this test case

        '''

        elapsed_control_time_ratio = self.case._get_elapsed_control_time_ratio()
        time_rat = np.mean(elapsed_control_time_ratio) if len(elapsed_control_time_ratio) else None

        self.case.time_rat = time_rat

        return time_rat

    def get_actuator_travel(self):
        '''This method returns the measure of the actuator travel displacement when accounting for the average of all
        the actuators present in the test case.

        Parameters
        ----------
        None

        Returns
        -------
        atvl_tot: float
            displacement of actuator travel

        '''

        self.atvl_tot = 0.

        for source in self.sources_atvl:
            for signal in self.atvl_source_key_mapping[source]:
                atvl_data = np.array(self._get_data_from_last_index(signal,self.i_last_atvl))
                index_data = np.array(self._get_data_from_last_index('time',self.i_last_atvl))
                # Calculate displacement and update dictionaries
                displacement = self._displacement(index_data, atvl_data, index_data[0], index_data[-1])
                self.atvl_dict[signal] += displacement
                self.atvl_dict_by_source[source + '_' + signal] += self.atvl_dict[signal]
                self.atvl_tot = self.atvl_tot + self.atvl_dict[signal]/len(self.atvl_dict) #Divide by the number of the actuators

        # Assign to case
        self.case.atvl_tot            = self.atvl_tot
        self.case.atvl_dict           = self.atvl_dict
        self.case.atvl_dict_by_source = self.atvl_dict_by_source

        # Update last integration index
        self._set_last_index('atvl', set_initial=False)

        return self.atvl_tot


    def _displacement(self, x, y, a, b):
        """
        Computes the displacement of the given curve
        defined by (x0, y0), (x1, y1) ... (xn, yn)
        over the provided bounds, `a` and `b`.

        Parameters
        ----------
        x: numpy.ndarray
            The array of x values
        y: numpy.ndarray
            The array of y values corresponding to each value of x
        a: int
            The lower limit to integrate from
        b: int
            The upper limit to integrate to

        Returns
        -------
        numpy.float64
            The displacement of the curve

        """

        bounds = (x >= a) & (x <= b)
        grad = np.gradient(y[bounds], x[bounds])
        integrand = np.abs(grad)
        value = np.trapezoid(integrand, x[bounds])

        return float(value)


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
