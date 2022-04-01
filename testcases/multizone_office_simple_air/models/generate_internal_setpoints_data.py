#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This script generates internal load and set point data for data.csv in BOPTEST.
Simulate the test case and output in sim.csv the following variables:

    flo.zone.qGai_flow[x] for all x in [1-3] and all zone in zones
    flo.intGaiFra.y
    hvac.occSch.occupied

"""

import pandas as pd

mapper_names = {'qGai_flow[1]':'InternalGainsRad',
                'qGai_flow[2]':'InternalGainsCon',
                'qGai_flow[3]':'InternalGainsLat'}
mapper_zones = {'nor.':'nor',
                'sou.':'sou',
                'eas.':'eas',
                'wes.':'wes',
                'cor.':'cor'}

area = {'nor':207.58, # m^2
        'sou':207.58,
        'eas':131.416,
        'wes':131.416,
        'cor':984.672}

df = pd.read_csv('sim.csv',index_col='Time')

# Internal Loads
mapper = {}
for key in df.columns:
    for name in mapper_names.keys():
        if name in key:
            for zone in mapper_zones.keys():
                if zone in key.lower():
                    mapper[key] = mapper_names[name]+'[{0}]'.format(mapper_zones[zone])
                    if 'qGai_flow' in key:
                        df[key] = df[key].values*area[mapper_zones[zone]]
df = df.rename(columns=mapper)
df.index.name = 'time'

# Set points
for zone in mapper_zones.keys():
    df['LowerSetp[{0}]'.format(mapper_zones[zone])] = 12
    df['LowerSetp[{0}]'.format(mapper_zones[zone])][df['hvac.occSch.occupied']>0] = 20
    df['UpperSetp[{0}]'.format(mapper_zones[zone])] = 30
    df['UpperSetp[{0}]'.format(mapper_zones[zone])][df['hvac.occSch.occupied']>0] = 24
    df['UpperCO2[{0}]'.format(mapper_zones[zone])] = 894

# Occupancy
density = 0.05
for key in df.columns:
    if 'flo.intGaiFra.y[1]' in key:
        for zone in area.keys():
            df['Occupancy[{0}]'.format(zone)] = (df[key].values*area[zone]*density).astype(int)

df = df.drop(columns=['hvac.occSch.occupied'])
df = df.drop(columns=['flo.intGaiFra.y[1]'])
df = df.drop(columns=['heaPum.heaPum.QCon_flow'])
df = df.drop(columns=['chi.chi.QEva_flow'])
df.to_csv('Resources/internal_setpoints_occupancy.csv')
