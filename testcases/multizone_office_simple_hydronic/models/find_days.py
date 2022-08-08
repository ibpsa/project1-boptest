#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This script generates the days for the different scenarios.

"""

from data.find_days import find_days
import json

days = find_days(heat='heat',
                 cool='cold',
                 data='sim_heat_cold.csv',
                 img_name=None)

with open('days.json', 'w') as f:
    json.dump(days, f)
