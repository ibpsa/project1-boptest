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
import pandas as pd
import multiprocessing
import time
import subprocess 

def run_scenario(scenario_params, result_dict):
    try:
        kpi, df_res = run_single_case(scenario_params)
        result_dict['kpi'] = kpi
        result_dict['df_res'] = df_res
    except Exception as e:
        result_dict['error'] = e

def run_scenario_with_timeout(scenario_params, timeout):
    with multiprocessing.Manager() as manager:
        result_dict = manager.dict()
        p = multiprocessing.Process(target=run_scenario, args=(scenario_params, result_dict))
        p.start()
        p.join(timeout)
        if p.is_alive():
            p.terminate()
            p.join()
            return None, None  # Return None if timeout occurred
        else:
            if 'error' in result_dict:
                raise result_dict['error']
            return result_dict['kpi'], result_dict['df_res']

def run_all_scenarios(electricity_price_lst, time_period_lst, global_config):
    scenario_lst = list(itertools.product(electricity_price_lst, time_period_lst))
    scenario_name_lst = [f'{scenario[0]}+{scenario[1]}' for scenario in scenario_lst]
    
    script_dir = os.path.dirname(os.path.abspath(__file__))  # Directory of the current Python script
    docker_dir = os.path.abspath(os.path.join(script_dir, ".."))  # Docker directory path
    os.chdir(docker_dir)  # Change directory to the Docker directory
    print (docker_dir)
    
    for scenario in scenario_lst:
        scenario_params = {'time_period': scenario[1], 'electricity_price': scenario[0]}
        print("Testing start", scenario_params)
        try:
            kpi, df_res = run_scenario_with_timeout(scenario_params, timeout=1800)  # Timeout set to 10 minutes (600 seconds)
            if kpi is None or df_res is None:
                print("Scenario execution timed out.")
                # Perform Docker compose down and up
                subprocess.run(["docker","compose", "down"])
                time.sleep(10)
                subprocess.run(["docker","compose", "up", "-d"])
                time.sleep(10)
                continue  # Skip to the next scenario
        except Exception as e:
            print(f"Scenario execution failed: {e}")
            continue  # Skip to the next scenario

        print("Finished testing", scenario_params)

        # Save KPI result for the current scenario if save_kpi_results is True
        if global_config["save_kpi_results"]:
            save_kpi_result(scenario_params, kpi)

        # Save measurements for the current scenario if save_measurements is True
        if global_config["save_measurements"]:
            scenario_name = f'{scenario[0]}+{scenario[1]}'  # Unique sheet name
            save_measurements_to_csv(df_res, scenario_name)

    return scenario_name_lst

def run_single_case(scenario_params, start_time=0, warmup_period=0, length=24*3600):
    """
    Run simulation for a single scenario.

    Args:
    - scenario_params (Scenario): Parameters for the scenario.
    - start_time (int): Start time of the simulation (default: 0).
    - warmup_period (int): Warm-up period for the simulation (default: 0).
    - length (int): Length of the simulation (default: 24*3600).

    Returns:
    - kpi (float): Key Performance Indicator (KPI) for the scenario.
    - df_res (pd.DataFrame): DataFrame containing simulation results.
    """
    control_module = 'examples.python.controllers.baseline'
    step = length
    kpi, df_res, _ , _ = control_test(control_module, start_time, warmup_period, length,
                                                      scenario=scenario_params, step=step)
    time.sleep(5)  # Simulating some processing time
    return kpi, df_res

def save_kpi_result(scenario_params, kpi):
    """
    Save KPI result for a scenario to a JSON file.

    Args:
    - scenario_params (Scenario): Parameters for the scenario.
    - kpi (float): Key Performance Indicator (KPI) for the scenario.
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
        

def save_measurements_to_csv(df_res, scenario_name):
    """
    Save simulation results to a CSV file.

    Args:
    - df_res (pd.DataFrame): DataFrame containing simulation results.
    - scenario_name (str): Name of the scenario.
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

    Args:
    - test_case (str): Name of the test case.
    """
    # Load configuration from JSON file
    with open('config.json') as config_file:
        config = json.load(config_file)
    
    # Check if the test case is in the configuration
    if test_case not in config:
        print(f"Test case '{test_case}' not found in config.")
        sys.exit(1)
    
    model_config = config[test_case]
    
    # Run user-defined baseline control testing or run all scenarios
    if model_config.get("run_user_defined_test", False):
        scenario_name_lst, df_res_scenario_lst = run_single_case(scenario=None, 
                                                                 start_time=15*24*3600, 
                                                                 warmup_period=1*24*3600, 
                                                                 length=7*24*3600)
        scenario_name_lst = ["user_defined"]
        df_res_scenario_lst = [df_res_scenario_lst]
        
        # Save KPI results if required
        if model_config.get("save_kpi_results", True):
            save_kpi_result(scenario_name_lst[0], kpi)
        
        # Save measurements if required
        if model_config.get("save_measurements", False):
            save_measurements_to_csv(df_res_scenario_lst[0], scenario_name_lst[0])
        
    else:
        electricity_price_lst = model_config["electricity_price"]
        time_period_lst = model_config["time_period"]
        scenario_name_lst = run_all_scenarios(electricity_price_lst, 
                                                                    time_period_lst, 
                                                                    config)
    
if __name__ == "__main__":
    # Set the default test case if no command-line argument is provided
    test_case = sys.argv[1] if len(sys.argv) > 1 else 'bestest_air'
    main(test_case)