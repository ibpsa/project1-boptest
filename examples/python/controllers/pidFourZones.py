# -*- coding: utf-8 -*-
"""
This module implements a simple P controller for the four zones of testcase3.
It uses BOPTEST forecasts to retrieve temperature limits shared by the zones.
"""

import pandas as pd


def compute_control(y, forecasts):
    """Compute one overwrite command for each zone."""

    try:
        temperatures = [y['TRooAirVec_{0}_y'.format(i)] for i in range(1, 5)]
    except KeyError as exc:
        raise KeyError(
            "Missing zone temperature measurement {0} in: {1}".format(exc, y)
        )

    try:
        lower = forecasts['LowerSetp[zon1]'].values[-1] # Setpoint identical for every zone
        upper = forecasts['UpperSetp[zon1]'].values[-1]
    except (KeyError, TypeError):
        raise KeyError(
            "LowerSetp[zon1] and UpperSetp[zon1] are required in forecasts."
        )

    k_p = 2000
    u = {}

    for i, temperature in enumerate(temperatures, start=1):
        if temperature < lower:
            error = lower - temperature
        elif temperature > upper:
            error = upper - temperature
        else:
            error = 0

        group = (i - 1) // 2 + 1
        nested = (i - 1) % 2 + 1
        point = 'ctrReaBlo_{0}_ctrReaBloNested_{1}_oveAct'.format(
            group, nested
        )
        u[point + '_u'] = k_p * error
        u[point + '_activate'] = 1

    return u


def initialize():
    """Initialize all four overwrite inputs to zero and activate them."""

    u = {}
    for group in range(1, 3):
        for nested in range(1, 3):
            point = 'ctrReaBlo_{0}_ctrReaBloNested_{1}_oveAct'.format(
                group, nested
            )
            u[point + '_u'] = 0
            u[point + '_activate'] = 1

    return u


def get_forecast_parameters():
    """Request the shared temperature limits used by the controller."""

    return {
        'point_names': ['LowerSetp[zon1]', 'UpperSetp[zon1]'],
        'horizon': 600,
        'interval': 300
    }


def update_forecasts(forecast_data, forecasts):
    """Append the first forecast value for each requested point."""

    forecast_config = get_forecast_parameters()['point_names']

    if forecasts is None:
        forecasts = pd.DataFrame(columns=forecast_config)

    for point in forecast_config:
        t = forecast_data['time'][0]
        forecasts.loc[t, point] = forecast_data[point][0]

    return forecasts
