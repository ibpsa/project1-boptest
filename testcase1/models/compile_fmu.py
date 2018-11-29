# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the 
overwrite block parser.

"""

from parser import parser

# DEFINE MODEL
# ------------
mopath = 'SimpleRC.mo';
modelpath = 'SimpleRC'
extra_libraries = ['/home/dhbubu/git/ibpsa/project1-boptest/project1-boptest/parser/TestOverWrite.mo']
# ------------

# COMPILE FMU
# -----------
fmupath = parser.export_fmu(modelpath, [mopath]+extra_libraries)
# -----------