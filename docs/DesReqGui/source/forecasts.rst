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

