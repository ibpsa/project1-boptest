#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 13:20:58 2021
@author: dhbubu18

Module to perform a test case yearly simulation and find the peak and
typical days for heating and cooling. These days are used to define
the test case scenarios. BOPTEST needs to be deployed if the data is
to be simulated.

The ``find_days`` class should be imported to a script within the 
``models`` directory of a test case, since
parameters are specific to each test case.  For that test case specific script:

To run only post processing to find days (simulation data exported otherwise):
1. Create a csv file of annual simulation data with all needed points
2. Set 'data' parameter to the simulation data file name (e.g. ``simulation.csv``)
3. Set 'heat' and 'cool' parameters to point names that neeed to be used to 
   evaluate heating and cooling demand, along with any other parameters.
4. Run script

To run with simulation:
1. Build BOPTEST worker docker image
2. Set 'heat' and 'cool' parameters to point names that neeed to be used to 
   evaluate heating and cooling demand
3. Ensure the test case FMU is called ``wrapped.fmu`` within the test case models directory
4. Run script

"""

import subprocess
import pandas as pd
import os
import numpy as np

def find_days(heat, cool, data='simulate', plot=False, cooling_negative=False, 
              peak_cool_restriction_hour=None,
              cool_day_low_limit=14, cool_day_high_limit=358,
              heat_day_low_limit=14, heat_day_high_limit=358):
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
        Default is `simulate`.
    plot: boolean, optional
        Set to True to show an overview of the days found.
        Default is False
    cooling_negative: boolean, optional
        Set to True if cooling heat flow data is negative in simulation or data file.
        Default is False.
    peak_cool_restriction_hour: integer, optional
        Hour if want peak cooling loads to only be considered equal to or after the hour
        each day.  This can be useful to avoid including hours with peak
        cooling loads due to morning start up, which may lead to the
        same peak load for many different days.  None will have no restrictions.
        Default is None.
    cool_day_low_limit: integer, optional
        Day below which should not be considered for cooling.
        Must be >= 14.
        Default = 14.
    cool_day_high_limit: integer, optional
        Day below which should not be considered for cooling.
        Must be <= 358.
        Default = 358.
    heat_day_low_limit: integer, optional
        Day below which should not be considered for heating.
        Must be >= 14.
        Default = 14.
    heat_day_high_limit: integer, optional
        Day below which should not be considered for heating.
        Must be <= 358.
        Default = 358.

    Returns
    -------
    days: dictionary
        Dictionary with days found

    '''

    days = {}

    if data == 'simulate':

        length = 3.1536e+7
        start_time = 0

        # Simulate in container
        if heat is not None and cool is not None:
            points = heat+','+cool
        elif heat is not None and cool is None:
            points = heat
        elif heat is None and cool is not None:
            points = cool
        
        # Create container from worker image and copy FMU
        print('Creating container find_days...')
        cmd_docker_container = 'docker run -t --name find_days -d project1-boptest-worker /bin/bash'.split()
        print('Copying FMU into container...')
        subprocess.call(cmd_docker_container)
        cmd_docker_cp = 'docker cp wrapped.fmu find_days:/boptest/wrapped.fmu'.split()
        subprocess.call(cmd_docker_cp)
        print('Running simulation ...')
        # Run simulation for target 'length'
        cmd_docker ='docker exec -t find_days /bin/bash -c '.split()
        cmd_python = ['. miniconda/bin/activate && conda activate pyfmi3 && cd boptest && python lib/data/simulate_skip_API.py {} {} {}'.format(start_time,length,points)]
        cmd_sim = cmd_docker + cmd_python
        subprocess.call(cmd_sim)
        print('Copying results simulation.csv from running container...')
        # Copy results to host
        cmd_cp_res = 'docker cp find_days:/boptest/simulation.csv .'.split()
        subprocess.call(cmd_cp_res)
        print('Removing container...')
        # Remove container
        cmd_docker_rm = 'docker rm --force find_days'.split()
        subprocess.call(cmd_docker_rm)
        

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
    if cooling_negative:
        df_raw[cool] = -df_raw[cool]
    df = df_raw.resample('15T').mean()
    df.dropna(axis=0, inplace=True)
    # Since assume two-week test period with one-week warmup,
    # edges of year are not available to choose from
    df_available =  df.loc[pd.Timedelta(days=14):pd.Timedelta(days=365-7)]



    # Find peak
    if heat is not None:
        df_available_heat = df[heat].loc[pd.Timedelta(days=heat_day_low_limit):pd.Timedelta(days=heat_day_high_limit)]
        df_heat = df[heat]
        peak_heat_day = df_available_heat.idxmax().days
        days['peak_heat_day'] = peak_heat_day
        print('Peak heat is day {0}.'.format(peak_heat_day))

    if cool is not None:
        df_available_cool = df[cool].loc[pd.Timedelta(days=cool_day_low_limit):pd.Timedelta(days=cool_day_high_limit)]
        df_cool = df[cool]
        if peak_cool_restriction_hour is not None:
            # Limit available cooling hours to those after restriction
            df_available_cool = df_available_cool[df_available_cool.index.seconds/3600>=peak_cool_restriction_hour]
            df_cool = df_cool[df_cool.index.seconds/3600>=peak_cool_restriction_hour]
        peak_cool_day = df_available_cool.idxmax().days
        days['peak_cool_day'] = peak_cool_day
        print('Peak cool is day {0}.'.format(peak_cool_day))

    # Find typical
    if heat is not None:
        df_daily_heat = df_heat.resample('D').max()
        df_available_daily_heat = df_available_heat.resample('D').max()
        median_heat = df_daily_heat[df_daily_heat>1].median()
        typical_heat_day = df_available_daily_heat[df_available_daily_heat.values <= median_heat].sort_values(ascending=False).index[0].days
        days['typical_heat_day'] = typical_heat_day
        print('Typical heat is day {0}.'.format(typical_heat_day))

    if cool is not None:
        df_daily_cool = df_cool.resample('D').max()
        df_available_daily_cool = df_available_cool.resample('D').max()
        median_cool = df_daily_cool[df_daily_cool>1].median()
        typical_cool_day = df_available_daily_cool[df_available_daily_cool.values <= median_cool].sort_values(ascending=False).index[0].days
        days['typical_cool_day'] = typical_cool_day
        print('Typical cool is day {0}.'.format(typical_cool_day))

    # Find heat cool mix
    df_available_daily = df_available.resample('D').sum()
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
            plt.plot(time_days, df_heat)
            plt.xlabel('Day of the year')
            plt.ylabel('[W]')
            plt.axvline(x=peak_heat_day, color='r', label='Peak')
            plt.axhline(y=df_available_heat.max(), color='r', label='_nolegend_')
            plt.axvline(x=typical_heat_day, color='r', linestyle='--', label='Typical')
            plt.axhline(y=median_heat, color='r', linestyle='--', label='_nolegend_')
            plt.legend()

        if cool is not None:
            plt.figure()
            plt.title('Cooling load')
            plt.plot(time_days, df_cool)
            plt.xlabel('Day of the year')
            plt.ylabel('[W]')
            plt.axvline(x=peak_cool_day, color='r', label='Peak')
            plt.axhline(y=df_available_cool.max(), color='r', label='_nolegend_')
            plt.axvline(x=typical_cool_day, color='r', linestyle='--', label='Typical')
            plt.axhline(y=median_cool, color='r', linestyle='--', label='_nolegend_')
            plt.legend()

        plt.show()

    return days

if __name__ == "__main__":
    find_days(heat='reaPHeaPum_y', cool=None, data='simulate')