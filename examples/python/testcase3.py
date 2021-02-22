# -*- coding: utf-8 -*-
"""
This module is an example python-based testing interface.  It uses the
``requests`` package to make REST API calls to the test case container,
which must already be running.  A controller is tested, which is
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
    config['length'] = 48*3600
    config['step'] = 300  
    config['control_module'] =  'controllers.pidTwoZones'
    config['prediction_config'] =  ['LowerSetp[North]',
                                    'UpperSetp[North]',
                                    'LowerSetp[South]',
                                    'UpperSetp[South]']    
    
    kpi,df_res,customizedkpis_result,prediction_store = control_test(config)
    setpoints = prediction_store    

    time = df_res.index.values/3600 # convert s --> hr
    setpoints.index = setpoints.index/3600 # convert s --> hr
    TZoneNor = df_res['TRooAirNor_y'].values-273.15 # convert K --> C
    PHeatNor = df_res['PHeaNor_y'].values
    TZoneSou = df_res['TRooAirSou_y'].values-273.15 # convert K --> C
    PHeatSou = df_res['PHeaSou_y'].values
    setpoints= setpoints - 273.15 # convert K --> C
    # Plot results
    if plot:
        from matplotlib import pyplot as plt
        plt.figure(1)
        plt.title('Zone Temperatures')
        plt.plot(time, TZoneNor, label='TZoneNor')
        plt.plot(time, TZoneSou, label='TZoneSou')
        for stp in setpoints.columns:
            plt.plot(setpoints[stp], '--', label=stp)
        plt.ylabel('Temperature [C]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.figure(2)
        plt.title('Heater Powers')
        plt.plot(time, PHeatNor, label='PHeatNor')
        plt.plot(time, PHeatSou, label='PHeatSou')
        plt.ylabel('Electrical Power [W]')
        plt.xlabel('Time [hr]')
        plt.legend()
        plt.show()
    # --------------------

    return kpi,df_res

if __name__ == "__main__":
    kpi,df_res = run(plot=False)
