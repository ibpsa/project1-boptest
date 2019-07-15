# -*- coding: utf-8 -*-
"""
This module helps user to understand how to define KPI classes
  
"""
import numpy as np

class MovingAve(object):
    def __init__(self, config, **kwargs):
        self.name=config.get("name")

    def calculation(self,data):
        return sum(data['x'])/len(data['x'])

class Deviation(object):
    def __init__(self, config, **kwargs):
        self.name=config.get("name")
        self.setpoint=float(config.get("setpoint"))

    def calculation(self,data):
        temp=abs(np.array(data['x'])-np.array([self.setpoint]*len(data)))
        return sum(temp)/len(temp) 