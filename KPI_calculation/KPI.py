# -*- coding: utf-8 -*-
"""
This class includes the basic functions for processing the results 
for BOPTEST simulations and generating the corresponding key performance 
indicators.

"""
# GENERAL PACKAGE IMPORT
# ----------------------
import pandas as pd
import sys
# ----------------------

class KPI(object):
    '''Class for generating the Key Performance Indicators''' 

    def __init__(self,tab,config):


    # There are two major inputs when instantiating the KPI class:
    #   - tab is a DataFrame
    #   - config is a dictionary containing the points that are used in the KPI calculation

    
    # CHECKING IF NECESSARY ITEMS ARE INCLUDED IN THE CONFIG
    # ----------------------
        if 'power_points' in config.keys():
            self.power_points=config['power_points']
        else:
            print('"power_points" is needed')
            sys.exit()
        if 'zone_temp_points' in config.keys():
            self.zone_temp_points=config['zone_temp_points']
        else:
            print('"zone_temp_points" is needed')
            sys.exit()
        self.tab=tab
    # ----------------------

#   ENERGY USGAE METRICS
    # CALCULATING THE LOAD FACTOR
    def loadfactor(self,col):
        if col in self.tab.columns:
            avg= self.tab[col].mean()
            max= self.tab[col].max()
            try:
                factor=avg/max
            except ZeroDivisionError as err:
                print("Error: {0}".format(err))
                return
            return factor
        else:
                print("Error: no such variable called {0}".format(col))
                return

    # CALCULATING THE PEAK POWER
    def powerpeak(self,col):
        if col in self.tab.columns:
            max= self.tab[col].max()
            return max
        else:
            print("Error: no such variable called {0}".format(col))
            return

    # CALCULATING THE ENERGY CONSUMPTION
    def energy(self,col):
        if col in self.tab.columns:
            energy= self.tab[col].sum()*60/3600/1000
            return energy
        else:
            print("Error: no such variable called {0}".format(col))
            return
   
    def Energy_Usage_Metrics(self):
        print('\nEnergy_Usage_Metrics\n---------------------')
        Energy=0
        for key in self.power_points:
            if key is not None:
                for subkey in self.power_points[key]:
                        if subkey is not None:
                            print('device: {0}'.format(subkey))
                            print('Load factor is {0}'.format(round(self.loadfactor(self.power_points[key][subkey]),2)))  
                            print('Peak load is {0} W'.format(round(self.powerpeak(self.power_points[key][subkey]),2)))
                            energy_sub=round(self.energy(self.power_points[key][subkey]),2)
                            print('Energy Consumption is {0} kWh'.format(energy_sub))
                            Energy=Energy+energy_sub
                            print('\n---------------------')

        print('Total Energy Consumption is {0} kWh'.format(Energy))

    #Thermal Comfort Metrics
    # CHECKING IF X IS WITHIN THE RANGE FROM Y TO Z
    @staticmethod
    def valation_temp(x, y, z):
        if x<=y and x>=z:
            r = 0 
        else: 
            r = 1
        return r

    # COUNTING THE TIME WHEN THE TEMPERATURE IS BEYOND THE THERMAL COMFORT RANGE
    def count_unconditional_excursions(self,zonetemp,coolsetp,heatsetp):

        if not zonetemp in self.tab.columns:                  
                print("Error: no such variable called {0}".format(zonetemp))
                return

        if not coolsetp in self.tab.columns:
                print("Error: no such variable called {0}".format(coolsetp))
                return
        if not heatsetp in self.tab.columns:
                print("Error: no such variable called {0}".format(heatsetp))
                return
        temp=pd.DataFrame() 
        temp['num'] = self.tab.apply(lambda row: self.valation_temp(row[zonetemp], row[coolsetp], row[heatsetp]), axis=1)
        temp['pos_dev'] = self.tab[zonetemp]-self.tab[coolsetp]
        temp['neg_dev'] = self.tab[zonetemp]-self.tab[heatsetp]
        return float(temp['num'].sum()),temp['pos_dev'].max(),temp['neg_dev'].min()

    def Thermal_Comfort_Metrics(self):
        print('\nThermal Comfort Metrics\n---------------------')
        for key in self.zone_temp_points:
            if key is not None:
                print('room: {0}'.format(self.zone_temp_points[key]['name']))
                ratio,pos_max,neg_max=self.count_unconditional_excursions(self.zone_temp_points[key]['zonetemp'],self.zone_temp_points[key]['coolsetp'],self.zone_temp_points[key]['heatsetp'])
                ratio=ratio/float(len(self.tab))
                print('The ratio of uncomfortable time is :{0}'.format(round(ratio,2))) 
                print('The maximum positive deviation is: {0}'.format(round(pos_max,2)))
                print('The maximum negative deviation is: {0}'.format(-round(neg_max,2)))  
                print('\n---------------------')

#   SYSTEM AND EQUIPMENT UTILIZATION METRICS
    @staticmethod
    # CHECKING IF X IS LARGER THAN Y
    def valation_power(x, y):
        if x>=y:
            r = 1 
        else: 
            r = 0
        return r
    def System_Equipment_Utilization_Metrics(self):
        print('\nSystem and Equipment Utilization Metrics\n---------------------')
        Energy=0
        for key in self.power_points:
            if key is not None:
                for subkey in self.power_points[key]:
                        if subkey is not None:
                            print('device: {0}'.format(subkey))
                            temp=pd.DataFrame() 
                            temp['num'] = self.tab.apply(lambda row: self.valation_power(row[self.power_points[key][subkey]], 1), axis=1)
                            on_ratio=temp['num'].sum()/float(len(self.tab))
                            print('The on time ratio is: {0}'.format(round(on_ratio,2)))  
                            print('\n---------------------')
                            