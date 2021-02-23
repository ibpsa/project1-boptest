# -*- coding: utf-8 -*-
"""
This module implements a simple P controller.

"""


def compute_control(y):
    """Compute the control input from the measurement.

    Parameters
    ----------
    y : dict
        Contains the current values of the measurements.
        {<measurement_name>:<measurement_value>}

    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """
    # Compute control
    u = {
        'oveTSetRooHea_u': 22 + 273.15,
        'oveTSetRooHea_activate': 1,
        'oveTSetRooCoo_u': 23 + 273.15,
        'oveTSetRooCoo_activate': 1
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
        'oveTSetRooHea_u': 22 + 273.15,
        'oveTSetRooHea_activate': 1,
        'oveTSetRooCoo_u': 23 + 273.15,
        'oveTSetRooCoo_activate': 1
    }
    return u
