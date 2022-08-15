# -*- coding: utf-8 -*-
"""
This module implements a baseline control for testcase bestest_air.

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
        'con_oveTSetCoo_u': 297.15,
        'con_oveTSetCoo_activate': 0,
        'con_oveTSetHea_u': 289.15,
        'con_oveTSetHea_activate': 0,
        'fcu_oveTSup_u': 286.15,
        'fcu_oveTSup_activate': 0,
        'fcu_oveFan_u': 0.5,
        'fcu_oveFan_activate': 0
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
        'con_oveTSetCoo_u': 297.15,
        'con_oveTSetCoo_activate': 0,
        'con_oveTSetHea_u': 289.15,
        'con_oveTSetHea_activate': 0,
        'fcu_oveTSup_u': 286.15,
        'fcu_oveTSup_activate': 0,
        'fcu_oveFan_u': 0.5,
        'fcu_oveFan_activate': 0
    }

    return u
