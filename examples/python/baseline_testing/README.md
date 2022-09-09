# Baseline Testing

This folder contains examples and results for performing testing of baseline controllers for different testcases.

## Baseline Controller and Test Case Implementation

- For each ``<TestCase>``, the baseline controller module file ``<TestCase>.py`` and the test script ``testcase<TestCase>scenario.py`` will be used for running an example baseline test.

- Baseline control modules files ``<TestCase>.py`` are located in ``../controllers``. The baseline controllers are actually incorporated in the testcase models.
The function ``compute_control`` is psuedo. The control inputs will not be overwritten by this external controller. Thus, baseline controllers in the testcase models will be used. 

- For test scripts ``testcase<TestCase>scenario.py`` for performing the baseline control test, user could specify the combination of
simulation start, warmup_period, and length or a predefined test case scenario. For the default setting of the baseline tests,
 scenarios with different electricity prices and time periods will be  simulated. 

## Run an Example Baseline Test
- First, deploy the test case corresponding to the desired example (see repository root ``README.md`` for instructions on deploying a test case).
- Then, use ``$ python testcase<TestCase>scenario.py`` to run the desired example.

## Baseline Testing Scenarios
Two-week simulation are conducted with three electricity price schemes and representative time periods for each testcase. Please see ``root/Testcases/README.md`` for different predefined scenarios for each testcase. 

For each scenario, one week simulation before ``time_period`` is conducted for the warm-up and two-week simulation is then conducted.
The results of these representative scenarios are also compared with the average results of one year/heating season (that depends on the testcases) with a rolling window of two weeks. 
In total 3180 scenarios are simulated for different testcases with various time periods and three electricity price schemes. 
However, it is noted that the baseline controls do not use price signal information, and therefore the KPI results are the same for scenarios with different electricity price schemes except the total cost and controller computational time ratio. 
For the KPIs including the cost and controller computational time ratio, we consider all 3180 scenarios. To avoid the repetition, we only show the baseline results of one electricity price scheme (in total 1060 cases as shown below) for rest of KPIs.

The purpose of showing the baseline testing results are to provide a reference range for different KPIs among different test cases with various time periods and three electricity price schemes. 
The detailed results for each testcase could be referred to ``[baseline_control.ipynb](baseline_control.ipynb)``.
The high-level statistical results for all the testcases are summarized first. Then the by-testcase results are individually illustrated for the following testcases:

1. bestest_air (365-7-14=344 time periods)
2. multizone_office_simple_air (365-7-14=344 time periods)
3. bestest_hydronic (93 time periods)
4. bestest_hydronic_heat_pump (93 time periods)
5. multizone_residential_hydronic (93 time periods)
6. singlezone_commercial_hydronic (93 time periods)



