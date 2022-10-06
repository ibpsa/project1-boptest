# -*- coding: utf-8 -*-
"""
This module implements a baseline control for testcase bestest_hydronic.

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
        'ovePum_u': 1,
        'ovePum_activate': 0,
        'oveTSetHea_u': 289.15,
        'oveTSetHea_activate': 0,
        'oveTSetSup_u': 295.15,
        'oveTSetSup_activate': 0,
        'oveTSetCoo_u': 297.15,
        'oveTSetCoo_activate': 0
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
        'ovePum_u': 1,
        'ovePum_activate': 0,
        'oveTSetHea_u': 289.15,
        'oveTSetHea_activate': 0,
        'oveTSetSup_u': 295.15,
        'oveTSetSup_activate': 0,
        'oveTSetCoo_u': 297.15,
        'oveTSetCoo_activate': 0
    }

    return u
