# -*- coding: utf-8 -*-
'''
This class includes the basic functions generating a data 
.csv file of a test case containing weather data, price 
profiles, internal gains, emission factors and temperature
set points.

'''
# GENERAL PACKAGE IMPORT
# ----------------------
from pymodelica import compile_fmu
from pyfmi import load_fmu
import pandas as pd
import matplotlib.pyplot as plt
import os
import zipfile

class Data_Generator(object):
    '''
    This class prepares a data file with the weather data, 
    energy prices, emission factors, internal gains and 
    temperature set points. It also stores the data as a 
    csv file within the Resources folder of the test
    case and within the resources folder of the 
    wrapped.fmu of this test case. Generating the data
    from this class ensures that all the data is 
    concatenated using the proper indexes and that 
    the data is substracted and located within the 
    correct directories. It also ensures that the right
    column keys are used.
    
    '''
    
    def __init__(self,
                 start_time="20090101 00:00:00",
                 final_time="20091231 23:00:00",
                 period=900):
        '''Initialize the data index and data frame
        
        Parameters
        ----------
        start_time: string
            Pandas date-time indicating the starting 
            time of the data frame.
        final_time: string
            Pandas date-time indicating the end time
            of the data frame.
        period: integer
            Number of seconds of the sampling time.
            It should be kept to 900 as that is 
            normally the convention for spot prices.
        
        '''
        
        # Create a date time index
        self.datetime_index = pd.DatetimeIndex( 
                            start=pd.Timestamp(start_time), 
                            end=pd.Timestamp(final_time), 
                            freq='{period}s'.format(period=period)) 
        
        # Initialize the data frame
        self.data = pd.DataFrame(index=self.datetime_index)
        
        # Get an absolute time vector in seconds and save it
        time_since_epoch = self.datetime_index.asi8/1e9
        time = time_since_epoch - time_since_epoch[0]  
        self.data['time'] = time
        
        # Test case folder from kpis folder
        self.case_path = os.path.join(\
            os.path.split(os.path.split(os.path.abspath(__file__))[0])[0], # BOPTEST main path
            os.environ['TESTCASE'])
        print(self.case_path)
    
    def generate_data(self,
                      weather_file_name='DRYCOLD.mos',
                      electricity_price_file_name='balancing_prices_belgium_2009.csv'):
        '''This method appends the weather data, the
        energy prices, the emission factors, the
        internal gains and the temperature set 
        points to the data frame of this class. 
        It also stores the data as a csv file 
        within the Resources folder of the test
        case and within the resources folder of 
        the wrapped.fmu of this test case.
        
        Parameters
        ----------
        weather_file_name: string
            Name of the .mos file containing the 
            raw weather data. This file should be
            located within the Resources\\weatherdata
            folder of the test case.
        electricity_price_file_name: string
            path to location with the highly dynamic price profile
        '''
        
        self.append_weather_data(weather_file_name=weather_file_name)
        self.append_energy_prices(electricity_price_file_name=electricity_price_file_name)
        self.append_emission_factors()
        self.append_occupancy()
        self.append_temperature_set_points()
        self.save_data()
        self.plot_data()
        
        return self.data
    
    def append_weather_data(self,
                            weather_file_name='DRYCOLD.mos',
                            model_class='IBPSA.BoundaryConditions.WeatherData.ReaderTMY3',
                            model_library=None):
        '''Append the weather data to the data frame 
        of this class. This method reads the data 
        from a .mos file and applies a transformation 
        carried out by the ReaderTMY3 model of the 
        IBPSA library. The user could provide any other
        reader model but should then make sure that
        the naming convention is accomplished. 
        
        Parameters
        ----------
        weather_file_name: str
            Name of the .mos file containing the 
            raw weather data. This file should be
            located within the Resources\\weatherdata
            folder of the test case.
        model_class: str
            Name of the model class that is going to be
            used to pre-process the weather data. This is 
            most likely to be the ReaderTMY3 of IBPSA but 
            other classes could be created. 
        model_library: str
            String to library path. If empty it will look
            for IBPSA library in modelicapath
            
        '''
        
        if not model_library:
            # Try to find the IBPSA library
            for p in os.environ['modelicapath'].split(';'):
                if os.path.isdir(os.path.join(p,'IBPSA')):
                    model_library = os.path.join(p,'IBPSA')
            # Raise error if ibpsa cannot be found
            if not model_library:
                raise ValueError("Provide a valid model_library or point to IBPSA library in your MODELICAPATH")      
                  
        # Path to modelica model file
        model_file =  model_library
        for f in model_class.split('.')[1:]:
            model_file = os.path.join(model_file,f)
        model_file = model_file+'.mo'
        
        # Edit the class to load the weather_file_name before compilation
        str_old = 'filNam=""'
        str_new = 'filNam=Modelica.Utilities.Files.loadResource("{0}")'.format(weather_file_name)
        
        with open(model_file) as f:
            newText=f.read().replace(str_old, str_new)
        
        with open(model_file, "w") as f:
            f.write(newText)
        
        # Directory to weather file
        weather_file_directory = os.path.join(os.path.join(os.path.join(\
            self.case_path,'models'),'Resources'),'weatherdata')
        
        # Change to weather file directory
        currdir = os.curdir
        os.chdir(weather_file_directory)
        
        # Compile the ReaderTMY3 from IBPSA using JModelica
        fmu_path = compile_fmu(model_class, model_library)
        
        # Revert changes in directory and model file
        os.chdir(currdir)
        
        with open(model_file) as f:
            newText=f.read().replace(str_new, str_old)
            
        with open(model_file, "w") as f:
            f.write(newText)
        
        # Load FMU 
        model = load_fmu(fmu_path)
        
        # Set number of communication points
        options = model.simulate_options()
        options['ncp']=len(self.datetime_index)-1
        
        # Simulate
        res = model.simulate(start_time=self.data.time[0],
                             final_time=self.data.time[-1],
                             options=options)
        
        # Get model outputs
        output_names = []
        for key in res.keys():
            if 'weaBus.' in key:
                output_names.append(key)
        
        # Write every output in the data
        for out in output_names:
            self.data.loc[:,out.replace('weaBus.', '')] = res[out]
            
    def append_energy_prices(self,
                             price_constant = 0.2,
                             price_day = 0.3,
                             price_night = 0.1,
                             start_day_time = '08:00:00',
                             end_day_time = '17:00:00',
                             electricity_price_file_name = 'balancing_prices_belgium_2009.csv'):
        '''Append the energy prices for electricity and gas.
        There are three different scenarios considered for electricity:
            1. price_static: completely constant price
            2. price_dynamic: day/night tariff
            3. price_highly_dynamic: spot price changing every 15 minutes
            
        All prices are expressed in ($/euros)/Kw*h.
        
        Parameters
        ----------
        price_constant : float
            price of the constant price profile
        price_day : float
            price during the day for the dynamic price profile
        price_night : float
            price during the night for the dynamic price profile
        start_day_time : string
            datetime indicating the starting time of the day
            for the dynamic price profile
        end_day_time : string
            datetime indicating the end time of the day for the
            dynamic price profile
        electricity_price_file_name : string
            path to location with the highly dynamic price profile
        
        '''
        
        self.data.loc[:,'price_electricity_constant'] = price_constant
        
        self.day_time_index = self.data.between_time(start_day_time, end_day_time).index
        
        self.data.loc[self.data.index.isin(self.day_time_index),  'price_electricity_dynamic'] = price_day
        self.data.loc[~self.data.index.isin(self.day_time_index), 'price_electricity_dynamic'] = price_night
        
        self.data.loc[:,'price_electricity_highly_dynamic'] = price_constant
        
        self.data.loc[:,'price_gas'] = price_constant
    
    def append_occupancy(self,
                        start_day_time = '07:00:00',
                        end_day_time   = '18:00:00'):
        '''Append occupancy schedules
        '''
        
        self.day_time_index = self.data.between_time(start_day_time, end_day_time).index

        self.data.loc[self.data.index.isin(self.day_time_index),  'occupancy'] = 1
        self.data.loc[~self.data.index.isin(self.day_time_index), 'occupancy'] = 0
    
    def append_emission_factors(self):
        '''Append the emission factors for every possible 
        energy vector. The units are in kgCO2/kW*h. For the 
        electricity this factor depends on the energy mix of 
        the building location at every instant. For the gas
        it depends on the net calorific value and the type
        of gas.
        '''
        
        self.data['emission_factor_electricity'] = 0.5 
        self.data['emission_factor_gas'] = 0.5 
    
    def append_temperature_set_points(self):
        '''Append the lower and upper temperature set points 
        that are used in the model to define the comfort range.
        These temperature set points are defined in Kelvins 
        and can vary over time but are fixed for a particular
        test case.
        
        '''
        
        self.data['T_set_lower'] = 273.15 + 20
        self.data['T_set_upper'] = 273.15 + 25
    
    def save_data(self,data_file_name='test_case_data.csv'):
        '''Store the data in .csv format
        
        Parameters
        ----------
        data_file_name: string
            Name that will be used to store the data
            
        '''
        
        # Path to data file within the Resources folder of the test case
        data_file_path=os.path.join(os.path.join(os.path.join(\
                        self.case_path,'models'),'Resources'),data_file_name)
        
        # Save a copy of the csv within the Resources folder of the test case
        self.data.to_csv(data_file_path, index_label='datetime')
        
        # Path of the fmu used by BOPTEST for this test case
        fmu_path = os.path.join(os.path.join(self.case_path,'models'),'wrapped.fmu')
        
        # Open the fmu zip file in append mode
        z_fmu = zipfile.ZipFile(fmu_path,'a')
        
        # Write a copy of the csv within the resources folder of the fmu
        z_fmu.write(data_file_path, os.path.join('resources',data_file_name))
        z_fmu.close()
        
    def plot_data(self,
                  to_plot=['TDryBul','HGloHor','price_electricity_dynamic']):
        '''Plot the items of the data indicated in to_plot
        
        Parameters
        ----------
        to_plot: list of strings
            Indicates the variables to plot upon
            calling this method.  
        
        '''
        
        for item in to_plot:
            plt.figure()
            plt.plot(self.data[item],label=item)
            plt.legend()
            plt.show()
            
    
if __name__ == "__main__":
    
    os.environ['TESTCASE'] = 'testcase3'
    gen = Data_Generator()
    gen.generate_data(weather_file_name='Uccle.TMY')
    
    
    