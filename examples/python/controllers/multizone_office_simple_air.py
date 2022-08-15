# -*- coding: utf-8 -*-
"""
This module implements a supervisory controller for room temperature set points
specifically for testcase2.

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

    # Compute control
    u = {
        'hvac_oveZonActSou_yDam_u':0,
        'hvac_oveZonActSou_yDam_activate':0,
        'hvac_oveZonSupEas_TZonHeaSet_u':287.15,
        'hvac_oveZonSupEas_TZonHeaSet_activate':0,
        'hvac_oveZonSupWes_TZonHeaSet_u':287.15,
        'hvac_oveZonSupWes_TZonHeaSet_activate':0,
        'hvac_oveAhu_yRet_u':0,
        'hvac_oveAhu_yRet_activate':0,
        'hvac_oveZonSupSou_TZonHeaSet_u':287.15,
        'hvac_oveZonSupSou_TZonHeaSet_activate':0,
        'hvac_oveZonActCor_yReaHea_u':0,
        'hvac_oveZonActCor_yReaHea_activate':0,
        'hvac_oveZonActEas_yDam_u':0,
        'hvac_oveZonActEas_yDam_activate':0,
        'hvac_oveAhu_yPumCoo_u':0,
        'hvac_oveAhu_yPumCoo_activate':0,
        'hvac_oveZonSupSou_TZonCooSet_u':287.15,
        'hvac_oveZonSupSou_TZonCooSet_activate':0,
        'hvac_oveZonSupWes_TZonCooSet_u':287.15,
        'hvac_oveZonSupWes_TZonCooSet_activate':0,
        'hvac_oveAhu_yFan_u':0,
        'hvac_oveAhu_yFan_activate':0,
        'hvac_oveZonSupNor_TZonHeaSet_u':287.15,
        'hvac_oveZonSupNor_TZonHeaSet_activate':0,
        'hvac_oveAhu_TSupSet_u':287.15,
        'hvac_oveAhu_TSupSet_activate':0,
        'hvac_oveZonActCor_yDam_u':0,
        'hvac_oveZonActCor_yDam_activate':0,
        'hvac_oveZonSupNor_TZonCooSet_u':287.15,
        'hvac_oveZonSupNor_TZonCooSet_activate':0,
        'hvac_oveAhu_yCoo_u':0,
        'hvac_oveAhu_yCoo_activate':0,
        'hvac_oveZonActSou_yReaHea_u':0,
        'hvac_oveZonActSou_yReaHea_activate':0,
        'hvac_oveZonSupCor_TZonCooSet_u':287.15,
        'hvac_oveZonSupCor_TZonCooSet_activate':0,
        'hvac_oveAhu_yPumHea_u':0,
        'hvac_oveAhu_yPumHea_activate':0,
        'hvac_oveZonActWes_yReaHea_u':0,
        'hvac_oveZonActWes_yReaHea_activate':0,
        'hvac_oveZonActNor_yDam_u':0,
        'hvac_oveZonActNor_yDam_activate':0,
        'hvac_oveZonSupEas_TZonCooSet_u':287.15,
        'hvac_oveZonSupEas_TZonCooSet_activate':0,
        'hvac_oveAhu_dpSet_u':280,
        'hvac_oveAhu_dpSet_activate':0,
        'hvac_oveAhu_yOA_u':0,
        'hvac_oveAhu_yOA_activate':0,
        'hvac_oveZonActNor_yReaHea_u':0,
        'hvac_oveZonActNor_yReaHea_activate':0,
        'hvac_oveZonActWes_yDam_u':0,
        'hvac_oveZonActWes_yDam_activate':0,
        'hvac_oveAhu_yHea_u':0,
        'hvac_oveAhu_yHea_activate':0,
        'hvac_oveZonSupCor_TZonHeaSet_u':287.15,
        'hvac_oveZonSupCor_TZonHeaSet_activate':0,
        'hvac_oveZonActEas_yReaHea_u':0,
        'hvac_oveZonActEas_yReaHea_activate':0
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
        'hvac_oveZonActSou_yDam_u':0,
        'hvac_oveZonActSou_yDam_activate':0,
        'hvac_oveZonSupEas_TZonHeaSet_u':287.15,
        'hvac_oveZonSupEas_TZonHeaSet_activate':0,
        'hvac_oveZonSupWes_TZonHeaSet_u':287.15,
        'hvac_oveZonSupWes_TZonHeaSet_activate':0,
        'hvac_oveAhu_yRet_u':0,
        'hvac_oveAhu_yRet_activate':0,
        'hvac_oveZonSupSou_TZonHeaSet_u':287.15,
        'hvac_oveZonSupSou_TZonHeaSet_activate':0,
        'hvac_oveZonActCor_yReaHea_u':0,
        'hvac_oveZonActCor_yReaHea_activate':0,
        'hvac_oveZonActEas_yDam_u':0,
        'hvac_oveZonActEas_yDam_activate':0,
        'hvac_oveAhu_yPumCoo_u':0,
        'hvac_oveAhu_yPumCoo_activate':0,
        'hvac_oveZonSupSou_TZonCooSet_u':287.15,
        'hvac_oveZonSupSou_TZonCooSet_activate':0,
        'hvac_oveZonSupWes_TZonCooSet_u':287.15,
        'hvac_oveZonSupWes_TZonCooSet_activate':0,
        'hvac_oveAhu_yFan_u':0,
        'hvac_oveAhu_yFan_activate':0,
        'hvac_oveZonSupNor_TZonHeaSet_u':287.15,
        'hvac_oveZonSupNor_TZonHeaSet_activate':0,
        'hvac_oveAhu_TSupSet_u':287.15,
        'hvac_oveAhu_TSupSet_activate':0,
        'hvac_oveZonActCor_yDam_u':0,
        'hvac_oveZonActCor_yDam_activate':0,
        'hvac_oveZonSupNor_TZonCooSet_u':287.15,
        'hvac_oveZonSupNor_TZonCooSet_activate':0,
        'hvac_oveAhu_yCoo_u':0,
        'hvac_oveAhu_yCoo_activate':0,
        'hvac_oveZonActSou_yReaHea_u':0,
        'hvac_oveZonActSou_yReaHea_activate':0,
        'hvac_oveZonSupCor_TZonCooSet_u':287.15,
        'hvac_oveZonSupCor_TZonCooSet_activate':0,
        'hvac_oveAhu_yPumHea_u':0,
        'hvac_oveAhu_yPumHea_activate':0,
        'hvac_oveZonActWes_yReaHea_u':0,
        'hvac_oveZonActWes_yReaHea_activate':0,
        'hvac_oveZonActNor_yDam_u':0,
        'hvac_oveZonActNor_yDam_activate':0,
        'hvac_oveZonSupEas_TZonCooSet_u':287.15,
        'hvac_oveZonSupEas_TZonCooSet_activate':0,
        'hvac_oveAhu_dpSet_u':280,
        'hvac_oveAhu_dpSet_activate':0,
        'hvac_oveAhu_yOA_u':0,
        'hvac_oveAhu_yOA_activate':0,
        'hvac_oveZonActNor_yReaHea_u':0,
        'hvac_oveZonActNor_yReaHea_activate':0,
        'hvac_oveZonActWes_yDam_u':0,
        'hvac_oveZonActWes_yDam_activate':0,
        'hvac_oveAhu_yHea_u':0,
        'hvac_oveAhu_yHea_activate':0,
        'hvac_oveZonSupCor_TZonHeaSet_u':287.15,
        'hvac_oveZonSupCor_TZonHeaSet_activate':0,
        'hvac_oveZonActEas_yReaHea_u':0,
        'hvac_oveZonActEas_yReaHea_activate':0
    }

    return u
