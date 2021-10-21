"""
This script generates data for Resources/*.csv.  It uses the data/data_generator
for Resources/weather.csv and Resources/emissions.csv.  
It uses a year simulation data RealOccupancy.csv to create
occupancy, internal gains, and set points in Resources/occupancy_internalgains_setpoints.csv.
Resources/prices.csv is generated using this script at first, 
with additional columns added manually.

"""

from data.data_generator import Data_Generator
import os
import pandas as pd

# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)
# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

# Generate emission factors data in Denmark
gen.generate_emissions(emissions_district_heating_power=0.1163, 
#kg CO2e/kWh
#obtained from https://www.banktrack.org/download/carbon_accounting_report_2018/dnb_asa_carbon_footprint_report_2018.pdf
emissions_electric_power=0.2090 
#kg CO2e/kWh
# obtained from https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf
)

#=====================================================================
# Generate prices
#=====================================================================
# Electricity prices obtained from Nordpool DK2: average for Feb, 2019
# https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Yearly/?view=table
# 
# Dynamic price obtained from Nordpool DK 1: 12 Feb, 2019, peak and off peak price of the selected day
# https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Hourly/?view=table

# highly dynamic price obtained from Nord pool DK1: day-ahead price, hourly price on 12 Feb, 2019, repeat electricity price of the selected day
# https://www.nordpoolgroup.com/Market-data1/Dayahead/Area-Prices/DK/Hourly/?view=chart

## Generate prices data in Denmark - note, will not produce what is in Resources/prices.csv.
#gen.generate_prices(start_day_time='07:00:00',
#end_day_time='22:00:00',
#price_constant=0.04281, #Euro/kWh
#price_day=0.05253,
#price_night=0.03857,
#price_district_heating_power=0.0828)
##district heating price 0.0828 euro/kWh source:https://www.c40.org/case_studies/98-of-copenhagen-city-heating-supplied-by-waste-heat

# Remove duplicate states
print(os.getcwd())
df = pd.read_csv('../RealOccupancy.csv')
df = df.set_index('Time')
df.index.name = 'time'

# Convert W/m^2 to W
A = 8500 # m^2
for key in ['ou44Bdg.qGai_flow[1]','ou44Bdg.qGai_flow[2]','ou44Bdg.qGai_flow[3]']:
    df[key] = df[key]*A

# Change names
column_map = {'ou44Bdg.qGai_flow[1]': 'InternalGainsRad[1]',
              'ou44Bdg.qGai_flow[2]': 'InternalGainsCon[1]',
              'ou44Bdg.qGai_flow[3]': 'InternalGainsLat[1]',
              'occupancy.y[1]': 'Occupancy[1]',
              'conPIDrad.u_s': 'LowerSetp[1]'}
df = df.rename(columns=column_map)

# Make occupancy data integers
df['Occupancy[1]'] = df['Occupancy[1]'].get_values().astype(int)

# Add upper temperature limit
df['UpperSetp[1]'] = 30+273.15

# Add CO2 limit
df['UpperCO2[1]'] = 800

df.to_csv('occupancy_internalgains_setpoints.csv')