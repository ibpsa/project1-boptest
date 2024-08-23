# -*- coding: utf-8 -*-
"""
This module implements a signal generator specifically for `multizone_office_complex_air`.

"""
import numpy.random as random

# Set the global random seed
random.seed(42)

# excite signal: - generator for exciting signals
def uniform_real(a,b):
    return (b-a)*random.random_sample()+a

def uniform_int(a,b):
    return random.randint(a,b)

def compute_control(y, forecasts=None):
    """Compute the control input from the measurement.

    Parameters
    ----------
    y : dict
        Contains the current values of the measurements.
        {<measurement_name>:<measurement_value>}
    forecasts : structure depends on controller, optional
        Forecasts used to calculate control.
        Default is None.

    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """
    TSupSet = uniform_int(12,20) # or uniform_real(12,20)
    TzonCooSet = uniform_int(13,30) # Celsius
    TzonHeaSet = uniform_int(12,TzonCooSet) # ensure Heating setpoint is lower than Cooling setpoint
    u = {
        'hva_floor1_TSupAirSet_u': 273.15 + TSupSet, 
        'hva_floor1_TSupAirSet_activate': 1,
        'hva_floor1_oveZonCor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor1_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor1_oveZonCor_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor1_oveZonCor_TZonHeaSet_activate': 1,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u': uniform_real(0.3,1),
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate': 1,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u': uniform_real(0.005,1),
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate': 1,
        'hva_floor2_TSupAirSet_u': 273.15 + TSupSet,
        'hva_floor2_TSupAirSet_activate': 1,
        'hva_floor2_oveZonCor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor2_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor2_oveZonCor_TZonHeaSet_u': 273.15 + TzonHeaSet,
        'hva_floor2_oveZonCor_TZonHeaSet_activate': 1,
        'hva_floor3_TSupAirSet_u': 273.15 + TSupSet,
        'hva_floor3_TSupAirSet_activate': 1,
        'hva_floor3_oveZonCor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor3_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor3_oveZonCor_TZonHeaSet_u': 273.15 + TzonHeaSet,
        'hva_floor3_oveZonCor_TZonHeaSet_activate': 1,
        'hva_floor1_oveZonSou_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor1_oveZonSou_TZonCooSet_activate': 1,
        'hva_floor1_oveZonSou_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor1_oveZonSou_TZonHeaSet_activate': 1,
        'hva_floor2_oveZonSou_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor2_oveZonSou_TZonCooSet_activate': 1,
        'hva_floor2_oveZonSou_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor2_oveZonSou_TZonHeaSet_activate': 1,
        'hva_floor3_oveZonSou_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor3_oveZonSou_TZonCooSet_activate': 1,
        'hva_floor3_oveZonSou_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor3_oveZonSou_TZonHeaSet_activate': 1,
        'hva_floor1_oveZonEas_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor1_oveZonEas_TZonCooSet_activate': 1,
        'hva_floor1_oveZonEas_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor1_oveZonEas_TZonHeaSet_activate': 1,
        'hva_floor2_oveZonEas_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor2_oveZonEas_TZonCooSet_activate': 1,
        'hva_floor2_oveZonEas_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor2_oveZonEas_TZonHeaSet_activate': 1,
        'hva_floor3_oveZonEas_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor3_oveZonEas_TZonCooSet_activate': 1,
        'hva_floor3_oveZonEas_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor3_oveZonEas_TZonHeaSet_activate': 1,
        'hva_floor1_oveZonNor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor1_oveZonNor_TZonCooSet_activate': 1,
        'hva_floor1_oveZonNor_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor1_oveZonNor_TZonHeaSet_activate': 1,
        'hva_floor2_oveZonNor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor2_oveZonNor_TZonCooSet_activate': 1,
        'hva_floor2_oveZonNor_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor2_oveZonNor_TZonHeaSet_activate': 1,
        'hva_floor3_oveZonNor_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor3_oveZonNor_TZonCooSet_activate': 1,
        'hva_floor3_oveZonNor_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor3_oveZonNor_TZonHeaSet_activate': 1,
        'hva_floor1_oveZonWes_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor1_oveZonWes_TZonCooSet_activate': 1,
        'hva_floor1_oveZonWes_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor1_oveZonWes_TZonHeaSet_activate': 1,
        'hva_floor2_oveZonWes_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor2_oveZonWes_TZonCooSet_activate': 1,
        'hva_floor2_oveZonWes_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor2_oveZonWes_TZonHeaSet_activate': 1,
        'hva_floor3_oveZonWes_TZonCooSet_u': 273.15 + TzonCooSet,
        'hva_floor3_oveZonWes_TZonCooSet_activate': 1,
        'hva_floor3_oveZonWes_TZonHeaSet_u': 273.15 + TzonHeaSet, 
        'hva_floor3_oveZonWes_TZonHeaSet_activate': 1
    }

    return u


def initialize():
    """Initialize the control input u.

    Parameters
    ----------
    None

    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """

    u = {
        'hva_floor1_TSupAirSet_u': 273.15 + 12,
        'hva_floor1_TSupAirSet_activate': 1,
        'hva_floor1_oveZonCor_TZonCooSet_u': 273.15 + 24,
        'hva_floor1_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor1_oveZonCor_TZonHeaSet_u': 273.15 + 20,
        'hva_floor1_oveZonCor_TZonHeaSet_activate': 1,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_u': 1.0,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yDam_activate': 1,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_u': 0.01,
        #'hva_floor1_fivZonVAV_vAV1_oveZonLoc_yReaHea_activate': 1,
        'hva_floor2_TSupAirSet_u': 273.15 + 12,
        'hva_floor2_TSupAirSet_activate': 1,
        'hva_floor2_oveZonCor_TZonCooSet_u': 273.15 + 24,
        'hva_floor2_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor2_oveZonCor_TZonHeaSet_u': 273.15 + 20,
        'hva_floor2_oveZonCor_TZonHeaSet_activate': 1,  
        'hva_floor3_TSupAirSet_u': 273.15 + 12,
        'hva_floor3_TSupAirSet_activate': 1,
        'hva_floor3_oveZonCor_TZonCooSet_u': 273.15 + 24,
        'hva_floor3_oveZonCor_TZonCooSet_activate': 1,
        'hva_floor3_oveZonCor_TZonHeaSet_u': 273.15 + 20,
        'hva_floor3_oveZonCor_TZonHeaSet_activate': 1,              
    }

    return u
