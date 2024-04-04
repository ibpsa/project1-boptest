# -*- coding: utf-8 -*-
"""
Created on Tue Nov 13 16:36:31 2018

@author: dhb-lx
"""

from pyfmi import load_fmu
import numpy as np

def simulate(start_time=0, final_time=3600*48, overwrite = None, plot = False):
    '''Simulate the wrapper fmu with any overwriting signals.

    Parameters
    ----------
    start_time : int
        Start time of simulation in seconds
        Default is 0
    final_time : int, optional
        Final time of simulation in seconds
        Default is 3600*48
    overwrite : str
        'set' to overwrite the setpoint.
        'act' to overwrite the actuator.
        None to overwrite nothing.
        Default is None

    Returns
    -------
    res : pyfmi results object
        Results from simulation.

    '''

    fmu = load_fmu('wrapped.fmu')
    # Get input names
    input_names = fmu.get_model_variables(causality = 2).keys();
    print('Inputs: {0}'.format(input_names))
    # Get output names
    output_names = fmu.get_model_variables(causality = 3).keys();
    print('Outputs: {0}'.format(output_names))
    # Set any overwrites
    if overwrite:
        if overwrite is 'set':
            input_object = overwrite_set(input_names)
        elif overwrite is 'act':
            input_object = overwrite_act(input_names)
        else:
            raise ValueError('{0} overwrite unknown.')
    else:
        input_object = None
    # Set options
    options = fmu.simulate_options()
    options['ncp'] = 500
    # Simulate
    print(input_object)
    res = fmu.simulate(start_time,final_time, options=options, input=input_object)

    if plot:
        from matplotlib import pyplot as plt
        # Plot
        time = res['time']
        TZone = res['TZone_y']
        PHeat = res['PHeat_y']
        setZone = res['setZone_y']
        plt.figure(1)
        plt.plot(time,TZone,label='TZone')
        plt.plot(time,setZone,label='Zone Setpoint')
        plt.legend()
        plt.figure(2)
        plt.plot(time,PHeat,label='PHeat')
        plt.legend()
        plt.show()

    return res

def overwrite_set(input_names):
    '''Creates input object for overwriting the setpoint.

    Setpoint is 25 degC.

    Parameters
    ----------
    input_names : list
        List of FMU input names.

    Returns
    -------
    input_object : tuple
        pyfmi fmu input object

    '''

    u_list = []
    u_trajectory = 0
    for key in input_names:
        print(key)
        if key == 'oveSet_u':
            value = 273.15+25
        elif key == 'oveSet_activate':
            value = True
        else:
            continue
        u_list.append(key)
        u_trajectory = np.vstack((u_trajectory, value))
    input_object = (u_list, np.transpose(u_trajectory))

    return input_object

def overwrite_act(input_names):
    '''Creates input object for overwriting the actuator.

    Heater is always at 500 W.

    Parameters
    ----------
    input_names : list
        List of FMU input names.

    Returns
    -------
    input_object : tuple
        pyfmi fmu input object

    '''

    u_list = []
    u_trajectory = 0
    for key in input_names:
        if key == 'oveAct_u':
            value = 500
        elif key == 'oveAct_activate':
            value = True
        else:
            continue
        u_list.append(key)
        u_trajectory = np.vstack((u_trajectory, value))
    input_object = (u_list, np.transpose(u_trajectory))

    return input_object


if __name__ == '__main__':
    res = simulate(overwrite=None)
    res = simulate(overwrite='set')
    res = simulate(overwrite='act')
