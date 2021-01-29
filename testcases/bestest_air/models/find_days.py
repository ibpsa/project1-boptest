#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 13:20:58 2021

@author: dhbubu18
"""

import pandas as pd

csv_filepath = 'TestCase_Ideal.csv' # csv file containing model results (with Time as index column in seconds)
heat = 'fcu.powHeaThe.y' # Column for heating load [W]
cool = 'fcu.powCooThe.y' # Column for cooling load [W]

# Load data
df = pd.read_csv(csv_filepath, index_col='Time')
df.index = pd.TimedeltaIndex(df.index.values, unit='s')
df = df.resample('15T').mean()
df = df.loc[pd.Timedelta(days=7):pd.Timedelta(days=365-7)]
print(df)
# Find peak
peak_heat = df[heat].idxmax().days
peak_cool = df[cool].idxmax().days
print('Peak heat is day {0}.  Peak cool is day {1}.'.format(peak_heat, peak_cool))

# Find typical
df = df.resample('D').max()
median_heat = df[heat][df[heat]>1].median()
median_cool = df[cool][df[cool]>1].median()
df[heat][df[heat].values <= median_heat].sort_values(ascending=False).index[0].days
typical_heat = df[heat][df[heat].values <= median_heat].sort_values(ascending=False).index[0].days
typical_cool = df[cool][df[cool].values <= median_cool].sort_values(ascending=False).index[0].days
print('Typical heat is day {0}.  Typical cool is day {1}.'.format(typical_heat, typical_cool))
