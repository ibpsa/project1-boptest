# -*- coding: utf-8 -*-
"""
This module sets the zone air temperatures for testcase multizone_office_complex_air.

"""


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
    
    HourOfDay = int((y['time']%86400)/3600)
    
    if (HourOfDay <= 6) or (HourOfDay > 21):
        TCHWSet = 273.15 + 5.56
        TSupAir = 273.15 + 12.88
    elif 15 <= HourOfDay < 18:
        TCHWSet = 273.15 + 7
        TSupAir = 273.15 + 13
    else:
        TCHWSet = 273.15 + 8
        TSupAir = 273.15 + 11

    # Compute control
    u = {
         'hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1, 
         'hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0,
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400, 
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u': 1,
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1,
         'hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400,
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u':  1,
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0,
         'hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1,
         'hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0, 
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400,
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u': 1,
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0, 
         'hvac_oveFloor1TDisAir_u': TSupAir,
         'hvac_oveFloor1TDisAir_activate': 1,
         'hvac_oveFloor2TDisAir_u': TSupAir,
         'hvac_oveFloor2TDisAir_activate': 1,
         'hvac_oveFloor3TDisAir_u': TSupAir,
         'hvac_oveFloor3TDisAir_activate': 1, 
         'hvac_oveTCHWSet_u': TCHWSet,
         'hvac_oveTCHWSet_activate': 1,
         'hvac_oveTHWSet_u':  353.15,
         'hvac_oveTHWSet_activate': 0      
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
         'hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1, 
         'hvac_floor1_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0,
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400, 
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u': 1,
         'hvac_floor1_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1,
         'hvac_floor2_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400,
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u':  1,
         'hvac_floor2_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0,
         'hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_u': 1,
         'hvac_floor3_duaFanAirHanUnit_mixingBox_oveEcoDam_activate': 0, 
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_u': 400,
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_ovePreSetPoi_activate': 0, 
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_u': 1,
         'hvac_floor3_duaFanAirHanUnit_supFan_variableSpeed_oveSpeSup_activate': 0, 
         'hvac_oveFloor1TDisAir_u': 286.03,
         'hvac_oveFloor1TDisAir_activate': 1,
         'hvac_oveFloor2TDisAir_u': 286.03,
         'hvac_oveFloor2TDisAir_activate': 1,
         'hvac_oveFloor3TDisAir_u': 286.03,
         'hvac_oveFloor3TDisAir_activate': 1, 
         'hvac_oveTCHWSet_u': 278.71,
         'hvac_oveTCHWSet_activate': 1,
         'hvac_oveTHWSet_u':  353.15,
         'hvac_oveTHWSet_activate': 0      
    }
    return u
