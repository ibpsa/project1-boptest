# -*- coding: utf-8 -*-
"""
This script generates data for the BESTESTAir test case.

"""

from data.data_generator import Data_Generator

resources_dir = '/home/dhbubu/git/ibpsa/project1-boptest/project1-boptest/testcaseBESTESTAir/models/Resources' # Must be full path
gen = Data_Generator(resources_dir, period=900)
gen.generate_weather()
gen.generate_prices()
gen.generate_emissions()
gen.generate_occupancy(2, 
                       start_day_time = '08:00:00',
                       end_day_time = '18:00:00')
gen.generate_internalGains(start_day_time = '08:00:00',
                           end_day_time   = '18:00:00',
                           RadOcc = 10.325*48,
                           RadUnocc = 0.85*48,
                           ConOcc = 7.71667*48,
                           ConUnocc = 0.65*48,
                           LatOcc = 1.875*48,
                           LatUnocc = 0*48)
gen.generate_setpoints(start_day_time = '08:00:00',
                       end_day_time = '18:00:00',
                       THeaOn  = 21+273.15,
                       THeaOff = 15+273.15,
                       TCooOn  = 24+273.15,
                       TCooOff = 30+273.15)

