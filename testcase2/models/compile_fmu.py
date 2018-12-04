# -*- coding: utf-8 -*-
"""
This module compiles the test case model into an FMU using the package
``pymodelica``.

"""

from parser import parser

# DEFINE MODEL
# ------------
mopath = 'SingleZoneVAV.mo';
modelpath = 'SingleZoneVAV.TestCaseSupervisory'
extra_libraries = ['../../parser/SignalExchange.mo'] # Buildings must be on MODELICAPATH
# ------------

# COMPILE FMU
# -----------
fmupath = parser.export_fmu(modelpath, [mopath]+extra_libraries)
# -----------
