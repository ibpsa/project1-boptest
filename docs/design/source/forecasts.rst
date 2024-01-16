.. _SecForGen:

Forecast Generation
===================

A forecaster module is developed to retrieve forecast from a BOPTEST
testcase, which is needed for predictive controllers. This module uses the
data_manager object of a test case to read the deterministic forecast from
the testcase wrapped.fmu. In future developments it will be possible to
request stochastic forecast with a predefined distribution over the
deterministic forecast for research purposes. This distribution will be
added on the top of the deterministic forecast mentioned before.

The controller developer can choose the prediction horizon and interval of
the forecast from the actual simulation time. The controller developer may
also filter the forecast for a specific data category or request all data
variables and filter it afterwards.

**Getting Forecasts Across Year-End**

This subsection shows how the forecast is handled when going across the year.
At the edge between current and new year of simulation the boundary 
conditions are discontinuous in the .csv files, as an example see the relative
humidity in the chart below (orange line). 
The current implementation splits the data at simulation year-end inclusive of 
the last data point at the end of the year (midnight), and after year-end not 
inclusive of the first data point at the start of the year (midnight). The 
implementation is done this way so that the forecast is more consistent for 
any interval through the full first year if a user only intends to simulate one 
year. The relative humidity plot below shows the interpolation behavior of the 
implementation graphically for forecast intervals of 1800s and 123s (as in the 
unit tests), compared to the reference boundary condition .csv file.

.. figure:: images/relative_humidity_over_year_sim.png
    :scale: 50 %
