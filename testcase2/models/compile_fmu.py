# -*- coding: utf-8 -*-
"""
This module compiles the test case model into an FMU using the package
``pymodelica``.

"""

from pymodelica import compile_fmu

# DEFINE MODEL
# ------------
mopath = 'SingleZoneVAV.mo';
modelpath = 'SingleZoneVAV.TestCaseSupervisory'
# ------------

# COMPILE FMU
# -----------
fmupath = compile_fmu(modelpath, mopath)
# -----------