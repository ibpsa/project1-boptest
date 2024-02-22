# -*- coding: utf-8 -*-
"""
This script can be used to generate the html documentation code for I/O.

To run:
1. Build BOPTEST test case
2. Run BOPTEST test case on localhost:5000
3. Run this script

Outputs:
"inputs.html": html code documenting the inputs
"measurements.html": html code documenting the outputs
"forecast_points.html" html code documenting the forecasts
"inputs_measurements_forecasts.html" html code documenting inputs,outputs and 
forecasts together
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import requests
# ----------------------


def run():
    '''Run the script.

    Parameters
    ----------
    None

    Returns
    -------
    None

    '''

    # SETUP TEST CASE
    # ---------------
    # Set URL for testcase
    url = 'http://127.0.0.1:5000'
    # ---------------

    # GET TEST INFORMATION
    # --------------------
    # Create single I/O file
    # Inputs available
    inputs = requests.get('{0}/inputs'.format(url)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'w') as f:
        f.write('<h3>Model IO\'s</h3>\n')
        f.write('<h4>Inputs</h4>\n')
        f.write('The model inputs are:\n')
        f.write('<ul>\n')
        for i in sorted(inputs.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,inputs[i]['Unit'],inputs[i]['Minimum'], inputs[i]['Maximum'], inputs[i]['Description']))
            else:
                f.write('<li>\n<code>{0}</code> [1] [min=0, max=1]: Activation signal to overwrite input {1} where 1 activates, 0 deactivates (default value)\n</li>\n'.format(i,i.replace('activate','')+'u'))
        f.write('</ul>\n')
    # Measurements available
    measurements = requests.get('{0}/measurements'.format(url)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'a') as f:
        f.write('<h4>Outputs</h4>\n')
        f.write('The model outputs are:\n')
        f.write('<ul>\n')
        for i in sorted(measurements.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,measurements[i]['Unit'],measurements[i]['Minimum'], measurements[i]['Maximum'], measurements[i]['Description']))
        f.write('</ul>\n')
    # Forecasts available
    forecast_points = requests.get('{0}/forecast_points'.format(url)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'a') as f:
        f.write('<h4>Forecasts</h4>\n')
        f.write('The model forecasts are:\n')
        f.write('<ul>\n')
        for i in sorted(forecast_points.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}]: {2}\n</li>\n'.format(i,forecast_points[i]['Unit'],forecast_points[i]['Description']))
        f.write('</ul>\n')
    # --------------------

if __name__ == "__main__":
    run()
