# -*- coding: utf-8 -*-
"""
This script is copied inside of the JModelica docker container in order to 
compile an FMU.  

It needs to be written for Python 2.

"""

import argparse
from pymodelica import compile_fmu

# Create arguments
parser = argparse.ArgumentParser(description='Compile the given model path.')
parser.add_argument('model_path', metavar='m', type=str, help='Model path to compile')
parser.add_argument('file_path', metavar='f', type=str, nargs='+', help='File paths')
# Parse arguments
args = parser.parse_args()
file_path = []
for path in args.file_path:
    file_path.append(path)
# Compile fmu
fmu_path = compile_fmu(args.model_path, file_path,  compiler_log_level='info')