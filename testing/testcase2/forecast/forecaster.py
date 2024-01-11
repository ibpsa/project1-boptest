'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Forecaster class with methods to obtain
forecast data for the test case. It relies on the data_manager object
of the test case to provide deterministic forecast.

'''
from .error_emulator import predict_temperature_error_AR1, predict_solar_error_AR1,mean_filter
import numpy as np


class Forecaster(object):
    '''This class retrieves test case data forecast for its use in
    optimal control strategies.

    '''

    def __init__(self, testcase):
        '''
        Constructor

        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case that
            contains the data stored from the test case run

        '''

        # Point to the test case object
        self.case = testcase

    def get_forecast(self, point_names, horizon=24 * 3600, interval=3600,
                     weather_temperature_dry_bulb=None, weather_solar_global_horizontal=None,
                     category=None, plot=False):

        if weather_temperature_dry_bulb is None:
            weather_temperature_dry_bulb = {
                "F0": 0, "K0": 0, "F": 0, "K": 0, "mu": 0
            }

        if weather_solar_global_horizontal is None:
            weather_solar_global_horizontal = {
                "ag0": 0, "bg0": 0, "phi": 0, "ag": 0, "bg": 0
            }
        # Get the forecast
        forecast = self.case.data_manager.get_data(variables=point_names,
                                                   horizon=horizon,
                                                   interval=interval,
                                                   category=category,
                                                   plot=plot)
        if 'TDryBul' in point_names and any(weather_temperature_dry_bulb.values()):
            # error in the forecast
            error_forecast_temp = predict_temperature_error_AR1(
                hp=horizon / interval + 1,
                F0=weather_temperature_dry_bulb["F0"],
                K0=weather_temperature_dry_bulb["K0"],
                F=weather_temperature_dry_bulb["F"],
                K=weather_temperature_dry_bulb["K"],
                mu=weather_temperature_dry_bulb["mu"]
            )

            # forecast error just added to dry bulb temperature
            forecast['TDryBul'] = forecast['TDryBul'] + error_forecast_temp
            forecast['TDryBul']=forecast['TDryBul'].tolist()
        if 'HGloHor' in point_names and any(weather_solar_global_horizontal.values()):

            original_HGloHor = np.array(forecast['HGloHor']).copy()
            lower_bound = 0.2 * original_HGloHor
            upper_bound = 2 * original_HGloHor
            indices = np.where(original_HGloHor > 50)[0]
            for _ in range(200):
            # while True:
                error_forecast_solar = predict_solar_error_AR1(
                    horizon / interval + 1,
                    weather_solar_global_horizontal["ag0"],
                    weather_solar_global_horizontal["bg0"],
                    weather_solar_global_horizontal["phi"],
                    weather_solar_global_horizontal["ag"],
                    weather_solar_global_horizontal["bg"]
                )

                forecast['HGloHor'] = original_HGloHor + error_forecast_solar

                # Check if any point in forecast['HGloHor'] is out of the specified range

                condition = np.any((forecast['HGloHor'][indices] > 2 * original_HGloHor[indices]) |
                               (forecast['HGloHor'][indices] < 0.2 * original_HGloHor[indices]))
                # forecast['HGloHor']=gaussian_filter_ignoring_nans(forecast['HGloHor'])
                forecast['HGloHor'] = mean_filter(forecast['HGloHor'])
                forecast['HGloHor'] = np.clip(forecast['HGloHor'], lower_bound, upper_bound)
                forecast['HGloHor']=forecast['HGloHor'].tolist()
                if not condition:
                    break

        return forecast
