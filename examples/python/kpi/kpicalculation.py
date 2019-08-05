# -*- coding: utf-8 -*-
"""
This module is a generic interface, allowing users to calculate customized KPI.
The customized KPI information is defined in json format.
  
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import importlib
import sys
# ----------------------

class cutomizedKPI(object):
    '''
      Class that implements the customized KPI calculation.    
    '''
    def __init__(self, config, **kwargs):
        # import necessary KPI information from the config files
        self.name=config.get("name")
        kpi_file=config.get("kpi_file")
        kpi_class = config.get("kpi_class")
        self.data_points=config.get("data_points")

        if all([self.name,kpi_file,kpi_class,self.data_points]):
        # instantiate the KPI calculation class
             module = importlib.import_module(kpi_file)
             model_class = getattr(module, kpi_class)
        # instantiate the KPI calculation class
             self.model = model_class(config)        
        # initialize the data buffer
             self.data_buff=None
        else:
             print('KPI definitation is not sufficients')
             sys.exit()

    # A function to process the streaming data 
    def processing_data(self,data):
    # A temporary array to contain the streaming data
        temp=[]
        for point in self.data_points:
               temp.append(data[self.data_points[point]])
    # Customized data postprocessing
        self.data_buff = self.model.processing_data(self.data_buff,temp)
        return        

    # a function to process the streaming data 
    def calculation(self):
        res = self.model.calculation(self.data_buff)
        return res