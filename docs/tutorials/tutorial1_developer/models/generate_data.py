from data.data_generator import Data_Generator
import os

# Set the location of the Resource directory relative to this file location 
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)
# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()
# Generate prices data with default values
gen.generate_prices()
# Generate emission factors data with default values
gen.generate_emissions()
# Generate occupancy data for our case
gen.generate_occupancy(2,
                       start_day_time = '08:00:00',
                       end_day_time = '18:00:00')
# Generate internal gains data for our case
gen.generate_internalGains(start_day_time = '08:00:00',
                           end_day_time   = '18:00:00',
                           RadOcc = 10.325*48,
                           RadUnocc = 0.85*48,
                           ConOcc = 7.71667*48,
                           ConUnocc = 0.65*48,
                           LatOcc = 1.875*48,
                           LatUnocc = 0*48)
# Generates comfort range data for our case
gen.generate_setpoints(start_day_time = '08:00:00',
                       end_day_time = '18:00:00',
                       THeaOcc  = 21+273.15,
                       THeaUnocc = 15+273.15,
                       TCooOcc  = 24+273.15,
                       TCooUnocc = 30+273.15)

