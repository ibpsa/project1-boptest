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
import kpicalculation
import json,collections
# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers import sup
# ----------------------

def run(plot=False, kpiconfig=None):
    '''Run test case.
    
    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.
    customizedkpi : string, optional
        The name of the json file which contains the customized kpi information.
        Default is None.
        
    Returns
    -------
    kpi : dict
        Dictionary of KPI names and values.
        {kpi_name : value}
    res : dict
        Dictionary of trajectories of inputs and outputs.
    
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

    # import customized KPI if any
    customizedkpis=[]
    if kpiconfig is not None:
        with open(kpiconfig) as f:
                config=json.load(f,object_pairs_hook=collections.OrderedDict)
   
        for key in config.keys():
               customizedkpis.append(kpicalculation.cutomizedKPI(config[key]))
    
    # RUN TEST CASE
    # -------------
    start = time.time()
    # Reset test case
    print('Resetting test case if needed.')
    res = requests.put('{0}/reset'.format(url))
    print('\nRunning test case...')
    # Set simulation step
    res = requests.put('{0}/step'.format(url), data={'step':step})
    # Initialize u
    u = sup.initialize()
    # Simulation Loop
    for i in range(int(length/step)):
        # Advance simulation
        y = requests.post('{0}/advance'.format(url), data=u).json()
        # Compute next control signal
        u = sup.compute_control(y)
        # Compute customized KPIs
        if not customizedkpis:
             for customizedkpi in customizedkpis:
                  customizedkpi.processing_data(y,customizedkpi.data_point_num)
                  print('KPI:\t{0}:\t{1}'.format(customizedkpi.model.name,round(customizedkpi.calculation(),2)))
    print('\nTest case complete.')
    print('Elapsed time of test was {0} seconds.'.format(time.time()-start))
    # -------------
        
    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    print('\nKPI RESULTS \n-----------')
    for key in kpi.keys():
        if key == 'energy':
            unit = 'kWh'
        elif key == 'comfort':
            unit = 'Kh'
        print('{0}: {1} {2}'.format(key, kpi[key], unit))
    # ------------ 
        
    # POST PROCESS RESULTS
    # --------------------
    # Get result data
    res = requests.get('{0}/results'.format(url)).json()
    t = [x/3600 for x in res['y']['time']] # convert s --> hr
    TRooAir = [x-273.15 for x in res['y']['TRooAir_y']] # convert K --> C
    TSetRooHea = [x-273.15 for x in res['u']['oveTSetRooHea_u']] # convert K --> C
    TSetRooCoo = [x-273.15 for x in res['u']['oveTSetRooCoo_u']] # convert K --> C
    PFan = res['y']['PFan_y']
    PCoo = res['y']['PCoo_y']
    PHea = res['y']['PHea_y']
    PPum = res['y']['PPum_y']
    # Plot results
    if plot:
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
        
    return kpi, res
        
if __name__ == "__main__":
    kpi,res = run(kpiconfig='kpi.config')