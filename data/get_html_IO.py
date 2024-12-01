# -*- coding: utf-8 -*-
"""
This script can be used to generate the html documentation code for I/O.

To run:
1. Deploy BOPTEST as described in README.md at root of repository.
2. Run this script with test case as string input argument:

$ python get_html_IO.py bestest_air

Output:
``inputs_measurements_forecasts.html`` html code documenting inputs, outputs and 
forecasts together
"""

# GENERAL PACKAGE IMPORT
# ----------------------
import requests
import sys
# ----------------------


def run(test_case_name):
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
    # Set URL for test case
    url = 'http://127.0.0.1:80'
    # Deploy worker container and obtain test case ID
    testid = requests.post("{0}/testcases/{1}/select".format(url, test_case_name)).json()["testid"]
    # ---------------
    
    # GET TEST INFORMATION
    # --------------------
    # Create single I/O file
    # Inputs available
    print('\nGetting available inputs...')
    inputs = requests.get('{0}/inputs/{1}'.format(url,testid)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'w') as f:
        f.write('<h3>Model IO\'s</h3>\n')
        f.write('<h4>Inputs</h4>\n')
        f.write('The model inputs are:\n')
        f.write('<ul>\n')
        print('\nWriting inputs to inputs_measurements_forecasts.html...')
        for i in sorted(inputs.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,inputs[i]['Unit'],inputs[i]['Minimum'], inputs[i]['Maximum'], inputs[i]['Description']))
            else:
                f.write('<li>\n<code>{0}</code> [1] [min=0, max=1]: Activation signal to overwrite input {1} where 1 activates, 0 deactivates (default value)\n</li>\n'.format(i,i.replace('activate','')+'u'))
        f.write('</ul>\n')
    # Measurements available
    print('\nGetting available measurements...')
    measurements = requests.get('{0}/measurements/{1}'.format(url,testid)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'a') as f:
        f.write('<h4>Outputs</h4>\n')
        f.write('The model outputs are:\n')
        f.write('<ul>\n')
        print('\nWriting measurements to inputs_measurements_forecasts.html...')
        for i in sorted(measurements.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,measurements[i]['Unit'],measurements[i]['Minimum'], measurements[i]['Maximum'], measurements[i]['Description']))
        f.write('</ul>\n')
    # Forecasts available
    print('\nGetting available forecasts...')
    forecast_points = requests.get('{0}/forecast_points/{1}'.format(url,testid)).json()['payload']
    with open('inputs_measurements_forecasts.html', 'a') as f:
        f.write('<h4>Forecasts</h4>\n')
        f.write('The model forecasts are:\n')
        f.write('<ul>\n')
        print('\nWriting forecasts to inputs_measurements_forecasts.html...')
        for i in sorted(forecast_points.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}]: {2}\n</li>\n'.format(i,forecast_points[i]['Unit'],forecast_points[i]['Description']))
        f.write('</ul>\n')
    # --------------------
    # SHUT DOWN TEST CASE
    # -------------------------------------------------------------------------
    print('\nShutting down test case...')
    res = requests.put("{0}/stop/{1}".format(url,testid))
    if res.status_code == 200:
        print('Done shutting down test case.')
    else:
        print('Error shutting down test case.')
        
if __name__ == "__main__":
    test_case_name = sys.argv[1]
    run(test_case_name)
