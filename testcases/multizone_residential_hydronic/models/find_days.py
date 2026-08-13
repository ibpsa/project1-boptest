'''
Finds the peak and typical heat days for the multizone_residential_hydronic.
This case needs to be deployed if using BOPTEST image.

'''

from data.find_days import find_days
import json

days = find_days(heat='boi.QWat_flow.y', cool=None)

with open('days.json', 'w') as f:
    json.dump(days, f)
