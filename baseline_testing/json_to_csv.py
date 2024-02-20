# -*- coding: utf-8 -*-
import json
import csv

def json_to_csv(json_data, csv_file):
    # Open CSV file in write mode with newline=''
    with open(csv_file, 'w', newline='') as csvfile:
        # Create a CSV writer object
        writer = csv.writer(csvfile)

        # Write the header row based on the keys of the first dictionary
        if json_data:
            header = json_data[0]['kpi'].keys()  # Assuming all dictionaries have the same keys
            writer.writerow(['time_period', 'electricity_price'] + list(header))

            # Write data rows
            for item in json_data:
                scenario_params = item['scenario_params']
                kpi = item['kpi']
                writer.writerow([scenario_params['time_period'], scenario_params['electricity_price']] +
                                [kpi[key] for key in header])

def load_config(file_path):
    with open(file_path, 'r') as f:
        config = json.load(f)
    return config

# Example usage:
json_data = load_config('kpi_results.json')

# Convert JSON data to CSV
json_to_csv(json_data, 'kpi_results.csv')
