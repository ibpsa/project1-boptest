'''
Created on Jun 17, 2020

@author: David Blum
'''

from data.data_generator import Data_Generator
import os
import pandas as pd
from pymodelica import compile_fmu
from pyfmi import load_fmu
from scipy import interpolate

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)

# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()
