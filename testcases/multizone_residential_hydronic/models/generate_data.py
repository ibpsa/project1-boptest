'''
Created on Sep 18, 2019

@author: Javier Arroyo
'''

from data.data_generator import Data_Generator
import os
import pandas as pd
from pymodelica import compile_fmu
from pyfmi import load_fmu
from scipy import interpolate
import numpy as np

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval of 5 minutes
gen = Data_Generator(resources_dir, period=300)

# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

#=====================================================================
# Generate prices
#=====================================================================
# Electricity prices obtained from:
# https://particuliers.engie.fr/electricite/contrat-electricite/contrat-elec-ajust.html
# for the Engie's "Elec Ajust" deal before taxes (HTT = 'hors taxes', TTC = 'taxes compris')
# for electricity the price before taxes is chosen to allow comparison against
# the highly dynamic price scenario that uses spot prices.
# The tariff used is the one for households with contracted power installations
# higher than 6 kVA.
# For the highly dynamic scenario, the French day-ahead prices of 2019 are used.
# Obtained from:
# https://www.epexspot.com/en
# The prices are parsed and exported using this repository:
# https://github.com/JavierArroyoBastida/epex-spot-data
# And stored as downloaded in /Resources/2019.csv
# This script preprocesses the csv file and overwrites the highly
# dynamic price scenario with that data.

# Gas prices obtained from:
# https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-sommaire-gaz-energie-garantie.pdf
# For the "Gaz Energie Garantie 1 an" deal
# price before taxes (HTT) for a contracted anual tariff between 0 - 6000 kWh

# All pricing scenarios include the same constant value for transmission fees and taxes
# of each commodity. The used value is the typical price that household users pay
# for the network, taxes and levies, as calculateed by Eurostat and obtained from:
# https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:52020DC0951&from=EN
# For the assumed location of the test case, this value is of
# 0.125 EUR/kWh for electricity and of 0.042 EUR/kWh for gas.

fees_and_taxes_ele = 0.125
fees_and_taxes_gas = 0.042

gen.generate_prices(start_day_time = '07:00:00',
                    end_day_time = '22:00:00',
                    price_constant = 0.108+fees_and_taxes_ele,
                    price_day = 0.126+fees_and_taxes_ele,
                    price_night = 0.086+fees_and_taxes_ele,
                    price_gas_power = 0.0491+fees_and_taxes_gas)

# Remove prices that are not used within the model
prices_boptest = pd.read_csv(os.path.join(gen.resources_dir, 'prices.csv'),
                             index_col='time')
prices_boptest = prices_boptest.drop(labels=['PriceDistrictHeatingPower',
                                             'PriceBiomassPower',
                                             'PriceSolarThermalPower'], axis=1)

# Read highly dynamic price scenario for preprocessing
prices_epex = pd.read_csv(os.path.join(gen.resources_dir,'2019.csv'),
                          parse_dates=True)

# Combine columns to form a unique datetime column
prices_epex['Date'] = pd.to_datetime(prices_epex['date'] + ' ' +prices_epex['start_hour'])

# Disregard duplicate from daylight saving
prices_epex.drop_duplicates(subset='Date', keep='first', inplace=True)

# Get an absolute time vector in seconds from the beginning of the year
prices_epex.sort_values('Date', ascending=True, inplace=True)
time_since_epoch = pd.DatetimeIndex(prices_epex['Date']).asi8/1e9
prices_epex['time'] = time_since_epoch - time_since_epoch[0]
prices_epex.set_index('time', inplace=True)
prices_epex = prices_epex.reindex(prices_boptest.index, method='ffill')

# Prices of 30th and 31st of December are not provided,
# repeat profile using the same two previous days profile
prices_epex.loc[prices_epex.index>=31363200, 'price_euros_mwh'] = \
np.asarray(prices_epex.loc[(prices_epex.index>=31190400) &
          (prices_epex.index<=31363200), 'price_euros_mwh'])

# Overwrite testcase highly dynamic price profile and save
# Convert EUR/MWh to EUR/kWh and add fees and taxes to epex
prices_boptest['PriceElectricPowerHighlyDynamic'] = \
    prices_epex['price_euros_mwh']/1000. + fees_and_taxes_ele
prices_boptest.to_csv(os.path.join(gen.resources_dir, 'prices.csv'), index=True)

# Electricity emission factor obtained from: https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf
# Gas emission factor obtained from: https://www.eia.gov/environment/emissions/co2_vol_mass.php
gen.generate_emissions(emissions_electric_power = 0.0470,
                       emissions_gas_power = 0.18108)

# Remove emission factors that are not used within the model
emissions_boptest = pd.read_csv(os.path.join(gen.resources_dir, 'emissions.csv'),
                                index_col='time')
emissions_boptest = emissions_boptest.drop(labels=['EmissionsDistrictHeatingPower',
                                                   'EmissionsBiomassPower',
                                                   'EmissionsSolarThermalPower'], axis=1)
emissions_boptest.to_csv(os.path.join(gen.resources_dir, 'emissions.csv'), index=True)

