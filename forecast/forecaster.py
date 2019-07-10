'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Forecaster class with methods to obtain 
forecast data for the test case. It relies on the data_manager object
of the test case to provide deterministic forecast and extends this
functionality to provide also stochastic forecast with a predefined
distribution. 

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
        
        # Instantiate a data_manager if not instantiated yet
        if not hasattr(self.case, 'data_manager'):
            self.case.data_manager = Data_Manager(self.case)        
        
    def get_forecast(self,horizon=24*3600, category=None, plot=False):
        '''Returns forecast of the test case data
        
        Parameters
        ----------
        horizon : int
            Length of the requested forecast in seconds 
        category : string (optional)
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category. 
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', 'setpoints'
        plot : boolean
            True if desired to plot the forecast
            
        Returns
        -------
        forecast: dict 
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
        
        '''
        
        # Get the forecast
        forecast = self.case.data_manager.get_data(horizon=horizon,
                                                   category=category,
                                                   plot=plot)
        
        return forecast
    