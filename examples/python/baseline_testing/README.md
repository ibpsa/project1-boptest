# Baseline Testing

This folder contains examples and results for performing testing of baseline controllers for different testcases.

## Baseline Controller Implementation

- The baseline controllers are incorporated in the testcase models.
The control modules for each testcases in ``../controllers`` follow the structure as described above 
(see upper directory ``../README.md`` for instructions on deploying a control test case).
The function ``compute_control`` is psuedo. The control inputs will not be overwritten by this external controller. 

- For test scripts for performing the baseline control test, user could specify the combination of
simulation start, warmup_period, and length or a predefined test case scenario. For the default setting of the baseline tests,
 scenarios with different electricity prices and time periods will be  simulated. 

## Run an Example Baseline Test
- First, deploy the test case corresponding to the desired example as described above (see repository root ``README.md`` for instructions on deploying a test case).
- Then, use ``$ python testcase<...>.py`` depending on the desired example from those defined above.

## Baseline Testing Results
Two-week simulation are conducted with different electricity prices and representative time periods for each testcases Please see ``root/Testcases/README.md`` for different predefined scenarios for each testcase. For each scenario, one week simulation before ``time_period`` is conducted for the warm-up and two-week simulation is then conducted.
The results of these representative scenarios are also compared with the average results of one year/heating season (that depends on the testcases) with a rolling window of two weeks.

