# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a feedback controller
with the prototype test case called "testcase3". It uses the testing
interface implemented in interface.py and the concrete controller implemented
in controllers/pidTwoZones.py.

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
    # ----------------------------------
    control_module = 'examples.python.controllers.pidTwoZones'
    start_time = 0
    warmup_period = 0
    length = 48*3600
    step = 300
    use_forecast = True
    # ------------------------------------

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                             start_time=start_time,
                                                             warmup_period=warmup_period,
                                                             length=length,
                                                             step=step,
                                                             use_forecast=use_forecast)

    # POST-PROCESS RESULTS
    # --------------------
    setpoints = forecasts
    time = df_res.index.values/3600  # convert s --> hr
    setpoints.index = setpoints.index/3600  # convert s --> hr
    zone_temp_north = df_res['TRooAirNor_y'].values-273.15  # convert K --> C
    power_heat_north = df_res['PHeaNor_y'].values
    zone_temp_south = df_res['TRooAirSou_y'].values-273.15  # convert K --> C
    power_heat_south = df_res['PHeaSou_y'].values
    setpoints = setpoints - 273.15  # convert K --> C
    # Plot results if needed
    if plot:
        try:
            from matplotlib import pyplot as plt
            plt.figure(1)
            plt.title('Zone Temperatures')
            plt.plot(time, zone_temp_north, label='TZoneNor')
            plt.plot(time, zone_temp_south, label='TZoneSou')
            for stp in setpoints.columns:
                plt.plot(setpoints[stp], '--', label=stp)
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.legend()
            plt.figure(2)
            plt.title('Heater Powers')
            plt.plot(time, power_heat_north, label='PHeatNor')
            plt.plot(time, power_heat_south, label='PHeatSou')
            plt.ylabel('Electrical Power [W]')
            plt.xlabel('Time [hr]')
            plt.legend()
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")
    # --------------------

    return kpi, df_res, custom_kpi_result


if __name__ == "__main__":
    kpi, df_res, custom_kpi_result = run()