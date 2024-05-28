# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a supervisory controller
with the prototype test case called "testcase2". It uses the testing
interface implemented in interface.py and the concrete controller implemented
in controllers/sup.py.

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
    control_module = 'examples.python.controllers.baseline'
    start_time = 24 * 3600 * 12
    warmup_period = 0
    length = 24 * 3600 * 1
    step = 24 * 3600 * 1
    #customized_kpi_dir_path = os.path.dirname(os.path.realpath(__file__))
    #customized_kpi_config = os.path.join(customized_kpi_dir_path, 'custom_kpi', 'custom_kpis_example.config')
    # -------------------------------------

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                             start_time=start_time,
                                                             warmup_period=warmup_period,
                                                             length=length,
                                                             step=step)
    return kpi, df_res

if __name__ == "__main__":
    kpi, df_res = run()
    print(kpi)
