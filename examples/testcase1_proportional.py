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
# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers import pid
# ----------------------

def run(plot=False):
    '''Run test case.
    
    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.
        
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
    
    # RUN TEST CASE
    # -------------
    # Reset test case
    print('Resetting test case if needed.')
    res = requests.put('{0}/reset'.format(url))
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
    print('\nTest case complete.')
    # -------------
        
    # VIEW RESULTS
    # ------------
    # Report KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    print('\nKPI RESULTS \n-----------')
    for key in kpi.keys():
        print('{0}: {1}'.format(key, kpi[key]))
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
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.figure(2)
        plt.title('Heater Power')
        plt.plot(time, PHeat)
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.show()
    # --------------------
        
    return kpi, res

if __name__ == "__main__":
    kpi, res = run()