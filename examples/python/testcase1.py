# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a feedback controller
with the prototype test case called "testcase1".  It uses the testing
interface implemented in interface.py and the concrete controller implemented
in controllers/pid.py.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import sys
import os
sys.path.insert(0, '/'.join((os.path.dirname(os.path.abspath(__file__))).split('/')[:-2]))
from examples.python.interface import control_test


def run(plot=False):
    """Run controller test.

    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.

    Returns
    -------
    kpi : dict
        Dictionary of core KPI names and values.
        {kpi_name : value}
    res : dict
        Dictionary of trajectories of inputs and outputs.
    custom_kpi_result: dict
        Dictionary of tracked custom KPI calculations.
        Empty if no customized KPI calculations defined.

    """

    # CONFIGURATION FOR THE CONTROL TEST
    # ---------------------------------------
    control_module = 'examples.python.controllers.pid'
    start_time = 0
    warmup_period = 0
    length = 48*3600
    step = 300
    customized_kpi_dir_path = os.path.dirname(os.path.realpath(__file__))
    customized_kpi_config = os.path.join(customized_kpi_dir_path, 'custom_kpi', 'custom_kpis_example.config')
    # ---------------------------------------

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                             start_time=start_time,
                                                             warmup_period=warmup_period,
                                                             length=length,
                                                             step=step,
                                                             customized_kpi_config=customized_kpi_config)
    # POST-PROCESS RESULTS
    # --------------------
    time = df_res.index.values/3600  # convert s --> hr
    zone_temperature = df_res['TRooAir_y'].values - 273.15  # convert K --> C
    heating_power = df_res['PHea_y'].values
    # Plot results if needed
    if plot:
        try:
            from matplotlib import pyplot as plt
            import numpy as np
            plt.figure(1)
            plt.title('Zone Temperature')
            plt.plot(time, zone_temperature)
            plt.plot(time, 20*np.ones(len(time)), '--')
            plt.plot(time, 23*np.ones(len(time)), '--')
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.figure(2)
            plt.title('Heater Power')
            plt.plot(time, heating_power)
            plt.ylabel('Electrical Power [W]')
            plt.xlabel('Time [hr]')
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")
    # --------------------

    return kpi, df_res, custom_kpi_result


if __name__ == "__main__":
    kpi, df_res, custom_kpi_result = run()
