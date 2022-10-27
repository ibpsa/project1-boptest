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
    control_module = 'examples.python.controllers.multizone_large_office_eplus'
    start_time = 198*24*3600
    warmup_period = 0
    length = 2*24*3600
    step = 300

    # ---------------------------------------

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                             start_time=start_time,
                                                             warmup_period=warmup_period,
                                                             length=length,
                                                             step=step)
    # POST-PROCESS RESULTS
    # --------------------
    time = df_res.index.values/3600  # convert s --> hr
    QSenCooLoaMidSou=df_res['EPlus96_reaSenCooLoaMidSou_y'].values
    TZonMidSou=df_res['EPlus96_reaSenCooLoaMidSou_y'].values
    OccSch=df_res['EPlus96_reaOccSch_y'].values
    # Plot results if needed
    if plot:
        try:
            from matplotlib import pyplot as plt
            import numpy as np
            plt.figure(1)
            plt.title('Mid South Zone Temperature')
            plt.plot(time, TZonMidSou)
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.figure(2)
            plt.title('Mid South Sensible Cooling Load')
            plt.plot(time, QSenCooLoaMidSou)
            plt.ylabel('Power [W]')
            plt.xlabel('Time [hr]')
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")
    # --------------------

    return kpi, df_res


if __name__ == "__main__":
    kpi, df_res = run()
    df_res.to_csv("df_res.csv")
