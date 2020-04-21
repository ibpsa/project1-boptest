# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries must be on the MODELICAPATH:

- Modelica IBPSA
- Modelica Buildings

"""

from parsing import parser
from pymodelica import environ

environ['JVM_ARGS'] = '-Xmx4096m'

def compile_fmu():
    '''Compile the fmu.
    
    Returns
    -------
    fmupath : str
        Path to compiled fmu.
    
    '''
    
    # DEFINE MODEL
    # ------------
    mopath      = 'DetachedHouse_ENGIE_IBPSAP1'
    modelpath   = 'DetachedHouse_ENGIE_IBPSAP1.DetachedHouse_ENGIE_IBPSAP1_BOPTEST_v3'
    # ------------
    
    # COMPILE FMU
    # -----------
    fmupath = parser.export_fmu(modelpath, [mopath])
    # -----------
    
    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()