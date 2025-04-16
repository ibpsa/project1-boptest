'''
Created on Feb 11, 2021

@author: Javier Arroyo

'''

from testcase import TestCase
import numpy as np
import pandas as pd
import sys

def simulate_skip_API(start_time=0, length=3.1536e+7,
                      points='fcu.powHeaThe.y,fcu.powCooThe.y'):
    '''Invokes a simulation in the Docker container directly, without
    making use of the Rest API. Useful to retrieve data other than the
    available measurements from the read blocks. It is used when
    finding the peak and typical heating or cooling days.
    The simulation results are returned in `.csv` format.

    Parameters
    ----------
    start_time: integer
        Start time of the simulation in seconds from beginning of the
        year. Default is 0.
    lenght: integer
        Length of the simulation to be performed in seconds. Default
        is one year.
    points: string
        Model variables to be returned from the simulation, separated
        by `,`. Results are stored in a `simulation.csv` file.

    '''

    start_time=int(float(start_time))
    length=int(float(length))
    points=points.split(',')

    case = TestCase(fmupath='wrapped.fmu')
    case.initialize(start_time=start_time, warmup_period=0)

    # Initialize
    y = {'time':np.array([])}
    for point in points:
        y[point] = np.array([])
    
    # Add points to result list
    for point in points:
        if not ('_y' in point) or not ('_u' in point):
            case.options['filter'].append('mod.'+point)
    
    # Simulate
    res = case._TestCase__simulation(start_time=start_time,
                                     end_time=start_time+length)

    # Gather and store results
    y['time'] = np.append(y['time'], res['time'][1:])
    for point in points:
        if ('_y' in point) or ('_u' in point):
            y[point] = np.append(y[point], res[point][1:])
        else:
            y[point] = np.append(y[point], res['mod.'+point][1:])
    df = pd.DataFrame(y)
    df.set_index('time', inplace=True)
    df.index.name='Time'
    df.to_csv('simulation.csv')

if __name__ == "__main__":
    simulate_skip_API(start_time=sys.argv[1], length=sys.argv[2], points=sys.argv[3])
