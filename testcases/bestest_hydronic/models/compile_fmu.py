"""
This module compiles the defined test case model into an FMU using the
BOPTEST parser.

CLI default values are what are used for compilation of the test case FMU in the
BOPTEST public repository.

The following libraries must be on the MODELICAPATH:

- IDEAS

"""

from parsing import parser
import argparse

# Define model
mopath      = 'BESTESTHydronic/package.mo'
modelpath   = 'BESTESTHydronic.TestCase'

# Add CLI arguments
cliargs = argparse.ArgumentParser(
    description="Compile test case FMUs for BOPTEST. CLI default values are what are used for compilation of the test case FMU in the BOPTEST public repository.")
cliargs.add_argument(
    "--tool",
    help="FMU compilation tool. Appropriate software and licenses must be installed.  Options are 'dymola' or 'openmodelica' or 'OCT'. Default is 'dymola'.",
    default='dymola')
cliargs.add_argument(
    "--algorithm",
    help="Specify the solver algorithm, which must be compliant with the tool.  Default is 'Cvode'.\n \
    Valid algorithms for dymola are 'Cvode', 'Dassl', 'Radau', 'Lsodar'.\n \
    Valid algorithms for openmodelica are 'cvode'.\n \
    Valid algorithms for OCT are 'CVode', 'Radau5ODE', 'RungeKutta34', 'ExplicitEuler'.",
    default='Cvode')
cliargs.add_argument(
    "--tolerance",
    help="Specify the solver tolerance. 1e-6 is recommended and default.",
    default=1e-6)
args = cliargs.parse_args()

# Call FMU compilation
print('Compiling FMU with tool = {0}, algorithm = {1}, and tolerance = {2}.'.format(args.tool, args.algorithm, args.tolerance))
fmupath = parser.export_fmu(modelpath, [mopath], args.tool, args.algorithm, args.tolerance)
