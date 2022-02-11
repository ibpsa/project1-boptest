#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This script can be used to find the scenario time period days based
on simulation data containing heating and cooling load.
"""

from data.find_days import find_days
import json

days = find_days(heat='fcu.heaCoi.Q_flow', cool='fcu.cooCoi.Q_flow',
                 data='heating_cooling.csv')

with open('days.json', 'w') as f:
    json.dump(days, f)
