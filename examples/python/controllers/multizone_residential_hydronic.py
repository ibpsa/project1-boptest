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
        'conHeaRo2_oveActHea_u':0,
        'conHeaRo2_oveActHea_activate':0,
        'conHeaLiv_oveTSetHea_u':283.15,
        'conHeaLiv_oveTSetHea_activate':0,
        'conHeaRo3_oveActHea_u':0,
        'conHeaRo3_oveActHea_activate':0,
        'conCooLiv_oveCoo_u':0,
        'conCooLiv_oveCoo_activate':0,
        'oveTSetPum_u':283.15,
        'oveTSetPum_activate':0,
        'conHeaRo1_oveActHea_u':0,
        'conHeaRo1_oveActHea_activate':0,
        'conHeaLiv_oveActHea_u':0,
        'conHeaLiv_oveActHea_activate':0,
        'conHeaRo2_oveTSetHea_u':283.15,
        'conHeaRo2_oveTSetHea_activate':0,
        'oveEmiPum_u':0,
        'oveEmiPum_activate':0,
        'conCooRo1_oveTSetCoo_u':283.15,
        'conCooRo1_oveTSetCoo_activate':0,
        'conCooHal_oveTSetCoo_u':283.15,
        'conCooHal_oveTSetCoo_activate':0,
        'conCooLiv_oveTSetCoo_u':283.15,
        'conCooLiv_oveTSetCoo_activate':0,
        'conCooBth_oveCoo_u':0,
        'conCooBth_oveCoo_activate':0,
        'oveMixValSup_u':0,
        'oveMixValSup_activate':0,
        'conCooRo3_oveTSetCoo_u':283.15,
        'conCooRo3_oveTSetCoo_activate':0,
        'conCooRo1_oveCoo_u':0,
        'conCooRo1_oveCoo_activate':0,
        'conHeaBth_oveTSetHea_u':283.15,
        'conHeaBth_oveTSetHea_activate':0,
        'conCooBth_oveTSetCoo_u':283.15,
        'conCooBth_oveTSetCoo_activate':0,
        'conCooRo2_oveTSetCoo_u':283.15,
        'conCooRo2_oveTSetCoo_activate':0,
        'oveTSetSup_u':283.15,
        'oveTSetSup_activate':0,
        'conHeaRo3_oveTSetHea_u':283.15,
        'conHeaRo3_oveTSetHea_activate':0,
        'conCooRo3_oveCoo_u':0,
        'conCooRo3_oveCoo_activate':0,
        'conCooHal_oveCoo_u':0,
        'conCooHal_oveCoo_activate':0,
        'conCooRo2_oveCoo_u':0,
        'conCooRo2_oveCoo_activate':0,
        'boi_oveBoi_u':0,
        'boi_oveBoi_activate':0,
        'conHeaRo1_oveTSetHea_u':283.15,
        'conHeaRo1_oveTSetHea_activate':0,
        'conHeaBth_oveActHea_u':0,
        'conHeaBth_oveActHea_activate':0
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
        'conHeaRo2_oveActHea_u':0,
        'conHeaRo2_oveActHea_activate':0,
        'conHeaLiv_oveTSetHea_u':283.15,
        'conHeaLiv_oveTSetHea_activate':0,
        'conHeaRo3_oveActHea_u':0,
        'conHeaRo3_oveActHea_activate':0,
        'conCooLiv_oveCoo_u':0,
        'conCooLiv_oveCoo_activate':0,
        'oveTSetPum_u':283.15,
        'oveTSetPum_activate':0,
        'conHeaRo1_oveActHea_u':0,
        'conHeaRo1_oveActHea_activate':0,
        'conHeaLiv_oveActHea_u':0,
        'conHeaLiv_oveActHea_activate':0,
        'conHeaRo2_oveTSetHea_u':283.15,
        'conHeaRo2_oveTSetHea_activate':0,
        'oveEmiPum_u':0,
        'oveEmiPum_activate':0,
        'conCooRo1_oveTSetCoo_u':283.15,
        'conCooRo1_oveTSetCoo_activate':0,
        'conCooHal_oveTSetCoo_u':283.15,
        'conCooHal_oveTSetCoo_activate':0,
        'conCooLiv_oveTSetCoo_u':283.15,
        'conCooLiv_oveTSetCoo_activate':0,
        'conCooBth_oveCoo_u':0,
        'conCooBth_oveCoo_activate':0,
        'oveMixValSup_u':0,
        'oveMixValSup_activate':0,
        'conCooRo3_oveTSetCoo_u':283.15,
        'conCooRo3_oveTSetCoo_activate':0,
        'conCooRo1_oveCoo_u':0,
        'conCooRo1_oveCoo_activate':0,
        'conHeaBth_oveTSetHea_u':283.15,
        'conHeaBth_oveTSetHea_activate':0,
        'conCooBth_oveTSetCoo_u':283.15,
        'conCooBth_oveTSetCoo_activate':0,
        'conCooRo2_oveTSetCoo_u':283.15,
        'conCooRo2_oveTSetCoo_activate':0,
        'oveTSetSup_u':283.15,
        'oveTSetSup_activate':0,
        'conHeaRo3_oveTSetHea_u':283.15,
        'conHeaRo3_oveTSetHea_activate':0,
        'conCooRo3_oveCoo_u':0,
        'conCooRo3_oveCoo_activate':0,
        'conCooHal_oveCoo_u':0,
        'conCooHal_oveCoo_activate':0,
        'conCooRo2_oveCoo_u':0,
        'conCooRo2_oveCoo_activate':0,
        'boi_oveBoi_u':0,
        'boi_oveBoi_activate':0,
        'conHeaRo1_oveTSetHea_u':283.15,
        'conHeaRo1_oveTSetHea_activate':0,
        'conHeaBth_oveActHea_u':0,
        'conHeaBth_oveActHea_activate':0
    }

    return u
