#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  22 13:20:58 2022

@author: Ezanetti
"""

from data.find_days import find_days
import json

days = find_days(heat='hydronicSystem.AirHeaPum.heatFlowSensor.Q_flow', cool=None,
                 data='simulation.csv', img_name='boptest_testcasehydronicMilan')

with open('days.json', 'w') as f:
    json.dump(days, f)
