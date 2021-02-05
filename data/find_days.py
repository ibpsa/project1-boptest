#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 13:20:58 2021
@author: dhbubu18

Module to perform a test case yearly simulation and find the peak and
typical days for heating and cooling. These days are used to define 
the test case scenarios. The case needs to be deployed.  

"""

import pandas as pd
import requests
import os

def find_days(heat, cool, data='simulate',
              url = 'http://127.0.0.1:5000',
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
    url: string
        url address to deployed testcase. Needed only if simulation 
        is required. 
    plot: boolean
        Set to True to show an overview of the days found
        
    Returns
    -------
    days: dictionary
        Dictionary with days found
    
    '''
    
    days = {}
    
    if data=='simulate':
        # Initialize
        requests.put('{0}/initialize'.format(url), data={'start_time':0,
                                                         'warmup_period':0})
        
        # Set simulation step to be one year
        length= 3.1536e+7 
        requests.put('{0}/step'.format(url), data={'step':length}) 
        
        # Advance simulation with baseline controller
        requests.post('{0}/advance'.format(url), data={}).json()
        
        # Initialize results data frame
        df = pd.DataFrame()
        
        # Obtain results
        points = [heat, cool]
        for point in points:
            if point is not None:
                res = requests.put('{0}/results'.format(url), 
                                   data={'point_name':point,
                                         'start_time':0, 
                                         'final_time':length}).json()
                df = pd.concat((df,pd.DataFrame(data=res[point], 
                                                index=res['time'],
                                                columns=[point])), 
                                                axis=1)
        df.index.name = 'Time'

        # Store results to file
        df.to_csv('yearly_simulation.csv')
        
    elif os.path.isfile(data) and data.endswith('.csv'):
        df = pd.read_csv(data, index_col='Time')
    
    else:
        raise Exception('The data argument should be either the <simulate>'/
                        'string keyword or a path to a .csv file containing'/
                        'the yearly model simulation data. ')
        
    # Load data
    df.index = pd.TimedeltaIndex(df.index.values, unit='s')
    df = df.resample('15T').mean()
    df = df.loc[pd.Timedelta(days=7):pd.Timedelta(days=365-7)]
    df.dropna(axis=0, inplace=True)
    print(df)
    
    # Find peak
    if heat is not None:
        peak_heat_day = df[heat].idxmax().days
        days['peak_heat_day'] = peak_heat_day
        print('Peak heat is day {0}.'.format(peak_heat_day))
    
    if cool is not None:
        peak_cool_day = df[cool].idxmax().days
        days['peak_cool_day'] = peak_cool_day
        print('Peak cool is day {0}.'.format(peak_cool_day))
    
    # Find typical
    df_daily = df.resample('D').max()
    
    if heat is not None:
        median_heat = df_daily[heat][df_daily[heat]>1].median()
        typical_heat_day = df_daily[heat][df_daily[heat].values <= median_heat].sort_values(ascending=False).index[0].days
        days['typical_heat_day'] = typical_heat_day
        print('Typical heat is day {0}.'.format(typical_heat_day))
    
    if cool is not None: 
        median_cool = df_daily[cool][df_daily[cool]>1].median()
        typical_cool_day = df_daily[cool][df_daily[cool].values <= median_cool].sort_values(ascending=False).index[0].days
        days['typical_cool_day'] = typical_cool_day
        print('Typical cool is day {0}.'.format(typical_cool_day))
        
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
    