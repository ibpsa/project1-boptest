# -*- coding: utf-8 -*-
"""
This script process the .mat file results from running 
"TwoZoneApartmentHydronic.TestCases.BoundaryConditions" to generate 
InternalGains.csv, occupancy.csv, weather.csv and setpoints.csv

@author: Ettore Zanetti
"""
#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#
# import from future to make Python2 behave like Python3
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from future import standard_library
standard_library.install_aliases()
from builtins import *
from io import open
# end of from future import
import os
import matplotlib
matplotlib.use('qt5agg')
import matplotlib.pyplot as plt
from buildingspy.io.outputfile import Reader
import pandas as pd
import datetime
import numpy as np
from scipy import integrate

def _extract_data(mat_file, re_val, tool):
    """
    Extract time series data from mat file.

    :param mat_file: Path of .mat output file
    :param re_val: List of variables that the data should be extracted
    :param tool: simulation tool
    """
    from buildingspy.io.outputfile import Reader
    

    try:
        if CODE_VERBOSE:
            print(f"**** Extracting {mat_file}")
        r = Reader(mat_file, tool)
    except IOError:
        raise ValueError("Failed to read {}.".format(mat_file))

    result = list()
    for var in re_val:
        time = []
        val = []
        try:
            var_mat = var
            (time, val) = r.values(var_mat)
            timen, valn = clean_time_series(time, val)
        except KeyError:
            raise ValueError("Result {} does not have variable {}."
                             .format(mat_file, var))
        # Convert variable to compact format to save disk space.
        temp = {'variable': var,
                'time': timen,
                'value': valn}
        result.append(temp)
    return result


def clean_time_series(time, val):
    """
    Clean doubled time values

    :param time: Time.
    :param val: Variable values.
    """
    import numpy as np
    # Create shift array
    Shift = np.array([-1.0], dtype='f')
    # Shift time to right and left and subtract
    time_sr = np.concatenate((Shift, time))
    time_sl = np.concatenate((time, Shift))
    time_d = time_sl - time_sr
    time_dn = time_d[0:-1]
    # Get new values for time and val
    tol = 1E-5
    timen = time[time_dn > tol]
    valn = val[time_dn > tol]
    return timen, valn


def dict_to_datetimedf(input_dict,sampling_time,res_type):
    """
    This function transforms the input dictionary from _extract_data into a dataframe
    of a given sampling time and starting at the simulation start converted assuming 
    the current year when the simulation is executed
    
    :param input_dict: variable dictionary coming from _exctract_data function
    :param sampling_time: sampling time for output dataframe in seconds
    :param res_type: specify the resampling type ("mean" or "sum")
    """
    from datetime import datetime
    #get df
    df_out = pd.DataFrame()
    for var in input_dict:
        if len(var["time"]) < 3:
            df_out[var["variable"]] = float(var["value"][0])
        else:    
            df_out[var["variable"]] = var["value"]
            df_out["time"] = var["time"]
    
    #convert df index into datetime
    first_date = int(datetime(datetime.now().year, 1, 1).timestamp())
    if res_type == "raw":
        df_out = df_out.set_index(df_out["time"])
        df_out_res = df_out
    else:    
        df_out = df_out.set_index(pd.to_datetime(df_out["time"]*10**9)+ 
                                  pd.DateOffset(seconds = first_date+3600))
        
        #Resample data at chosen interval with given resampler
        if res_type == "sum":
            df_out_res = df_out.resample(str(sampling_time)+"S", 
                                         closed = "left", label = "left").sum()
        elif res_type == "mean":
            df_out_res = df_out.resample(str(sampling_time)+"S",
                                         closed = "left", label = "left").mean()
        else:
            raise Exception("Operazione errata: " + str(res_type))
    
    return df_out_res
    
    

    
#PostProcessing Parameters
file_name = "BoundaryConditions.mat" # .mat file to be extracted
tool = "dymola" # simulation tool
CODE_VERBOSE = True # shows code progres
#Generate weatherfile
weather_read_vars = ["weaBus.HGloHor","weaBus.HDifHor","weaBus.HDirNor","weaBus.TBlaSky","weaBus.TDewPoi",
                     "weaBus.TDryBul","weaBus.TWetBul","weaBus.winSpe","weaBus.winDir",
                     "weaBus.ceiHei","weaBus.nOpa","weaBus.nTot","weaBus.pAtm",
                     "weaBus.relHum","weaBus.solAlt","weaBus.solDec","weaBus.solHouAng",
                     "weaBus.solTim","weaBus.solZen","weaBus.cloTim","weaBus.lat","weaBus.lon"]
weather_use_list = [s.replace("weaBus.", "") for s in weather_read_vars]

setpoints_read_vars = ["thermostatDayZon.TSetZ","thermostatNigZon.TSetZ"]

setpoints_use_vars = ["LowerSetp[Day]","LowerSetp[Night]"]

internalG_read_vars = ["sumRadDayZon.y","sumConDayZon.y","sumLatDayZon.y",
                       "sumRadNigZon.y","sumConNigZon.y","sumLatNigZon.y"]

internalG_use_vars = ["InternalGainsRad[Day]",	"InternalGainsCon[Day]",	
                      "InternalGainsLat[Day]","InternalGainsRad[Night]",
                      "InternalGainsCon[Night]",	"InternalGainsLat[Night]"]
occ_read_vars = ["thermostatDayZon.Occ","thermostatNigZon.Occ"]
occ_use_vars = ["Occupancy[Day]","Occupancy[Night]"]
var_read_list = weather_read_vars+setpoints_read_vars+internalG_read_vars+occ_read_vars
var_use_list = weather_use_list+setpoints_use_vars+internalG_use_vars+occ_use_vars
sampling_time = 900 # sampling time in seconds
res_type = "raw" # ty

# Extract data
get_cwd = os.getcwd()
path = os.path.join(get_cwd,file_name)
result = _extract_data(path, var_read_list, tool)
# Resample data and create dataframe for overall period
df_tot = dict_to_datetimedf(result ,sampling_time,res_type)
# Renaming the dataframe variable with proper name
new_col_names = {}
k = 0
for var_name in var_read_list:
    new_col_names[var_name] = var_use_list[k]
    k+=1
df_tot = df_tot.rename(columns=new_col_names)
# Print csv files 
df_tot[weather_use_list].to_csv("weather.csv")
df_tot[occ_use_vars].to_csv("occupancy.csv")
df_tot[internalG_use_vars].to_csv("internalGains.csv")
# add setpoint variables
df_setPoi = df_tot[setpoints_use_vars]
df_setPoi["UpperSetp[Day]"] = 24 + 273.15
df_setPoi["UpperSetp[Night]"] = 24 + 273.15
df_setPoi["UpperCO2[Day]"] = 1500
df_setPoi["UpperCO2[Night]"] = 1500
df_setPoi.to_csv('setpoints.csv')