The high-level [statistical results for all the testcases](#summary-results-for-all-the-testcases)are summarized first. Then [the by-testcase results](#summary-results-for-each-testcase) are individually illustrated for the following testcases:

1. [bestest_air](#1-bestest_air)
2. [multizone_office_simple_air](#2-multizone_office_simple_air)
3. [bestest_hydronic](#3-bestest_hydronic)
4. [bestest_hydronic_heat_pump](#4-bestest_hydronic_heat_pump)
5. [multizone_residential_hydronic](#5-multizone_residential_hydronic)
6. [singlezone_commercial_hydronic](#6-singlezone_commercial_hydronic)


### Summary results for all the testcases

The following table shows the statistics of the KPIs for all the testcases. 

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
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

### Summary results for each testcase

For each testcase, the baseline testing results are visualized by a scatterplot and a boxplot to show the KPI ranges in different scenarios. Note that the baseline controls do not use price signal information, and therefore the KPI results are the same for  scenarios price different electricity prices expect the total cost and controller computation time ratio. 


#### 1. bestest_air

- Summary Table 

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
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

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_bestest_air.png" alt="scatterplot_bestest_air"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_bestest_air.png" alt="boxplot_bestest_air"/>
</p>

#### 2. multizone_office_simple_air

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
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

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_multizone_office_simple_air.png" alt="scatterplot_multizone_office_simple_air"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_multizone_office_simple_air.png" alt="boxplot_multizone_office_simple_air"/>
</p>


#### 3. bestest_hydronic

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|  0 | constant       | peak_heat_day      |       18.2 |          0 |       9    |      0.466 |       1.63 |          0 |      0.118 |        nan | 2e-05       |
|  1 | constant       | typical_heat_day   |       27.9 |          0 |      12.24 |      0.627 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  2 | dynamic        | peak_heat_day      |       18.2 |          0 |       9    |      0.466 |       1.63 |          0 |      0.118 |        nan | 2.9e-05     |
|  3 | dynamic        | typical_heat_day   |       27.9 |          0 |      12.24 |      0.627 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  4 | highly_dynamic | peak_heat_day      |       18.2 |          0 |       9    |      0.465 |       1.63 |          0 |      0.118 |        nan | 3e-05       |
|  5 | highly_dynamic | typical_heat_day   |       27.9 |          0 |      12.24 |      0.626 |       2.21 |          0 |      0.118 |        nan | 2.9e-05     |
|  6 | constant       | heat_month_average |       18   |          0 |       9.12 |      0.471 |       1.65 |          0 |      0.118 |        nan | 4.12473e-05 |

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_bestest_hydronic.png" alt="scatterplot_bestest_hydronic"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_bestest_hydronic.png" alt="boxplot_bestest_hydronic"/>
</p>


#### 4. bestest_hydronic_heat_pump

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|  0 | constant       | peak_heat_day      |        8.4 |          0 |       3.48 |      0.882 |       0.58 |      0.019 |    nan     |        nan | 3.2e-05     |
|  1 | constant       | typical_heat_day   |        9.4 |          0 |       1.77 |      0.45  |       0.3  |      0.016 |    nan     |        nan | 4.5e-05     |
|  2 | dynamic        | peak_heat_day      |        8.4 |          0 |       3.48 |      0.883 |       0.58 |      0.019 |    nan     |        nan | 4.1e-05     |
|  3 | dynamic        | typical_heat_day   |        9.4 |          0 |       1.77 |      0.442 |       0.3  |      0.016 |    nan     |        nan | 4.1e-05     |
|  4 | highly_dynamic | peak_heat_day      |        8.4 |          0 |       3.48 |      0.909 |       0.58 |      0.019 |    nan     |        nan | 4e-05       |
|  5 | highly_dynamic | typical_heat_day   |        9.4 |          0 |       1.77 |      0.413 |       0.3  |      0.016 |    nan     |        nan | 4.2e-05     |
|  6 | constant       | heat_month_average |       14.2 |          0 |       6.82 |      0.588 |       1.22 |      0.006 |      0.117 |        nan | 3.81183e-05 |

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_bestest_hydronic_heat_pump.png" alt="scatterplot_bestest_hydronic_heat_pump"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_bestest_hydronic_heat_pump.png" alt="boxplot_bestest_hydronic_heat_pump"/>
</p>


#### 5. multizone_residential_hydronic

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|  0 | constant       | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.793 |       1.43 |      0.002 |      0.096 |        nan | 4.3e-05     |
|  1 | constant       | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.591 |       1.03 |      0.002 |      0.096 |        nan | 0.000101    |
|  2 | dynamic        | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.791 |       1.43 |      0.002 |      0.096 |        nan | 0.000106    |
|  3 | dynamic        | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.588 |       1.03 |      0.002 |      0.096 |        nan | 0.0001      |
|  4 | highly_dynamic | peak_heat_day      |       22   |     9114.6 |       8.14 |      0.771 |       1.43 |      0.002 |      0.096 |        nan | 0.000103    |
|  5 | highly_dynamic | typical_heat_day   |       24.4 |    10688.7 |       5.96 |      0.57  |       1.03 |      0.002 |      0.096 |        nan | 0.000102    |
|  6 | constant       | heat_month_average |       20.4 |    10553.6 |       6.06 |      0.598 |       1.05 |      0.002 |      0.095 |        nan | 0.000155323 |

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_multizone_residential_hydronic.png" alt="scatterplot_multizone_residential_hydronic"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_multizone_residential_hydronic.png" alt="boxplot_multizone_residential_hydronic"/>
</p>


#### 6. singlezone_commercial_hydronic

|    | price          | test_day           |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |    time_rat |
|---:|:---------------|:-------------------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|------------:|
|  0 | constant       | peak_heat_day      |        8   |        5.4 |       3.22 |      0.262 |       0.38 |      0.005 |        nan |       0.09 | 2.7e-05     |
|  1 | constant       | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.157 |       0.29 |      0.006 |        nan |       0.08 | 4.4e-05     |
|  2 | dynamic        | peak_heat_day      |        8   |        5.4 |       3.22 |      0.263 |       0.38 |      0.005 |        nan |       0.09 | 5e-05       |
|  3 | dynamic        | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.16  |       0.29 |      0.006 |        nan |       0.08 | 4.4e-05     |
|  4 | highly_dynamic | peak_heat_day      |        8   |        5.4 |       3.22 |      0.263 |       0.38 |      0.005 |        nan |       0.09 | 4.8e-05     |
|  5 | highly_dynamic | typical_heat_day   |        0.9 |    12196.2 |       2.12 |      0.161 |       0.29 |      0.006 |        nan |       0.08 | 4.6e-05     |
|  6 | constant       | heat_month_average |        6.4 |     3235.2 |       3.83 |      0.305 |       0.47 |      0.006 |        nan |       0.09 | 0.000193538 |

- Scatter Plot

<p align="center">
  <img src="./img/scatterplot_singlezone_commercial_hydronic.png" alt="scatterplot_singlezone_commercial_hydronic"/>
</p>

- Box Plot

<p align="center">
  <img src="./img/boxplot_singlezone_commercial_hydronic.png" alt="boxplot_singlezone_commercial_hydronic"/>
</p>