'''
Created on Feb 5, 2021

@author: Javier Arroyo

Finds the peak and typical heat days for the bestest_hydronic_heatpump
case. This case needs to be deployed.

'''

from data.find_days import find_days
import json

days = find_days(heat='reaQHeaPumCon.y', cool=None,
                 data='simulate', img_name='boptest_bestest_hydronic_heat_pump')

with open('days.json', 'w') as f:
    json.dump(days, f)
