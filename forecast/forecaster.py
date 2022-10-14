'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Forecaster class with methods to obtain
forecast data for the test case. It relies on the data_manager object
of the test case to provide deterministic forecast.

'''

from .error_emulator import predict_error


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

    def get_forecast(self,horizon=None, interval=None,
                     category=None, F0=0, K0=0, F=0, K=0, mu=0,
                     plot=False):
        '''Returns forecast of the test case data

        Parameters
        ----------
        horizon : int, default is None
            Length of the requested forecast in seconds. If None,
            the test case horizon will be used instead.
        interval : int, default is None
            resampling time interval in seconds. If None,
            the test case interval will be used instead.
        category : string, default is None
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category.
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', internalGains, 'setpoints'
        F0 : float, default is 0
            mean of the initial error model for weather forecast
        K0 : float, default is 0
            standard deviation of the initial error model for weather forecast
        F : float from 0 to 1, default is 0
            autocorrelation factor of the AR error model for weather forecast
        K : float, default is 0
            standard deviation of the AR error model
        mu : float, default is 0
            mean value of the distribution function integrated in the AR error model
            for weather forecast
        plot : boolean, default is False
            True if desired to plot the forecast

        Returns
        -------
        forecast : dict
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
            where <variable_name> is a string with the variable
            key and <variable_forecast_trajectory> is a list with
            the forecasted values. 'time' is included as a variable

        '''

        # Set default parameters if not provided
        if horizon is None:
            horizon = self.case.horizon
        if interval is None:
            interval = self.case.interval

        # Get the forecast
        forecast = self.case.data_manager.get_data(horizon=horizon,
                                                   interval=interval,
                                                   category=category,
                                                   plot=plot)
        
        # error in the forecast
        error_forecast = predict_error(hp=horizon, F0=F0, K0=K0, F=F, K=K, mu=mu)
        
        # forecast error just added to dry bulb temperature
        forecast['TDryBul'] = forecast['TDryBul'] + error_forecast

        return forecast
