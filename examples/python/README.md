# Python-based example scripts for performing control tests

This folder contains a generic BOPTEST control testing interface and examples for demonstrating the usage.

## Structure
- ``/controllers``
It contains a generic BOPTEST control testing interface class (``controller.py``).
It also contains examples for implementing controllers.
- ``/custom_kpi``
A code base for implementing customized KPI calculation.

## Quick-Start to Perform a python-based control test
1) Implement the tested control in a python module (``control module``).   
   This module should contain two functions: ``initialize`` and ``compute_control``;  
   The ``initialize`` function calculates the initial control inputs while the ``compute_control`` functions updates the control inputs based on recent measurements.  
   Examples for the control modules are provided in ``/controllers``.  
2) Develop a test script for performing the control test.
   In this script, a generic BOPTEST interface class (``control_test``) should be instantiated.  
   When instantiating the control_test class, the simulation length (s), the sampling step (s), and the control_test must be specified.  
   Optionally, users can also provide configurations of the customized KPIs, scenarios, and forecast information.  
   ``testcase1.py`` and ``testcase2.py`` demonstrates how to instantiate the control_test class with the required inputs and the customized KPIs;  
   ``testcase1_scenario.py`` and ``testcase3.py`` show how to instantiate the control_test class with additional scenarios and forecast information,respectively.  