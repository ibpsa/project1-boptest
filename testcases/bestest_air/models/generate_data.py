'''
Generates internal load, setpoint, and occupancy boundary data for
bestest_air case.  Uses csv result file from one-year simulation that needs
to already be run using baseline control, containing the following output
variables:

zon.roo.qGai_flow[1]
zon.roo.qGai_flow[2]
zon.roo.qGai_flow[3]
con.TSetCoo.y[1]
con.TSetHea.y[1]

'''

import pandas as pd
import numpy as np

# Remove duplicate states
df = pd.read_csv('Resources/TestCase_Ideal.csv')
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
A = 48 # m^2
for key in ['zon.roo.qGai_flow[1]','zon.roo.qGai_flow[2]','zon.roo.qGai_flow[3]']:
    df[key] = df[key]*A

# Add occupancy
df['Occupancy[1]'] = 0
df['Occupancy[1]'][df['zon.roo.qGai_flow[3]']>0]=2

# Add CO2 limit
df['UpperCO2[1]'] = 1500
df['UpperCO2[1]'][df['zon.roo.qGai_flow[3]']>0]=894

# Change names
column_map = {'zon.roo.qGai_flow[1]': 'InternalGainsRad[1]',
              'zon.roo.qGai_flow[2]': 'InternalGainsCon[1]',
              'zon.roo.qGai_flow[3]': 'InternalGainsLat[1]',
              'con.TSetCoo.y[1]': 'UpperSetp[1]',
              'con.TSetHea.y[1]': 'LowerSetp[1]'}
df = df.rename(columns=column_map)


df.to_csv('Resources/TestCase_Ideal_data.csv')
