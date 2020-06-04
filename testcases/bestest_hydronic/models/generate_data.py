'''
Created on Feb 20, 2020

@author: Javier Arroyo
'''

from data.data_generator import Data_Generator
import os
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

#=====================================================================
# Generate prices
#=====================================================================
# Electricity prices obtained from: https://www.energyprice.be/products-list/Engie
# for the "Easy Indexed" deal for electricity, on June 2020
# More info in https://www.energyprice.be/blog/2017/11/06/electricity-price-belgium/
# and in https://www.energyprice.be/blog/2017/10/23/electricity-off-peak-hours/
# For the highly dynamic scenario, the Belgian day-ahead prices of 2019 are used. Obtained from:
# https://my.elexys.be/MarketInformation/SpotBelpex.aspx

# Gas prices obtained from https://www.energyprice.be/products-list/Engie
# for the "Easy Indexed" deal for gas, on June 2020
# More info in https://www.energyprice.be/blog/2017/12/07/gas-price-belgium/

gen.generate_prices(start_day_time = '07:00:00',
                      end_day_time = '22:00:00',
                      price_constant = 0.0535,
                      price_day = 0.0666,
                      price_night = 0.0383, 
                      price_district_heating_power = 0.1,
                      price_gas_power = 0.0198,
                      price_biomass_power = 0.2,
                      price_solar_thermal_power = 0.0)

gen.generate_emissions(emissions_electric_power = 0.5,
                           emissions_district_heating_power = 0.1,
                           emissions_gas_power = 0.2,
                           emissions_biomass_power = 0.0,
                           emissions_solar_thermal_power = 0.0)

 
#=====================================================================
# Generate variables from model
#=====================================================================
# Initialize data frame
df = gen.create_df()
file_name    = 'BESTESTHydronic'
class_name   = 'BESTESTHydronic.TestCase'
 
# Compile the model to generate the data
fmu_path = compile_fmu(file_name=file_name, class_name=class_name)
 
# Load FMU 
model = load_fmu(fmu_path)
 
# Set number of communication points
options = model.simulate_options()
options['ncp']=len(gen.time)-1
 
# Simulate
res = model.simulate(start_time=gen.time[0],
                     final_time=gen.time[-1],
                     options=options)
 
keysMap = {}
 
# Occupancy schedules
keysMap['Occupancy[1]'] = 'yOcc.y' 
 
# Internal gains
keysMap['InternalGainsRad[1]'] = 'case900Template.intGaiOcc.portRad.Q_flow' 
keysMap['InternalGainsCon[1]'] = 'case900Template.intGaiOcc.portCon.Q_flow'
keysMap['InternalGainsLat[1]'] = 'case900Template.airModel.preHeaFloLat.Q_flow'
 
# Comfort range setpoints
keysMap['LowerSetp[1]'] = 'reaTSetHea.y'
keysMap['UpperSetp[1]'] = 'reaTSetCoo.y'
 
# Get model outputs
output_names = keysMap.keys()
  
# Write every output in the data
for out in output_names:
    # Interpolate to avoid problems with events from Modelica
    g = interpolate.interp1d(res['time'],res[keysMap[out]],kind='linear')
    df.loc[:,out] = g(gen.time)
 
# Switch sign to sensible heat gains
df['InternalGainsRad[1]'] = -df['InternalGainsRad[1]']
df['InternalGainsCon[1]'] = -df['InternalGainsCon[1]']
 
# Add CO2 limits
df['UpperCO2[1]'] = 894.
 
# Store in csv
gen.store_df(df,'dataFromModel')

