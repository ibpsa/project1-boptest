# -*- coding: utf-8 -*-
"""
This script demonstrates baseline testing of test case called "multizone_residential_hydronic".

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import sys
import os
sys.path.insert(0, '/'.join((os.path.dirname(os.path.abspath(__file__))).split('/')[:-3]))
from examples.python.interface import control_test
import pandas as pd
import json
import itertools
import datetime as dt
import time


def run(modelname, scenario, plot=False):
    """Run test case.
    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.

    Returns
    -------
    kpi : dict
        Dictionary of core KPI names and values.
        {kpi_name : value}
    res : dict
        Dictionary of trajectories of inputs and outputs.
    custom_kpi_result: dict
        Dictionary of tracked custom KPI calculations.
        Empty if no customized KPI calculations defined.

    """

    # RUN THE CONTROL TEST
    # --------------------
    control_module = 'examples.python.controllers.{}'.format(modelname)
    step = 300

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                                  scenario=scenario,
                                                                  step=step)

    # POST-PROCESS RESULTS
    # --------------------
    time = df_res.index.values / 3600  # convert s --> hr
    zone_temperature = df_res['conHeaLiv_reaTZon_y'].values - 273.15  # convert K --> C
    # Plot results
    if plot:
        try:
            from matplotlib import pyplot as plt
            import numpy as np
            plt.figure(1)
            plt.title('Zone Temperature')
            plt.plot(time, zone_temperature)
            plt.plot(time, 20 * np.ones(len(time)), '--')
            plt.plot(time, 23 * np.ones(len(time)), '--')
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")

    return kpi, df_res, custom_kpi_result


if __name__ == "__main__":

    modelname='multizone_residential_hydronic'
    
    #Specify the baseline scenarios
    price_elec=['constant','dynamic','highly_dynamic']
    time_period=['peak_heat_day', 'typical_heat_day']

    scenario_lst=list(itertools.product(price_elec, time_period))
    scenario_name_lst= [scenario[0]+'+'+scenario[1] for scenario in scenario_lst]
    
    kpi_scenario_lst=[]
    #df_res_scenario_lst=[]
    
    for scenario in scenario_lst:
        scenario = {'time_period': scenario[1], 'electricity_price': scenario[0]}
        kpi, df_res, custom_kpi_result = run(modelname,scenario)
        print("Finished testing",scenario)        
        kpi_scenario_lst.append(kpi)
        #df_res_scenario_lst.append(df_res)
    
    #Save kpi
    df_kpi=pd.DataFrame(kpi_scenario_lst, index=scenario_name_lst)
    df_kpi.to_csv (r'df_kpi_{}.csv'.format(modelname), header=True)
    
    #Save measurements
    #writer=pd.ExcelWriter(r'df_res_{}.xlsx'.format(modelname))
    #for i, df_res_scenario in enumerate(df_res_scenario_lst):
        #df_res_scenario.to_excel(writer,sheet_name="{0}".format(scenario_name_lst[i]))