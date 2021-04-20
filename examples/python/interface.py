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
from examples.python.custom_kpi import custom_kpi_calculator as kpicalculation
import json,collections
import pandas as pd
import importlib

def control_test(config):
    '''Run test case.

    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.
    config : string, dict
        Dictionary of control config and simulation settings.
        {attribute_name : value}

    Returns
    -------
    kpi : dict
        Dictionary of core KPI names and values.
        {kpi_name : value}
    res : dict
        Dictionary of trajectories of inputs and outputs.
    customizedkpis_result: dict
        Dictionary of tracked custom KPI calculations.
        Empty if no customized KPI calculations defined.

    '''
    # SETUP TEST CASE
    # ---------------
    # Set URL for testcase
    url = 'http://127.0.0.1:5000'
    # Set simulation parameters
    length = config['length']
    step = config['step']
    # optional customzied kpi calculation
    if "customized_kpi_config" in config:
        customized_kpi_config = config['customized_kpi_config']
    else:
        customized_kpi_config = None 
    if "prediction_config" in config:
        prediction_config = config['prediction_config']
    else:
        prediction_config = None        
    # ---------------

    # TEST CONTROLLER IMPORT
    # ----------------------
    control = importlib.import_module(config["control_module"])
    # ----------------------    

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
    customizedkpis=[] # Initialize customzied kpi calculation list
    customizedkpis_result={} # Initialize tracking of customized kpi calculation results
    if customized_kpi_config is not None:
        with open(customized_kpi_config) as f:
                config=json.load(f,object_pairs_hook=collections.OrderedDict)
        for key in config.keys():
               customizedkpis.append(kpicalculation.cutomizedKPI(config[key]))
               customizedkpis_result[kpicalculation.cutomizedKPI(config[key]).name]=[]
    customizedkpis_result['time']=[]
    # --------------------

    # RUN TEST CASE
    # -------------
    start = time.time()
    # Initialize test case
    print('Initializing test case simulation.')
    res = requests.put('{0}/initialize'.format(url), data={'start_time':0,'warmup_period':0}).json()
    if res:
        print('Successfully initialized the simulation')
    print('\nRunning test case...')
    # Set simulation step
    res = requests.put('{0}/step'.format(url), data={'step':step})
    # Initialize u
    u = control.initialize()
    # Store prediction if any
    if prediction_config is not None:
        predictions_store = pd.DataFrame(columns=prediction_config)
    else:  
        predictions_store = None    
    # Simulation Loop
    for i in range(int(length/step)):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), data=u).json()
        # Compute next control signal                
        if prediction_config is not None:
            forecast = requests.get('{0}/forecast'.format(url)).json() 
            predictions = []            
            for j in range(len(prediction_config)):
                predictions.append(forecast[prediction_config[j]][0])  
            predictions_store.loc[(i+1)*step, predictions_store.columns] = predictions                 
            u = control.compute_control(y,predictions)                
        else:                
            u = control.compute_control(y)
        # Compute customized KPIs if any
        if customized_kpi_config is not None:
             for customizedkpi in customizedkpis:
                  customizedkpi.processing_data(y) # Process data as needed for custom KPI
                  customizedkpi_value = customizedkpi.calculation() # Calculate custom KPI value
                  customizedkpis_result[customizedkpi.name].append(round(customizedkpi_value,2)) # Track custom KPI value
                  print('KPI:\t{0}:\t{1}'.format(customizedkpi.name,round(customizedkpi_value,2))) # Print custom KPI value
             customizedkpis_result['time'].append(y['time']) # Track custom KPI calculation time
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
    points = measurements.keys() + inputs.keys()
    df_res = pd.DataFrame()
    for point in points:
        res = requests.put('{0}/results'.format(url), data={'point_name':point,'start_time':0, 'final_time':length}).json()
        df_res = pd.concat((df_res,pd.DataFrame(data=res[point], index=res['time'],columns=[point])), axis=1)
    df_res.index.name = 'time'
    
    return kpi,df_res,customizedkpis_result,predictions_store