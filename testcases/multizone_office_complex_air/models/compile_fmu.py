import sys
import os
sys.path.insert(0, os.path.sep.join(os.path.dirname(os.path.abspath(__file__)).split(os.path.sep)[:-3]))
from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'MultizoneOfficeComplexAir/package.mo'
    modelpath = 'MultizoneOfficeComplexAir.TestCases.TestCase'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath], tool= sys.argv[1], algorithm='Cvode', tolerance=1e-6)

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
