# -*- coding: utf-8 -*-
"""
This module implements a simple P controller for room heater control specifically
for testcase3.  Note that it uses BOPTEST forecasts to retrieve the
zone temperature set points.

"""

import pandas as pd

def compute_control(y, forecasts):
    """Compute the control input from the measurement.

    Parameters
    ----------
    y : dict
        Contains the current values of the measurements.
        {<measurement_name>:<measurement_value>}
    forecasts : structure depends on controller
        Forecasts used to calculate control, defined in ``update_forecasts``..

    Returns
    -------
    u : dict
        Defines the control input to be used for the next step.
        {<input_name> : <input_value>}

    """

    # Check measurements
    try:
        north_temp = y['TRooAirNor_y']
        south_temp = y['TRooAirSou_y']
    except KeyError:
        raise KeyError("Temperature values ['TRooAirNor_y', 'TRooAirSou_y'] not in input: {0}".format(y))

    # Check forecasts and extract set point information
    try:
        north_sp_lower = forecasts['LowerSetp[North]'].values[-1]
        north_sp_upper = forecasts['UpperSetp[North]'].values[-1]
        lower_sp_south = forecasts['LowerSetp[South]'].values[-1]
        upper_sp_south = forecasts['UpperSetp[South]'].values[-1]
    except KeyError:
        raise KeyError("Temperature values ['LowerSetp[North]', 'UpperSetp[North]', 'LowerSetp[South]', 'UpperSetp[South]'] not in forecasts: {0}".format(forecasts.columns))

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

def get_forecast_parameters():
    """Get forecast parameters within the controller.

    Returns
    -------
    forecast_parameters: dict
        {'point_names':[<string>],
         'horizon': <int>,
         'interval': <int>}

    """

    forecast_parameters = {'point_names':['LowerSetp[North]',
                                          'UpperSetp[North]',
                                          'LowerSetp[South]',
                                          'UpperSetp[South]'],
                           'horizon': 600,
                           'interval': 300}


    return forecast_parameters

def update_forecasts(forecast_data, forecasts):
    """Update forecast_store within the controller.

    This controller only uses the first timestep of the forecast for upper
    and lower temperature limits.


    Parameters
    ----------
    forecast_data: dict
        Dictionary of arrays with forecast data from BOPTEST
        {<point_name1: [<data>]}
    forecasts: DataFrame
        DataFrame of forecast values used over time.

    Returns
    -------
    forecasts: DataFrame
        Updated DataFrame of forcast values used over time.

    """

    forecast_config = get_forecast_parameters()['point_names']

    if forecasts is None:
        forecasts = pd.DataFrame(columns=forecast_config)
    for i in forecast_config:
        t = forecast_data['time'][0]
        forecasts.loc[t,i] = forecast_data[i][0]

    return forecasts
