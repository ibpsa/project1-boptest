'''
Created on Apr 25, 2019

@author: Javier Arroyo, Laura Zabala and Wanfu Zheng

This module contains the Forecaster class with methods to obtain
forecast data for the test case. It relies on the data_manager object
of the test case to provide deterministic forecast.

'''
from .error_emulator import predict_temperature_error_AR1, predict_solar_error_AR1, mean_filter
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
                     wea_tem_dry_bul=None, wea_sol_glo_hor=None, seed=None):
        '''
        Retrieves forecast data for specified points over a given horizon and interval.

        Parameters
        ----------
        point_names : list of str
            List of data point names for which the forecast is to be retrieved.
        horizon : int, optional
            Forecast horizon in seconds (default is 86400 seconds, i.e., one day).
        interval : int, optional
            Time interval between forecast points in seconds (default is 3600 seconds, i.e., one hour).
        wea_tem_dry_bul : dict, optional
            Parameters for the AR1 model to simulate forecast error in dry bulb temperature:
                - F0, K0, F, K, mu : parameters used in the AR1 model.
            If None, defaults to a dictionary with all parameters set to zero, simulating no forecast error.
        wea_sol_glo_hor : dict, optional
            Parameters for the AR1 model to simulate forecast error in global horizontal solar irradiation:
                - ag0, bg0, phi, ag, bg : parameters used in the AR1 model.
            If None, defaults to a dictionary with all parameters set to zero, simulating no forecast error.
        seed : int, optional
            Seed for the random number generator to ensure reproducibility of the stochastic forecast error.

        Returns
        -------
        forecast : dict
            A dictionary containing the forecast data for the requested points with applied error models.

        '''

        if wea_tem_dry_bul is None:
            wea_tem_dry_bul = {
                "F0": 0, "K0": 0, "F": 0, "K": 0, "mu": 0
            }

        if wea_sol_glo_hor is None:
            wea_sol_glo_hor = {
                "ag0": 0, "bg0": 0, "phi": 0, "ag": 0, "bg": 0
            }
        # Get the forecast
        forecast = self.case.data_manager.get_data(variables=point_names,
                                                   horizon=horizon,
                                                   interval=interval)

        if 'TDryBul' in point_names and any(wea_tem_dry_bul.values()):
            if seed is not None:
                np.random.seed(seed)
            # error in the forecast
            error_forecast_temp = predict_temperature_error_AR1(
                hp=int(horizon / interval + 1),
                F0=wea_tem_dry_bul["F0"],
                K0=wea_tem_dry_bul["K0"],
                F=wea_tem_dry_bul["F"],
                K=wea_tem_dry_bul["K"],
                mu=wea_tem_dry_bul["mu"]
            )

            # forecast error just added to dry bulb temperature
            forecast['TDryBul'] = forecast['TDryBul'] - error_forecast_temp
            forecast['TDryBul'] = forecast['TDryBul'].tolist()
        if 'HGloHor' in point_names and any(wea_sol_glo_hor.values()):

            original_HGloHor = np.array(forecast['HGloHor']).copy()
            lower_bound = 0.2 * original_HGloHor
            upper_bound = 2 * original_HGloHor
            indices = np.where(original_HGloHor > 50)[0]


            for i in range(200):
                if seed is not None:
                    np.random.seed(seed+i*i)
                error_forecast_solar = predict_solar_error_AR1(
                    int(horizon / interval + 1),
                    wea_sol_glo_hor["ag0"],
                    wea_sol_glo_hor["bg0"],
                    wea_sol_glo_hor["phi"],
                    wea_sol_glo_hor["ag"],
                    wea_sol_glo_hor["bg"]
                )

                forecast['HGloHor'] = original_HGloHor - error_forecast_solar

                # Check if any point in forecast['HGloHor'] is out of the specified range
                condition = np.any((forecast['HGloHor'][indices] > 2 * original_HGloHor[indices]) |
                                   (forecast['HGloHor'][indices] < 0.2 * original_HGloHor[indices]))
                # forecast['HGloHor']=gaussian_filter_ignoring_nans(forecast['HGloHor'])
                forecast['HGloHor'] = mean_filter(forecast['HGloHor'])
                forecast['HGloHor'] = np.clip(forecast['HGloHor'], lower_bound, upper_bound)
                forecast['HGloHor'] = forecast['HGloHor'].tolist()
                if not condition:
                    break

        return forecast
