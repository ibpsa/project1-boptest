# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a feedback controller
with the prototype test case called "multizone_office_complex_air".  It uses the testing
interface implemented in interface.py and the concrete controller implemented
in controllers/multizone_office_complex_air.py.

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
    control_module = 'examples.python.controllers.multizone_office_complex_air'
    start_time = 180*24*3600
    warmup_period = 0
    length = 1*24*3600
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
    PChi=df_res['hvac_reaPChi_y'].values
    PCHWPum=df_res['hvac_reaPCHWPum_y'].values
    # Plot results if needed
    if plot:
        try:
            from matplotlib import pyplot as plt
            import numpy as np
            plt.figure(1)
            plt.title('Chiller power consumption')
            plt.plot(time, PChi)
            plt.ylabel('Power [W]')
            plt.xlabel('Time [hr]')
            plt.figure(2)
            plt.title('Pump power consumption')
            plt.plot(time, PCHWPum)
            plt.ylabel('Power [W]')
            plt.xlabel('Time [hr]')
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")
    # --------------------

    return kpi, df_res


if __name__ == "__main__":
    kpi, df_res = run()
    df_res.to_csv("df_res_multizone_office_complex_air.csv")
