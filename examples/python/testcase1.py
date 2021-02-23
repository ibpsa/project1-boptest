# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which mus already be running.  A controller is tested, which is
imported from a different module.

"""

# GENERAL PACKAGE IMPORT
# ----------------------
from interface import control_test


def run(plot=False):
    """Run test case.

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
    # config for the control test
    config = {
        'length': 48*3600,
        'step': 300,
        'customized_kpi_config': 'custom_kpi/custom_kpis_example.config',
        'control_module': 'controllers.pid'
    }
    kpi, df_res, custom_kpi_result, predictions_store = control_test(config)
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
    kpi, df_res, custom_kpi_result = run()