# -*- coding: utf-8 -*-
"""
This module compiles the test case model into an FMU using the package
``pymodelica``.

"""

from pymodelica import compile_fmu

# DEFINE MODEL
# ------------
mopath = 'SimpleRC_Input.mo';
modelpath = 'SimpleRC_Input'
# ------------

# COMPILE FMU
# -----------
fmupath = compile_fmu(modelpath, mopath)
# -----------