'''
Finds the peak and typical heat days for the multizone_residential_hydronic.
This case needs to be deployed if using BOPTEST image.

'''

from data.find_days import find_days
import json

days = find_days(heat='sum_Q_flow', cool=None,
                 data='TestCase.csv')

with open('days.json', 'w') as f:
    json.dump(days, f)
