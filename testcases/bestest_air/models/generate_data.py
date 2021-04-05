'''
Created on Feb 20, 2020

@author: Javier Arroyo
'''

from data.data_generator import Data_Generator
import os
import pandas as pd
from pymodelica import compile_fmu
from pyfmi import load_fmu
from scipy import interpolate
import numpy as np

#=====================================================================
# Generate variables from model
#=====================================================================

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
