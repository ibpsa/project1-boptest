# -*- coding: utf-8 -*-
"""
This script reports the results of testing.

"""

import json
import os
import utilities

report_file ='testing_report.txt'
    
def record(message, display=True, write=True, initial=False):
    '''Records a message to screen and/or file.
    
    Parameters
    ----------
    message : str
        Message to record.
    display : bool, optional
        Display to terminal.
        Default is True.
    write : bool, optional
        Write to file.
        Default is True.
        
    '''

    if display:
        print(message)
    if write:
        if initial:
            access = 'w'
        else:
            access = 'a'
        with open(report_file, access) as logf:
            logf.write('\n'+message)

if __name__ == '__main__':
    exit_code = 0
    record('\n==============\nTESTING REPORT\n==============\n', initial=True)
    # Get all test case logs
    testing_dir = os.path.join(utilities.get_root_path(),'testing')
    logs = []
    for f in os.listdir(testing_dir):
        if f.endswith('.log'):
            logs.append(os.path.join(testing_dir, f))
    # Get total number of tests run
    cases = 0
    passed = 0
    record('The following test modules were run:')
    for log in logs:
        with open(log, 'r') as f:
            d = json.load(f)
        cases = cases + d['NCases']
        passed = passed + d['NPassed']
        record(d['TestFile'])
    # Report total number run
    record('The total number of individual tests run was {0}.'.format(cases))
    # Report if all passed
    if cases == passed:
        record('\n-------------\nAll tests OK.\n-------------\n\nOutput saved to {0}.'.format(report_file))
    else:
        exit_code = 1
        record('\n-------------\nNot all tests passed.  See {0} for more detailed report.\n-------------\n'.format(report_file))
        for log in logs:
            with open(log, 'r') as f:
                d = json.load(f)
            record('\nFrom {0}\n========================='.format(d['TestFile']))
            record('Of {0} tests run...'.format(d['NCases']))
            record('Passed: {0}'.format(d['NPassed']))
            record('Failures: {0}'.format(d['NFailures']))
            record('Errors: {0}'.format(d['NErrors']))
            record('\nFailure Messages\n----------------')
            for failure in d['Failures'].keys():
                record('Failure {0}:\n{1}'.format(failure, d['Failures'][failure]))
            record('\nError Messages\n----------------')
            for error in d['Errors'].keys():
                record('Error {0}:\n{1}'.format(error, d['Errors'][error]))
    # Clean up test logs
    for log in logs:
        os.remove(log)
    # Return exit code
    exit(exit_code)