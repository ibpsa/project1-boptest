'''
Created on Apr 25, 2019

@author: Javier Arroyo

This module contains the Data_Generator class with methods to generate
data as .csv files for a test case. A test case data-set must
include: weather data, price profiles, occupancy schedules, emission
factors, internal gain schedules and temperature set points for a whole year.

'''

from pymodelica import compile_fmu
from pyfmi import load_fmu
from scipy import interpolate
import pandas as pd
import numpy as np
import os
import platform
import json

class Data_Generator(object):
    '''
    This class generates weather data, energy prices,
    emission factors, internal gains and temperature
    set points. Generating the data with this class
    ensures that all the data is using the right
    column keys.

    '''

    def __init__(self,
                 resources_dir,
                 start_time="20090101 00:00:00",
                 final_time="20100101 00:00:00",
                 period=3600):
        '''Initialize the data index and data frame

        Parameters
        ----------
        resources_dir: string
            path to test case Resources directory
        start_time: string, default is "20090101 00:00:00"
            Pandas date-time indicating the starting
            time of the data frame.
        final_time: string, default is "20100101 00:00:00"
            Pandas date-time indicating the end time
            of the data frame.
        period: integer, default is 3600
            Number of seconds of the sampling time.

        '''

        # test case Resources directory
        self.resources_dir = resources_dir

        # Find all files within Resources folder
        self.files = []
        weather_files = []
        for root, _, files in os.walk(self.resources_dir):
            for f in files:
                self.files.append(os.path.join(root,f))
                if f.endswith('.mos') or f.endswith('.TMY'):
                    weather_files.append(f)
                    self.weather_dir = root
        # Find the weather file name
        if len(weather_files)>1:
            raise ReferenceError('There cannot be more than one weather '\
                                 'file within the Resources folder of the '\
                                 'test case.')
        elif len(weather_files)==0:
            self.weather_file_name = None
        else:
            self.weather_file_name = weather_files[0]
        # Find separator for environmental variables depending on OS
        if platform.system() == 'Linux':
            self.sep = ':'
        else:
            self.sep = ';'

        # Create a date time index
        self.datetime_index = pd.date_range(
            start=pd.Timestamp(start_time),
            end=pd.Timestamp(final_time),
            freq='{period}s'.format(period=period))

        # Get an absolute time vector in seconds and save it
        time_since_epoch = self.datetime_index.asi8/1e9
        self.time = time_since_epoch - time_since_epoch[0]

        # Load possible data keys from categories.json
        with open(os.path.join(os.path.split(os.path.abspath(__file__))[0],
                               'categories.json'),'r') as f:
            self.categories = json.loads(f.read())

    def generate_data(self):
        '''This method generates the weather data, the
        energy prices, the emission factors, the occupancy
        schedule, the internal gains and the temperature set
        points, and it stores each data-set in a separate csv
        file within the Resources folder of the test case.

        '''

        # Generate weather data if there is any weather file provided
        if self.weather_file_name is not None:
            self.generate_weather()

        # Generate default values for other variables
        self.generate_prices()
        self.generate_emissions()
        self.generate_occupancy()
        self.generate_internalGains()
        self.generate_setpoints()

    def generate_weather(self,
                       model_class='IBPSA.BoundaryConditions.WeatherData.ReaderTMY3',
                       model_library=None):
        '''Generate the weather data and store into a
        csv file. This method reads the data
        from a .mos or .TMY file and applies a transformation
        carried out by the ReaderTMY3 model of the
        IBPSA library. The user could provide any other
        reader model but should then make sure that
        the naming convention is accomplished.

        Parameters
        ----------
        model_class: string, default is IBPSA TMY3 Reader
            Name of the model class that is going to be
            used to pre-process the weather data. This is
            most likely to be the ReaderTMY3 of IBPSA but
            other classes could be created.
        model_library: string, default is None
            String to library path. If empty it will look
            for IBPSA library in MODELICAPATH

        '''

        # Initialize data frame
        df = self.create_df()

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

        # Change to Resources directory
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
        options['ncp']=len(self.time)-1

        # Simulate
        res = model.simulate(start_time=self.time[0],
                             final_time=self.time[-1],
                             options=options)

        # Get model outputs
        output_names = []
        for key in res.keys():
            if 'weaBus.' in key:
                output_names.append(key)

        # Write every output in the data
        for out in output_names:
            # Interpolate to avoid problems with events from Modelica
            g = interpolate.interp1d(res['time'],res[out],kind='linear')
            df.loc[:,out.replace('weaBus.', '')] = g(self.time)

        # Store in csv
        self.store_df(df,'weather')

        return df

    def generate_prices(self,
                      start_day_time = '08:00:00',
                      end_day_time = '17:00:00',
                      price_constant = 0.2,
                      price_day = 0.3,
                      price_night = 0.1,
                      price_district_heating_power = 0.1,
                      price_gas_power = 0.07,
                      price_biomass_power = 0.2,
                      price_solar_thermal_power = 0.0):

        '''Append the prices for different energy sources.
        There are three different scenarios considered for electricity:
            1. PriceElectricPowerConstant: completely constant price
            2. PriceElectricPowerDynamic: day/night tariff
            3. PriceElectricPowerHighlyDynamic: spot price

        All prices are expressed in ($/euros)/kWh.

        Parameters
        ----------
        start_day_time : string, default is '08:00:00'
            datetime indicating the starting time of the day
            for the dynamic price profile
        end_day_time : string, default is '17:00:00'
            datetime indicating the end time of the day for the
            dynamic price profile
        price_constant : float, default is 0.2
            price of the constant price profile
        price_day : float, default is 0.3
            price during the day for the dynamic price profile
        price_night : float, default is 0.1
            price during the night for the dynamic price profile
        price_district_heating_power : float, default is 0.1
            price of the district heating power
        price_gas_power : float, default is 0.07
            price of the gas power
        price_biomass_power : float, default is 0.2
            price of the biomass power
        price_solar_thermal_power : float, default is 0.0
            price of the solar thermal power


        '''

        # Initialize data frame
        df = self.create_df()

        df['PriceElectricPowerConstant'] = price_constant

        day_time_index = df.between_time(start_day_time,
                                         end_day_time).index

        df.loc[df.index.isin(day_time_index),
            'PriceElectricPowerDynamic'] = price_day
        df.loc[~df.index.isin(day_time_index),
            'PriceElectricPowerDynamic'] = price_night

        df['PriceElectricPowerHighlyDynamic'] = \
            price_day*np.sin(self.time*2*np.pi/24/3600)

        df['PriceDistrictHeatingPower'] = price_district_heating_power
        df['PriceGasPower']             = price_gas_power
        df['PriceBiomassPower']         = price_biomass_power
        df['PriceSolarThermalPower']    = price_solar_thermal_power

        # Store in csv
        self.store_df(df,'prices')

        return df

    def generate_emissions(self,
                           emissions_electric_power = 0.5,
                           emissions_district_heating_power = 0.1,
                           emissions_gas_power = 0.2,
                           emissions_biomass_power = 0.0,
                           emissions_solar_thermal_power = 0.0):
        '''Append the emission factors for every possible
        energy vector. The units are in kgCO2/kWh. For the
        electricity this factor depends on the energy mix of
        the building location at every instant. For the gas
        it depends on the net calorific value and the type
        of gas.

        Parameters
        ----------
        emissions_electric_power : float, default is 0.5
            emission factor for electric power in kgCO2/kWh
        emissions_district_heating_power : float, default is 0.1
            emission factor for district heating power in kgCO2/kWh
        emissions_gas_power : float, default is 0.2
            emission factor for gas power in kgCO2/kWh
        emissions_biomass_power : float, default is 0.0
            emission factor for biomass power in kgCO2/kWh
        emissions_solar_thermal_power : float, default is 0.0
            emission factor for solar_thermal power in kgCO2/kWh

        '''

        # Initialize data frame
        df = self.create_df()

        df['EmissionsElectricPower']        = emissions_electric_power
        df['EmissionsDistrictHeatingPower'] = emissions_district_heating_power
        df['EmissionsGasPower']             = emissions_gas_power
        df['EmissionsBiomassPower']         = emissions_biomass_power
        df['EmissionsSolarThermalPower']    = emissions_solar_thermal_power

        # Store in csv
        self.store_df(df,'emissions')

        return df

    def generate_occupancy(self, occ_num,
                        start_day_time = '07:00:00',
                        end_day_time   = '18:00:00',
                        zone_id        = '1'):
        '''The occupancy indicates the number of people in the building
        at each time.

        Parameters
        ----------
        occ_num : int
            number of occupants during occupied hours
        start_day_time: string, default is '07:00:00'
            string in pandas date-time format with the starting day time
        end_day_time: string, default is '18:00:00'
            string in pandas date-time format with the ending day time
        zone_id: string, default is '1'
            zone identifier to specify the zone for which data is generated

        '''

        # Initialize data frame
        df = self.create_df()

        day_time_index = df.between_time(start_day_time,
                                         end_day_time).index

        df.loc[df.index.isin(day_time_index),
               'Occupancy[{0}]'.format(zone_id)] = occ_num
        df.loc[~df.index.isin(day_time_index),
               'Occupancy[{0}]'.format(zone_id)] = 0

        # Store in csv
        self.store_df(df,'occupancy')

    def generate_internalGains(self,
                        start_day_time = '07:00:00',
                        end_day_time   = '18:00:00',
                        RadOcc = 1000,
                        RadUnocc = 0,
                        ConOcc = 1000,
                        ConUnocc = 0,
                        LatOcc = 200,
                        LatUnocc = 0,
                        zone_id = '1'):
        '''The internal gains are the heat gains (in Watts) produced by
        electrical appliances and the people within the building.

        Parameters
        ----------
        start_day_time: string, default is '07:00:00'
            string in pandas date-time format with the starting occupied time
        end_day_time: string, default is '18:00:00'
            string in pandas date-time format with the ending occupied time
        RadOcc: num, default is 1000
            Radiant internal load during occupied times in W
        RadUnocc: num, default is 0
            Radiant internal load during unoccupied times in W
        ConOcc: num, default is 1000
            Convective internal load during occupied times in W
        ConUnocc: num, default is 0
            Convective internal load during unoccupied times in W
        LatOcc: num, default is 200
            Latent internal load during occupied times in W
        LatUnocc: num, default is 0
            Latent internal load during unoccupied times in W
        zone_id: string, default is '1'
            zone identifier to specify the zone for which data is generated

        '''

        # Initialize data frame
        df = self.create_df()

        day_time_index = df.between_time(start_day_time,
                                         end_day_time).index

        df.loc[df.index.isin(day_time_index),
               'InternalGainsRad[{0}]'.format(zone_id)] = RadOcc
        df.loc[~df.index.isin(day_time_index),
               'InternalGainsRad[{0}]'.format(zone_id)] = RadUnocc
        df.loc[df.index.isin(day_time_index),
               'InternalGainsCon[{0}]'.format(zone_id)] = ConOcc
        df.loc[~df.index.isin(day_time_index),
               'InternalGainsCon[{0}]'.format(zone_id)] = ConUnocc
        df.loc[df.index.isin(day_time_index),
               'InternalGainsLat[{0}]'.format(zone_id)] = LatOcc
        df.loc[~df.index.isin(day_time_index),
               'InternalGainsLat[{0}]'.format(zone_id)] = LatUnocc

        # Store in csv
        self.store_df(df,'internalGains')

    def generate_setpoints(self,
                         start_day_time = '07:00:00',
                         end_day_time   = '18:00:00',
                         THeaOcc  = 22+273.15,
                         THeaUnocc = 22+273.15,
                         TCooOcc  = 23+273.15,
                         TCooUnocc = 23+273.15,
                         CO2Occ = 894,
                         CO2Unocc = 894,
                         zone_id = '1'):
        '''Append the lower and upper temperature set points
        that are used in the model to define the comfort range.
        These temperature set points are defined in Kelvins
        and can vary over time but are fixed for a particular
        test case.

        Parameters
        ----------
        start_day_time: string, default is '07:00:00'
            string in pandas date-time format with the starting occupied time
        end_day_time: string, default is '18:00:00'
            string in pandas date-time format with the ending occupied time
        THeaOcc: float, default is 22+273.15
            Heating temperature set-point during occupied hours
        THeaUnocc: float, default is 22+273.15
            Heating temperature set-point during unoccupied hours
        TCooOcc: float, default is 23+273.15
            Cooling temperature set-point during occupied hours
        TCooUNocc: float, default is 23+273.15
            Cooling temperature set-point during unoccupied hours
        CO2Occ: float, default is 864
            CO2 ppm upper limit during occupied hours
        CO2Unocc: float, default is 894
            CO2 ppm upper limit during unoccupied hours
        zone_id: string, default is '1'
            zone identifier to specify the zone for which data is generated

        '''

        # Initialize data frame
        df = self.create_df()

        day_time_index = df.between_time(start_day_time,
                                         end_day_time).index

        df.loc[df.index.isin(day_time_index),
               'LowerSetp[{0}]'.format(zone_id)] = THeaOcc
        df.loc[df.index.isin(day_time_index),
               'UpperSetp[{0}]'.format(zone_id)] = TCooOcc
        df.loc[~df.index.isin(day_time_index),
               'LowerSetp[{0}]'.format(zone_id)] = THeaUnocc
        df.loc[~df.index.isin(day_time_index),
               'UpperSetp[{0}]'.format(zone_id)] = TCooUnocc
        df.loc[~df.index.isin(day_time_index),
               'UpperCO2[{0}]'.format(zone_id)] = CO2Occ
        df.loc[df.index.isin(day_time_index),
               'UpperCO2[{0}]'.format(zone_id)] = CO2Unocc

        # Store in csv
        self.store_df(df,'setpoints')

        return df

    def create_df(self):
        '''Creates a data frame with the datetime index as the index
        and the time vector as one of the columns

        '''

        # Initialize data frame
        df = pd.DataFrame(index=self.datetime_index)

        # Add time vector in seconds as column
        df['time'] = self.time

        return df

    def store_df(self, df, name='data'):
        '''Stores the data frame in a csv format and with the time in
        seconds as one of the columns.

        '''

        # Get rid of datetime as fmus do not understand that format
        df.reset_index(drop=True, inplace=True)

        # Save a copy of the csv within the test case Resources folder
        df.to_csv(os.path.join(self.resources_dir,name+'.csv'),
                  index=False)

if __name__ == "__main__":
    resources_dir = os.path.join(\
        os.path.split(os.path.split(os.path.abspath(__file__))[0])[0],
        'testcase2','models','Resources')
    gen = Data_Generator(resources_dir)
    gen.generate_data()
