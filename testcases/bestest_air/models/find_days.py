#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 13:20:58 2021

@author: dhbubu18
"""

from data.find_days import find_days
import json

days = find_days(heat='fcu.powHeaThe.y', cool='fcu.powCooThe.y',
                 data='simulate', img_name='boptest_bestest_air')

with open('days.json', 'w') as f:
    json.dump(days, f)
