# -*- coding: utf-8 -*-
"""
This module compiles the test case model into an FMU using the package
``pymodelica``.

"""

from pymodelica import compile_fmu

# DEFINE MODEL
# ------------
mopath = 'IBPSA.Utilities.IO.RESTClient.Examples.Sampler.mo';
modelpath = 'IBPSA.Utilities.IO.RESTClient.Examples.Sampler'
# ------------

# COMPILE FMU
# -----------

# -----------


#modelName = 'IBPSA.Utilities.IO.RESTClient.Examples.Sampler'
#
modelName = 'SimpleRC_Input_test'
modelFile = ''
extraLibPath = '.\IBPSA'
modelicaLibPath = '.'

# Set the compiler options
compilerOptions = {'extra_lib_dirs':[ modelicaLibPath, extraLibPath]}

fmupath = compile_fmu(modelName, modelFile, compiler_options=compilerOptions)
