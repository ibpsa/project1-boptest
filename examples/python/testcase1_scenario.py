# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.  A controller is tested, which is
imported from a different module.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
import sys
import pathlib
sys.path.insert(0, str(pathlib.Path(__file__).absolute().parents[2]))
from examples.python.interface import control_test


def run(plot=False, customized_kpi_config=None):
    """Run test case.
    Parameters
    ----------
    plot : bool, optional
        True to plot timeseries results.
        Default is False.
    customized_kpi_config : string, optional
        The path of the json file which contains the customized kpi information.
        Default is None.

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
    ########################################
    # config for the control test
    length = 48*3600
    step = 300
    control_module = 'examples.python.controllers.pid'
    scenario = {'time_period': 'test_day', 'electricity_price': 'dynamic'}
    ########################################
    kpi, df_res, custom_kpi_result, prediction_store = control_test(length=length,
                                                                    step=step,
                                                                    control_module=control_module,
                                                                    customized_kpi_config=customized_kpi_config,
                                                                    scenario=scenario)
    time = df_res.index.values / 3600  # convert s --> hr
    zone_temperature = df_res['TRooAir_y'].values - 273.15  # convert K --> C
    # Plot results
    if plot:
        try:
            from matplotlib import pyplot as plt
            import numpy as np
            plt.figure(1)
            plt.title('Zone Temperature')
            plt.plot(time, zone_temperature)
            plt.plot(time, 20 * np.ones(len(time)), '--')
            plt.plot(time, 23 * np.ones(len(time)), '--')
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")
    # --------------------

    return kpi, df_res, custom_kpi_result


if __name__ == "__main__":
    kpi, df_res, custom_kpi_result = run()
