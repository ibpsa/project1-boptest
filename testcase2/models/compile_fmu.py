# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA
- Modelica Buildings

"""

from parser import parser

# DEFINE MODEL
# ------------
mopath = 'SingleZoneVAV.mo';
modelpath = 'SingleZoneVAV.TestCaseSupervisory'
# ------------

# COMPILE FMU
# -----------
fmupath = parser.export_fmu(modelpath, [mopath])
# -----------
