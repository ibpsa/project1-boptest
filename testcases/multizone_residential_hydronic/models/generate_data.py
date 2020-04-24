'''
Created on Sep 18, 2019

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
# Create data generator object with time interval of 5 minutes
gen = Data_Generator(resources_dir, period=300)

#=====================================================================
# Generate variables from model
#=====================================================================
# Initialize data frame
df = gen.create_df()
        
file_name    = 'DetachedHouse_ENGIE_IBPSAP1'
class_name   = 'DetachedHouse_ENGIE_IBPSAP1.Generate_Data'

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
keysMap['Occupancy[Sal]'] = 'occSal.y' 
keysMap['Occupancy[Ro1]'] = 'occRo1.y' 
keysMap['Occupancy[Ro2]'] = 'occRo2.y' 
keysMap['Occupancy[Ro3]'] = 'occRo3.y' 

# Internal gains
keysMap['InternalGainsRad[Sal]'] = 'heaGaiSalRad.y' 
keysMap['InternalGainsCon[Sal]'] = 'heaGaiSalCon.y'
keysMap['InternalGainsLat[Sal]'] = 'heaGaiSalLat.y'
keysMap['InternalGainsRad[Ro1]'] = 'heaGaiRo1Rad.y' 
keysMap['InternalGainsCon[Ro1]'] = 'heaGaiRo1Con.y'
keysMap['InternalGainsLat[Ro1]'] = 'heaGaiRo1Lat.y'
keysMap['InternalGainsRad[Ro2]'] = 'heaGaiRo2Rad.y' 
keysMap['InternalGainsCon[Ro2]'] = 'heaGaiRo2Con.y'
keysMap['InternalGainsLat[Ro2]'] = 'heaGaiRo2Lat.y'
keysMap['InternalGainsRad[Ro3]'] = 'heaGaiRo3Rad.y' 
keysMap['InternalGainsCon[Ro3]'] = 'heaGaiRo3Con.y'
keysMap['InternalGainsLat[Ro3]'] = 'heaGaiRo3Lat.y'

# Comfort range setpoints
keysMap['LowerSetp[Sal]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Sal]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro1]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro1]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro2]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro2]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Ro3]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Ro3]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Bth]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Bth]'] = 'reaTSetCoo.y'
keysMap['LowerSetp[Hal]'] = 'reaTSetHea.y'
keysMap['UpperSetp[Hal]'] = 'reaTSetCoo.y'

# Get model outputs
output_names = keysMap.keys()
 
# Write every output in the data
for out in output_names:
    # Interpolate to avoid problems with events from Modelica
    g = interpolate.interp1d(res['time'],res[keysMap[out]],kind='linear')
    df.loc[:,out] = g(gen.time)

# Add CO2 limits
keysMap['UpperCO2[Sal]'] = 894.
keysMap['UpperCO2[Ro1]'] = 894.
keysMap['UpperCO2[Ro2]'] = 894.
keysMap['UpperCO2[Ro3]'] = 894.
keysMap['UpperCO2[Bth]'] = 894.
keysMap['UpperCO2[Hal]'] = 894.

# Missing null occupancy variables
df['Occupancy[Bth]'] = 0.
df['Occupancy[Hal]'] = 0. 

# Missing null InternalGains variables
df['InternalGainsRad[Bth]'] = 0. 
df['InternalGainsCon[Bth]'] = 0. 
df['InternalGainsLat[Bth]'] = 0. 
df['InternalGainsRad[Hal]'] = 0. 
df['InternalGainsCon[Hal]'] = 0. 
df['InternalGainsLat[Hal]'] = 0. 

# Store in csv
gen.store_df(df,'dataFromModel')

#=====================================================================
# Generate weather
#=====================================================================
# Generate weather data from .mos in Resources folder with default values
gen.generate_weather()

