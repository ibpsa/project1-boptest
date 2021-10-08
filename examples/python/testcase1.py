# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a feedback controller
with the prototype test case called "testcase1".
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
    ########################################
    kpi, df_res, custom_kpi_result, forecast_store = control_test(length=length,
                                                                    step=step,
                                                                    control_module=control_module,
                                                                    customized_kpi_config=customized_kpi_config)
    time = df_res.index.values/3600  # convert s --> hr
    zone_temperature = df_res['TRooAir_y'].values - 273.15  # convert K --> C
    heating_power = df_res['PHea_y'].values
    q_heat = df_res['oveAct_u'].values
    # Plot results
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
    kpi, df_res, custom_kpi_result = run(customized_kpi_config='custom_kpi/custom_kpis_example.config')