# IBPSA Project 1 - BOPTEST
Building Optimization Performance Tests

This repository contains prototype code for the Building Optimization Performance Test framework (BOPTEST)
that is being developed as part of the IBPSA Project 1 (https://ibpsa.github.io/project1/).

## Structure
- ``\testcase#`` contains prototype code for developing and deploying test case #.  Test Case 1 is a simple RC model with actuator control of a heater.  Test Case 2 is a Single Zone VAV system with supervisory control of heating and cooling setpoints.
- ``\examples`` contains prototype code for interacting with the test case and running an example test with a simple controller.
- ``\template`` contains template Modelica code for an emulator model.

## Run Prototype Test Cases
1) Follow the instructions in ``testcase#/README.md`` to build and deploy the test case.  See ``testcase#/doc/`` for a description of the test case.
2) For testcase1, in a separate terminal use ``$ python examples/twoday-p.py`` to test a simple proportional feedback controller on the test case over a two-day period.
2) For testcase2, in a separate terminal use ``$ python examples/szvav-sup.py`` to test a simple supervisory controller on the test case over a two-day period.

## More Information
See the [wiki](https://github.com/ibpsa/project1-boptest/wiki) for use cases and development requirements.
