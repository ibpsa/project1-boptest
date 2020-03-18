# Introduction

The repository contains a Modelica model of the OU44 building, SDU Campus Odense, Denmark,
which is one of the emulator models to be included in IBPSA Project 1 BOPTEST
(Building Optimization Performance Tests): https://github.com/ibpsa/project1-boptest

The model is a single-zone whole-building model, meaning that all thermal zones in the building
are modeled with a single large volume, and all HVAC systems are serving only this zone.
This major simplification makes testing control optimization algorithms easier (due less control variables).
Consequently, it will be helpful for users learning how to use BOPTEST.

The model is developed in accordance with the BOPTEST [Development Document](https://github.com/ibpsa/project1-boptest/wiki).

# Dependencies

The model contains components from:

* Buildings 5.0.1: https://simulationresearch.lbl.gov/modelica/downloads/archive/modelica-buildings.html
* Modelica Standard Library (MSL)

To test the model from this repository, the user is expected to have the depending libraries downloaded
and loaded in Dymola.

The model was developed in Dymola 2018 FD01.


