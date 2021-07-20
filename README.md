# IBPSA Project 1 - BOPTEST

[![Build Status](https://travis-ci.com/ibpsa/project1-boptest.svg?branch=master)](https://travis-ci.com/ibpsa/project1-boptest)

Building Optimization Performance Tests

This repository contains code for the Building Optimization Performance Test framework (BOPTEST)
that is being developed as part of the IBPSA Project 1 (https://ibpsa.github.io/project1/).

## Structure
- ``/testcases`` contains test cases, including docs, models, and configuration settings.
- ``/examples`` contains code for interacting with a test case and running example tests with simple controllers.  Those controllers are implemented in Python (Version 2.7 and 3.9), Julia (Version 1.0.3), and JavaScript (Version ECMAScript 2018).
- ``/parsing`` contains code for a script that parses a Modelica model using signal exchange blocks and outputs a wrapper FMU and KPI json.
- ``/testing`` contains code for unit and functional testing of this software.  See the README there for more information about running these tests.
- ``/data`` contains code for generating and managing data associated with test cases.  This includes boundary conditions, such as weather, schedules, and energy prices, as well as a map of test case FMU outputs needed to calculate KPIs.
- ``/forecast`` contains code for returning boundary condition forecast, such as weather, schedules, and energy prices.
- ``/kpis`` contains code for calculating key performance indicators.
- ``/docs`` contains design requirements and guide documentation.

##2) Build the test case by ``$ make build`` where <testcase_dir_name> is the name of the test case subdirectory located in ``/testcases``.
## Quick-Start to Run Test Cases
1) Install [Docker](https://docs.docker.com/get-docker/).
2) Build the BOPTEST Service by ``$ make build``.
3) Start the BOPTEST Service by ``$ make run``.
4) In a separate process, use the test case API defined below to interact with a test case using your test controller.  Alternatively, view and run an example test controller as described in the next step.
5) Run an example test controller:

* For Python-based example controllers:
  * Build and run the BOPTEST Service.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase1.py`` to test a simple proportional feedback controller on this test case over a two-day period.
  * Build and run the BOPTEST Service.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase1_scenario.py`` to test a simple proportional feedback controller on this test case over a test period defined using the ``/scenario`` API.
  * Build and run the BOPTEST Service.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase2.py`` to test a simple supervisory controller on this test case over a two-day period.

* Julia-based example controllers are not yet updated according to BOPTEST Service conventions

6) Shutdown the Service from the terminal window using ``Ctrl+C``.
7) Remove the test case Docker image by ``$ make remove-image``.

## Test Case RESTful API
- To run a test, use the API defined in the table below by sending RESTful requests to: ``http://127.0.0.1/<request>/<testid>``
- In BOPTEST Service there can be many tests running concurently. The ``select`` API is used to begin a test and retrieve a unique ``testid`` which is used for further API requests related to the test: ``curl -X POST  http://127.0.0.1/testcases/testcase1/select``. The value ``testcase1`` can be any one of the available BOPTEST test cases reported by the API: GET ``http://127.0.0.1/testcases/``.

Example RESTful interaction:

- Begin a test and retrieve a unique ``testid``: ``$ curl -X POST http://127.0.0.1/testcases/testcase1/select``
- Receive a list of available measurement names and their metadata: ``$ curl http://127.0.0.1/measurements/<testid>``
- Receive a forecast of boundary condition data: ``$ curl http://127.0.0.1/forecast/<testid>``
- Advance simulation of test case 2 with new heating and cooling temperature setpoints: ``$ curl http://127.0.0.1/advance/<testid> -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"``.  Leave an empty json to advance the simulation using the setpoints embedded in the model.
- End the test: ``$ curl -X PUT http://127.0.0.1/stop/<testid>``

| Interaction                                                           | Request                                                   |
|-----------------------------------------------------------------------|-----------------------------------------------------------|
| List available test cases.                                             |  GET ``testcases`` |
| Select a test case and begin a new test.                               |  POST ``testcases/{testcase_name}/select`` |
| Stop a running test.                                                   |  PUT ``stop/{testid}`` |
| Advance simulation with control input and receive measurements.        |  POST ``advance/{testid}`` with json data "{<input_name>:<value>}" |
| Initialize simulation to a start time using a warmup period in seconds.     |  PUT ``initialize/{testid}`` with arguments ``start_time=<value>``, ``warmup_time=<value>``|
| Receive communication step in seconds.                                 |  GET ``step/{testid}``                                             |
| Set communication step in seconds.                                     |  PUT ``step/{testid}`` with argument ``step=<value>``              |
| Receive sensor signal point names (y) and metadata.                          |  GET ``measurements/{testid}``                                     |
| Receive control signal point names (u) and metadata.                        |  GET ``inputs/{testid}``                                           |
| Receive test result data for the given point name between the start and final time in seconds. |  PUT ``results/{testid}`` with arguments ``point_name=<string>``, ``start_time=<value>``, ``final_time=<value>``|
| Receive test KPIs.                                                     |  GET ``kpi/{testid}``                                              |
| Receive test case name.                                                |  GET ``name/{testid}``                                             |
| Receive boundary condition forecast from current communication step.   |  GET ``forecast/{testid}``                                         |
| Receive boundary condition forecast parameters in seconds.             |  GET ``forecast_parameters/{testid}``                              |
| Set boundary condition forecast parameters in seconds.                 |  PUT ``forecast_parameters/{testid}`` with arguments ``horizon=<value>``, ``interval=<value>``|
| Receive current test scenario.                                         |  GET ``scenario/{testid}``                                   |
| Set test scenario. Setting the argument ``time_period`` performs an initialization with predefined start time and warmup period and will only simulate for predefined duration. |  PUT ``scenario/{testid}`` with optional arguments ``electricity_price=<string>``, ``time_period=<string>``.  See README in [/testcases](https://github.com/ibpsa/project1-boptest/tree/master/testcases) for options and test case documentation for details.|
| Receive BOPTEST version.                                               |  GET ``version``                                             |
## Development

This repository uses pre-commit to ensure that the files meet standard formatting conventions (such as line spacing, layout, etc).
Presently only a handful of checks are enabled and will expanded in the near future. To run pre-commit first install
pre-commit into your Python version using pip `pip install pre-commit`. Pre-commit can either be manually by calling
`pre-commit run --all-files` from within the BOPTEST checkout directory, or you can install pre-commit to be run automatically
as a hook on all commits by calling `pre-commit install` in the root directory of the BOPTEST GitHub checkout.

## More Information
See the [wiki](https://github.com/ibpsa/project1-boptest/wiki) for use cases and development requirements.

## BOPTEST Dashboard
A dashboard for aggregating and sharing test results is under development here: https://github.com/NREL/boptest-dashboard.

## Publications
D. Blum, F. Jorissen, S. Huang, Y. Chen, J. Arroyo, K. Benne, Y. Li, V. Gavan, L. Rivalin, L. Helsen, D. Vrabie, M. Wetter, and M. Sofos. (2019). “Prototyping the BOPTEST framework for simulation-based testing of advanced control strategies in buildings.” In *Proc. of the 16th International Conference of IBPSA*, Sep 2 – 4. Rome, Italy.
