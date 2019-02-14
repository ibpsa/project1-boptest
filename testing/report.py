# -*- coding: utf-8 -*-
"""
This script reports the results of testing.

"""

import json
import os
import utilities

print('\n==============\nTESTING REPORT\n==============\n')
# Get all test case logs
testing_dir = os.path.join(utilities.get_root_path(),'testing')
logs = []
for f in os.listdir(testing_dir):
    if f.endswith('.log'):
        logs.append(os.path.join(testing_dir, f))

# Get total number of tests run
cases = 0
passed = 0
print('The test logs found were:')
for log in logs:
    print(log)
    with open(log, 'r') as f:
        d = json.load(f)
    cases = cases + d['NCases']
    passed = passed + d['NPassed']

# Report total number run
print('The total number of tests run was {0}.'.format(cases))
# Report if all passed
if cases == passed:
    print('All tests OK.')
else:
    print('Not all tests passed.  See below for more detailed report:\n')
    for log in logs:
        print('\nFrom {0}\n========================='.format(log))
        with open(log, 'r') as f:
            d = json.load(f)
        print('Of {0} tests run...'.format(d['NCases']))
        print('Passed: {0}'.format(d['NPassed']))
        print('Failures: {0}'.format(d['NFailures']))
        print('Errors: {0}'.format(d['NErrors']))
        print('\nFailure Messages\n----------------')
        for failure in d['Failures'].keys():
            print('Failure {0}:\n{1}'.format(failure, d['Failures'][failure]))
        print('\nError Messages\n----------------')
        for error in d['Errors'].keys():
            print('Error {0}:\n{1}'.format(error, d['Errors'][error]))
            
# Clean up test logs
for log in logs:
    os.remove(log)