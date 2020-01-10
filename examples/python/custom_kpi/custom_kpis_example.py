# -*- coding: utf-8 -*-
"""
This module helps user to understand how to define KPI classes
  
"""
import numpy as np

class MovingAve(object):
    def __init__(self, config, **kwargs):
        optinal_settings=config.get("optional")
        self.data_point_num=int(optinal_settings.get("data_point_num"))

    def processing_data(self,data_buff,data):
    # initialize the data arrays
        if data_buff is None:
           data_buff=[]
           data_buff.append(sum(data))
    # keep a moving window
        else:
           data_buff.append(sum(data))
           if len(data_buff)>=self.data_point_num:        
                 data_buff.pop(0) 
        return data_buff

    def calculation(self,data_buff):
        return sum(data_buff)/len(data_buff)

class Deviation(object):
    def __init__(self, config, **kwargs):
        optinal_settings=config.get("optional")
        self.setpoint=int(optinal_settings.get("setpoint"))

    def processing_data(self,data_buff,data):
    # initialize the data arrays
        data_buff=data
        return data_buff

    def calculation(self,data_buff):
        temp=np.array(data_buff)-np.array(([self.setpoint]*len(data_buff)))
        return sum(temp)/len(temp) 