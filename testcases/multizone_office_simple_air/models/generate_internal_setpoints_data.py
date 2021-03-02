#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  2 09:48:03 2021

@author: dhbubu18
"""

import pandas as pd
import re

mapper_names = {'qGai_flow[1]':'InternalGainsRad',
                'qGai_flow[2]':'InternalGainsCon',
                'qGai_flow[3]':'InternalGainsLat',
                'TRooHeaSet':'LowerSetp',
                'TRooCooSet':'UpperSetp'}
mapper_zones = {'nor':'North',
                'sou':'South',
                'eas':'East',
                'wes':'West',
                'cor':'Core'}

df = pd.read_csv('Resources/internal_setpoints_occupancy_sim.csv',index_col='Time')

# Internal Loads and Setpoints
mapper = {}
for key in df.columns:
    for name in mapper_names.keys():
        if name in key:
            for zone in mapper_zones.keys():
                if zone in key.lower():
                    mapper[key] = mapper_names[name]+'[{0}]'.format(mapper_zones[zone])
df = df.rename(columns=mapper)
df.index.name = 'time'

# Occupancy
lat_per = 80 # W/per
area = {'North':207.58, # m^2
        'South':207.58,
        'East':131.416,
        'West':131.416,
        'Core':984.672}
for key in df.columns:
    if 'InternalGainsLat' in key:
        zone = re.findall(r'\[([^]]*)\]', key)[0]
        df['Occupancy[{0}]'.format(zone)] = (df['InternalGainsLat[{0}]'.format(zone)].values*area[zone]/lat_per).astype(int)

# CO2 Limits
for zone in mapper_zones:
    df['UpperCO2[{0}]'.format(mapper_zones[zone])] = 894

df.to_csv('Resources/internal_setpoints_occupancy.csv')
