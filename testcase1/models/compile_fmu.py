# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA

"""

from parser import parser

# DEFINE MODEL
# ------------
mopath = 'SimpleRC.mo';
modelpath = 'SimpleRC'
# ------------

# COMPILE FMU
# -----------
fmupath = parser.export_fmu(modelpath, [mopath])
# -----------
