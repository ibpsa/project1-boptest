# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  
  
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import os
import sys
import cPickle as pickle
import numpy as np

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
step = 3600

E = dict()
E['E_trapz'] = []
E['E_model'] = []
days = range(1,365,7)
for d in days:
    
    case.reset()
    
    length = d*24*3600

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
        
    # ------------
    # Report KPIs
    kpi = case.get_kpis()
    
    E['E_trapz'].append(kpi['integrated energy'])
    E['E_model'].append(kpi['energy'])
    # ------------ 
    
    f=file('EnergyIntegrals', 'w')
    pickle.dump(E,f)
    f.close()
    
# Plot results
plt.figure(1)
plt.title('Energy integrals')
plt.plot(days, E['E_trapz'])
plt.ylabel('Energy [kWh]')
plt.xlabel('Time [days]')
plt.figure(2)
plt.title('Difference')
plt.plot(days, np.asarray(E['E_trapz'])-np.asarray(E['E_model']))
plt.ylabel('Energy [kWh]')
plt.xlabel('Time [days]')
plt.show()
# --------------------

E_loaded = pickle.load(file('EnergyIntegrals','r'))