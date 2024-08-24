#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This script generates the days for the different scenarios.

"""

from data.find_days import find_days
import json

days = find_days(heat='heating_cooling.heapro.Q_flow',
                 cool='heating_cooling.coopro.Q_flow',
                 data='HeatingCooling.csv',
                 cooling_negative=True,
                 cool_day_low_limit=77+7, # Without limit, typical day is the first day cooling turns on
                 plot=True)

with open('days.json', 'w') as f:
    json.dump(days, f)
