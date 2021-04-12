'''
Created on Jun 17, 2020

@author: Javier Arroyo
'''

from data.data_generator import Data_Generator
import os
import pandas as pd
from pymodelica import compile_fmu
from pyfmi import load_fmu
from scipy import interpolate

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)

# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

#=====================================================================
# Generate prices
#=====================================================================
# Electricity prices obtained from: https://www.energyprice.be/products-list/Engie
# for the "Easy Indexed" deal for electricity, on June 2020
# More info in https://www.energyprice.be/blog/2017/11/06/electricity-price-belgium/
# and in https://www.energyprice.be/blog/2017/10/23/electricity-off-peak-hours/
# For the highly dynamic scenario, the Belgian day-ahead prices of 2019 are used.
# Obtained from:
# https://my.elexys.be/MarketInformation/SpotBelpex.aspx
# And stored as downloaded in /Resources/BelpexFilter.xlsx
# This script preprocesses the excel file and overwrites the highly
# dynamic price scenario with that data.

# Gas prices obtained from https://www.energyprice.be/products-list/Engie
# for the "Easy Indexed" deal for gas, on June 2020
# More info in https://www.energyprice.be/blog/2017/12/07/gas-price-belgium/

# All pricing scenarios include the same constant value for transmission fees and taxes
# of each commodity. The used value is the typical price that household users pay
# for the network, taxes and levies, as calculateed by Eurostat and obtained from:
# https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:52020DC0951&from=EN
# For the assumed location of the test case, this value is of
# 0.20 EUR/kWh for electricity and of 0.03 EUR/kWh for gas.

fees_and_taxes_ele = 0.20
fees_and_taxes_gas = 0.03

gen.generate_prices(start_day_time = '07:00:00',
                      end_day_time = '22:00:00',
                      price_constant = 0.0535+fees_and_taxes_ele,
                      price_day = 0.0666+fees_and_taxes_ele,
                      price_night = 0.0383+fees_and_taxes_ele,
                      price_district_heating_power = 0.1,
                      price_gas_power = 0.0198+fees_and_taxes_gas,
                      price_biomass_power = 0.2,
                      price_solar_thermal_power = 0.0)

# Remove prices that are not used within the model
prices_boptest = pd.read_csv(os.path.join(gen.resources_dir, 'prices.csv'),
                             index_col='time')
prices_boptest = prices_boptest.drop(labels=['PriceGasPower',
                                             'PriceDistrictHeatingPower',
                                             'PriceBiomassPower',
                                             'PriceSolarThermalPower'], axis=1)

# Read highly dynamic price scenario for preprocessing
prices_belpex  = pd.read_excel(os.path.join(gen.resources_dir,'BelpexFilter.xlsx'),
                               parse_dates=True)

# Disregard duplicate from daylight saving
prices_belpex.drop_duplicates(subset='Date', keep='first', inplace=True)

# Get an absolute time vector in seconds from the beginning of the year
prices_belpex.sort_values('Date', ascending=True, inplace=True)
time_since_epoch = pd.DatetimeIndex(prices_belpex['Date']).asi8/1e9
prices_belpex['time'] = time_since_epoch - time_since_epoch[0]
prices_belpex.set_index('time', inplace=True)
prices_belpex = prices_belpex.reindex(prices_boptest.index, method='ffill')

# Overwrite testcase highly dynamic price profile and save
# Convert EUR/MWh to EUR/kWh and add fees and taxes to belpex
prices_boptest['PriceElectricPowerHighlyDynamic'] = \
    prices_belpex['Euro']/1000. + fees_and_taxes_ele
prices_boptest.to_csv(os.path.join(gen.resources_dir, 'prices.csv'), index=True)

gen.generate_emissions(emissions_electric_power = 0.167,
                           emissions_district_heating_power = 0.1,
                           emissions_gas_power = 0.18108,
                           emissions_biomass_power = 0.0,
                           emissions_solar_thermal_power = 0.0)

# Remove emission factors that are not used within the model
emissions_boptest = pd.read_csv(os.path.join(gen.resources_dir, 'emissions.csv'),
                                index_col='time')
emissions_boptest = emissions_boptest.drop(labels=['EmissionsGasPower',
                                                   'EmissionsDistrictHeatingPower',
                                                   'EmissionsBiomassPower',
                                                   'EmissionsSolarThermalPower'], axis=1)
emissions_boptest.to_csv(os.path.join(gen.resources_dir, 'emissions.csv'), index=True)

#=====================================================================
# Generate variables from model
#=====================================================================
# Initialize data frame
df = gen.create_df()
file_name    = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                            'BESTESTHydronicHeatPump')
class_name   = 'BESTESTHydronicHeatPump.TestCase'

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
keysMap['Occupancy[1]'] = 'yOcc.y'

# Internal gains
keysMap['InternalGainsRad[1]'] = 'case900Template.intGaiOcc.portRad.Q_flow'
keysMap['InternalGainsCon[1]'] = 'case900Template.intGaiOcc.portCon.Q_flow'
keysMap['InternalGainsLat[1]'] = 'case900Template.airModel.preHeaFloLat.Q_flow'

# Comfort range setpoints
keysMap['LowerSetp[1]'] = 'reaTSetHea.y'
keysMap['UpperSetp[1]'] = 'reaTSetCoo.y'

# Get model outputs
output_names = keysMap.keys()

# Write every output in the data
for out in output_names:
    # Interpolate to avoid problems with events from Modelica
    g = interpolate.interp1d(res['time'],res[keysMap[out]],kind='linear')
    df.loc[:,out] = g(gen.time)

# Switch sign to sensible heat gains
df['InternalGainsRad[1]'] = -df['InternalGainsRad[1]']
df['InternalGainsCon[1]'] = -df['InternalGainsCon[1]']

# Add CO2 limits
df['UpperCO2[1]'] = 894.

def hold_step_values_in_event_times(df, var, event_freq):
    ''' This method goes through the index of a data frame to inspect
    when positive step changes take place for a variable and makes sure
    that the event times hold the values when the step is active.

    Parameters
    ----------
    df: DataFrame
        Data frame with the data to be changed. Index should be
        a DatetimeIndex type
    var: string
        Column of the data frame used to find step changes
    event_freq: integer
        Frequency of possible step changes in seconds. Choose the
        greatest common divisor of all event times. One hours is a
        safe choice, unless step changes happen more frequently, which
        is not normally the case.

    Returns
    df: DataFrame
        The modified data frame that holds the step values in the
        event times.

    '''

    time_original = df.time

    for i in df.index[1:-1]:
        # Check if we are in a potential event time
        if int((i - df.index[0]).total_seconds())%event_freq == 0:
            # Check the cases that we want to avoid:
            if df.loc[i+i.freq,var]>df.loc[i,var]:
                # A step has been activated but event time is not
                # holding the value during activation. Change that:
                df.loc[i,:] = df.loc[i+i.freq,:]
            if df.loc[i-i.freq,var]>df.loc[i,var]:
                # A step has been deactivated but event time is not
                # holding the value during activation. Change that:
                df.loc[i,:] = df.loc[i-i.freq,:]

    df.time = time_original

    return df

df = hold_step_values_in_event_times(df=df,
                                     var='Occupancy[1]',
                                     event_freq=3600)

# Store in csv
gen.store_df(df,'dataFromModel')
