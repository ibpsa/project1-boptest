# -*- coding: utf-8 -*-
"""
This script demonstrates baseline testing of a test case.
"""

import os
import sys
import json
import itertools
from examples.python.interface import control_test
import pandas as pd


def run_all_scenarios(price_elec_lst, time_period_lst):

    scenario_lst = list(itertools.product(price_elec_lst, time_period_lst))
    scenario_name_lst = [f'{scenario[0]}+{scenario[1]}' for scenario in scenario_lst]
    
    kpi_scenario_lst = []
    df_res_scenario_lst = []

    for scenario in scenario_lst:
        scenario = {'time_period': scenario[1], 'electricity_price': scenario[0]}
        kpi, df_res  = run_single_case(scenario)
        print("Finished testing", scenario)
        kpi_scenario_lst.append(kpi)
        df_res_scenario_lst.append(df_res)
    
    return scenario_name_lst, kpi_scenario_lst, df_res_scenario_lst


def run_single_case(scenario, start_time=0, warmup_period=0, length=24*3600):

    control_module = 'examples.python.controllers.baseline'
    step = length
    
    kpi, df_res, _ , _ = control_test(control_module, start_time, warmup_period, length,
                                                      scenario=scenario, step=step)
    
    return kpi, df_res

    
def main(test_case):
    # Default settings
    save_kpi_results = True
    save_measurements = True
    run_user_defined_test = False
    
    
    # Load configuration from JSON file
    with open('config.json') as config_file:
        config = json.load(config_file)
    
    # Check if the test case is in the configuration
    if test_case not in config:
        print(f"Test case '{test_case}' not found in config.")
        sys.exit(1)
    
    model_config = config[test_case]
    
    # Run user-defined baseline control testing or run all scenarios
    if run_user_defined_test:
        kpi_scenario_lst, df_res_scenario_lst = run_single_case(scenario=None, 
                                                                 start_time=15*24*3600, 
                                                                 warmup_period=1*24*3600, 
                                                                 length=7*24*3600)
        scenario_name_lst = ["user_defined"]
        df_res_scenario_lst = [df_res_scenario_lst]
    else:
        price_elec_lst = model_config["price_elec"]
        time_period_lst = model_config["time_period"]
        scenario_name_lst, kpi_scenario_lst, df_res_scenario_lst = run_all_scenarios(price_elec_lst, 
                                                                                     time_period_lst)
            
    # Save KPI results if required
    if save_kpi_results:
        df_kpi = pd.DataFrame(kpi_scenario_lst, index=scenario_name_lst)
        df_kpi.to_csv(f'df_kpi_{test_case}.csv', header=True, encoding='utf-8')
    
    # Save measurements if required
    if save_measurements:
        writer = pd.ExcelWriter(f'df_res_{test_case}.xlsx')
        # Create a dictionary to store DataFrames with their corresponding sheet names
        dfs_to_write = {str(sheet_name): df_res_scenario for sheet_name, df_res_scenario in zip(scenario_name_lst, df_res_scenario_lst)}
        # Write all DataFrames to the Excel file at once
        for sheet_name, df_res_scenario in dfs_to_write.items():
            df_res_scenario.to_excel(writer, sheet_name=sheet_name)
        # Save the Excel file
        writer.close()    
            
            

if __name__ == "__main__":
    # Set the default test case if no command-line argument is provided
    test_case = sys.argv[1] if len(sys.argv) > 1 else 'bestest_air'
    main(test_case)    
