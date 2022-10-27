# -*- coding: utf-8 -*-
"""
This module implements a baseline control for testcase multizone_large_office_eplus.

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
        TZonCooSet = 273.15+28
    elif (HourOfDay>=15)|(HourOfDay<18):
        TZonCooSet = 273.15+22
    else:
        TZonCooSet = 273.15+24
    
    # Compute control
    u = {
         'EPlus96_oveTZonBotCor_u':TZonCooSet,
         'EPlus96_oveTZonBotCor_activate':1,
         'EPlus96_oveTZonBotEas_u':TZonCooSet,
         'EPlus96_oveTZonBotEas_activate':1,
         'EPlus96_oveTZonBotNor_u':TZonCooSet,
         'EPlus96_oveTZonBotNor_activate':1,
         'EPlus96_oveTZonBotSou_u':TZonCooSet,
         'EPlus96_oveTZonBotSou_activate':1,
         'EPlus96_oveTZonBotWes_u':TZonCooSet,
         'EPlus96_oveTZonBotWes_activate':1,
         'EPlus96_oveTZonMidCor_u':TZonCooSet,
         'EPlus96_oveTZonMidCor_activate':1,
         'EPlus96_oveTZonMidEas_u':TZonCooSet,
         'EPlus96_oveTZonMidEas_activate':1,
         'EPlus96_oveTZonMidNor_u':TZonCooSet,
         'EPlus96_oveTZonMidNor_activate':1,
         'EPlus96_oveTZonMidSou_u':TZonCooSet,
         'EPlus96_oveTZonMidSou_activate':1,
         'EPlus96_oveTZonMidWes_u':TZonCooSet,
         'EPlus96_oveTZonMidWes_activate':1,
         'EPlus96_oveTZonTopCor_u':TZonCooSet,
         'EPlus96_oveTZonTopCor_activate':1,
         'EPlus96_oveTZonTopEas_u':TZonCooSet,
         'EPlus96_oveTZonTopEas_activate':1,
         'EPlus96_oveTZonTopNor_u':TZonCooSet,
         'EPlus96_oveTZonTopNor_activate':1,
         'EPlus96_oveTZonTopSou_u':TZonCooSet,
         'EPlus96_oveTZonTopSou_activate':1,
         'EPlus96_oveTZonTopWes_u':TZonCooSet,
         'EPlus96_oveTZonTopWes_activate':1
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
    TZonCooSet = 297.15
    
    u = {
         'EPlus96_oveTZonBotCor_u':TZonCooSet,
         'EPlus96_oveTZonBotCor_activate':1,
         'EPlus96_oveTZonBotEas_u':TZonCooSet,
         'EPlus96_oveTZonBotEas_activate':1,
         'EPlus96_oveTZonBotNor_u':TZonCooSet,
         'EPlus96_oveTZonBotNor_activate':1,
         'EPlus96_oveTZonBotSou_u':TZonCooSet,
         'EPlus96_oveTZonBotSou_activate':1,
         'EPlus96_oveTZonBotWes_u':TZonCooSet,
         'EPlus96_oveTZonBotWes_activate':1,
         'EPlus96_oveTZonMidCor_u':TZonCooSet,
         'EPlus96_oveTZonMidCor_activate':1,
         'EPlus96_oveTZonMidEas_u':TZonCooSet,
         'EPlus96_oveTZonMidEas_activate':1,
         'EPlus96_oveTZonMidNor_u':TZonCooSet,
         'EPlus96_oveTZonMidNor_activate':1,
         'EPlus96_oveTZonMidSou_u':TZonCooSet,
         'EPlus96_oveTZonMidSou_activate':1,
         'EPlus96_oveTZonMidWes_u':TZonCooSet,
         'EPlus96_oveTZonMidWes_activate':1,
         'EPlus96_oveTZonTopCor_u':TZonCooSet,
         'EPlus96_oveTZonTopCor_activate':1,
         'EPlus96_oveTZonTopEas_u':TZonCooSet,
         'EPlus96_oveTZonTopEas_activate':1,
         'EPlus96_oveTZonTopNor_u':TZonCooSet,
         'EPlus96_oveTZonTopNor_activate':1,
         'EPlus96_oveTZonTopSou_u':TZonCooSet,
         'EPlus96_oveTZonTopSou_activate':1,
         'EPlus96_oveTZonTopWes_u':TZonCooSet,
         'EPlus96_oveTZonTopWes_activate':1,
    }

    return u
