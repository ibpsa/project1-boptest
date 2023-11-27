# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which must already be running.  A controller is tested, which is
imported from a different module.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import requests
import sys
import time
import numpy as np
import requests
from examples.python.custom_kpi.custom_kpi_calculator import CustomKPI
from examples.python.controllers.controller import Controller
import json
import collections
import pandas as pd


def check_response(response):
    """Check status code from restful API and return result if no error

    Parameters
    ----------

    response: obj, response object

    Returns
    -------
    result : dict, result from call to restful API

    """
    if isinstance(response, requests.Response):
        status = response.status_code
    if status == 200:
        response = response.json()['payload']
        return response
    print("Unexpected error: {}".format(response.text))
    print("Exiting!")
    sys.exit()


def control_test(control_module='', start_time=0, warmup_period=0, length=24*3600, scenario=None, step=300, customized_kpi_config=None, use_forecast=False):
    """
    Main interface that executes communication between testcase (controller) and the restufl API communicating with
        the model (FMU) running in docker.

    Parameters
    ----------

    control_module: str
        relative path to controller code without .py suffix (e.g., 'controllers.sup').
    start_time: int, optional
        Simulation start time in seconds from midnight January 1st.
        Not used if scenario defined.
        Default is 0.
    warmup_period: int, optional
        Simulation warmup-period in seconds before start_time.
        Not used if scenario defined.
        Default is 0.
    length: int, optional
        Simulation duration in seconds (e.g., 24*3600 is a 1 day simulation).
        Not used if scenario defined.
        Default is 24*3600 (1-day).
    scenario: dict, optional
        Dictionary defining the predefined test scenario.
        {'time_period': str, 'electricity_price': str}.
        If specified, start_time, warmup_period, and length not used.
        Default is None.
    step: int, optional
        Simulation step size in seconds.
        Default is 300.
    customized_kpi_config: str, optional
        relative path to custom KPI (e.g., 'custom_kpi.custom_kpis_example.config')
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
    forecasts : structure depends on controller
        Forecasts used to calculate control.
        None if controller does not use forecasts.

    """

    # SETUP TEST
    # -------------------------------------------------------------------------
    # Set URL for testcase
    url = 'http://127.0.0.1:5000'
    # Instantiate concrete controller (pid, pidTwoZones, sup, etc.)
    controller = Controller(control_module, use_forecast)

    # GET TEST INFORMATION
    # -------------------------------------------------------------------------
    print('\nTEST CASE INFORMATION\n---------------------')
    # Retrieve testcase name from REST API
    name = check_response(requests.get('{0}/name'.format(url)))
    print('Name:\t\t\t\t{0}'.format(name))
    # Retrieve a list of inputs (controllable points) for the model from REST API
    inputs = check_response(requests.get('{0}/inputs'.format(url)))
    print('Control Inputs:\t\t\t{0}'.format(inputs))
    # Retrieve a list of measurements (outputs) for the model from REST API
    measurements = check_response(requests.get('{0}/measurements'.format(url)))
    print('Measurements:\t\t\t{0}'.format(measurements))
    # Get the default simulation timestep for the model for simulation run
    step_def = check_response(requests.get('{0}/step'.format(url)))
    print('Default Control Step:\t{0}'.format(step_def))

    # IF ANY CUSTOM KPI CALCULATION, DEFINE STRUCTURES
    # ------------------------------------------------
    custom_kpis = []  # Initialize customized kpi calculation list
    custom_kpi_result = {}  # Initialize tracking of customized kpi calculation results
    if customized_kpi_config is not None:
        with open(customized_kpi_config) as f:
            config = json.load(f, object_pairs_hook=collections.OrderedDict)
        for key in config.keys():
            custom_kpis.append(CustomKPI(config[key]))
            custom_kpi_result[CustomKPI(config[key]).name] = []
    custom_kpi_result['time'] = []

    # RUN TEST CASE
    # -------------------------------------------------------------------------
    # Record real starting time
    start = time.time()
    # Initialize test case
    print('Initializing test case simulation.')
    if scenario is not None:
        # Initialize test with a scenario time period
        res = check_response(requests.put('{0}/scenario'.format(url), json=scenario))['time_period']
        print(res)
        # Record test simulation start time
        start_time = int(res['time'])
        # Set final time and total time steps to be very large since scenario defines length
        final_time = np.inf
        total_time_steps = int((365 * 24 * 3600)/step)
    else:
        # Initialize test with a specified start time and warmup period
        res = check_response(requests.put('{0}/initialize'.format(url), json={'start_time': start_time, 'warmup_period': warmup_period}))
        print("RESULT: {}".format(res))
        # Set final time and total time steps according to specified length (seconds)
        final_time = start_time + length
        total_time_steps = int(length / step)  # calculate number of timesteps
    if res:
        print('Successfully initialized the simulation')
    print('\nRunning test case...')
    # Set simulation time step
    res = check_response(requests.put('{0}/step'.format(url), json={'step': step}))
    # Initialize input to simulation from controller
    u = controller.initialize()
    # Initialize forecast storage structure
    forecasts = None
    print(requests.get('{0}/scenario'.format(url)).json())
    # Simulation Loop
    for t in range(total_time_steps):
        # Advance simulation with control input value(s)
        y = check_response(requests.post('{0}/advance'.format(url), json=u))
        # If simulation is complete break simulation loop
        if not y:
            break
        # If custom KPIs are configured, compute the KPIs
        for kpi in custom_kpis:
            kpi.processing_data(y)  # Process data as needed for custom KPI
            custom_kpi_value = kpi.calculation()  # Calculate custom KPI value
            custom_kpi_result[kpi.name].append(round(custom_kpi_value, 2))  # Track custom KPI value
            print('KPI:\t{0}:\t{1}'.format(kpi.name, round(custom_kpi_value, 2)))  # Print custom KPI value
        custom_kpi_result['time'].append(y['time'])  # Track custom KPI calculation time
        # If controller needs a forecast, get the forecast data and provide the forecast to the controller
        if controller.use_forecast:
            # Retrieve forecast from restful API
            forecast_parameters = controller.get_forecast_parameters()
            forecast_data = check_response(requests.put('{0}/forecast'.format(url), json=forecast_parameters))
            # Use forecast data to update controller-specific forecast data
            forecasts = controller.update_forecasts(forecast_data, forecasts)
        else:
            forecasts = None
        # Compute control signal input to simulation for the next timestep
        u = controller.compute_control(y, forecasts)
    print('\nTest case complete.')
    print('Elapsed time of test was {0} seconds.'.format(time.time()-start))

    # VIEW RESULTS
    # -------------------------------------------------------------------------
    # Report KPIs
    kpi = check_response(requests.get('{0}/kpi'.format(url)))
    print('\nKPI RESULTS \n-----------')
    for key in kpi.keys():
        if key == 'ener_tot':
            unit = 'kWh/m$^2$'
        elif key == 'pele_tot':
            unit = 'kW/m$^2$'
        elif key == 'pgas_tot':
            unit = 'kW/m$^2$'
        elif key == 'pdih_tot':
            unit = 'kW/m$^2$'
        elif key == 'tdis_tot':
            unit = 'Kh/zone'
        elif key == 'idis_tot':
            unit = 'ppmh/zone'
        elif key == 'cost_tot':
            unit = 'Euro or \$/m$^2$'
        elif key == 'emis_tot':
            unit = 'KgCO2/m$^2$'
        elif key == 'time_rat':
            unit = 's/s'
        else:
            unit = None
        print('{0}: {1} {2}'.format(key, kpi[key], unit))

    # POST PROCESS RESULTS
    # -------------------------------------------------------------------------
    # Get result data
    points = list(measurements.keys()) + list(inputs.keys())
    df_res = pd.DataFrame()
    res = check_response(requests.put('{0}/results'.format(url), json={'point_names': points, 'start_time': start_time, 'final_time': final_time}))
    df_res = pd.DataFrame.from_dict(res)
    df_res = df_res.set_index('time')
    return kpi, df_res, custom_kpi_result, forecasts
