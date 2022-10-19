# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import requests
import sys
import time
import numpy as np
import json
import collections
import pandas as pd
# ----------------------

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


def run(start_time=0, warmup_period=0, length=24*3600, step=60):
    '''Run test case.

    Parameters
    ----------
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
    step: int, optional
        Simulation step size in seconds.
        Default is 60.
    Returns
    -------
    None

    '''

    # SETUP TEST
    # -------------------------------------------------------------------------
    # Set URL for testcase
    url = 'http://127.0.0.1:5000'

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


    # RUN TEST CASE
    # -------------------------------------------------------------------------
    # Record real starting time
    start = time.time()
    # Initialize test case
    print('Initializing test case simulation.')

    # Initialize test with a specified start time and warmup period
    res = check_response(requests.put('{0}/initialize'.format(url), data={'start_time': start_time, 'warmup_period': warmup_period}))
    print("RESULT: {}".format(res))
    # Set final time and total time steps according to specified length (seconds)
    final_time = start_time + length
    total_time_steps = int(length / step)  # calculate number of timesteps
    if res:
        print('Successfully initialized the simulation')
    print('\nRunning test case...')
    # Set simulation time step
    res = check_response(requests.put('{0}/step'.format(url), data={'step': step}))


    # Simulation Loop
    for t in range(total_time_steps):
        # Advance simulation with control input value(s)
        y = check_response(requests.post('{0}/advance'.format(url)))
        # If simulation is complete break simulation loop
        if not y:
            break

    print('\nTest case complete.')
    print('Elapsed time of test was {0} seconds.'.format(time.time()-start))

    # VIEW RESULTS
    # -------------------------------------------------------------------------


    # POST PROCESS RESULTS
    # -------------------------------------------------------------------------
    # Get result data
    points = list(measurements.keys()) + list(inputs.keys())
    df_res = pd.DataFrame()
    for point in points:
        res = check_response(requests.put('{0}/results'.format(url), data={'point_name': point, 'start_time': start_time, 'final_time': final_time}))
        df_res = pd.concat((df_res, pd.DataFrame(data=res[point], index=res['time'], columns=[point])), axis=1)
    df_res.index.name = 'time'
    
    return df_res


if __name__ == "__main__":
    df_res = run(start_time=17107200, warmup_period=0, length=24*3600, step=300)
    df_res.to_csv("df_res.csv")
