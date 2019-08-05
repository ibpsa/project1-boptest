# Customized KPI Calculation

This folder contains all files for calculating the customized KPI during simulation and examples for demonstrating the usage

## Structure
- ``/kpicalculation.py`` A generic Python class to set up and enable the online customized KPI calculation based on configuration files
- ``/kpi_example.py``  Python classes that contain the detailed procedure for processing the streaming simulation data
- ``/kpi.config``  A Json file that defines the required data point, kpi calculation classes and the calculation settings for each customized KPI


## Run Customized KPI Calculation
1) Define the customized KPI information in ``kpi.config``. The necessary inputs include ``name`` (KPI name), ``kpi_class`` (Python class for executing the KPI calculation), ``kpi_file`` (file for containing the Python classes), and ``data_points`` (a dictionary that maps the simulation data and the input for KPI calculation)
   Additional case-dependent information can be defined under the ``optional`` key 
2) Deploy the KPI calculation by setting the ``kpiconfig`` equal to ``kpi/kpi.config`` when running the interface script (``szvav_sup.py``).

