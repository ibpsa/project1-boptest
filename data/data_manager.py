'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Data_Manager class with methods to  
access the test case data within the resources folder of the
test case FMU.

'''

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import zipfile
from scipy import interpolate
import json

class Data_Manager(object):
    '''Class to access the test case data within the resources 
    folder of the test case FMU. The returned data may be used 
    for forecasting purposes or for KPI calculations.
    
    '''

    def __init__(self, testcase):
        '''Initialize the Data_Manager class. One Data_Manager
        is associated with one test case.
        
        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case used
            to retrieve test case metadata
        
        '''
        
        # Point to the test case object
        self.case = testcase
        
        # Define the column keys and group them by categories
        self.weather_keys   = ['pAtm','nTot','nOpa','HGloHor',
                               'HDifHor','HDirNor','celHei','winSpe',
                               'HHorIR','winDir','cloTim','solTim',
                               'TDewPoi','relHum','TDryBul','TWetBul',
                               'solAlt','solZen','solDec','solHouAng',
                               'lon','lat','TBlaSky']
        self.price_keys     = ['PriceElectricPowerConstant', 
                               'PriceElectricPowerDynamic', 
                               'PriceElectricPowerHighlyDynamic',
                               'PriceGasPower',
                               'PriceBiomassPower',
                               'PriceSolarThermalPower']
        self.emissions_keys = ['EmissionsElectricPower',
                               'EmissionsDistrictHeatingPower',
                               'EmissionsGasPower',
                               'EmissionsBiomassPower'
                               'EmissionsSolarThermalPower'] 
        self.occupancy_keys = ['occupancy']
        self.setpoint_keys  = ['LowerSetp', 'UpperSetp']
        
        # Save the categories within a dictionary:
        self.categories = {}
        self.categories['weather']   = self.weather_keys
        self.categories['prices']    = self.price_keys
        self.categories['emissions'] = self.emissions_keys
        self.categories['occupancy'] = self.occupancy_keys
        self.categories['setpoints'] = self.setpoint_keys
        
    def get_data(self, horizon=24*3600, interval=None,
                 category=None, index=None, plot=False,
                 data_file_name='test_case_data.csv'):
        '''Retrieve test case data from the fmu. The data
        is stored within the data_file_name file that 
        is located in the resources folder of the wrapped.fmu.
        
        Parameters
        ----------
        horizon : int
            Length of the requested forecast in seconds 
        interval: int (optional)
            resampling time interval in seconds. If None,
            the test case step will be used instead
        category : string (optional)
            Type of data to retrieve from the test case.
            If None it will return all available test case
            data without filtering it by any category. 
            Possible options are 'weather', 'prices',
            'emissions', 'occupancy', 'setpoints'
        data_file_name : string
            Name of the data file from where the data is 
            retrieved. Notice that this file should be within
            the resources folder of the wrapped.fmu
            
        Returns
        -------
        data: dict 
            Dictionary with the requested forecast data
            {<variable_name>:<variable_forecast_trajectory>}
        
        Notes
        -----
        The read and pre-process of the data happens only 
        once to reduce the computational load during the 
        co-simulation
        
        '''
        
        # First read the test case data if not read yet
        if not hasattr(self.case, 'data'):    
            self.load_data(data_file_name)
        
        # Filter the requested data columns
        if category is not None:
            data_slice = self.case.data.loc[:,self.categories[category]]
        else:
            data_slice = self.case.data
            
        # If no index use horizon and interval 
        if index is None:
            # Use the test case start time 
            start = self.case.start_time
            stop  = start + horizon
            # Reindex to the desired interval. Use step if none
            if interval is None:
                interval=self.case.step
            index = np.arange(start,stop,interval).astype(int)
            
        # Reindex to the desired index
        data_slice_reindexed = data_slice.reindex(index)
        
        for key in data_slice_reindexed.keys():
            # Use linear interpolation for continuous variables
            if key in self.weather_keys:
                f = interpolate.interp1d(self.case.data.index,
                    self.case.data[key], kind='linear')
                data_slice_reindexed.loc[:,key] = f(index)
            # Use forward fill for discrete variables
            else:
                f = interpolate.interp1d(self.case.data.index,
                    self.case.data[key], kind='zero')
                data_slice_reindexed.loc[:,key] = f(index)
        
        if plot:
            if category is None:
                to_plot = data_slice_reindexed.keys()
            else: 
                to_plot = self.categories[category]
            for var in to_plot:
                data_slice_reindexed[var].plot()
                plt.legend()
                plt.show()
        
        # Reset the index to keep the 'time' column in the data
        # Transform data frame to dictionary
        return data_slice_reindexed.reset_index().to_dict('list')
    
    def load_data(self, data_file_name='test_case_data.csv'):
        '''Load the data from the resources folder of the fmu.
        Resample it with the specified time interval.
        
        Parameters
        ----------
        data_file_name : string
            Name of the data file from where the data is 
            retrieved. Notice that this file should be within
            the resources folder of the wrapped.fmu
        '''
        
        # Point to the fmu zip file
        z_fmu = zipfile.ZipFile(self.case.fmupath, 'r')
        # The following will work in any OS because the zip format 
        # specifies a forward slash.
        
        # Load kpi json
        json_str = z_fmu.open('resources/kpis.json').read()
        self.case.kpi_json = json.loads(json_str)
        
        self.case.data=pd.read_csv(z_fmu.open('resources/'+data_file_name))
        
        # Convert any convert any string formatted
        # numbers to floats.
        self.case.data = self.case.data.applymap(float)
        
        # Set time as index 
        self.case.data = self.case.data.astype({'time':int})
        self.case.data = self.case.data.set_index('time')
        
        # Close the fmu
        z_fmu.close()
        