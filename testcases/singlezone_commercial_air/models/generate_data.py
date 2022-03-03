'''
Generates internal load, setpoint, and occupancy boundary data for
singlezone_commercial_air case.  Uses csv result file from one-year simulation that needs
to already be run using baseline control, containing the following output
variables:

zon.roo.qGai_flow[1]
zon.roo.qGai_flow[2]
zon.roo.qGai_flow[3]
zon.numOcc.y
con.TSetCoo.y[1]
con.TSetHea.y[1]

This script should be run from the models/ directory.

'''

from data.data_generator import Data_Generator
import pandas as pd
import numpy as np
import os

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)

# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

# Remove duplicate states
df = pd.read_csv('../TestCase_Staged.csv')
drop_list = []
for i in range(len(df.index)):
    if i != len(df.index)-1:
        if df['Time'][i] == df['Time'][i+1]:
            if np.mod(df['Time'][i],24*3600) == 18*3600:
                drop_list.append(i+1)
            else:
                drop_list.append(i)
df = df.drop(index=drop_list)
df = df.set_index('Time')
df.index.name = 'time'

# Convert W/m^2 to W
A = 348.4 # m^2
for key in ['zon.roo.qGai_flow[1]','zon.roo.qGai_flow[2]','zon.roo.qGai_flow[3]']:
    df[key] = df[key]*A

# Add CO2 limit
df['UpperCO2[1]'] = 1500
df['UpperCO2[1]'][df['con.TSetCoo.y[1]']<28]=894

# Adjust temp set points to kelvin
df['con.TSetCoo.y[1]'] = df['con.TSetCoo.y[1]'].values + 273.15
df['con.TSetHea.y[1]'] = df['con.TSetHea.y[1]'].values + 273.15
# Change names
column_map = {'zon.roo.qGai_flow[1]': 'InternalGainsRad[1]',
              'zon.roo.qGai_flow[2]': 'InternalGainsCon[1]',
              'zon.roo.qGai_flow[3]': 'InternalGainsLat[1]',
              'con.TSetCoo.y[1]': 'UpperSetp[1]',
              'con.TSetHea.y[1]': 'LowerSetp[1]',
              'zon.numOcc.y':'Occupancy[1]'}
df = df.rename(columns=column_map)

df.to_csv('internal_setpoints.csv')

# Generate TOU electricty prices
df_prices = pd.DataFrame(index=pd.TimedeltaIndex(df.index.values,unit='s'))
df_prices.index = (df_prices.index - df_prices.index[0])+pd.datetime(2018, 1, 1, 0, 0, 0)
df_prices['PriceElectricPowerDynamic'] = 0.0138
df_prices['PriceElectricPowerDynamic'][(df_prices.index.weekday >= 0) & (df_prices.index.weekday <= 4) & \
                                       (df_prices.index.hour >= 8) & (df_prices.index.hour <= 21)] = 0.1862
df_prices['PriceElectricPowerDynamic'][(df_prices.index.month >= 6) & (df_prices.index.month <= 9) & \
                                       (df_prices.index.weekday >= 0) & (df_prices.index.weekday <= 4) & \
                                       (df_prices.index.hour >= 8) & (df_prices.index.hour <= 21)] = 0.3782
df_prices.index = df.index
df_prices.to_csv('electricity_prices_dynamic.csv')
