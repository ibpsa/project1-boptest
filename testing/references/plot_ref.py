#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Oct  6 07:39:17 2020

@author: dhbubu18
"""

from matplotlib import pyplot as plt
import pandas as pd
import os

name = 'bestest_air'
seasons = ['summer', 'winter', 'shoulder']

for season in seasons:
    if name == 'bestest_air':
        size = 4
        area = 48
        spec = {'fcu_reaPHea_y':{'label':'Heating (Gas)',
                                 'subplot':3,
                                 'style':'-'},
                'fcu_reaPFan_y':{'label':'Fan (Electric)',
                                 'subplot':3,
                                 'style':'-'},
                'fcu_reaPCoo_y':{'label':'Cooling (Electric)',
                                 'subplot':3,
                                 'style':'-'},
                'fcu_reaFloSup_y':{'label':'',
                                 'subplot':2,
                                 'style':'-'},
                'fcu_reaTSup_y':{'label':'',
                                 'subplot':1,
                                 'style':'-'},
                'con_reaTSetCoo_y':{'label':'Cooling Setpoint',
                                 'subplot':0,
                                 'style':'--'},
                'con_reaTSetHea_y':{'label':'Heating Setpoint',
                                 'subplot':0,
                                 'style':'--'},
                'zon_reaTRooAir_y':{'label':'Room Air',
                                 'subplot':0,
                                 'style':'-'}
                }
    elif name == 'bestest_hydronic':
        size = 3
        area = 48
        spec = {'reaQHea_y':{'label':'Heating (Gas)',
                                 'subplot':2,
                                 'style':'-'},
                'reaPPum_y':{'label':'Pump (Electric)',
                                 'subplot':2,
                                 'style':'-'},
                'reaTSetSup_y':{'label':'',
                                 'subplot':1,
                                 'style':'-'},
                'reaTSetHea_y':{'label':'Heating Setpoint',
                                 'subplot':0,
                                 'style':'--'},
                'reaTRoo_y':{'label':'Room Air',
                                 'subplot':0,
                                 'style':'-'}
                }
    elif name == 'bestest_hydronic_heat_pump':
        size = 3
        area = 13.4*17.9
        spec = {'reaPHeaPum_y':{'label':'Heat Pump (Electric)',
                                 'subplot':2,
                                 'style':'-'},
                'reaPFan_y':{'label':'Evap Fan (Electric)',
                                 'subplot':2,
                                 'style':'-'},
                'reaPPumEmi_y':{'label':'Pump (Electric)',
                                 'subplot':2,
                                 'style':'-'},
                'reaTSup_y':{'label':'',
                                 'subplot':1,
                                 'style':'-'},
                'reaTSetHea_y':{'label':'Heating Setpoint',
                                 'subplot':0,
                                 'style':'--'},
                'reaTZon_y':{'label':'Room Operative',
                                 'subplot':0,
                                 'style':'-'}
                }

    csv = os.path.join(name,'results_{0}.csv'.format(season))
    df = pd.read_csv(csv, index_col='time')
    df.index = pd.TimedeltaIndex(df.index.values, unit='s') + pd.to_datetime('1/1/2018')

    fig, ax = plt.subplots(size,1, sharex=True, figsize=[8,10])
    for key in spec:
        i = spec[key]['subplot']
        label = spec[key]['label']
        style = spec[key]['style']
        if i == 0:
            ax[i].plot(df[key].index, df[key].values-273.15, label=label, linestyle=style)
            ax[i].set_ylabel('Room Temperature [' + u"\u00b0" + 'C]')
        elif i == 1:
            ax[i].plot(df[key].index, df[key].values-273.15, label=label, linestyle=style)
            ax[i].set_ylabel('Supply Temperature [' + u"\u00b0" + 'C]')
        elif i == 2:
            if name == 'bestest_air':
                ax[i].plot(df[key].index, df[key].values, label=label, linestyle=style)
                ax[i].set_ylabel('Supply Flow [kg/s]')
            else:
                ax[i].plot(df[key].index, df[key].values/area, label=label, linestyle=style)
                ax[i].set_ylabel('Power Consumption [W/m2]')
        elif i == 3:
            ax[i].plot(df[key].index, df[key].values/area, label=label, linestyle=style)
            ax[i].set_ylabel('Power Consumption [W/m2]')
        ax[i].legend(loc='upper left', bbox_to_anchor=(1.05, 1))
    locs, labels = plt.xticks()
    time = pd.date_range(df.index[0], df.index[-1], freq='6H')
    plt.xticks(time)
    plt.xticks(rotation=45)
    plt.savefig('{0}_{1}.png'.format(name, season), bbox_inches='tight')
    plt.close('all')