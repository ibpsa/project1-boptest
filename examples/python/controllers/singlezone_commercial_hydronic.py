# -*- coding: utf-8 -*-
"""
This module implements a baseline control for testcase singlezone_commercial_hydronic.

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
        'ahu_oveFanRet_u': 1,
        'ahu_oveFanRet_activate': 0,
        'oveValRad_u': 0.5,
        'oveValRad_activate': 0,
        'oveCO2ZonSet_u': 500,
        'oveCO2ZonSet_activate': 0,
        'ahu_oveFanSup_u': 0.15,
        'ahu_oveFanSup_activate': 0,
        'ovePum_u': 1,
        'ovePum_activate': 0,
        'oveValCoi_u': 0.5,
        'oveValCoi_activate': 0,
        'oveTZonSet_u': 285.15,
        'oveTZonSet_activate': 0,
        'oveTSupSet_u': 285.15,
        'oveTSupSet_activate': 0  
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
        'ahu_oveFanRet_u': 1,
        'ahu_oveFanRet_activate': 0,
        'oveValRad_u': 0.5,
        'oveValRad_activate': 0,
        'oveCO2ZonSet_u': 500,
        'oveCO2ZonSet_activate': 0,
        'ahu_oveFanSup_u': 0.15,
        'ahu_oveFanSup_activate': 0,
        'ovePum_u': 1,
        'ovePum_activate': 0,
        'oveValCoi_u': 0.5,
        'oveValCoi_activate': 0,
        'oveTZonSet_u': 285.15,
        'oveTZonSet_activate': 0,
        'oveTSupSet_u': 285.15,
        'oveTSupSet_activate': 0
    }

    return u
