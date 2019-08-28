from data.data_generator import Data_Generator

resources_dir = '/home/dhbubu/git/ibpsa/project1-boptest/project1-boptest/testcase_bestest_air/models/Resources' # Must be full path
gen = Data_Generator(resources_dir, period=900) # Sets time interval to 15 minutes
gen.generate_weather() # Generates weather data from .mos in Resources folder
gen.generate_prices() # Generates prices with default values
gen.generate_emissions() # Generates emission factors with default values
gen.generate_occupancy(2, # Generates occupancy data for our case
                       start_day_time = '08:00:00',
                       end_day_time = '18:00:00')
gen.generate_internalGains(start_day_time = '08:00:00', # Generates gains for our case
                           end_day_time   = '18:00:00',
                           RadOcc = 10.325*48,
                           RadUnocc = 0.85*48,
                           ConOcc = 7.71667*48,
                           ConUnocc = 0.65*48,
                           LatOcc = 1.875*48,
                           LatUnocc = 0*48)
gen.generate_setpoints(start_day_time = '08:00:00', # Generates comfort range for our case
                       end_day_time = '18:00:00',
                       THeaOn  = 21+273.15,
                       THeaOff = 15+273.15,
                       TCooOn  = 24+273.15,
                       TCooOff = 30+273.15)

