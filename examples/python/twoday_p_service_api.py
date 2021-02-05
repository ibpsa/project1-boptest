# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which must already be running.  A controller is tested, which is
imported from a different module.

"""

#%% GENERAL PACKAGE IMPORT
# ----------------------
import requests
import numpy as np
from boptest_client import BoptestClient
# ----------------------

#%% TEST CONTROLLER IMPORT
# ----------------------
from controllers import pid
# ----------------------

#%% SETUP TEST CASE
# ---------------
# Set URL for testcase
url = 'http://localhost'
# Set simulation parameters
length = 18*3600
com_step = 300
# Setup building emulator
testcase = 'testcase1'
client = BoptestClient(url)
testid = client.submit('../../testcases/{0}/models/wrapped.fmu'.format(testcase))
# ---------------

#%% GET TEST INFORMATION
# --------------------
print('\nTEST CASE INFORMATION\n---------------------')
# Inputs available
inputs = requests.get('{0}/inputs/{1}'.format(url,testid)).json()
print('Control Inputs:\t\t\t{0}'.format(inputs))
# Measurements available
measurements = requests.get('{0}/measurements/{1}'.format(url,testid)).json()
print('Measurements:\t\t\t{0}'.format(measurements))
# --------------------

#%% RUN TEST CASE
# -------------
# Initialize
print('\nInitializing the test case.')
res = requests.put('{0}/initialize/{1}'.format(url,testid), data={'start_time':0,'warmup_period':0})
# Set communication step
print('Setting communication step to {0}.'.format(com_step))
res = requests.put('{0}/step/{1}'.format(url,testid), json={'step':com_step})
# Run test case
print('\nRunning test case...')
# Initialize u
u = pid.initialize()
# Simulation Loop
for i in range(int(length/com_step)-1):
    # Print current step
    print('Current step is {0} of {1}.'.format(i+1,int(length/com_step)-1))
    # Advance simulation
    y = requests.post('{0}/advance/{1}'.format(url,testid), json=u).json()
    # Compute next control signal
    u = pid.compute_control(y)
# Stop test case
print('Stopping test case and reporting KPIs.')
res = requests.put('{0}/stop/{1}'.format(url,testid))
print('\nTest case complete.')
# -------------

#%% VIEW KPIS
# ---------
# Report KPIs
kpi = requests.get('{0}/kpi/{1}'.format(url,testid)).json()
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
# ----------

#%% POST-PROCESS RESULTS
# --------------------
# Get result data
res = requests.get('{0}/results/{1}'.format(url,testid)).json()
time = [x/3600 for x in res['y']['time']] # convert s --> hr
TZone = [x-273.15 for x in res['y']['TRooAir_y']] # convert K --> C
PHeat = res['y']['PHea_y']
# Plot results
#if True:
#    from matplotlib import pyplot as plt
#    plt.figure(1)
#    plt.title('Zone Temperature')
#    plt.plot(time, TZone)
#    plt.plot(time, 20*np.ones(len(time)), '--')
#    plt.plot(time, 23*np.ones(len(time)), '--')
#    plt.ylabel('Temperature [C]')
#    plt.xlabel('Time [hr]')
#    plt.figure(2)
#    plt.title('Heater Power')
#    plt.plot(time, PHeat)
#    plt.ylabel('Electrical Power [W]')
#    plt.xlabel('Time [hr]')
#    plt.show()
# --------------------
