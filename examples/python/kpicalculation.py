# -*- coding: utf-8 -*-
"""
This module is a generic interface, allowing users to calculate customized KPI.
The customized KPI information is defined in json format.
  
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import importlib
# ----------------------

class cutomizedKPI(object):
    '''
      Class that implements the customized KPI calculation.    
    '''
    def __init__(self, config, **kwargs):
        # import the KPI class based on the config files
        kpi_file=config.get("kpi_file")
        module = importlib.import_module(kpi_file)
        kpi_class = config.get("kpi_class")
        model_class = getattr(module, kpi_class)

        # instantiate the KPI calculation class
        self.model = model_class(config)
        # import data point mapping info
        self.data_points=config.get("data_points")
        # import the length of data array
        self.data_point_num=config.get("data_point_num")
        # initialize the data buffer
        self.data_buff=None

    # a function to process the streaming data 
    def processing_data(self,data,num):
    # initialize the data arrays
        if self.data_buff is None:
           self.data_buff={}
           for point in self.data_points:
               self.data_buff[point]=[]
               self.data_buff[point].append(data[self.data_points[point]])
    # keep a moving window
        else:
           for point in self.data_points:
               self.data_buff[point].append(data[self.data_points[point]])
               if len(self.data_buff[point])>=num:        
                    self.data_buff[point].pop(0) 
  
    # a function to process the streaming data 
    def calculation(self):
        res = self.model.calculation(self.data_buff)
        return res