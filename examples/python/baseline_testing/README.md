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
The high-level [statistical results for all the testcases](#summary-results-for-all-the-testcases)are summarized first. Then [the by-testcase results](#detailed-results-for-each-testcase) are individually illustrated for the following testcases:

1. [bestest_air](#1-bestest_air) (365-7-14=344 time periods)
2. [multizone_office_simple_air](#2-multizone_office_simple_air) (365-7-14=344 time periods)
3. [bestest_hydronic](#3-bestest_hydronic) (93 time periods)
4. [bestest_hydronic_heat_pump](#4-bestest_hydronic_heat_pump) (93 time periods)
5. [multizone_residential_hydronic](#5-multizone_residential_hydronic) (93 time periods)
6. [singlezone_commercial_hydronic](#6-singlezone_commercial_hydronic) (93 time periods)


## Summary results for all the testcases

The following table shows the statistics of the KPIs for all the testcases and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs using the baseline testing data from all the testcases. 
For example, the third quartile value for ``tdis_tot`` is 9.8 K*h.
The testing result beyond that value probably needs further attention (e.g., doublecheck the benchmark results within the testcase).

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
| mean  |        8.8 |     1649.5 |       3.24 |      0.228 |       0.81 |      0.015 |      0.074 |       0.09 |    0.000122 |
| std   |        6.5 |     3101.9 |       2.99 |      0.231 |       0.54 |      0.01  |      0.044 |       0    |    0.000608 |
| min   |        0.2 |        0   |       0.1  |      0.009 |       0.03 |      0     |      0     |       0.08 |    2e-05    |
| 25%   |        4.8 |        0   |       1.19 |      0.054 |       0.42 |      0.005 |      0.033 |       0.09 |    4.2e-05  |
| 50%   |        6.7 |      263.9 |       2.05 |      0.122 |       0.67 |      0.017 |      0.093 |       0.09 |    4.6e-05  |
| 75%   |        9.8 |     1222.2 |       4.28 |      0.349 |       1.17 |      0.023 |      0.117 |       0.09 |    0.000158 |
| max   |       29.1 |    14853   |      12.42 |      0.942 |       2.25 |      0.033 |      0.121 |       0.09 |    0.011904 |
</div>

<h4 align="center">Boxplot of KPI Distribution for All Scenarios</h4>

<p align="center">
  <img src="./img/boxplot_all_summary.png" alt="boxplot_all_summary"/>
</p>


## Detailed results for each testcase

For each testcase, the baseline testing results are visualized by a scatterplot and a boxplot to show the KPI ranges in different scenarios. 


### 1. bestest_air

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot. 
To provide a convincing benchmark, the heating month average, cooling month average, and annual average for different KPIs are provided in the last three rows.
For a specific sceanrio (e.g., constant+peak_cool_day), one could compare the customized controller performance with the baseline case results (row 2).
In addition, the cooling month average (row 16) and annual average results could be compared (row 17). 


<h4 align="center"> Typical Day Testing Result Table for Testcase bestest_air </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |        5.7 |     1219.7 |       3.72 |      0.023 |       0.79 |      0.01  |      0.121 |        nan | 0.000259    |
|  1 | constant       | typical_heat_day   |        5.6 |     1219.7 |       2.69 |      0.032 |       0.71 |      0.017 |      0.104 |        nan | 3.2e-05     |
|  2 | constant       | peak_cool_day      |        7.7 |     1222.1 |       2.23 |      0.121 |       1.47 |      0.033 |      0.022 |        nan | 3.7e-05     |
|  3 | constant       | typical_cool_day   |        4.3 |     1222.6 |       1.1  |      0.06  |       0.73 |      0.015 |      0     |        nan | 3.6e-05     |
|  4 | constant       | mix_day            |        5.7 |     1220.2 |       3.18 |      0.043 |       0.89 |      0.023 |      0.117 |        nan | 3.3e-05     |
|  5 | dynamic        | peak_heat_day      |        5.7 |     1219.7 |       3.72 |      0.027 |       0.79 |      0.01  |      0.121 |        nan | 3.3e-05     |
|  6 | dynamic        | typical_heat_day   |        5.6 |     1219.7 |       2.69 |      0.041 |       0.71 |      0.017 |      0.104 |        nan | 3.3e-05     |
|  7 | dynamic        | peak_cool_day      |        7.7 |     1222.1 |       2.23 |      0.15  |       1.47 |      0.033 |      0.022 |        nan | 3.2e-05     |
|  8 | dynamic        | typical_cool_day   |        4.3 |     1222.6 |       1.1  |      0.102 |       0.73 |      0.015 |      0     |        nan | 3.3e-05     |
|  9 | dynamic        | mix_day            |        5.7 |     1220.2 |       3.18 |      0.056 |       0.89 |      0.023 |      0.117 |        nan | 3.2e-05     |
| 10 | highly_dynamic | peak_heat_day      |        5.7 |     1219.7 |       3.72 |      0.016 |       0.79 |      0.01  |      0.121 |        nan | 3.3e-05     |
| 11 | highly_dynamic | typical_heat_day   |        5.6 |     1219.7 |       2.69 |      0.014 |       0.71 |      0.017 |      0.104 |        nan | 3.3e-05     |
| 12 | highly_dynamic | peak_cool_day      |        7.7 |     1222.1 |       2.23 |      0.068 |       1.47 |      0.033 |      0.022 |        nan | 3.2e-05     |
| 13 | highly_dynamic | typical_cool_day   |        4.3 |     1222.6 |       1.1  |      0.035 |       0.73 |      0.015 |      0     |        nan | 3.2e-05     |
| 14 | highly_dynamic | mix_day            |        5.7 |     1220.2 |       3.18 |      0.015 |       0.89 |      0.023 |      0.117 |        nan | 3.7e-05     |
| 15 | constant       | heat_month_average |        5.7 |     1220.5 |       2.55 |      0.043 |       0.8  |      0.021 |      0.098 |        nan | 4.35484e-05 |
| 16 | constant       | cool_month_average |        7.2 |     1222.2 |       2.21 |      0.121 |       1.46 |      0.026 |      0.001 |        nan | 4.06667e-05 |
| 17 | constant       | annual_average     |        5.9 |     1221.4 |       2.01 |      0.072 |       0.98 |      0.023 |      0.049 |        nan | 8.07673e-05 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase bestest_air </h4>

<p align="center">
  <img src="./img/scatterplot_bestest_air.png" alt="scatterplot_bestest_air"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``bestest_air`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 


<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for Testcase bestest_air </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |        5.9 |     1221.4 |       2.01 |      0.072 |       0.98 |      0.023 |      0.049 |        nan |   8.1e-05  |
| std   |        1.3 |        1.1 |       0.8  |      0.039 |       0.4  |      0.006 |      0.042 |        nan |   0.000603 |
| min   |        3   |     1218.7 |       0.46 |      0.014 |       0.27 |      0.01  |      0     |        nan |   2.3e-05  |
| 25%   |        4.9 |     1220.5 |       1.36 |      0.04  |       0.68 |      0.018 |      0     |        nan |   4.2e-05  |
| 50%   |        5.6 |     1221.9 |       1.91 |      0.056 |       0.81 |      0.022 |      0.042 |        nan |   4.4e-05  |
| 75%   |        6.8 |     1222.3 |       2.46 |      0.107 |       1.32 |      0.026 |      0.082 |        nan |   4.4e-05  |
| max   |        9.3 |     1223.1 |       4.78 |      0.167 |       2.02 |      0.033 |      0.121 |        nan |   0.01126  |
| count |      344   |      344   |     344    |    344     |     344    |    344     |    344     |          0 | 344        |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase bestest_air </h4>

<p align="center">
  <img src="./img/boxplot_bestest_air.png" alt="boxplot_bestest_air"/>
</p>

### 2. multizone_office_simple_air

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot.  
To provide a convincing benchmark, the heating month average, cooling month average, and annual average for different KPIs are provided in the last three rows.
For a specific sceanrio (e.g., constant+peak_cool_day), one could compare the customized controller performance with the baseline case results (row 2).
In addition, the cooling month average (row 16) and annual average results could be compared (row 17). 

<h4 align="center"> Typical Day Testing Result Table for Testcase multizone_office_simple_air </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |       11.8 |        0   |       1.79 |      0.168 |       0.61 |      0.033 |        nan |        nan | 4.4e-05     |
|  1 | constant       | typical_heat_day   |        7.7 |        0   |       1.05 |      0.099 |       0.36 |      0.028 |        nan |        nan | 0.000101    |
|  2 | constant       | peak_cool_day      |        8.6 |       79.9 |       2.19 |      0.206 |       0.75 |      0.024 |        nan |        nan | 9.8e-05     |
|  3 | constant       | typical_cool_day   |        2.7 |       20.3 |       0.85 |      0.08  |       0.29 |      0.012 |        nan |        nan | 8.7e-05     |
|  4 | constant       | mix_day            |        5   |        0   |       0.31 |      0.029 |       0.11 |      0.016 |        nan |        nan | 8.6e-05     |
|  5 | dynamic        | peak_heat_day      |       11.8 |        0   |       1.79 |      0.165 |       0.61 |      0.033 |        nan |        nan | 9.9e-05     |
|  6 | dynamic        | typical_heat_day   |        7.7 |        0   |       1.05 |      0.095 |       0.36 |      0.028 |        nan |        nan | 0.000104    |
|  7 | dynamic        | peak_cool_day      |        8.6 |       79.9 |       2.19 |      0.246 |       0.75 |      0.024 |        nan |        nan | 0.0001      |
|  8 | dynamic        | typical_cool_day   |        2.7 |       20.3 |       0.85 |      0.094 |       0.29 |      0.012 |        nan |        nan | 8.8e-05     |
|  9 | dynamic        | mix_day            |        5   |        0   |       0.31 |      0.029 |       0.11 |      0.016 |        nan |        nan | 8.6e-05     |
| 10 | highly_dynamic | peak_heat_day      |       11.8 |        0   |       1.79 |      0.133 |       0.61 |      0.033 |        nan |        nan | 9.9e-05     |
| 11 | highly_dynamic | typical_heat_day   |        7.7 |        0   |       1.05 |      0.072 |       0.36 |      0.028 |        nan |        nan | 0.000105    |
| 12 | highly_dynamic | peak_cool_day      |        8.6 |       79.9 |       2.19 |      0.165 |       0.75 |      0.024 |        nan |        nan | 0.0001      |
| 13 | highly_dynamic | typical_cool_day   |        2.7 |       20.3 |       0.85 |      0.056 |       0.29 |      0.012 |        nan |        nan | 8.6e-05     |
| 14 | highly_dynamic | mix_day            |        5   |        0   |       0.31 |      0.022 |       0.11 |      0.016 |        nan |        nan | 8.6e-05     |
| 15 | constant       | heat_month_average |        7.5 |       29.9 |       1.11 |      0.104 |       0.38 |      0.025 |        nan |        nan | 0.000271075 |
| 16 | constant       | cool_month_average |        5.5 |       67.8 |       1.49 |      0.14  |       0.51 |      0.02  |        nan |        nan | 0.000153409 |
| 17 | constant       | annual_average     |        5.2 |       55.7 |       0.97 |      0.091 |       0.33 |      0.019 |        nan |        nan | 0.000185249 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase multizone_office_simple_air </h4>

<p align="center">
  <img src="./img/scatterplot_multizone_office_simple_air.png" alt="scatterplot_multizone_office_simple_air"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``multizone_office_simple_air`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for multizone_office_simple_air </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |        5.2 |       55.7 |       0.97 |      0.091 |       0.33 |      0.019 |        nan |        nan |   0.000185 |
| std   |        3.2 |       85.5 |       0.58 |      0.055 |       0.2  |      0.008 |        nan |        nan |   0.000622 |
| min   |        0.2 |        0   |       0.1  |      0.009 |       0.03 |      0.004 |        nan |        nan |   4.4e-05  |
| 25%   |        2.1 |        0   |       0.44 |      0.041 |       0.15 |      0.012 |        nan |        nan |   0.000153 |
| 50%   |        5.2 |       30.3 |       1.03 |      0.096 |       0.35 |      0.02  |        nan |        nan |   0.000161 |
| 75%   |        7.7 |       76   |       1.35 |      0.127 |       0.46 |      0.024 |        nan |        nan |   0.00017  |
| max   |       13.3 |      712.2 |       2.26 |      0.246 |       0.77 |      0.033 |        nan |        nan |   0.011904 |
| count |      344   |      344   |     344    |    344     |     344    |    344     |          0 |          0 | 344        |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase multizone_office_simple_air </h4>

<p align="center">
  <img src="./img/boxplot_multizone_office_simple_air.png" alt="boxplot_multizone_office_simple_air"/>
</p>


### 3. bestest_hydronic

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot.  
To provide a convincing benchmark, the heating month average for different KPIs is provided in the last row.
For a specific sceanrio (e.g., constant+peak_heat_day), one could compare the customized controller performance with the baseline case results (row 0).
In addition, the heating month average results could be compared (row 6). 

<h4 align="center"> Typical Day Testing Result Table for Testcase bestest_hydronic </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |       18.2 |          0 |       9    |      0.466 |       1.63 |          0 |      0.118 |        nan | 2e-05       |
|  1 | constant       | typical_heat_day   |       27.9 |          0 |      12.24 |      0.627 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  2 | dynamic        | peak_heat_day      |       18.2 |          0 |       9    |      0.466 |       1.63 |          0 |      0.118 |        nan | 2.9e-05     |
|  3 | dynamic        | typical_heat_day   |       27.9 |          0 |      12.24 |      0.627 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  4 | highly_dynamic | peak_heat_day      |       18.2 |          0 |       9    |      0.465 |       1.63 |          0 |      0.118 |        nan | 3e-05       |
|  5 | highly_dynamic | typical_heat_day   |       27.9 |          0 |      12.24 |      0.626 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  6 | constant       | heat_month_average |       18   |          0 |       9.12 |      0.471 |       1.65 |          0 |      0.118 |        nan | 4.12473e-05 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase bestest_hydronic </h4>

<p align="center">
  <img src="./img/scatterplot_bestest_hydronic.png" alt="scatterplot_bestest_hydronic"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``bestest_hydronic`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for bestest_hydronic </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |       18.3 |          0 |       9.21 |      0.476 |       1.67 |          0 |      0.118 |        nan |    4e-05   |
| std   |        5.8 |          0 |       2.27 |      0.113 |       0.41 |          0 |      0.001 |        nan |    5e-06   |
| min   |        4.5 |          0 |       3.98 |      0.214 |       0.72 |          0 |      0.114 |        nan |    2e-05   |
| 25%   |       13.6 |          0 |       9.11 |      0.472 |       1.65 |          0 |      0.118 |        nan |    4e-05   |
| 50%   |       19.2 |          0 |       9.8  |      0.505 |       1.77 |          0 |      0.118 |        nan |    4.1e-05 |
| 75%   |       22.4 |          0 |      10.53 |      0.542 |       1.9  |          0 |      0.118 |        nan |    4.1e-05 |
| max   |       28   |          0 |      12.42 |      0.636 |       2.25 |          0 |      0.118 |        nan |    6e-05   |
| count |       93   |         93 |      93    |     93     |      93    |         93 |     93     |          0 |   93       |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase bestest_hydronic </h4>

<p align="center">
  <img src="./img/boxplot_bestest_hydronic.png" alt="boxplot_bestest_hydronic"/>
</p>


### 4. bestest_hydronic_heat_pump

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot.  
To provide a convincing benchmark, the heating month average for different KPIs is provided in the last row.
For a specific sceanrio (e.g., constant+peak_heat_day), one could compare the customized controller performance with the baseline case results (row 0).
In addition, the heating month average results could be compared (row 6). 

<h4 align="center"> Typical Day Testing Result Table for Testcase bestest_hydronic_heat_pump </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |        8.4 |          0 |       3.48 |      0.882 |       0.58 |      0.019 |    nan     |        nan | 3.2e-05     |
|  1 | constant       | typical_heat_day   |        9.4 |          0 |       1.77 |      0.45  |       0.3  |      0.016 |    nan     |        nan | 4.5e-05     |
|  2 | dynamic        | peak_heat_day      |        8.4 |          0 |       3.48 |      0.883 |       0.58 |      0.019 |    nan     |        nan | 4.1e-05     |
|  3 | dynamic        | typical_heat_day   |        9.4 |          0 |       1.77 |      0.442 |       0.3  |      0.016 |    nan     |        nan | 4.1e-05     |
|  4 | highly_dynamic | peak_heat_day      |        8.4 |          0 |       3.48 |      0.909 |       0.58 |      0.019 |    nan     |        nan | 4e-05       |
|  5 | highly_dynamic | typical_heat_day   |        9.4 |          0 |       1.77 |      0.413 |       0.3  |      0.016 |    nan     |        nan | 4.2e-05     |
|  6 | constant       | heat_month_average |       14.2 |          0 |       6.82 |      0.588 |       1.22 |      0.006 |      0.117 |        nan | 3.81183e-05 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase bestest_hydronic_heat_pump </h4>

<p align="center">
  <img src="./img/scatterplot_bestest_hydronic_heat_pump.png" alt="scatterplot_bestest_hydronic_heat_pump"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``bestest_hydronic_heat_pump`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for bestest_hydronic_heat_pump </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |       13.9 |          0 |       6.57 |      0.593 |       1.17 |      0.007 |      0.117 |        nan |    3.8e-05 |
| std   |        6   |          0 |       3.18 |      0.235 |       0.59 |      0.009 |      0.001 |        nan |    4e-06   |
| min   |        4.5 |          0 |       1.77 |      0.214 |       0.3  |      0     |      0.114 |        nan |    2.3e-05 |
| 25%   |        8.9 |          0 |       3.5  |      0.473 |       0.58 |      0     |      0.118 |        nan |    3.4e-05 |
| 50%   |       11.2 |          0 |       4.93 |      0.528 |       0.89 |      0     |      0.118 |        nan |    4e-05   |
| 75%   |       20.4 |          0 |       9.87 |      0.865 |       1.78 |      0.019 |      0.118 |        nan |    4.1e-05 |
| max   |       27.4 |          0 |      11.15 |      0.942 |       2.02 |      0.019 |      0.118 |        nan |    4.5e-05 |
| count |       93   |         93 |      93    |     93     |      93    |     93     |     62     |          0 |   93       |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase bestest_hydronic_heat_pump </h4>

<p align="center">
  <img src="./img/boxplot_bestest_hydronic_heat_pump.png" alt="boxplot_bestest_hydronic_heat_pump"/>
</p>


### 5. multizone_residential_hydronic

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot.  
To provide a convincing benchmark, the heating month average for different KPIs is provided in the last row.
For a specific sceanrio (e.g., constant+peak_heat_day), one could compare the customized controller performance with the baseline case results (row 0).
In addition, the heating month average results could be compared (row 6). 

<h4 align="center"> Typical Day Testing Result Table for Testcase multizone_residential_hydronic </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.793 |       1.43 |      0.002 |      0.096 |        nan | 4.3e-05     |
|  1 | constant       | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.591 |       1.03 |      0.002 |      0.096 |        nan | 0.000101    |
|  2 | dynamic        | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.791 |       1.43 |      0.002 |      0.096 |        nan | 0.000106    |
|  3 | dynamic        | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.588 |       1.03 |      0.002 |      0.096 |        nan | 0.0001      |
|  4 | highly_dynamic | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.771 |       1.43 |      0.002 |      0.096 |        nan | 0.000103    |
|  5 | highly_dynamic | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.57  |       1.03 |      0.002 |      0.096 |        nan | 0.000102    |
|  6 | constant       | heat_month_average |       20.4 |    10553.6 |       6.06 |      0.598 |       1.05 |      0.002 |      0.095 |        nan | 0.000155323 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase multizone_residential_hydronic </h4>

<p align="center">
  <img src="./img/scatterplot_multizone_residential_hydronic.png" alt="scatterplot_multizone_residential_hydronic"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``multizone_residential_hydronic`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for multizone_residential_hydronic </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |       20.5 |    10514.1 |       6.12 |      0.603 |       1.06 |      0.002 |      0.095 |        nan |   0.000152 |
| std   |        5   |     1466.3 |       1.46 |      0.14  |       0.26 |      0.001 |      0.002 |        nan |   0.000146 |
| min   |        5   |     5340.2 |       0.96 |      0.1   |       0.16 |      0.002 |      0.08  |        nan |   4.1e-05  |
| 25%   |       18.7 |     9952.2 |       5.59 |      0.555 |       0.97 |      0.002 |      0.096 |        nan |   0.0001   |
| 50%   |       21.8 |    10497.6 |       6.1  |      0.603 |       1.06 |      0.002 |      0.096 |        nan |   0.00013  |
| 75%   |       23.6 |    11257.2 |       7.12 |      0.698 |       1.24 |      0.002 |      0.096 |        nan |   0.000176 |
| max   |       29.1 |    14853   |       8.16 |      0.796 |       1.43 |      0.007 |      0.096 |        nan |   0.001539 |
| count |       93   |       93   |      93    |     93     |      93    |     93     |     93     |          0 |  93        |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase multizone_residential_hydronic </h4>

<p align="center">
  <img src="./img/boxplot_multizone_residential_hydronic.png" alt="boxplot_multizone_residential_hydronic"/>
</p>


### 6. singlezone_commercial_hydronic

The baseline testing results for the typical days with constant pricing scenario is tabulated in the following table and depicted in the scatterplot.  
To provide a convincing benchmark, the heating month average for different KPIs is provided in the last row.
For a specific sceanrio (e.g., constant+peak_heat_day), one could compare the customized controller performance with the baseline case results (row 0).
In addition, the heating month average results could be compared (row 6). 

<h4 align="center">  Typical Day Testing Result Table for Testcase singlezone_commercial_hydronic </h4>

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|    |                |                    |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |           1 |
|  0 | constant       | peak_heat_day      |        8   |        5.4 |       3.22 |      0.262 |       0.38 |      0.005 |        nan |       0.09 | 2.7e-05     |
|  1 | constant       | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.157 |       0.29 |      0.006 |        nan |       0.08 | 4.4e-05     |
|  2 | dynamic        | peak_heat_day      |        8   |        5.4 |       3.22 |      0.263 |       0.38 |      0.005 |        nan |       0.09 | 5e-05       |
|  3 | dynamic        | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.16  |       0.29 |      0.006 |        nan |       0.08 | 4.4e-05     |
|  4 | highly_dynamic | peak_heat_day      |        8   |        5.4 |       3.22 |      0.263 |       0.38 |      0.005 |        nan |       0.09 | 4.8e-05     |
|  5 | highly_dynamic | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.161 |       0.29 |      0.006 |        nan |       0.08 | 4.6e-05     |
|  6 | constant       | heat_month_average |        6.4 |     3235.2 |       3.83 |      0.305 |       0.47 |      0.006 |        nan |       0.09 | 0.000193538 |

<h4 align="center"> Scatterplot of Typical Day Testing Results for Testcase singlezone_commercial_hydronic </h4>

<p align="center">
  <img src="./img/scatterplot_singlezone_commercial_hydronic.png" alt="scatterplot_singlezone_commercial_hydronic"/>
</p>

The following table shows the statistics of the KPIs for Testcase ``singlezone_commercial_hydronic`` and the boxplot shows the distribution of different KPIs with the typical day results annotated. 
From there, one could benchmark some hard-to-judge KPIs from the statistics and distributions. 

<div align="center">
<h4 align="center"> Statistic Summary Table of All Scenarios for singlezone_commercial_hydronic </h4>

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |   time_rat |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| unit  |        K*h |      ppm*h |       kW*h |       euro |      kgCO2 |     kW/m^2 |     kW/m^2 |     kW/m^2 |          1 |
| mean  |        6.3 |     3408.9 |       3.76 |      0.299 |       0.46 |      0.006 |        nan |       0.09 |   0.000184 |
| std   |        2.4 |     3039.6 |       0.7  |      0.056 |       0.09 |      0.001 |        nan |       0    |   0.001179 |
| min   |        0.9 |        2.1 |       2.12 |      0.157 |       0.29 |      0.001 |        nan |       0.08 |   2.7e-05  |
| 25%   |        4.7 |      548.4 |       3.22 |      0.26  |       0.38 |      0.006 |        nan |       0.09 |   5e-05    |
| 50%   |        7   |     2999.3 |       3.87 |      0.303 |       0.48 |      0.006 |        nan |       0.09 |   6.9e-05  |
| 75%   |        8.2 |     5654.1 |       4.36 |      0.346 |       0.54 |      0.006 |        nan |       0.09 |   7.2e-05  |
| max   |       11.3 |    12196.2 |       4.97 |      0.397 |       0.61 |      0.006 |        nan |       0.09 |   0.011796 |
| count |       93   |       93   |      93    |     93     |      93    |     93     |          0 |      93    |  93        |
</div>

<h4 align="center"> Boxplot of All-Scenario Testing Results for Testcase singlezone_commercial_hydronic </h4>

<p align="center">
  <img src="./img/boxplot_singlezone_commercial_hydronic.png" alt="boxplot_singlezone_commercial_hydronic"/>
</p>
