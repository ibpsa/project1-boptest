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
import numpy as np
from examples.python.custom_kpi import custom_kpi_calculator as kpicalculation
import json,collections

# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers import pid
# ----------------------

def run(plot=False, customized_kpi_config=None):
    '''Run test case.
    
    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.
    customized_kpi_config : string, optional
        The path of the json file which contains the customized kpi information.
        Default is None.

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
    length = 48*3600
    step = 300
    # ---------------
    
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
    # --------------------

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
    # Reset test case
    print('Initializing the simualation.')
    res = requests.put('{0}/initialize'.format(url), data={'start_time':0,'warmup_period':0})
    if res:
        print('Successfully initialized the simulation')
    # Set simulation step
    print('Setting simulation step to {0}.'.format(step))
    res = requests.put('{0}/step'.format(url), data={'step':step})
    print('\nRunning test case...')
    # Initialize u
    u = pid.initialize()
    # Simulation Loop
    for i in range(int(length/step)):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), data=u).json()
        # Compute next control signal
        u = pid.compute_control(y)
        # Compute customized KPIs if any
        if customized_kpi_config is not None:
             for customizedkpi in customizedkpis:
                  customizedkpi.processing_data(y) # Process data as needed for custom KPI
                  customizedkpi_value = customizedkpi.calculation() # Calculate custom KPI value
                  customizedkpis_result[customizedkpi.name].append(round(customizedkpi_value,2)) # Track custom KPI value
                  print('KPI:\t{0}:\t{1}'.format(customizedkpi.name,round(customizedkpi_value,2))) # Print custom KPI value
             customizedkpis_result['time'].append(y['time']) # Track custom KPI calculation time  
    print('\nTest case complete.')
    # -------------
        
    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    print('\nKPI RESULTS \n-----------')
    for key in kpi.keys():
        if key == 'tdis_tot':
            unit = 'Kh'
        if key == 'idis_tot':
            unit = 'ppmh'
        elif key == 'ener_tot':
            unit = 'kWh'
        elif key == 'cost_tot':
            unit = 'euro or $'
        elif key == 'emis_tot':
            unit = 'kg CO2'
        elif key == 'time_rat':
            unit = ''
        print('{0}: {1} {2}'.format(key, kpi[key], unit))
    # ------------ 
        
    # POST PROCESS RESULTS
    # --------------------
    # Get result data
    res = requests.get('{0}/results'.format(url)).json()
    time = [x/3600 for x in res['y']['time']] # convert s --> hr
    TZone = [x-273.15 for x in res['y']['TRooAir_y']] # convert K --> C
    PHeat = res['y']['PHea_y']
    QHeat = res['u']['oveAct_u']
    # Plot results
    if plot:
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperature')
        plt.plot(time, TZone)
        plt.plot(time, 20*np.ones(len(time)), '--')
        plt.plot(time, 23*np.ones(len(time)), '--')
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.figure(2)
        plt.title('Heater Power')
        plt.plot(time, PHeat)
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.show()
    # --------------------
            
    return kpi,res,customizedkpis_result 

if __name__ == "__main__":
    kpi,res,customizedkpis_result = run(customized_kpi_config='custom_kpi/custom_kpis_example.config')