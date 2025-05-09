'''
Created on Apr 25, 2019

@author: Javier Arroyo, Laura Zabala, and Wanfu Zheng

This module contains the Forecaster class with methods to obtain
forecast data for the test case. It relies on the data_manager object
of the test case to provide a deterministic forecast, and the
error_emulator module to generate errors for uncertain forecasts.

'''
from .error_emulator import predict_temperature_error_AR1, predict_solar_error_AR1, mean_filter
import numpy as np
import json


class Forecaster(object):
    '''
    This class retrieves test case data forecast for its use in optimal control strategies.

    '''

    def __init__(self, testcase, forecast_uncertainty_params_path='forecast/forecast_uncertainty_params.json'):
        '''
        Constructor

        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case that
            contains the data stored from the test case run
        forecast_uncertainty_params_path : str, optional
            Path to the JSON file containing the uncertainty parameters.
            Default is 'forecast/forecast_uncertainty_params.json'.

        '''

        # Point to the test case object
        self.case = testcase
        # Load forecast uncertainty parameters
        self.uncertainty_params = self.load_uncertainty_params(forecast_uncertainty_params_path)

    def get_forecast(self, point_names, horizon=24*3600, interval=3600,
                     wea_tem_dry_bul=None, wea_sol_glo_hor=None, seed=None,
                     category=None):
        '''
        Retrieves forecast data for specified points over a given horizon and interval.

        Parameters
        ----------
        point_names : list of str
            List of data point names for which the forecast is to be retrieved.
        horizon : int, optional
            Forecast horizon in seconds.
            Default is 86400 seconds (24 hours).
        interval : int, optional
            Time interval between forecast points in seconds.
            Default is 3600 seconds (one hour).
        wea_tem_dry_bul : str, optional
            Uncertainty level for outside air dry bulb temperature.  'low', 'medium', or 'high'
            If None, defaults to no forecast error.
            Default is None.
        wea_sol_glo_hor : dict, optional
            Uncertainty level for outside solar radiation.  'low', 'medium', or 'high'
            If None, defaults to no forecast error.
            Default is None.
        seed : int, optional
            Seed for the random number generator to ensure reproducibility of the stochastic forecast error.
            If None, no seed is used.
            Default is None.
        category : string, optional
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category.
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', internalGains, 'setpoints'.

        Returns
        -------
        forecast : dict
            A dictionary containing the forecast data for the requested points with applied error models.

        '''

        # Set uncertainty parameters to 0 if no forecast uncertainty
        temperature_params = {"F0": 0, "K0": 0, "F": 0, "K": 0, "mu": 0}

        solar_params = {"ag0": 0, "bg0": 0, "phi": 0, "ag": 0, "bg": 0}

        if wea_tem_dry_bul is not None:
            temperature_params.update(self.uncertainty_params['temperature'][wea_tem_dry_bul])

        if wea_sol_glo_hor is not None:
            solar_params.update(self.uncertainty_params['solar'][wea_sol_glo_hor])

        # Get the deterministic forecast data at requested interval
        forecast = self.case.data_manager.get_data(variables=point_names,
                                                   horizon=horizon,
                                                   interval=interval,
                                                   category=category)

        # If uncertainty scenario, forecast should update only at the start of each hour and
        # underlying deterministic data should be hourly
        if (wea_tem_dry_bul is not None) or (wea_sol_glo_hor is not None):
            # Get actual start time in seconds
            start_raw = self.case.start_time
            # Round down to last start of the hour
            start = start_raw - (start_raw % 3600)
            # Build the index to send to the data_manager.  With uncertain forecasts, deterministic data should be at hour interval.
            stop = start + horizon
            index_uncertain = np.arange(start,stop+0.1+3600,3600).astype(int)
            # Check if error needs to be updated due to changing hour or new horizon
            if not hasattr(self, 'start_store'):
                self.start_store = start
                self.stop_store = stop
                update_error = True
            if (start != self.start_store) or (stop != self.stop_store):
                self.start_store = start
                self.stop_store = stop
                update_error = True
            else:
                update_error = False

        # If uncertainty scenario for outside dry bulb temperature, add any error and re-sample to requested interval
        if 'TDryBul' in point_names and any(temperature_params.values()):
            if (not hasattr(self, 'error_forecast_temp')) or update_error:
                if seed is not None:
                    np.random.seed(seed)
                # error in the forecast
                self.error_forecast_temp = predict_temperature_error_AR1(
                    hp=int((horizon+3600) / 3600 + 1), # Use interval of 3600 to create error
                    F0=temperature_params["F0"],
                    K0=temperature_params["K0"],
                    F=temperature_params["F"],
                    K=temperature_params["K"],
                    mu=temperature_params["mu"])
            # Get the forecast data for TDryBul at 3600 interval
            forecast['TDryBul'] = np.array(self.case.data_manager.get_data(variables=['TDryBul'],
                                                                           index=index_uncertain,
                                                                           category=category)['TDryBul'])
            # add forecast error to dry bulb temperature
            forecast['TDryBul'] = forecast['TDryBul'] - self.error_forecast_temp
            # interpolate error to interval
            x = np.arange(0,horizon+0.1,interval).astype(int)
            xp = np.arange(0,horizon+0.1,3600).astype(int)
            forecast['TDryBul'] = np.interp(forecast['time'],index_uncertain,forecast['TDryBul'])
            forecast['TDryBul'] = forecast['TDryBul'].tolist()

        # If uncertainty scenario for ghi, add any error and re-sample to requested interval
        if 'HGloHor' in point_names and any(solar_params.values()):
            if (not hasattr(self, 'forecast_solar_store')) or update_error:
                # Get HGloHor data at 3600 interval
                original_HGloHor = np.array(self.case.data_manager.get_data(variables=['HGloHor'],
                                                                            index=index_uncertain,
                                                                            category=category)['HGloHor'])
                lower_bound = 0.2 * original_HGloHor
                upper_bound = 2 * original_HGloHor
                indices = np.where(original_HGloHor > 50)[0]
                for i in range(200):
                    if seed is not None:
                        np.random.seed(seed+i*i)
                    error_forecast_solar = predict_solar_error_AR1(
                        int((horizon+3600) / 3600 + 1), # Generate error at 3600 interval
                        solar_params["ag0"],
                        solar_params["bg0"],
                        solar_params["phi"],
                        solar_params["ag"],
                        solar_params["bg"])
                    # add forecast error to dry bulb temperature
                    forecast['HGloHor'] = original_HGloHor - error_forecast_solar
                    # Check if any point in forecast['HGloHor'] is out of the specified range
                    condition = np.any((forecast['HGloHor'][indices] > 2 * original_HGloHor[indices]) |
                                    (forecast['HGloHor'][indices] < 0.2 * original_HGloHor[indices]))
                    if not condition:
                        break
                # forecast['HGloHor']=gaussian_filter_ignoring_nans(forecast['HGloHor'])
                forecast['HGloHor'] = mean_filter(forecast['HGloHor'])
                forecast['HGloHor'] = np.clip(forecast['HGloHor'], lower_bound, upper_bound)
                # store latest in case don't need to update next time
                self.forecast_solar_store = forecast['HGloHor']
            else:
                forecast['HGloHor'] = self.forecast_solar_store
            # interpolate data to interval
            x = np.arange(0,horizon+0.1,interval).astype(int)
            xp = np.arange(0,horizon+0.1,3600).astype(int)
            forecast['HGloHor'] = np.interp(forecast['time'],index_uncertain,forecast['HGloHor'])
            forecast['HGloHor'] = forecast['HGloHor'].tolist()

        return forecast

    def load_uncertainty_params(self, filepath):
        '''Load the uncertainty parameters from a JSON file.

        Parameters
        ----------
        filepath : str
            Path to the JSON file containing the uncertainty parameters.

        Returns
        -------
        uncertainty_params : dict
            Uncertainty parameters loaded from the JSON file.

        '''

        with open(filepath, 'r') as f:
            uncertainty_params = json.load(f)

        return uncertainty_params
