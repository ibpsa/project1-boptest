# -*- coding: utf-8 -*-
'''
This script demonstrates a minimalistic example of testing a feedback controller
using the scenario options with the prototype test case called "testcase1".

'''

import sys
import pathlib
# Add BOPTEST repository to PYTHONPATH for this example
sys.path.insert(0, str(pathlib.Path(__file__).absolute().parents[2]))

def run(plot=False):
    '''This is the main script.

    Parameters
    ----------
    plot : boolean
        True to plot result at end.
        Default is True.

    Returns
    -------
    kpi : dict
        Dictionary containing KPI values at end of test.

    '''

    # GENERAL PACKAGE IMPORT
    # -----------------------------------------------------------------------------
    import requests
    import numpy as np
    # -----------------------------------------------------------------------------
    # TEST CONTROLLER IMPORT
    # -----------------------------------------------------------------------------
    from examples.python.controllers import pid
    # -----------------------------------------------------------------------------
    # SET TEST PARAMETERS
    # -----------------------------------------------------------------------------
    # Set URL for test case
    url = 'http://127.0.0.1:5000'
    # Set testing scenario
    scenario = {'time_period':'test_day', 'electricity_price':'dynamic'}
    # Set control step
    step = 300
    # -----------------------------------------------------------------------------
    # GET TEST INFORMATION
    # -----------------------------------------------------------------------------
    # Get test case name
    name = requests.get('{0}/name'.format(url)).json()
    # Get inputs available
    inputs = requests.get('{0}/inputs'.format(url)).json()
    # Get measurements available
    measurements = requests.get('{0}/measurements'.format(url)).json()
    # -----------------------------------------------------------------------------
    # RUN TEST CASE
    # -----------------------------------------------------------------------------
    # Set control step
    requests.put('{0}/step'.format(url), data={'step':step})
    # Set test case scenario
    y = requests.put('{0}/scenario'.format(url), data=scenario).json()['time_period']
    # Record test start time
    start_time = y['time']
    # Simulation Loop
    while y:
        # Compute control signal
        u = pid.compute_control(y)
        # Advance simulation with control signal
        y = requests.post('{0}/advance'.format(url), data=u).json()
    # -----------------------------------------------------------------------------
    # GET RESULTS
    # -----------------------------------------------------------------------------
    # Get KPIs
    kpi = requests.get('{0}/kpi'.format(url)).json()
    # Get zone temperature over test period
    args = {'point_name':'TRooAir_y', 'start_time':start_time, 'final_time':np.inf}
    res = requests.put('{0}/results'.format(url), data=args).json()
    # -----------------------------------------------------------------------------
    # PRINT AND VIEW RESULTS
    # -----------------------------------------------------------------------------
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
    # Plot
    if plot:
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperature')
        plt.plot(res['time'], np.array(res['TRooAir_y'])-273.15)
        plt.plot(res['time'], 20*np.ones(len(res['time'])), '--')
        plt.plot(res['time'], 23*np.ones(len(res['time'])), '--')
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.show()

    return kpi

if __name__ == "__main__":
    kpi = run()
