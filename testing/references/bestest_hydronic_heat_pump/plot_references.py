#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 25 10:16:32 2020

@author: dhbubu18
"""

import pandas as pd
from matplotlib import pyplot as plt

csv = 'results_winter'
df_test = pd.read_csv(csv+'.csv', index_col='time')
df_old = pd.read_csv(csv+'_old.csv', index_col='time')
for key in df_old.columns.to_list():
    plt.figure()
    plt.plot(df_old.index, df_old[key], label='old', linewidth=4)
    plt.plot(df_test.index, df_test[key], label='test', linewidth=2)
    plt.legend()
    plt.title(key)
plt.show()
