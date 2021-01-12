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
from examples.python.custom_kpi import custom_kpi_calculator as kpicalculation
import json,collections

# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers import sup
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
    length = 24*3600*2
    step = 3600
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
    res = requests.put('{0}/initialize'.format(url), json={'start_time':0,'warmup_period':0}).json()
    if res['message'] == 'success':
        print('Successfully initialized the simulation')
    else:
        print('Error when initializing the simulation:{}'.format(res['error']))    
    print('\nRunning test case...')
    # Set simulation step
    res = requests.put('{0}/step'.format(url), json={'step':step})
    # Initialize u
    u = sup.initialize()
    # Simulation Loop
    for i in range(int(length/step)):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), json=u).json()
        if y['message'] == 'success':
            print('Successfully advanced the simulation')
        else:
            print('Error when advancing the simulation:{}'.format(y['error']))   
        # Compute next control signal
        u = sup.compute_control(y['result'])
        # Compute customized KPIs if any
        if customized_kpi_config is not None:
             for customizedkpi in customizedkpis:
                  customizedkpi.processing_data(y['result']) # Process data as needed for custom KPI
                  customizedkpi_value = customizedkpi.calculation() # Calculate custom KPI value
                  customizedkpis_result[customizedkpi.name].append(round(customizedkpi_value,2)) # Track custom KPI value
                  print('KPI:\t{0}:\t{1}'.format(customizedkpi.name,round(customizedkpi_value,2))) # Print custom KPI value
             customizedkpis_result['time'].append(y['result']['time']) # Track custom KPI calculation time  
    print('\nTest case complete.')
    print('Elapsed time of test was {0} seconds.'.format(time.time()-start))
    # -------------
        
    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    
    if kpi['message'] == 'success':
       print('\nKPI RESULTS \n-----------')
       kpi = kpi['result']
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
          else:
               unit = None
          print('{0}: {1} {2}'.format(key, kpi[key], unit))
    # ------------ 
        
    # POST PROCESS RESULTS
    # --------------------
    # Get result data
    res = requests.get('{0}/results'.format(url)).json()
    if res['message'] == 'success':
        result = res['result']
        t = [x/3600 for x in result['y']['time']] # convert s --> hr
        TRooAir = [x-273.15 for x in result['y']['TRooAir_y']] # convert K --> C
        TSetRooHea = [x-273.15 for x in result['u']['oveTSetRooHea_u']] # convert K --> C
        TSetRooCoo = [x-273.15 for x in result['u']['oveTSetRooCoo_u']] # convert K --> C
        PFan = result['y']['PFan_y']
        PCoo = result['y']['PCoo_y']
        PHea = result['y']['PHea_y']
        PPum = result['y']['PPum_y']
    # Plot results
    if plot and res['message'] == 'success':
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperature')
        plt.plot(t, TRooAir)
        plt.plot(t, TSetRooHea)
        plt.plot(t, TSetRooCoo)
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.figure(2)
        plt.title('HVAC Power')
        plt.plot(t, PHea, label='Heating')
        plt.plot(t, PCoo, label='Cooling')
        plt.plot(t, PFan, label='Fan')
        plt.plot(t, PPum, label='Pump')
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.show()
    # --------------------
   
    return kpi,result,customizedkpis_result 
        
if __name__ == "__main__":
    kpi,res,customizedkpis_result = run(customized_kpi_config='custom_kpi/custom_kpis_example.config')