#=====================================================================
# Generate variables from model
#=====================================================================
# Initialize data frame
df = gen.create_df()
file_name    = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                            'MultiZoneResidentialHydronic')
class_name   = 'MultiZoneResidentialHydronic.GenerateData'

# Compile the model to generate the data
fmu_path = compile_fmu(file_name=file_name, class_name=class_name)

# Load FMU
model = load_fmu(fmu_path)

# Set number of communication points
options = model.simulate_options()
options['ncp']=len(gen.time)-1

# Simulate
res = model.simulate(start_time=gen.time[0],
                     final_time=gen.time[-1],
                     options=options)

keysMap = {}

# Occupancy schedules
keysMap['Occupancy[Liv]'] = 'occLiv.y'
keysMap['Occupancy[Ro1]'] = 'occRo1.y'
keysMap['Occupancy[Ro2]'] = 'occRo2.y'
keysMap['Occupancy[Ro3]'] = 'occRo3.y'
keysMap['Occupancy[Bth]'] = 'occBth.y'
keysMap['Occupancy[Hal]'] = 'occHal.y'

# CO2 limits
keysMap['UpperCO2[Liv]'] = 'limCO2Liv.y'
keysMap['UpperCO2[Ro1]'] = 'limCO2Ro1.y'
keysMap['UpperCO2[Ro2]'] = 'limCO2Ro2.y'
keysMap['UpperCO2[Ro3]'] = 'limCO2Ro3.y'
keysMap['UpperCO2[Bth]'] = 'limCO2Bth.y'
keysMap['UpperCO2[Hal]'] = 'limCO2Hal.y'

# Internal gains
keysMap['InternalGainsRad[Liv]'] = 'heaGaiLivRad.y'
keysMap['InternalGainsCon[Liv]'] = 'heaGaiLivCon.y'
keysMap['InternalGainsLat[Liv]'] = 'heaGaiLivLat.y'
keysMap['InternalGainsRad[Ro1]'] = 'heaGaiRo1Rad.y'
keysMap['InternalGainsCon[Ro1]'] = 'heaGaiRo1Con.y'
keysMap['InternalGainsLat[Ro1]'] = 'heaGaiRo1Lat.y'
keysMap['InternalGainsRad[Ro2]'] = 'heaGaiRo2Rad.y'
keysMap['InternalGainsCon[Ro2]'] = 'heaGaiRo2Con.y'
keysMap['InternalGainsLat[Ro2]'] = 'heaGaiRo2Lat.y'
keysMap['InternalGainsRad[Ro3]'] = 'heaGaiRo3Rad.y'
keysMap['InternalGainsCon[Ro3]'] = 'heaGaiRo3Con.y'
keysMap['InternalGainsLat[Ro3]'] = 'heaGaiRo3Lat.y'

# Comfort range setpoints
keysMap['LowerSetp[Liv]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Liv]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro1]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro1]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro2]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro2]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro3]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro3]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Bth]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Bth]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Hal]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Hal]'] = 'reaTSetCoo.y'

# Get model outputs
output_names = keysMap.keys()

# Write every output in the data
for out in output_names:
    # Interpolate to avoid problems with events from Modelica
    g = interpolate.interp1d(res['time'],res[keysMap[out]],kind='linear')
    df.loc[:,out] = g(gen.time)

# Missing null InternalGains variables
df['InternalGainsRad[Bth]'] = 0.
df['InternalGainsCon[Bth]'] = 0.
df['InternalGainsLat[Bth]'] = 0.
df['InternalGainsRad[Hal]'] = 0.
df['InternalGainsCon[Hal]'] = 0.
df['InternalGainsLat[Hal]'] = 0.

def hold_step_values_in_event_times(df, cols, event_freq):
    ''' This method goes through the index of a data frame to inspect
    when positive step changes take place for a variable and makes sure
    that the event times hold the values when the step is active.

    Parameters
    ----------
    df: DataFrame
        Data frame with the data to be changed. Index should be
        a DatetimeIndex type
    cols: string
        Columns of the data frame used to find step changes and perform
        the inspection. These columns will be edited if required.
    event_freq: integer
        Frequency of possible step changes in seconds. Choose the
        greatest common divisor of all event times. One hour is a
        safe choice, unless step changes happen more frequently, which
        is not normally the case.

    Returns
    -------
    df: DataFrame
        The modified data frame that holds the step values in the
        event times.

    '''

    time_original = df.time

    for col in cols:
        for i in df.index[1:-1]:
            # Check if we are in a potential event time
            if int((i - df.index[0]).total_seconds())%event_freq == 0:
                # Check the cases that we want to avoid:
                if df.loc[i+i.freq,col]>df.loc[i,col]:
                    # A step has been activated but event time is not
                    # holding the value during activation. Change that:
                    df.loc[i,col] = df.loc[i+i.freq,col]
                if df.loc[i-i.freq,col]>df.loc[i,col]:
                    # A step has been deactivated but event time is not
                    # holding the value during activation. Change that:
                    df.loc[i,col] = df.loc[i-i.freq,col]

    df.time = time_original

    return df

df = hold_step_values_in_event_times(df=df,
                                     cols=keysMap.keys(),
                                     event_freq=3600)

# Store in csv
gen.store_df(df,'dataFromModel')
