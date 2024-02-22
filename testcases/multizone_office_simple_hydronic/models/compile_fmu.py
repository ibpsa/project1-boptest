# -*- coding: utf-8 -*-
"""
This module compiles the defined test case model into an FMU using the
overwrite block parser.

The following libraries with correct versions/commits must be on the MODELICAPATH:

- Modelica Buildings Library
- IDEAS Library

"""

from parsing import parser


def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    # ------------
    mopath = 'BuildingEmulators/package.mo'
    modelpath = 'BuildingEmulators.BuildingSystem'
    # ------------

    # COMPILE FMU
    # -----------
    fmupath = parser.export_fmu(modelpath, [mopath], tool='OCT')
    # -----------

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
