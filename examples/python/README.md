# Python-Based Examples

This folder contains example modules for performing control tests using Python.

## Structure
- ``interface.py`` is the primary example script for using the BOPTEST API to
configure and run a test with a controller.
- ``testcase1_scenario.py`` configures and runs a test using the the prototype
test case called "testcase1" with a predefined scenario.  It uses the testing
interface implemented in ``interface.py`` and the concrete controller implemented
in ``controllers/pid.py``.
- ``testcase1.py`` configures and runs a test using the the prototype
test case called "testcase1" with custom test start and length parameters.
It uses the testing interface implemented in ``interface.py`` and the
concrete controller implemented in ``controllers/pid.py``.
- ``testcase2.py`` configures and runs a test using the the prototype
test case called "testcase2" with custom test start and length parameters.
It uses the testing interface implemented in ``interface.py`` and the
concrete controller implemented in ``controllers/sup.py``.
- ``testcase3.py`` configures and runs a test using the the prototype
test case called "testcase3" with custom test start and length parameters, as
well as forecast data.
It uses the testing interface implemented in ``interface.py`` and the
concrete controller implemented in ``controllers/pidTwoZones.py``.
- ``/controllers`` contains a generic controller class ``controller.py`` that
instantiates concrete controller methods defined in ``pid.py``, ``pidTwoZones.py``, and
``sup.py``.
- ``/custom_kpi`` contains a code base for implementing customized KPI calculation
using results from BOPTEST.

## Run an Example Test
- First, deploy the test case corresponding to the desired example as described above (see repository root ``README.md`` for instructions on deploying a test case).
- Then, use ``$ python testcase<...>.py`` depending on the desired example from those defined above.

## Quick-Start for Testing Your Controller

These example modules can be used as templates to test your own controller using
the following steps:

1. Implement the controller to be tested in a python module, let's call ``controller_module.py``.
This module should contain at least two functions: ``initialize`` and ``compute_control``.
The ``initialize`` function calculates the initial control inputs while the
``compute_control`` functions updates the control inputs of the BOPTEST
test case based on recent measurements and forecasts, if needed.
If the controller requires forecasts, the controller module should contain
another function called ``update_forecasts``.
Examples for control modules are provided in ``/controllers``.

2. Develop a test script for performing the control test.
In this script, instantiate the interface class implemented in ``interface.py``.
Specify the ``controller_module.py`` to be used, as well as the combination of
simulation start, warmup_period, and length or a predefined test case scenario.
Optionally, users can also provide a configuration of the customized KPIs and
whether or not the controller uses forecast information.
