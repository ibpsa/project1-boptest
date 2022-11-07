# -*- coding: utf-8 -*-
"""
This module sets the zone air temperatures for testcase multizone_large_office_eplus.

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
    
    if (HourOfDay<=6)|(HourOfDay>21):
        TZonAir = 273.15+28
    elif (HourOfDay>=15) and (HourOfDay<18):
        TZonAir = 273.15+22
    else:
        TZonAir = 273.15+24
    
    # Compute control
    u = {
         'EPlus96_oveTZonAirBotCor_u':TZonAir,
         'EPlus96_oveTZonAirBotCor_activate':1,
         'EPlus96_oveTZonAirBotEas_u':TZonAir,
         'EPlus96_oveTZonAirBotEas_activate':1,
         'EPlus96_oveTZonAirBotNor_u':TZonAir,
         'EPlus96_oveTZonAirBotNor_activate':1,
         'EPlus96_oveTZonAirBotSou_u':TZonAir,
         'EPlus96_oveTZonAirBotSou_activate':1,
         'EPlus96_oveTZonAirBotWes_u':TZonAir,
         'EPlus96_oveTZonAirBotWes_activate':1,
         'EPlus96_oveTZonAirMidCor_u':TZonAir,
         'EPlus96_oveTZonAirMidCor_activate':1,
         'EPlus96_oveTZonAirMidEas_u':TZonAir,
         'EPlus96_oveTZonAirMidEas_activate':1,
         'EPlus96_oveTZonAirMidNor_u':TZonAir,
         'EPlus96_oveTZonAirMidNor_activate':1,
         'EPlus96_oveTZonAirMidSou_u':TZonAir,
         'EPlus96_oveTZonAirMidSou_activate':1,
         'EPlus96_oveTZonAirMidWes_u':TZonAir,
         'EPlus96_oveTZonAirMidWes_activate':1,
         'EPlus96_oveTZonAirTopCor_u':TZonAir,
         'EPlus96_oveTZonAirTopCor_activate':1,
         'EPlus96_oveTZonAirTopEas_u':TZonAir,
         'EPlus96_oveTZonAirTopEas_activate':1,
         'EPlus96_oveTZonAirTopNor_u':TZonAir,
         'EPlus96_oveTZonAirTopNor_activate':1,
         'EPlus96_oveTZonAirTopSou_u':TZonAir,
         'EPlus96_oveTZonAirTopSou_activate':1,
         'EPlus96_oveTZonAirTopWes_u':TZonAir,
         'EPlus96_oveTZonAirTopWes_activate':1
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
    TZonAir = 273.15+28
    
    u = {
         'EPlus96_oveTZonAirBotCor_u':TZonAir,
         'EPlus96_oveTZonAirBotCor_activate':1,
         'EPlus96_oveTZonAirBotEas_u':TZonAir,
         'EPlus96_oveTZonAirBotEas_activate':1,
         'EPlus96_oveTZonAirBotNor_u':TZonAir,
         'EPlus96_oveTZonAirBotNor_activate':1,
         'EPlus96_oveTZonAirBotSou_u':TZonAir,
         'EPlus96_oveTZonAirBotSou_activate':1,
         'EPlus96_oveTZonAirBotWes_u':TZonAir,
         'EPlus96_oveTZonAirBotWes_activate':1,
         'EPlus96_oveTZonAirMidCor_u':TZonAir,
         'EPlus96_oveTZonAirMidCor_activate':1,
         'EPlus96_oveTZonAirMidEas_u':TZonAir,
         'EPlus96_oveTZonAirMidEas_activate':1,
         'EPlus96_oveTZonAirMidNor_u':TZonAir,
         'EPlus96_oveTZonAirMidNor_activate':1,
         'EPlus96_oveTZonAirMidSou_u':TZonAir,
         'EPlus96_oveTZonAirMidSou_activate':1,
         'EPlus96_oveTZonAirMidWes_u':TZonAir,
         'EPlus96_oveTZonAirMidWes_activate':1,
         'EPlus96_oveTZonAirTopCor_u':TZonAir,
         'EPlus96_oveTZonAirTopCor_activate':1,
         'EPlus96_oveTZonAirTopEas_u':TZonAir,
         'EPlus96_oveTZonAirTopEas_activate':1,
         'EPlus96_oveTZonAirTopNor_u':TZonAir,
         'EPlus96_oveTZonAirTopNor_activate':1,
         'EPlus96_oveTZonAirTopSou_u':TZonAir,
         'EPlus96_oveTZonAirTopSou_activate':1,
         'EPlus96_oveTZonAirTopWes_u':TZonAir,
         'EPlus96_oveTZonAirTopWes_activate':1,
    }

    return u
