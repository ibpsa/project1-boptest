# Customized KPI Calculation

This folder contains files for calculating customized KPIs during simulation and examples for demonstrating the usage.

## Structure
- ``/custom_kpi_calculator.py``
A generic Python class to set up and enable the runtime customized KPI calculation.
It is instantiated based on configuration files for specific applications.
- ``/custom_kpis_example.config``
One example of a configuration file for customized KPIs.
It defines the required data points, kpi calculation classes and calculation settings for each customized KPI.
- ``/custom_kpis_example.py``
One example of Python file that contains classes that define the detailed procedure for processing the simulation data and calculating customized KPIs.


## Run Customized KPI Calculation
1) Define the customized KPI information in a configuration file (for example ``custom_kpis_example.config``). The necessary inputs are:
    - ``name``: KPI name
    - ``kpi_class``: Python class name in ``kpi_file`` for executing the KPI calculation
    - ``kpi_file``: Python file for containing the ``kpi_class``
    - ``data_points`` Dictionary that maps the simulation output data to the input for KPI calculation
Additional case-dependent information can be defined under the ``optional`` key.

2) Deploy the KPI calculation by setting the ``customized_kpi`` argument equal to the path of the configuration file (for example ``custom_kpi/custom_kpis.config``) when running a controller script (for example ``szvav_sup.py`` and ``twoday_p.py``).
