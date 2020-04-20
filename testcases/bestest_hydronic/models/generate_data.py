'''
Created on Feb 20, 2020

@author: Javier Arroyo
'''

from data.data_generator import Data_Generator
import os
# Set the location of the Resource directory relative to this file location
file_dir = os.path.dirname(os.path.realpath(__file__))
resources_dir = os.path.join(file_dir, 'Resources')
# Create data generator object with time interval to 15 minutes
gen = Data_Generator(resources_dir, period=900)
# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()
gen.generate_prices(start_day_time = '08:00:00',
                      end_day_time = '17:00:00',
                      price_constant = 0.2,
                      price_day = 0.3,
                      price_night = 0.1, 
                      price_district_heating_power = 0.1,
                      price_gas_power = 0.04,
                      price_biomass_power = 0.2,
                      price_solar_thermal_power = 0.0)
gen.generate_emissions(emissions_electric_power = 0.5,
                           emissions_district_heating_power = 0.1,
                           emissions_gas_power = 0.2,
                           emissions_biomass_power = 0.0,
                           emissions_solar_thermal_power = 0.0)
gen.generate_occupancy(occ_num = 1,
                        start_day_time = '20:00:00',
                        end_day_time   = '07:00:00')
gen.generate_internalGains(start_day_time = '20:00:00',
                            end_day_time   = '07:00:00',
                            RadOcc = 43.8,
                            RadUnocc = 0,
                            ConOcc = 29.2,
                            ConUnocc = 0,
                            LatOcc = 45,
                            LatUnocc = 0)
gen.generate_setpoints(start_day_time = '20:00:00',
                         end_day_time   = '07:00:00',
                         THeaOcc  = 21+273.15,
                         THeaUnocc = 21+273.15,
                         TCooOcc  = 23+273.15,
                         TCooUnocc = 23+273.15)