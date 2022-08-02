#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  2 09:48:03 2021

@author: dhbubu18
"""

import pandas as pd

summer = [6,7,8,9]
index = pd.date_range('1/1/2019', '1/1/2020', freq='H')
data = []
# Summer
df1 = pd.DataFrame(index=index, data=[], columns=['PriceElectricPowerDynamic'])
df1.index.name = 'time'
df1['PriceElectricPowerDynamic'][(df1.index.hour>=14) & (df1.index.hour<19) & (df1.index.month>=6) & (df1.index.month<=9)] = 0.12727
df1['PriceElectricPowerDynamic'][(df1.index.hour>=22) | (df1.index.hour<6) & (df1.index.month>=6) & (df1.index.month<=9)] = 0.01584
df1 = df1['PriceElectricPowerDynamic'][(df1.index.month>=6) & (df1.index.month<=9)].fillna(0.02868)

# Winter
df2 = pd.DataFrame(index=index, data=[], columns=['PriceElectricPowerDynamic'])
df2.index.name = 'time'
df2['PriceElectricPowerDynamic'][(df2.index.hour>=14) & (df2.index.hour<19) & ((df2.index.month<6) | (df2.index.month>9))] = 0.11748
df2['PriceElectricPowerDynamic'][((df2.index.hour>=22) | (df2.index.hour<6)) & ((df2.index.month<6) | (df2.index.month>9))] = 0.01629
df2 = df2['PriceElectricPowerDynamic'][(df2.index.month<6) | (df2.index.month>9)].fillna(0.02664)

# Put together and save
df = pd.concat([df1,df2]).sort_index().to_frame()
df.index.name = 'time'
df.columns = ['PriceElectricPowerDynamic']
df = df + 0.094 - 0.05158
df.index = (df.index-df.index[0]).total_seconds()
df.to_csv('Resources/electricity_prices_dynamic.csv')
