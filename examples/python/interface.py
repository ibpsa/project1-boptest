# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.  A controller is tested, which is
imported from a different module.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import requests
import time
import numpy as np
from examples.python.custom_kpi.custom_kpi_calculator import CustomKPI
from examples.python.controllers.controller import Controller
import json
import collections
import pandas as pd


def control_test(length=24*3600, step=300, control_module='', customized_kpi_config=None, forecast_config=None, scenario=None):
    """Run test case.

    Parameters
    ----------

    length: int
        Simulation duration in seconds (e.g., 24*3600 is a 1 day simulation).
        Default is 24*3600 (1-day).
    step: int
        Simulation step size in seconds.
        Default is 300.
    control_module: str
        relative path to controller code without .py suffix (e.g., 'controllers.sup')
        Default is '' (required).
    customized_kpi_config: str
        relative path to custom KPI (e.g., 'custom_kpi.custom_kpis_example.config')
        default is None.
    forecast_config: list, str
        List of strings.  Each element is a point that will be passed to the /forecast restful call.
        Default is None.

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
    # SETUP TEST CASE
    # ---------------
    # Set URL for testcase
    url = 'http://127.0.0.1:5000'
    # Set simulation parameters
    forecasts_store = None
    if forecast_config is not None:
        forecasts_store = pd.DataFrame(columns=forecast_config)
    control = Control(control_module, forecast_config)

    # GET TEST INFORMATION
    # --------------------
    print('\nTEST CASE INFORMATION\n---------------------')
    # Test case name
    name = requests.get('{0}/name'.format(url)).json()
    print('Name:\t\t\t\t{0}'.format(name))
    # Inputs available
    inputs = requests.get('{0}/inputs'.format(url)).json()
    print('Control Inputs:\t\t\t{0}'.format(inputs))
    # Measurements available
    measurements = requests.get('{0}/measurements'.format(url)).json()
    print('Measurements:\t\t\t{0}'.format(measurements))
    # Default simulation step
    step_def = requests.get('{0}/step'.format(url)).json()
    print('Default Simulation Step:\t{0}'.format(step_def))

    # Define customized KPI if any
    custom_kpis = []  # Initialize customized kpi calculation list
    custom_kpi_result = {}  # Initialize tracking of customized kpi calculation results
    if customized_kpi_config is not None:
        with open(customized_kpi_config) as f:
            config = json.load(f, object_pairs_hook=collections.OrderedDict)
        for key in config.keys():
            custom_kpis.append(CustomKPI(config[key]))
            custom_kpi_result[CustomKPI(config[key]).name] = []
    custom_kpi_result['time'] = []
    # --------------------

    # RUN TEST CASE
    # -------------
    start = time.time()
    # Initialize test case
    print('Initializing test case simulation.')
    if scenario is not None:
        res = requests.put('{0}/scenario'.format(url), data=scenario).json()['time_period']
        # Record test start time
        start_time = res['time']
        final_time = np.inf
        total_time_steps = int((365 * 24 * 3600)/step)
    else:
        res = requests.put('{0}/initialize'.format(url), data={'start_time': 0, 'warmup_period': 0}).json()
        start_time = 0
        final_time = length
        total_time_steps = int(length / step)  # calculate number of timesteps
    if res:
        print('Successfully initialized the simulation')
    print('\nRunning test case...')
    # Set simulation step
    res = requests.put('{0}/step'.format(url), data={'step': step})
    # Initialize u
    u = controller.initialize()
    # Store forecast if any
    # Simulation Loop
    predictions = None
    for timestep in range(total_time_steps):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), data=u).json()
        if not y:
            break
        if control.use_forecast:
            forecast_data = requests.get('{0}/forecast'.format(url)).json()
            # Compute next control signal
            forecasts = control.update_forecasts(forecast_config, forecast_data)
            if forecasts_store is not None:
                forecasts_store.loc[(timestep + 1) * step, forecasts_store.columns] = forecasts
        u = control.compute_control(y, forecasts)
        # Compute customized KPIs if any
        for kpi in custom_kpis:
            kpi.processing_data(y)  # Process data as needed for custom KPI
            custom_kpi_value = kpi.calculation()  # Calculate custom KPI value
            custom_kpi_result[kpi.name].append(round(custom_kpi_value, 2))  # Track custom KPI value
            print('KPI:\t{0}:\t{1}'.format(kpi.name, round(custom_kpi_value, 2)))  # Print custom KPI value
        custom_kpi_result['time'].append(y['time'])  # Track custom KPI calculation time
    print('\nTest case complete.')
    print('Elapsed time of test was {0} seconds.'.format(time.time()-start))
    # -------------

    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    print('\nKPI RESULTS \n-----------')
    for key in kpi.keys():
        if key == 'ener_tot':
            unit = 'kWh'
        elif key == 'tdis_tot':
            unit = 'Kh'
        elif key == 'idis_tot':
            unit = 'ppmh'
        elif key == 'cost_tot':
            unit = 'Euro or $'
        elif key == 'emis_tot':
            unit = 'KgCO2'
        elif key == 'time_rat':
            unit = 'KgCO2'            
        else:
            unit = None
        print('{0}: {1} {2}'.format(key, kpi[key], unit))
    # ------------

    # POST PROCESS RESULTS
    # --------------------
    # Get result data
    points = list(measurements.keys()) + list(inputs.keys())
    df_res = pd.DataFrame()
    for point in points:
        res = requests.put('{0}/results'.format(url), data={'point_name': point, 'start_time': start_time, 'final_time': final_time}).json()
        df_res = pd.concat((df_res, pd.DataFrame(data=res[point], index=res['time'], columns=[point])), axis=1)
    df_res.index.name = 'time'
    
    return kpi, df_res, custom_kpi_result, forecasts_store

