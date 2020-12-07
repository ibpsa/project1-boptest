# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.  A controller is tested, which is
imported from a different module.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import time
import testcase
# ----------------------

def run():
    '''Run test case.

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
    tc = testcase.TestCase()
    # ---------------

    # GET TEST INFORMATION
    # --------------------
    print('\nTEST CASE INFORMATION\n---------------------')
    # Test case name
    name = tc.get_name()
    print('Name:\t\t\t\t{0}'.format(name))
    # Inputs available
    inputs = tc.get_inputs()
    print('Control Inputs:\t\t\t{0}'.format(inputs))
    # Measurements available
    measurements = tc.get_measurements()
    print('Measurements:\t\t\t{0}'.format(measurements))
    # Default simulation step
    step_def = tc.get_step()
    print('Default Simulation Step:\t{0}'.format(step_def))
    # --------------------

    # RUN TEST CASE
    # -------------
    # Reset test case
    print('Resetting test case if needed.')
    tc.reset()
    print('\nRunning test case...')

    # Simulation Loop
    start = time.time()
    for i in range(5000):
        # Advance simulation
        y = tc.advance({})
    end = time.time()
    print('\nBenchmark complete in {0} seconds.'.format(end-start))
    # -------------


if __name__ == "__main__":
    run()
