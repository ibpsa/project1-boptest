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
    '''Run test case.

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
    customizedkpis_result: dict
        Dictionary of tracked custom KPI calculations.
        Empty if no customized KPI calculations defined.

    '''
    # config for the control test
    config = {}
    config['length'] = 24*3600*2
    config['step'] = 3600
    config['customized_kpi_config'] = 'custom_kpi/custom_kpis_example.config'   
    config['control_module'] =  'controllers.sup'
    
    kpi,df_res,customizedkpis_result,predictions_store = control_test(config) 
    TRooAir = df_res['TRooAir_y'].values-273.15 # convert K --> C
    TSetRooHea = df_res['oveTSetRooHea_u'].values-273.15 # convert K --> C
    TSetRooCoo = df_res['oveTSetRooCoo_u'].values-273.15 # convert K --> C
    PFan = df_res['PFan_y'].values
    PCoo = df_res['PCoo_y'].values
    PHea = df_res['PHea_y'].values
    PPum = df_res['PPum_y'].values
    # Plot results
    if plot:
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperature')
        plt.plot(t, TRooAir)
        plt.plot(t, TSetRooHea)
        plt.plot(t, TSetRooCoo)
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.figure(2)
        plt.title('HVAC Power')
        plt.plot(t, PHea, label='Heating')
        plt.plot(t, PCoo, label='Cooling')
        plt.plot(t, PFan, label='Fan')
        plt.plot(t, PPum, label='Pump')
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.show()
    # --------------------

    return kpi,df_res,customizedkpis_result

if __name__ == "__main__":
    kpi,df_res,customizedkpis_result = run()
