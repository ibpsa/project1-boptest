# IBPSA Project 1 - BOPTEST
Building Optimization Performance Tests

This repository contains prototype code for the Building Optimization Performance Test framework (BOPTEST)
that is being developed as part of the IBPSA Project 1 (https://ibpsa.github.io/project1/).

## Structure
- ``\testcase`` contains prototype code for developing and deploying a simple test case.
- ``\examples`` contains prototype code for interacting with the test case and running an example test with a simple controller.
- ``\template`` contains template Modelica code for an emulator model.

## Run Prototype Test Case
1) Follow the instructions in ``testcase/README.md`` to build and deploy the test case.
2) ``$ python examples/twoday-p.py`` to test a simple controller on the test case over a two-day period.
