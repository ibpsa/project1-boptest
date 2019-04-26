'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Data_Generator class with methods to gather
data within .csv files for a test case. A test case data-set must
include: weather data, price profiles, occupancy schedules, emission 
factors and temperature set points for a whole year.

'''

from pymodelica import compile_fmu
from pyfmi import load_fmu
import matplotlib.pyplot as plt
import pandas as pd
import os
import zipfile
import platform

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
                 fmu_path=None,
                 data_file_name='test_case_data.csv',
                 start_time="20090101 00:00:00",
                 final_time="20091231 23:00:00",
                 period=900):
        '''Initialize the data index and data frame
        
        Parameters
        ----------
        fmu_path : str
            Path to the fmu where the data is to be saved
        data_file_name: string
            Name that will be used to store the data
        start_time: string
            Pandas date-time indicating the starting 
            time of the data frame.
        final_time: string
            Pandas date-time indicating the end time
            of the data frame.
        period: integer
            Number of seconds of the sampling time.
        
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
        
        # Path of the fmu used by BOPTEST for this test case
        if fmu_path is None:
            # If fmu_path not provided look for it using the test case 
            # environmental variable
            case_dir = os.path.join(\
                # BOPTEST main path
                os.path.split(os.path.split(os.path.abspath(__file__))[0])[0], 
                os.environ['TESTCASE'])
            
            self.fmu_path = os.path.join(os.path.join(case_dir,
                                         'models'),'wrapped.fmu')            
        
        else:
            self.fmu_path  = fmu_path
            case_dir = os.path.split(os.path.split(os.path.abspath(fmu_path))[0])[0]
        
        # Path to resources directory
        resources_dir = os.path.join(os.path.join(\
            case_dir,'models'),'Resources')
        
        # Path to data file within the Resources folder of the test case
        self.data_file_name = data_file_name
        self.data_file_path=os.path.join(resources_dir, data_file_name)
        
        # Path to kpis.json file
        self.kpi_path = os.path.join(os.path.join(\
            case_dir,'models'),'kpis.json')
        
        # Find all files within resources folder
        self.files = []
        weather_files = []
        for root, _, files in os.walk(resources_dir):
            for f in files:
                self.files.append(f)   
                if f.endswith('.mos') or f.endswith('.TMY'):
                    weather_files.append(f)
                    self.weather_dir = root
                
        # Find the weather file name
        if len(weather_files)>1:
            raise ReferenceError('There cannot be more than one weather '\
                                 'file within the Resources folder of the '\
                                 'test case.')
        elif len(weather_files)==0:
            raise ReferenceError('Please provide the .mos or .TMY file of '\
                                 'the test case within the resources folder')
        else:
            self.weather_file_name = weather_files[0] 
        
        # Find separator for environmental variables depending on OS
        if platform.system() == 'Linux':
            self.sep = ':'
        else:
            self.sep = ';'
         
    def generate_data(self):
        '''This method appends the weather data, the
        energy prices, the emission factors, the
        internal gains and the temperature set 
        points to the data frame of this class. 
        It also stores the data as a csv file 
        within the Resources folder of the test
        case and within the resources folder of 
        the wrapped.fmu of this test case.
        
        '''
        
        self.append_weather_data()
        self.append_energy_prices()
        self.append_emission_factors()
        self.append_occupancy()
        self.append_temperature_set_points()
        
        return self.data
    
    def append_weather_data(self,
                            model_class='IBPSA.BoundaryConditions.WeatherData.ReaderTMY3',
                            model_library=None):
        '''Append the weather data to the data frame 
        of this class. This method reads the data 
        from a .mos or .TMY file and applies a transformation 
        carried out by the ReaderTMY3 model of the 
        IBPSA library. The user could provide any other
        reader model but should then make sure that
        the naming convention is accomplished. 
        
        Parameters
        ----------
        model_class: str
            Name of the model class that is going to be
            used to pre-process the weather data. This is 
            most likely to be the ReaderTMY3 of IBPSA but 
            other classes could be created. 
        model_library: str
            String to library path. If empty it will look
            for IBPSA library in MODELICAPATH
            
        '''
        
        if not model_library:
            # Try to find the IBPSA library
            for p in os.environ['MODELICAPATH'].split(self.sep):
                if os.path.isdir(os.path.join(p,'IBPSA')):
                    model_library = os.path.join(p,'IBPSA')
            # Raise an error if ibpsa cannot be found
            if not model_library:
                raise ValueError('Provide a valid model_library or point '\
                                 'to the IBPSA library in your MODELICAPATH')   
                  
        # Path to modelica reader model file
        model_file =  model_library
        for f in model_class.split('.')[1:]:
            model_file = os.path.join(model_file,f)
        model_file = model_file+'.mo'
                        
        # Edit the class to load the weather_file_name before compilation
        str_old = 'filNam=""'
        str_new = 'filNam=Modelica.Utilities.Files.loadResource("{0}")'\
                  .format(self.weather_file_name)
        
        with open(model_file) as f:
            newText=f.read().replace(str_old, str_new)
        
        with open(model_file, "w") as f:
            f.write(newText)
        
        # Change to resources directory
        currdir = os.curdir
        os.chdir(self.weather_dir)
        
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
                             end_day_time = '17:00:00'):
        '''Append the energy prices for electricity and gas.
        There are three different scenarios considered for electricity:
            1. PriceElectricPowerConstant: completely constant price
            2. PriceElectricPowerDynamic: day/night tariff
            3. PriceElectricPowerHighlyDynamic: spot price 
            
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
        
        self.data['PriceElectricPowerConstant'] = price_constant
        
        self.day_time_index = self.data.between_time(start_day_time, 
                                                     end_day_time).index
        
        self.data.loc[self.data.index.isin(self.day_time_index),  
                      'PriceElectricPowerDynamic'] = price_day
        self.data.loc[~self.data.index.isin(self.day_time_index), 
                      'PriceElectricPowerDynamic'] = price_night
        
        self.data['PriceElectricPowerHighlyDynamic'] = price_constant
        
        self.data['PriceDistrictHeatingPower'] = 0.1
        self.data['PriceGasPower']             = 0.07
        self.data['PriceBiomassPower']         = 0.2
        self.data['PriceSolarThermalPower']    = 0.
    
    def append_occupancy(self,
                        start_day_time = '07:00:00',
                        end_day_time   = '18:00:00'):
        '''Append occupancy schedules
        
        Parameters
        ----------
        start_day_time: str
            string in pandas date-time format with the starting day time
        end_day_time: str
            string in pandas date-time format with the ending day time
        '''
        
        self.day_time_index = self.data.between_time(start_day_time, 
                                                     end_day_time).index

        self.data.loc[self.data.index.isin(self.day_time_index),  
                      'occupancy'] = 1
        self.data.loc[~self.data.index.isin(self.day_time_index), 
                      'occupancy'] = 0
    
    def append_emission_factors(self):
        '''Append the emission factors for every possible 
        energy vector. The units are in kgCO2/kW*h. For the 
        electricity this factor depends on the energy mix of 
        the building location at every instant. For the gas
        it depends on the net calorific value and the type
        of gas.
        '''
        
        self.data['EmissionsElectricPower']        = 0.5
        self.data['EmissionsDistrictHeatingPower'] = 0.1
        self.data['EmissionsGasPower']             = 0.2
        self.data['EmissionsBiomassPower']         = 0.
        self.data['EmissionsSolarThermalPower']    = 0.
    
    def append_temperature_set_points(self,
                                      start_day_time = '07:00:00',
                                      end_day_time   = '18:00:00',
                                      THeaOn=293.15,
                                      THeaOff=285.15,
                                      TCooOn=297.15,
                                      TCooOff=303.15):
        '''Append the lower and upper temperature set points 
        that are used in the model to define the comfort range.
        These temperature set points are defined in Kelvins 
        and can vary over time but are fixed for a particular
        test case.
        
        Parameters
        ----------
        start_day_time: str
            string in pandas date-time format with the starting day time
        end_day_time: str
            string in pandas date-time format with the ending day time
        THeaOn: float
            Heating temperature set-point during the day time
        THeaoff: float
            Heating temperature set-point out of the day time
        TCooOn: float
            Cooling temperature set-point during the day time
        TCoooff: float
            Cooling temperature set-point out of the day time
        '''
        
        self.day_time_index = self.data.between_time(start_day_time, 
                                                     end_day_time).index
        
        self.data.loc[self.data.index.isin(self.day_time_index),  
                      'LowerSetp'] = THeaOn
        self.data.loc[self.data.index.isin(self.day_time_index),  
                      'UpperSetp'] = TCooOn
        self.data.loc[~self.data.index.isin(self.day_time_index), 
                      'LowerSetp'] = THeaOff
        self.data.loc[~self.data.index.isin(self.day_time_index), 
                      'UpperSetp'] = TCooOff
        
    def save_data(self):
        '''Store the test case data in .csv format and save it within the
        resources folder of the fmu. Save also the kpis.json file in the
        same folder.
        
        '''
        
        # Get rid of datetime as fmus do not understand that format
        self.data.reset_index(drop=True, inplace=True)
        
        # Save a copy of the csv within the test case Resources folder 
        self.data.to_csv(self.data_file_path, index=False)
        
        # Open the fmu zip file in append mode
        z_fmu = zipfile.ZipFile(self.fmu_path,'a')
        
        # Write a copy of the csv within the resources folder of the fmu
        z_fmu.write(self.data_file_path, os.path.join('resources',
                                                 self.data_file_name))
        
        # Write a copy of the kpis.json within the resources folder of the fmu
        z_fmu.write(self.kpi_path, os.path.join('resources', 'kpis.json'))
        
        # Close the fmu
        z_fmu.close()
        
        # Delete the files appended to the fmu to have a unique location
        os.remove(self.data_file_path)
        os.remove(self.kpi_path)
        
    def plot_data(self,
                  to_plot=['TDryBul','HGloHor','PriceElectricPowerDynamic']):
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
    os.environ['TESTCASE'] = 'testcase2'
    gen = Data_Generator()
    gen.generate_data()
    gen.save_data()
    
    