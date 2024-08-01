# Baseline Testing

This folder contains examples and results for performing testing of baseline controllers for different testcases.

## Baseline Controller and Test Case Implementation

- The `root/examples/python/controllers/baseline.py` module file is utilized for executing the baseline control for each test case. It simplifies the process by setting `u={}`.

- The test script `run_baselines.py` facilitates the execution of a sample baseline test, with a configuration file `config.json` and the test case name provided as a command-line argument.

## Configuration File Description

- The `config.json` file is used to configure settings for running baseline simulations. It controls options for defining test scenarios, enabling user-defined tests, and saving results.
- The `config.json` file includes predefined representative scenarios for all the testcases with different combinations of electricity pricing and time period scenarios. Please see `root/Testcases/README.md` or detailed documentation on the testcase [webpage](https://ibpsa.github.io/project1-boptest/testcases/index.html) for different predefined scenarios for each testcase.
- **`save_kpi_results`**: Save calculated key performance indicator (KPI) results (`true` or `false`). Upon execution, the KPI results are saved in the directory `root/baselines/result`. If the `result` directory doesn't exist, it will be created automatically.
- **`save_measurements`**: Save measurement outputs (`true` or `false`). Upon execution, the measurement outputs are saved in the directory `root/baselines/result`. If the `result` directory doesn't exist, it will be created automatically.
- **`run_user_defined_test`**: Enable user-defined scenarios (`true` or `false`).
- **`user_defined_test_options`**: Custom parameters for user-defined scenarios:
  - `electricity_price`: Type of electricity pricing.
  - `start_time`: Start time of the simulation.
  - `warmup_period`: Warm-up period duration.
  - `length`: Duration of the simulation.


## Run an Example Baseline Test

- Run tests for a specific test case with the command: `$ make run_baseline_<TestCase>`.
- Run all the baseline testcases with command: `$ make run_baseline_all`.

## Baseline Testing Results

Last results update: BOPTEST v0.6.0

The purpose of showing the baseline testing results are to provide a reference range for different KPIs among different test cases with various time periods and three electricity price schemes.  Therefore, the results of predefined representative scenarios are also compared with the average results of one year (Day 15-358) or heating season if only a heating system is present (Day 15-45,297-358) with a rolling window of two weeks.  These results are found in ``root/baselines/csv`` and one can reproduce the results by using the test script `root/baselines/csv/run_all_scenarios.py` and providing the desired test case name as a command-line argument.

In total 3180 scenarios are simulated for different testcases with various time periods and three electricity price schemes.
However, it is noted that the baseline controls do not use price signal information, and therefore the KPI results are the same for scenarios with different electricity price schemes except the total cost and controller computational time ratio.

The detailed results for each testcase and the high-level statistical results can be analyzed using ``root/baselines/baseline_control.ipynb``.
The by-testcase results with different time periods are individually illustrated for the following testcases:

1. bestest_air (Day 15-358)
2. multizone_office_simple_air (Day 15-358)
3. bestest_hydronic (Day 15-45,297-358)
4. bestest_hydronic_heat_pump (Day 15-45,297-358)
5. multizone_residential_hydronic (Day 15-45,297-358)
6. twozone_apartment_hydronic (Day 15-45,297-358)
7. singlezone_commercial_hydronic (Day 15-45,297-358)
