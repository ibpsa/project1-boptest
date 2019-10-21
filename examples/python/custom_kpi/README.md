# Customized KPI Calculation

This folder contains files for calculating the customized KPI during simulation and examples for demonstrating the usage

## Structure
- ``/custom_kpi_calculator.py`` 
A generic Python class to set up and enable the runtime customized KPI calculation. 
It is instaniated based on configuration files for specific applications.
- ``/custom_kpis.config``  
One example for the configuration files for the customized KPI.
It defines the required data point, kpi calculation classes and the calculation settings for each customized KPI
- ``/custom_kpis.py``  
Example Python classes that contain the detailed procedure for processing the  simulation data


## Run Customized KPI Calculation
1) Define the customized KPI information in ``custom_kpis.config``. The necessary inputs include ``name`` (KPI name), ``kpi_class`` (Python class for executing the KPI calculation), ``kpi_file`` (file for containing the Python classes), and ``data_points`` (a dictionary that maps the simulation data and the input for KPI calculation)
Additional case-dependent information can be defined under the ``optional`` key 
2) Deploy the KPI calculation by setting the ``kpiconfig`` equal to ``custom_kpi/custom_kpis.config`` when running the controller scripts (``szvav_sup.py`` and ``twoday_p``).

