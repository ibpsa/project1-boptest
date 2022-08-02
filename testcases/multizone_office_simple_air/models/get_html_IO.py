# -*- coding: utf-8 -*-
"""
This script can be used to generate the html documentation code for I/O.

To run:
1. Build BOPTEST test case
2. Run BOPTEST test case on localhost:5000
3. Run this script

Outputs:
"inputs.txt": html code documenting the inputs
"measurements.txt": html code documenting the outputs

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
    # Inputs available
    inputs = requests.get('{0}/inputs'.format(url)).json()
    with open('inputs.txt', 'w') as f:
        for i in sorted(inputs.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,inputs[i]['Unit'],inputs[i]['Minimum'], inputs[i]['Maximum'], inputs[i]['Description']))
    # Measurements available
    measurements = requests.get('{0}/measurements'.format(url)).json()
    with open('measurements.txt', 'w') as f:
        for i in sorted(measurements.keys()):
            if 'activate' not in i:
                f.write('<li>\n<code>{0}</code> [{1}] [min={2}, max={3}]: {4}\n</li>\n'.format(i,measurements[i]['Unit'],measurements[i]['Minimum'], measurements[i]['Maximum'], measurements[i]['Description']))
    # --------------------

if __name__ == "__main__":
    run()
