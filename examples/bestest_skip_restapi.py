# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.  A controller is tested, which is 
imported from a different module.
  
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import os
import sys
 
#===============================================================================
# Configure environment for JModelica
GBT_dir = 'C:\Users\u0110910\Box Sync\work_folder\GBT' 
JM_dir  = 'C:\JModelica.org-2.2'

# Import the python library of the Grey-Box Toolbox 
GBTpy_dir = os.path.join(GBT_dir, os.path.join('greybox','python'))
sys.path.append(GBTpy_dir)

import configure_jmodelica
configure_jmodelica.main()  

# Set a 'ModelicaPath' environmental variable with the path to 
# Modelica and IBPSA libraries
Modelica_dir = os.path.join(JM_dir, os.path.join('install',os.path.join('ThirdParty','MSL')))
ibpsa_dir = "C:\\Users\\u0110910\\Documents\\modelica-ibpsa"
os.environ["ModelicaPath"] = Modelica_dir+';'+ibpsa_dir 
#===============================================================================

from matplotlib import pyplot as plt
# ----------------------

# TEST CONTROLLER IMPORT
# ----------------------
from controllers.pid_bestest import PID
# ----------------------

# SETUP TEST CASE
# ---------------
sys.path.append('C:\\Users\\u0110910\\Box Sync\\work_folder\\BOPTEST\\testcase3')
# Necesary to import config of the testcase

from testcase import TestCase
case = TestCase()
length = 2*24*3600
step = 900
# ---------------

# GET TEST INFORMATION
# --------------------
print('\nTEST CASE INFORMATION\n---------------------')
# Test case name
name = case.get_name()
print('Name:\t\t\t\t{0}'.format(name))
# Inputs available
inputs = case.get_inputs()
print('Control Inputs:\t\t\t{0}'.format(inputs))
# Measurements available
measurements = case.get_measurements()
print('Measurements:\t\t\t{0}'.format(measurements))
# Default simulation step
step_def = case.get_step()
print('Default Simulation Step:\t{0}'.format(step_def))
# --------------------

# RUN TEST CASE
# -------------
# Reset test case
print('Resetting test case if needed.')
res = case.reset()
# Set simulation step
print('Setting simulation step to {0}.'.format(step))
res = case.set_step(step)
print('\nRunning test case...')

# Instantiate controller 
pid = PID()
# Initialize u
u = pid.initialize()
# Simulation Loop
for i in range(int(length/step)):
    # Advance simulation
    y = case.advance(u)
    # Compute next control signal
    u = pid.compute_control(y)
print('\nTest case complete.')
# -------------
    
# VIEW RESULTS
# ------------
# Report KPIs
kpi = case.get_kpis()
print('\nKPI RESULTS \n-----------')
for key in kpi.keys():
    print('{0}: {1}'.format(key, kpi[key]))
# ------------ 
    
# POST PROCESS RESULTS
# --------------------
# Get result data
res = case.get_results()
time = [x/3600 for x in res['y']['time']] # convert s --> hr
TZone = [x-273.15 for x in res['y']['TRooAir_y']] # convert K --> C
Tsup  = [x-273.15 for x in res['u']['oveTsup_u']] # convert K --> C
PHeat = res['y']['PHea_y']

# Plot results
plt.figure(1)
plt.title('Zone Temperature')
plt.plot(time, TZone)
plt.ylabel('Temperature [C]')
plt.xlabel('Time [hr]')
plt.figure(2)
plt.title('Heater Power')
plt.plot(time, PHeat)
plt.ylabel('Heat Power [W]')
plt.xlabel('Time [hr]')
plt.figure(3)
plt.title('Supply temperature')
plt.plot(time, Tsup)
plt.ylabel('Supply temperature')
plt.xlabel('Time [hr]')
plt.show()
# --------------------