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
import time
import pandas as pd

# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers import pidTwoZones
# ----------------------

def run(plot=False):
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
    if name['message'] == 'success':
        print('Name:\t\t\t\t{0}'.format(name['result']))
    # Inputs available
    inputs = requests.get('{0}/inputs'.format(url)).json()
    if inputs['message'] == 'success':
        print('Control Inputs:\t\t\t{0}'.format(inputs['result']))
    # Measurements available
    measurements = requests.get('{0}/measurements'.format(url)).json()
    if measurements['message'] == 'success':
        print('Measurements:\t\t\t{0}'.format(measurements['result']))
    # Default simulation step
    step_def = requests.get('{0}/step'.format(url)).json()
    if step_def['message'] == 'success':
        print('Default Simulation Step:\t{0}'.format(step_def['result']))
    # --------------------
    
    # RUN TEST CASE
    # -------------
    # Initialize test case
    global time
    start = time.time()
    # Initialize test case
    print('Initializing test case simulation.')
    res = requests.put('{0}/initialize'.format(url), json={'start_time':0,'warmup_period':0}).json()
    if res['message'] == 'success':
        print('Successfully initialized the simulation')
    else:
        print('Error when initializing the simulation:{}'.format(res['error']))   
    # Set simulation step
    print('Setting simulation step to {0}.'.format(step))
    res = requests.put('{0}/step'.format(url), json={'step':step}).json()
    if res['message'] == 'success':
        print('Successfully set the simulation step')
    else:
        print('Error when setting the simulation step:{}'.format(res['error']))   

    # Set forecast parameters
    print('Setting forecast parameters')
    res = requests.put('{0}/forecast_parameters'.format(url), json={'horizon':step, 'interval':step}).json()
    if res['message'] == 'success':
        print('Successfully set the forecast parameters')
    else:
        print('Error when setting the forecast parameters:{}'.format(res['error']))   

    print('\nRunning test case...')
    # Initialize u
    u = pidTwoZones.initialize()
    # Store setpoints for further plotting
    setpoints = pd.DataFrame(columns=['LowerSetp[North]',
                                      'UpperSetp[North]',
                                      'LowerSetp[South]',
                                      'UpperSetp[South]'])
    # Simulation Loop
    for i in range(int(length/step)):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), json=u).json()
        if y['message'] == 'success':
            print('Successfully advanced the simulation')
        else:
            print('Error when advancing the simulation:{}'.format(y['error']))  
        # Get set points for each zone
        forecast = requests.get('{0}/forecast'.format(url)).json()
        if forecast['message'] == 'success':
           print(forecast)
           forecast = forecast['result']
           print(forecast)
           LowerSetpNor = forecast['LowerSetp[North]'][0]
           UpperSetpNor = forecast['UpperSetp[North]'][0]
           LowerSetpSou = forecast['LowerSetp[South]'][0]
           UpperSetpSou = forecast['UpperSetp[South]'][0]
           setpoints.loc[(i+1)*step, setpoints.columns] = \
            [LowerSetpNor, UpperSetpNor, LowerSetpSou, UpperSetpSou]
        # Compute next control signal
        u = pidTwoZones.compute_control(y['result'], 
                                        LowerSetpNor, UpperSetpNor,
                                        LowerSetpSou, UpperSetpSou)
        
    print('\nTest case complete.')
    # -------------
        
    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    if kpi['message'] == 'success':
       print('\nKPI RESULTS \n-----------')
       kpi = kpi['result']
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
    if res['message'] == 'success':
       result = res['result']
       time = [x/3600 for x in result['y']['time']] # convert s --> hr
       setpoints.index = setpoints.index/3600 # convert s --> hr
       TZoneNor = [x-273.15 for x in result['y']['TRooAirNor_y']] # convert K --> C
       PHeatNor = result['y']['PHeaNor_y']
       TZoneSou = [x-273.15 for x in result['y']['TRooAirSou_y']] # convert K --> C
       PHeatSou = result['y']['PHeaSou_y']
       setpoints= setpoints - 273.15 # convert K --> C
    # Plot results
    if plot and res['message'] == 'success':
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperatures')
        plt.plot(time, TZoneNor, label='TZoneNor')
        plt.plot(time, TZoneSou, label='TZoneSou')
        for stp in setpoints.columns:
            plt.plot(setpoints[stp], '--', label=stp)
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.figure(2)
        plt.title('Heater Powers')
        plt.plot(time, PHeatNor, label='PHeatNor')
        plt.plot(time, PHeatSou, label='PHeatSou')
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.show()
    # --------------------
            
    return kpi,result 

if __name__ == "__main__":
    kpi,res = run(plot=False)