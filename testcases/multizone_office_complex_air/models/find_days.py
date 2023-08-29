'''
Finds the peak and typical heat days for the multizone_office_simple_air.
This case needs to be deployed if using BOPTEST image.

'''

from data.find_days import find_days
import json

days = find_days(heat='hvac.boiWatPla.QTot.y',
                 cool='hvac.chiWatPla.QTot.y',
                 data='sim_heat_cool.csv',
                 peak_cool_restriction_hour=12,
                 img_name=None)

with open('days.json', 'w') as f:
    json.dump(days, f)
