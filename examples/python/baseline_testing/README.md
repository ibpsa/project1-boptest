# Baseline Testing

This folder contains examples and results for performing testing of baseline controllers for different testcases.

## Baseline Controller Implementation

- The baseline controllers are incorporated in the testcase models.
The control modules for each testcases in ``../controllers`` follow the structure as described above 
(see upper directory ``README.md`` for instructions on deploying a control test case).
The function ``compute_control`` is psuedo. The control inputs will not be overwritten by this external controller. 

- For test scripts for performing the baseline control test, user could specify the combination of
simulation start, warmup_period, and length or a predefined test case scenario. For the default setting of the baseline tests,
 scenarios with different electricity prices and time periods will be  simulated. 

## Run an Example Baseline Test
- First, deploy the test case corresponding to the desired example as described above (see repository root ``README.md`` for instructions on deploying a test case).
- Then, use ``$ python testcase<...>.py`` depending on the desired example from those defined above.

## Baseline Testing Results
Two-week simulation are conducted with different electricity prices and representative time periods for each testcase.
Please see ``root/Testcases`` ``README.md`` for different predefined scenarios for each testcase. 
For each scenario, one week simulation before ``time_period`` is conducted for the warm-up and two-week simulation is then conducted.
The results of these representative scenarios are also compared with the annual/heating season average results with a rolling window of two weeks.

- Summary results for all the testcases

The following table shows the statistics of the KPIs for all the testcases. 

|       |   tdis_tot |   idis_tot |   ener_tot |   cost_tot |   emis_tot |   pele_tot |   pgas_tot |   pdih_tot |
|:------|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|-----------:|
| mean  |   10.2222  |    2122.74 |    3.61333 |   0.279407 |   0.808889 |  0.0145    |  0.088     | 0.085      |
| std   |    7.56388 |    3926.85 |    3.14719 |   0.275812 |   0.547659 |  0.0105933 |  0.0432533 | 0.00547723 |
| min   |    0.9     |       0    |    0.31    |   0.014    |   0.11     |  0         |  0         | 0.08       |
| 25%   |    5.6     |       0    |    1.77    |   0.057    |   0.36     |  0.005     |  0.096     | 0.08       |
| 50%   |    7.85    |      50.1  |    2.46    |   0.1605   |   0.72     |  0.0155    |  0.104     | 0.085      |
| 75%   |   11.8     |    1222.1  |    3.72    |   0.46575  |   1.03     |  0.023     |  0.118     | 0.09       |
| max   |   27.9     |   12196.2  |   12.24    |   0.909    |   2.21     |  0.033     |  0.121     | 0.09       |

- Summary results for each testcase
1. 


2. 
