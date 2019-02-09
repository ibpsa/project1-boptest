# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA

"""
import os
import sys

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
ibpsa_dir = "C:\\Users\\u0110910\\Box Sync\\work_folder\\modelicalib\\modelica-ibpsa"
os.environ["MODELICAPATH"] = Modelica_dir+';'+ibpsa_dir  

sys.path.append('C:\\Users\\u0110910\\Box Sync\\work_folder\\BOPTEST')

from _parser import parser

# DEFINE MODEL
# ------------
mopath = 'SimpleRC.mo';
modelpath = 'SimpleRC'
# ------------

# COMPILE FMU
# -----------
fmupath,kpipath = parser.export_fmu(modelpath, [mopath])
# -----------
