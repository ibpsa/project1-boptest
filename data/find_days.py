#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 13:20:58 2021
@author: dhbubu18

Module to perform a test case yearly simulation and find the peak and
typical days for heating and cooling. These days are used to define
the test case scenarios. The case needs to be deployed if the data is
to be simulated.

"""

import subprocess
import pandas as pd
import os
import numpy as np

def find_days(heat, cool, data='simulate', img_name='boptest_bestest_air',
              plot = False):
    '''Find the start and final times for the test case scenarios.

    Parameters
    ----------
    heat: string
        Column for heating load [W] that will be used to find the
        peak and typical heating days of the year
    cool: string
        Column for cooling load [W] that will be used to find the
        peak and typical cooling days of the year
    data: string
        Options are:
        `simulate` in which case the model is simulated for one year
        to generate the data.
        `path_to_data.csv` indicates path to .csv file with the yearly
        simulation data.
    img_name: string
        Image name of the container where the simulation is to be
        performed.
    plot: boolean
        Set to True to show an overview of the days found

    Returns
    -------
    days: dictionary
        Dictionary with days found

    '''

    days = {}

    if data=='simulate':

        length = 3.1536e+7
        start_time = 0

        # Simulate in container
        if heat is not None and cool is not None:
            points = heat+','+cool
        elif heat is not None and cool is None:
            points = heat
        elif heat is None and cool is not None:
            points = cool
        cmd_docker ='docker exec -t {} /bin/bash -c '.format(img_name).split()
        cmd_python = ['python data/simulate_skip_API.py {} {} {}'.format(start_time,length,points)]
        cmd = cmd_docker + cmd_python
        subprocess.call(cmd)

        # Copy results to host
        cmd='docker cp {}:/home/developer/simulation.csv .'.format(img_name)
        subprocess.call(cmd)

        # Read results to data frame
        df_raw = pd.read_csv('simulation.csv', index_col='Time')

    elif os.path.isfile(data) and data.endswith('.csv'):
        df_raw = pd.read_csv(data, index_col='Time')

    else:
        raise Exception('The data argument should be either the <simulate>'/
                        'string keyword or a path to a .csv file containing'/
                        'the yearly model simulation data. ')

    # Load data
    df_raw.index = pd.TimedeltaIndex(df_raw.index.values, unit='s')
    df = df_raw.resample('15T').mean()
    df.dropna(axis=0, inplace=True)
    # Since assume two-week test period with one-week warmup,
    # edges of year are not available to choose from
    df_available = df.loc[pd.Timedelta(days=14):pd.Timedelta(days=365-7)]


    # Find peak
    if heat is not None:
        peak_heat_day = df_available[heat].idxmax().days
        days['peak_heat_day'] = peak_heat_day
        print('Peak heat is day {0}.'.format(peak_heat_day))

    if cool is not None:
        peak_cool_day = df_available[cool].idxmax().days
        days['peak_cool_day'] = peak_cool_day
        print('Peak cool is day {0}.'.format(peak_cool_day))

    # Find typical
    df_daily = df.resample('D').max()
    df_available_daily = df_available.resample('D').max()

    if heat is not None:
        median_heat = df_daily[heat][df_daily[heat]>1].median()
        typical_heat_day = df_available_daily[heat][df_available_daily[heat].values <= median_heat].sort_values(ascending=False).index[0].days
        days['typical_heat_day'] = typical_heat_day
        print('Typical heat is day {0}.'.format(typical_heat_day))

    if cool is not None:
        median_cool = df_daily[cool][df_daily[cool]>1].median()
        typical_cool_day = df_available_daily[cool][df_available_daily[cool].values <= median_cool].sort_values(ascending=False).index[0].days
        days['typical_cool_day'] = typical_cool_day
        print('Typical cool is day {0}.'.format(typical_cool_day))

    # Find heat cool mix
    if (heat is not None) and (cool is not None):
        df_available_daily_sum = pd.DataFrame(index=df_available_daily.index, columns=df_available_daily.columns)
        # For every day, integrate heating and cooling load
        for d in df_available_daily.index:
            for c in df_available_daily_sum.columns:
                df_available_daily_sum.loc[d,c] = np.trapz(df_raw[c][df_raw.index.days==d.days], df_raw.index.seconds[df_raw.index.days==d.days])
        # Calculate mix day
        mix = df_available_daily_sum[heat]+df_available_daily_sum[cool]-abs(df_available_daily_sum[heat]-df_available_daily_sum[cool])
        mix_day = mix.astype(float).idxmax().days
        days['mix_day'] = mix_day
        print('Mix is day {0}.'.format(mix_day))

    if plot:
        from matplotlib import pyplot as plt
        time_days = df.index.total_seconds()/3600./24.
        if heat is not None:
            plt.figure()
            plt.title('Heating load')
            plt.plot(time_days, df[heat])
            plt.xlabel('Day of the year')
            plt.ylabel('[W]')
            plt.axvline(x=peak_heat_day, color='r', label='Peak')
            plt.axhline(y=df[heat].max(), color='r', label='_nolegend_')
            plt.axvline(x=typical_heat_day, color='r', linestyle='--', label='Typical')
            plt.axhline(y=median_heat, color='r', linestyle='--', label='_nolegend_')
            plt.legend()
            plt.show()

        if cool is not None:
            plt.figure()
            plt.title('Cooling load')
            plt.plot(time_days, df[cool])
            plt.xlabel('Day of the year')
            plt.ylabel('[W]')
            plt.axvline(x=peak_cool_day, color='r', label='Peak')
            plt.axhline(y=df[cool].max(), color='r', label='_nolegend_')
            plt.axvline(x=typical_cool_day, color='r', linestyle='--', label='Typical')
            plt.axhline(y=median_cool, color='r', linestyle='--', label='_nolegend_')
            plt.legend()
            plt.show()

    return days

if __name__ == "__main__":
    find_days(heat='reaPHeaPum_y', cool=None, data='simulate')
