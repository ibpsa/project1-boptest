# Baseline Testing

This folder contains examples and results for performing testing of baseline controllers for different testcases.

## Baseline Controller and Test Case Implementation

- The ``baseline.py`` module file is utilized for executing the baseline control for each test case. It simplifies the process by setting ``u={}``.

- The test script ``run_baselines.py`` facilitates the execution of a sample baseline test, with the test case name provided as a command-line argument. If not explicitly mentioned, the default test case is assumed to be  ``bestest_air``. If the Boolean parameter ``run_user_defined_test`` is set to ``False``, the script simulates predefined test case scenarios outlined in ``config.json``. Alternatively, if it is ``True``, the baseline scenario can be customized by specifying parameters such as ``start_time``, ``warmup_period``, and ``length``. Additionally, the user has the option to save the results of KPIs and measurements by setting both  ``save_kpi_results`` and ``save_measurements`` to ``True``. The default values are both set to ``False``.

## Run an Example Baseline Test
The baseline testing could be conducted in either of the two methods:

- Run the test with command: ``$ make run_baseline_<TestCase>``. Run all the baseline testcases with command: ``$ make run_baseline_all``

- Or, deploy the test case corresponding to the desired example (see repository root ``README.md`` for instructions on deploying a test case). 
Then, use ``$ python testcase. py <TestCase>`` to run the desired example.

## Baseline Testing Scenarios
Two-week simulation are conducted with three electricity price schemes and representative time periods for each testcase. Please see ``root/Testcases/README.md`` for different predefined scenarios for each testcase. 

For each scenario, one week simulation before ``time_period`` is conducted for the warm-up and two-week simulation is then conducted.
The results of these representative scenarios are also compared with the average results of one year (Day 15-358)/heating season (Day 15-45,297-358) with a rolling window of two weeks. 
In total 3180 scenarios are simulated for different testcases with various time periods and three electricity price schemes. 
However, it is noted that the baseline controls do not use price signal information, and therefore the KPI results are the same for scenarios with different electricity price schemes except the total cost and controller computational time ratio. 

The purpose of showing the baseline testing results are to provide a reference range for different KPIs among different test cases with various time periods and three electricity price schemes. 
The detailed results for each testcase could be referred to [baseline_control.ipynb](baseline_control.ipynb).
The by-testcase results with different time periods are individually illustrated for the following testcases:

1. bestest_air (Day 15-358)
2. multizone_office_simple_air (Day 15-358)
3. bestest_hydronic (Day 15-45,297-358)
4. bestest_hydronic_heat_pump (Day 15-45,297-358)
5. multizone_residential_hydronic (Day 15-45,297-358)
6. singlezone_commercial_hydronic (Day 15-45,297-358)

After that the high-level statistical results for all the testcases are summarized. 

