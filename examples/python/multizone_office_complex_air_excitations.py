# -*- coding: utf-8 -*-
"""
This script demonstrates a minimalistic example of testing a feedback controller
using the scenario options with the prototype test case called "testcase1".

"""
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
sys.path.insert(0, os.path.sep.join(os.path.dirname(os.path.abspath(__file__)).split(os.path.sep)[:-2]))
from examples.python.interface import control_test


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

    # RUN THE CONTROL TEST
    # --------------------
    control_module = 'examples.python.controllers.perturb_multizone_office_complex_air'

    # ---------------------------------------

    # RUN THE CONTROL TEST
    # --------------------
    kpi, df_res, custom_kpi_result, forecasts = control_test(control_module,
                                                             start_time=0,
                                                             warmup_period=0,
                                                             length=7*24*3600,
                                                             step=60*60)

    # POST-PROCESS RESULTS
    # --------------------
    time = df_res.index.values / 3600  # convert s --> hr
    # Floor data processing function
    def process_floor_data(floor):
        zone_temperature_core = df_res[f'hva_{floor}_reaZonCor_TZon_y'].values - 273.15  # convert K --> C
        zone_temperature_south = df_res[f'hva_{floor}_reaZonSou_TZon_y'].values - 273.15
        zone_temperature_east = df_res[f'hva_{floor}_reaZonEas_TZon_y'].values - 273.15
        zone_temperature_north = df_res[f'hva_{floor}_reaZonNor_TZon_y'].values - 273.15
        zone_temperature_west = df_res[f'hva_{floor}_reaZonWes_TZon_y'].values - 273.15
        zone_temperature_cooSet = df_res[f'hva_{floor}_reaZonCor_TRoo_Coo_set_y'].values - 273.15
        zone_temperature_heaSet = df_res[f'hva_{floor}_reaZonCor_TRoo_Hea_set_y'].values - 273.15
        ahu_temperature_supSet = df_res[f'hva_{floor}_reaAhu_TSup_set_y'].values - 273.15
        return (zone_temperature_core, zone_temperature_south, zone_temperature_east, zone_temperature_north, 
                zone_temperature_west, zone_temperature_cooSet, zone_temperature_heaSet, ahu_temperature_supSet)
    # Process data for each floor
    floor1_data = process_floor_data('floor1')
    floor2_data = process_floor_data('floor2')
    floor3_data = process_floor_data('floor3')
    # Plot results
    if plot:
        try:
            from matplotlib import pyplot as plt
            plt.figure(figsize=(14, 10))

            # Plot for Floor 1
            plt.subplot(3, 1, 1)
            plt.title('Zone Temperature - Floor 1')
            plt.plot(time, floor1_data[0], color='red', label='Core')
            plt.plot(time, floor1_data[1], color='blue', label='South')
            plt.plot(time, floor1_data[2], color='green', label='East')
            plt.plot(time, floor1_data[3], color='darkcyan', label='North')
            plt.plot(time, floor1_data[4], color='magenta', label='West')
            plt.plot(time, floor1_data[5], '--', color='black', label='Cooling Setpoint')
            plt.plot(time, floor1_data[6], '--', color='gray', label='Heating Setpoint')
            plt.plot(time, floor1_data[7], '--', color='red', label='AHU Supply Setpoint')
            plt.ylabel('Temperature [C]')
            plt.legend(loc='upper right', fontsize='small')

            # Plot for Floor 2
            plt.subplot(3, 1, 2)
            plt.title('Zone Temperature - Floor 2')
            plt.plot(time, floor2_data[0], color='red', label='Core')
            plt.plot(time, floor2_data[1], color='blue', label='South')
            plt.plot(time, floor2_data[2], color='green', label='East')
            plt.plot(time, floor2_data[3], color='darkcyan', label='North')
            plt.plot(time, floor2_data[4], color='magenta', label='West')
            plt.plot(time, floor2_data[5], '--', color='black', label='Cooling Setpoint')
            plt.plot(time, floor2_data[6], '--', color='gray', label='Heating Setpoint')
            plt.plot(time, floor2_data[7], '--', color='red', label='AHU Supply Setpoint')
            plt.ylabel('Temperature [C]')
            plt.legend(loc='upper right', fontsize='small')

            # Plot for Floor 3
            plt.subplot(3, 1, 3)
            plt.title('Zone Temperature - Floor 3')
            plt.plot(time, floor3_data[0], color='red', label='Core')
            plt.plot(time, floor3_data[1], color='blue', label='South')
            plt.plot(time, floor3_data[2], color='green', label='East')
            plt.plot(time, floor3_data[3], color='darkcyan', label='North')
            plt.plot(time, floor3_data[4], color='magenta', label='West')
            plt.plot(time, floor3_data[5], '--', color='black', label='Cooling Setpoint')
            plt.plot(time, floor3_data[6], '--', color='gray', label='Heating Setpoint')
            plt.plot(time, floor3_data[7], '--', color='red', label='AHU Supply Setpoint')
            plt.ylabel('Temperature [C]')
            plt.xlabel('Time [hr]')
            plt.legend(loc='upper right', fontsize='small')

            plt.tight_layout()
            plt.show()
        except ImportError:
            print("Cannot import numpy or matplotlib for plot generation")

    return kpi, df_res, custom_kpi_result


if __name__ == "__main__":
    kpi, df_res, custom_kpi_result = run(plot=True)
    
    # SAVE TRAINING DATASET
    # --------------------
    outfilename = 'training.csv'
    if os.path.exists(outfilename):
        overwrite = input(f"The file {outfilename} already exists. Overwrite? (y/n): ")
        if overwrite.lower() == 'y':
            df_res.to_csv(outfilename, index=True)
            print(f'File overwritten as {outfilename}')
        else:
            new_outfilename = input("Enter a new filename (with .csv extension): ")
            df_res.to_csv(new_outfilename, index=True)
            print(f'File saved as {new_outfilename}')
    else:
        df_res.to_csv(outfilename, index=True)
        print(f'File saved as {outfilename}')