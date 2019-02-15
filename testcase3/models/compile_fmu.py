# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA
- Modelica Buildings

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

from Parser import parser

# DEFINE MODEL
# ------------
mopath = 'SingleZoneResidentialHydronic.mo';
modelpath = 'SingleZoneResidentialHydronic.SingleZoneResidentialHydronicControl'
# ------------

# COMPILE FMU
# -----------
fmupath = parser.export_fmu(modelpath, [mopath])
# -----------
