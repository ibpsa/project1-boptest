A forecaster module is developed to retrieve forecast from a BOPTEST
testcase, which is needed for predictive controllers. This module uses the
``data_manager`` object of a test case to read the deterministic forecast from
the testcase ``wrapped.fmu``.  A forecast uncertainty emulator
allows a user to optionally add uncertainty to weather forecasts for
dry bulb temperature and global horizontal irradiation.
Without uncertainty, the controller developer can choose the prediction horizon and interval of
the forecast from the actual simulation time. The controller developer may
also filter the forecast for a specific data category or request all data
variables and filter it afterwards.  Forecasts with uncertainty, however,
are limited in their allowable horizon and interval in order to stay consistent
with underlying uncertainty models.
