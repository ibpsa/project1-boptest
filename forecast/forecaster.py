'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Forecaster class with methods to obtain
forecast data for the test case. It relies on the data_manager object
of the test case to provide deterministic forecast.

'''

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

    def get_forecast(self,point_names, horizon=24*3600, interval=3600,
                     category=None, plot=False):
        '''Returns forecast of the test case data

        Parameters
        ----------
        point_names : list of str
            List of forecast point names for which to get data.
        horizon : int, default is 86400 (one day)
            Length of the requested forecast in seconds. If None,
            the test case horizon will be used instead.
        interval : int, default is 3600 (one hour)
            resampling time interval in seconds. If None,
            the test case interval will be used instead.
        category : string, default is None
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category.
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', internalGains, 'setpoints'
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

        # Get the forecast
        forecast = self.case.data_manager.get_data(variables=point_names,
                                                   horizon=horizon,
                                                   interval=interval,
                                                   category=category,
                                                   plot=plot)

        return forecast
