# -*- coding: utf-8 -*-
"""
This script demonstrates baseline testing of a test case.
"""

import os
import sys
import json
import itertools
sys.path.insert(0, '/'.join((os.path.dirname(os.path.abspath(__file__))).split('/')[:-1]))
from examples.python.interface import control_test


def run_all_scenarios(electricity_price_lst, time_period_lst, save_kpi_results, save_measurements):
    """
    Run simulations for all combinations of electricity prices and time periods as defined in the config file.

    Parameters
    ----------
    electricity_price_lst (List[float]): List of electricity prices.
    time_period_lst (List[int]): List of time periods.
    save_kpi_results (Boolean): Whether to save KPI results.
    save_measurements (Boolean): Whether to save all the measurements.

    """
    scenario_lst = list(itertools.product(electricity_price_lst, time_period_lst))
    
    for scenario in scenario_lst:
        scenario_params = {'time_period': scenario[1], 'electricity_price': scenario[0]}
        kpi, df_res  = run_single_case(scenario_params)
        print("Finished testing", scenario_params)

        # Save KPI result for the current scenario if save_kpi_results is True
        if save_kpi_results:
            save_kpi_result(scenario_params, kpi)

        # Save measurements for the current scenario if save_measurements is True
        if save_measurements:
            scenario_name = f'{scenario[0]}+{scenario[1]}'  # Unique sheet name
            save_measurements_to_csv(scenario_name, df_res)


def run_single_case(scenario_params, start_time=0, warmup_period=0, length=24*3600):
    """
    Run simulation for a single scenario.

    Parameters
    ----------
    scenario_params (Scenario): Parameters for the scenario.
    start_time (int): Start time of the simulation (default: 0).
    warmup_period (int): Warm-up period for the simulation (default: 0).
    length (int): Length of the simulation (default: 24*3600).

    Returns
    -------
    kpi (float): Key Performance Indicator (KPI) for the scenario.
    df_res (pd.DataFrame): DataFrame containing simulation results.
    """
    control_module = 'examples.python.controllers.baseline'
    step = length
    kpi, df_res, _ , _ = control_test(control_module, start_time, warmup_period, length,
                                                      scenario=scenario_params, step=step)
    return kpi, df_res

def save_kpi_result(scenario_params, kpi):
    """
    Save KPI result for a scenario to a JSON file.

    Parameters
    ----------
    scenario_params (Scenario): Parameters for the scenario.
    kpi (float): Key Performance Indicator (KPI) for the scenario.
    """
    script_dir = os.path.dirname(os.path.abspath(__file__))  # Directory of the current Python script
    result_folder = os.path.join(script_dir, "result")  # Result folder path
    os.makedirs(result_folder, exist_ok=True)  # Create result folder if it doesn't exist

    file_path = os.path.join(result_folder, 'kpi_results.json')  # File path within the result folder

    if os.path.exists(file_path):
        # If the file exists, load existing data
        with open(file_path, 'r') as f:
            kpi_results = json.load(f)
    else:
        kpi_results = []

    # Append new data
    kpi_results.append({'scenario_params': scenario_params, 'kpi': kpi})

    # Write back to the file
    with open(file_path, 'w') as f:
        json.dump(kpi_results, f)
        

def save_measurements_to_csv(scenario_name, df_res):
    """
    Save simulation results to a CSV file.

    Parameters
    ----------
    scenario_name (str): Name of the scenario.
    df_res (pd.DataFrame): DataFrame containing simulation results.
    
    """

    script_dir = os.path.dirname(os.path.abspath(__file__))  # Directory of the current Python script
    result_folder = os.path.join(script_dir, "result")  # Result folder path
    os.makedirs(result_folder, exist_ok=True)  # Create result folder if it doesn't exist

    file_name = f'df_res_{scenario_name}.csv'  # File name
    file_path = os.path.join(result_folder, file_name)  # File path within the result folder

    df_res.to_csv(file_path, index=True)  # Save DataFrame to CSV file

    
def main(test_case):
    """
    Main function to run simulations based on the specified test case.

    Parameters
    ----------
    test_case (str): Name of the test case.
    """
    # Load configuration from JSON file
    with open('config.json') as config_file:
        config = json.load(config_file)
    
    # Check if the test case is in the configuration
    if test_case not in config:
        print(f"Test case '{test_case}' not found in config.")
        sys.exit(1)
            
    # Run user-defined baseline control testing or run all scenarios
    if config.get("run_user_defined_test", False):
        user_options = config.get("user_defined_test_options", {})
        
        # Extract user-defined options
        electricity_price = user_options.get("electricity_price", "dynamic")
        start_time = user_options.get("start_time", 15*24*3600)
        warmup_period = user_options.get("warmup_period", 7*24*3600)
        length = user_options.get("length", 14*24*3600)
        
        # Run the test
        kpi, df_res_scenario_lst = run_single_case(scenario_params={"electricity_price": electricity_price},
                                                   start_time=start_time,
                                                   warmup_period=warmup_period,
                                                   length=length)
        
        # Save KPI results if required
        if config.get("save_kpi_results", True):
            save_kpi_result("user_defined", kpi)
        
        # Save measurements if required
        if config.get("save_measurements", False):
            save_measurements_to_csv("user_defined", df_res_scenario_lst)
        
    else:
        save_kpi_results= config["save_kpi_results"]
        save_measurements= config["save_measurements"]
        electricity_price_lst = config[test_case]["electricity_price"]
        time_period_lst = config[test_case]["time_period"]
        run_all_scenarios(electricity_price_lst,time_period_lst,
                                  save_kpi_results,save_measurements)
    
if __name__ == "__main__":
    # Set the default test case if no command-line argument is provided
    test_case = sys.argv[1] if len(sys.argv) > 1 else input("Enter the test case name: ")
    scenario_df = main(test_case)