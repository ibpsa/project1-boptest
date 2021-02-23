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
        'length': 24 * 3600 * 2,
        'step': 3600,
        'customized_kpi_config': 'custom_kpi/custom_kpis_example.config',
        'control_module': 'controllers.sup'
    }
    kpi, df_res, custom_kpi_result, predictions_store = control_test(config)
    time = df_res.index.values / 3600  # convert s --> hr
    room_temperature = df_res['TRooAir_y'].values - 273.15  # convert K --> C
    tset_heating = df_res['oveTSetRooHea_u'].values - 273.15  # convert K --> C
    tset_cooling = df_res['oveTSetRooCoo_u'].values - 273.15  # convert K --> C
    fan_power = df_res['PFan_y'].values
    cooling_power = df_res['PCoo_y'].values
    heating_power = df_res['PHea_y'].values
    pump_power = df_res['PPum_y'].values
    # Plot results
    if plot:
        try:
            from matplotlib import pyplot as plt
            plt.figure(1)
            plt.title('Zone Temperature')
            plt.plot(time, room_temperature)
            plt.plot(time, tset_heating)
            plt.plot(time, tset_cooling)
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.figure(2)
            plt.title('HVAC Power')
            plt.plot(time, heating_power, label='Heating')
            plt.plot(time, cooling_power, label='Cooling')
            plt.plot(time, fan_power, label='Fan')
            plt.plot(time, pump_power, label='Pump')
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
