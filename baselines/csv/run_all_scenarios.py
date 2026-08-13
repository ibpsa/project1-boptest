# -*- coding: utf-8 -*-
"""
This script demonstrates baseline testing of all the testcases.
"""
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from run_baselines import run_single_case
import pandas as pd


def main(test_case):
    """
    Main function to run simulations based on the specified test case.

    Parameters
    ----------
    test_case : str
        Name of the test case. This will be used to construct the CSV file name.
        The CSV file should contain scenarios and corresponding test days for the specified test case.

    Returns
    -------
    pandas.DataFrame
        DataFrame containing the results of the simulations for each scenario in the test case.
        The DataFrame includes columns for Scenario, test_day, cost_tot, emis_tot, ener_tot,
        idis_tot, pdih_tot, pele_tot, pgas_tot, tdis_tot, and time_rat.

    Notes
    -----
    This function reads data from a CSV file named 'df_kpi_{test_case}.csv' and loops through each scenario
    and corresponding test day to run simulations using the 'run_single_case' function. It then collects
    the simulation results into a DataFrame and returns it.
    """
    # Get the current directory of the Python script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Construct the path to the CSV file in the same directory
    csv_file_path = os.path.join(script_dir, f'df_kpi_{test_case}.csv')
    df = pd.read_csv(csv_file_path)
    scenarios = df['Scenario']
    test_days = df['test_day']
    
    # Create an empty list to store scenario data
    scenario_data_list = []
    
    # Loop through each scenario and corresponding test_day
    for scenario, test_day_value in zip(scenarios, test_days):
        # Split the scenario string into price signal and day number
        price_signal, day_number = scenario.split('+Day')
        day_number = int(day_number)
        
        # Print or use the price signal and day number
        print("Price Signal:", price_signal)
        print("Day Number:", day_number)
    
        kpi, df_res_scenario_lst = run_single_case(scenario_params={"electricity_price": price_signal},
                                               start_time=day_number*24*3600-7*24*3600,
                                               warmup_period=7*24*3600,
                                               length=14*24*3600)
        
        # Add scenario and kpi data to the DataFrame
        scenario_data = {
            'Scenario': scenario,
            'test_day': test_day_value,
            'cost_tot': kpi.get('cost_tot', None),
            'emis_tot': kpi.get('emis_tot', None),
            'ener_tot': kpi.get('ener_tot', None),
            'idis_tot': kpi.get('idis_tot', None),
            'pdih_tot': kpi.get('pdih_tot', None),
            'pele_tot': kpi.get('pele_tot', None),
            'pgas_tot': kpi.get('pgas_tot', None),
            'tdis_tot': kpi.get('tdis_tot', None),
            'time_rat': kpi.get('time_rat', None)
        }
        scenario_data_list.append(scenario_data)
    
    # Convert the list of dictionaries into a DataFrame
    scenario_df = pd.DataFrame(scenario_data_list)
    
    # Save the DataFrame to a CSV file
    output_csv_path = os.path.join(script_dir, f'results_{test_case}.csv')
    scenario_df.to_csv(output_csv_path, index=False)  # Set index=False to exclude the DataFrame index from the CSV

    return scenario_df

if __name__ == "__main__":
    # Set the default test case if no command-line argument is provided
    test_case = sys.argv[1] if len(sys.argv) > 1 else input("Enter the test case name: ")
    scenario_df = main(test_case)