# -*- coding: utf-8 -*-
import sys
"""
This module implements a simple P controller.

"""


def compute_control(y, predictions=[]):
    """Compute the control input from the measurement.

    Parameters
    ----------
    y : dict
        Contains the current values of the measurements.
        {<measurement_name>:<measurement_value>}
    predictions : list
        Temperature set point bounds.

    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """
    try:
        north_temp = y['TRooAirNor_y']
        south_temp = y['TRooAirSou_y']
    except KeyError:
        print("Temperature values ['TRooAirNor_y', 'TRooAirSou_y'] not in input: %s", y)
        sys.exit()

    # Extract set point information   
    north_sp_lower = predictions[0]
    north_sp_upper = predictions[1]
    lower_sp_south = predictions[2]
    upper_sp_south = predictions[3]

    # Controller parameters
    k_p = 2000

    # Compute control for north zone
    error_north = 0
    if north_temp < north_sp_lower:
        error_north = north_sp_lower - north_temp
    elif north_temp > north_sp_upper:
        error_north = north_sp_upper - north_temp

    # Compute control for south zone
    error_south = 0
    if south_temp < lower_sp_south:
        error_south = lower_sp_south - south_temp
    elif south_temp > upper_sp_south:
        error_south = upper_sp_south - south_temp

    value_north = k_p*error_north
    value_south = k_p*error_south
    u = {
        'oveActNor_u': value_north,
        'oveActNor_activate': 1,
        'oveActSou_u': value_south,
        'oveActSou_activate': 1
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
        'oveActNor_u': 0,
        'oveActNor_activate': 1,
        'oveActSou_u': 0,
        'oveActSou_activate': 1
    }

    return u


def update_forecast(prediction_config, forecast):
    """Update the control input from forecast.

    Parameters
    ----------
    prediction_config : list
        list of data points that names contained in forecast
        [<input_name1>, <input_name2>]
    forecast : dict
        dictionary of arrays with forecast data
        {<point_name1: [<data>]}

    Returns
    -------
    predictions : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """
    predictions = []
    if forecast:
        for j in range(len(prediction_config)):
            predictions.append(forecast[prediction_config[j]][0])
    else:
        print("Cannot do controller prediction - No forecast!")
    return predictions