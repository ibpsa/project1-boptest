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
import warnings
import os
import json

class Data_Manager(object):
    '''Class to access the test case data within the resources 
    folder of the test case FMU. The returned data may be used 
    for forecasting purposes or for KPI calculations.
    
    '''

    def __init__(self, testcase=None):
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
        
        # Find path to data directory
        data_dir = os.path.join(\
            os.path.split(os.path.split(os.path.abspath(__file__))[0])[0],
            'data')
        
        # Load possible data keys
        with open(os.path.join(data_dir,'categories.json'),'r') as f:
            self.categories = json.loads(f.read()) 
        
    def get_data(self, horizon=24*3600, interval=None, index=None, 
                 category=None, plot=False):
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
            self.load_data()
        
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
            if key in self.categories['weather']:
                f = interpolate.interp1d(self.case.data.index,
                    self.case.data[key], kind='linear')
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
    
    def load_data(self):
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
        
        # Find the test case data files
        files = []
        for f in z_fmu.namelist():
            if f.startswith('resources/') and f.endswith('.csv'):
                files.append(f)
        
        # Find the minimum sampling resolution
        sampling = 3600. 
        for f in files:
            df = pd.read_csv(z_fmu.open(f))
            if 'time' in df.keys():
                new_sampling = df.iloc[1]['time']-df.iloc[0]['time']
                if new_sampling<sampling:
                    sampling=new_sampling
                    
        # Define the index for one year with the minimum sampling found
        index = np.arange(0.,3.154e+7,sampling,dtype='int')
        
        # Find all data keys
        all_keys = []
        for category in self.categories:
            all_keys.extend(self.categories[category])
        
        # Initialize test case data frame
        self.case.data = \
            pd.DataFrame(index=index, columns=all_keys).rename_axis('time')
        
        # Load the test case data
        for f in files:
            df = pd.read_csv(z_fmu.open(f))
            keys = df.keys()
            if 'time' in keys:
                for key in keys.drop('time'):
                    for category in self.categories:
                        # Use linear interpolation for continuous variables
                        if key in self.categories[category] and \
                            category == 'weather':
                            g = interpolate.interp1d(df['time'],df[key], 
                                kind='linear',fill_value='extrapolate')
                            self.case.data.loc[:,key] = \
                                g(self.case.data.index)
                        # Use forward fill for discrete variables
                        elif key in self.categories[category]:
                            g = interpolate.interp1d(df['time'],df[key], 
                                kind='linear',fill_value='extrapolate')
                            self.case.data.loc[:,key] = \
                                g(self.case.data.index)
            else:
                warnings.warn('The following file does not have '\
                'time column and therefore no data is going to '\
                'be used from this file as test case data.', Warning) 
                print(f)
        
        # Close the fmu
        z_fmu.close()        
        
        # Convert any string formatted numbers to floats.
        self.case.data = self.case.data.applymap(float)

        
if __name__ == "__main__":
    import sys
    case_dir = os.path.join(\
        os.path.split(os.path.split(os.path.abspath(__file__))[0])[0], 
        'testcase2')
    # Append the case directory to see the config file
    sys.path.append(case_dir)
    
    from testcase import TestCase
    case=TestCase()
    man = Data_Manager(case)
    data=man.get_data()
        