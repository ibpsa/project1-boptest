"""
This script generates weather data for Resources/*.csv.
"""

from data.data_generator import Data_Generator
import os

#=====================================================================
# Generate weather
#=====================================================================

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)
# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

#=====================================================================
# Generate emissions
#=====================================================================

# Electricity emissions .csv obtained from https://app.electricitymaps.com/map for the Belgian mix during the year 2019
# Gas emissions .csv obtained from CEEM - Centre for Environmental Economics and Environmental Management. Universiteit
# Gent. https://ceem.ugent.be/en/index.htm.

#=====================================================================
# Generate prices
#=====================================================================
# Electricity prices correspond to the avergae prices for Belgian buildings with an energy use between 20 and 500 MWh/year
# Obtained from Picard, D. Modeling, Optimal Control and HVAC Design of Large Buildings using Ground Source Heat Pump
# Systems, 2017. Ph.D (Doctoral dissertation, Thesis). Department of Mechanical Engineering, KU Leuven, Leuven, Belgium (2018).

# Dynamic prices and highly dynamic prices obtained by prorrating the constant prices with the values from the
# bestest_hydronic_heat_pump testcase.

#=====================================================================
# Generate internal gains and occupancy
#=====================================================================
# Internal gains obtained from a yearly simulation of the testcase with the baseline controller.

#=====================================================================
# Generate setpoints
#=====================================================================
# Setpoints obtained from a yearly simulation of the testcase with the baseline controller.
# The comfort band is between 21°C and 25°C, with a setback of +/- 5°C during unoccupied periods.
