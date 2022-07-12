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

## Quick-Start to Run Test Cases
1) Download this repository.
2) Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).
3) Build and deploy a test case using the following commands executed in the root directory of this repository and where <testcase_dir_name> is the name of the test case subdirectory located in [/testcases](https://github.com/ibpsa/project1-boptest/tree/master/testcases):

  * ``docker-compose up``
  * A couple notes:
    * The first time this command is run, the image ``boptest_base`` will be built.  This takes about a minute.  Subsequent usage will use the already-built image and deploy much faster.
    * If you update your BOPTEST repository, use the command ``docker rmi boptest_base`` to remove the image so it can be re-built with the updated repository upon next deployment.
    * ``TESTCASE`` is simply an environment variable.  Consistent with use of docker-compose, you may also edit the value of this variable in the ``.env`` file and then use ``docker-compose up``.

4) In a separate process, use the test case API defined below to interact with the test case using your test controller.  Alternatively, view and run an example test controller as described below.
5) Shutdown the test case by the command ``docker-compose down`` executed in the root directory of this repository

## Run an example test controller:

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
- The API will return a JSON in the form ``{"status":<status_code_int>, "message":<message_str>, "payload":<relevant_return_data>}``. Status codes in ``"status"`` are integers: ``200`` for successful with or without warning, ``400`` for bad input error, or ``500`` for internal error.  Data returned in ``"payload"`` is the data of interest relvant to the specific API request, while the string in ``"message"`` will report any warnings or error messages to help debug encountered problems.

Example RESTful interaction:

- Begin a test and retrieve a unique ``testid``: ``$ curl -X POST http://127.0.0.1/testcases/testcase1/select``
- Receive a list of available measurement names and their metadata: ``$ curl http://127.0.0.1/measurements/<testid>``
- Receive a forecast of boundary condition data: ``$ curl http://127.0.0.1/forecast/<testid>``
- Advance simulation of test case 2 with new heating and cooling temperature setpoints: ``$ curl http://127.0.0.1/advance/<testid> -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"``.  Leave an empty json to advance the simulation using the setpoints embedded in the model.
- End the test: ``$ curl -X PUT http://127.0.0.1/stop/<testid>``

| Interaction                                                           | Request                                                   |
|-----------------------------------------------------------------------|-----------------------------------------------------------|
| List available test cases.                                             |  GET ``testcases`` |
| Select a test case and begin a new test. A unique ``testid`` will be returned.                                |  POST ``testcases/{testcase_name}/select`` |
| Stop a running test.                                                   |  PUT ``stop/{testid}`` |
| Advance simulation with control input and receive measurements.        |  POST ``advance/{testid}`` with optional json data "{<input_name>:<value>}" |
| Initialize simulation to a start time using a warmup period in seconds.  Also resets point data history and KPI calculations.     |  PUT ``initialize/{testid}`` with required arguments ``start_time=<value>``, ``warmup_period=<value>``|
| Receive communication step in seconds.                                 |  GET ``step/{testid}``                                             |
| Set communication step in seconds.                                     |  PUT ``step/{testid}`` with required argument ``step=<value>``              |
| Receive sensor signal point names (y) and metadata.                          |  GET ``measurements/{testid}``                                     |
| Receive control signal point names (u) and metadata.                        |  GET ``inputs/{testid}``                                           |
| Receive test result data for the given point name between the start and final time in seconds. |  PUT ``results/{testid}`` with required arguments ``point_name=<string>``, ``start_time=<value>``, ``final_time=<value>``|
| Receive test KPIs.                                                     |  GET ``kpi/{testid}``                                              |
| Receive test case name.                                                |  GET ``name/{testid}``                                             |
| Receive boundary condition forecast from current communication step.   |  GET ``forecast/{testid}``                                         |
| Receive boundary condition forecast parameters in seconds.             |  GET ``forecast_parameters/{testid}``                              |
| Set boundary condition forecast parameters in seconds.                 |  PUT ``forecast_parameters/{testid}`` with required arguments ``horizon=<value>``, ``interval=<value>``|
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
### To cite, please use:
D. Blum, J. Arroyo, S. Huang, J. Drgona, F. Jorissen, H.T. Walnum, Y. Chen, K. Benne, D. Vrabie, M. Wetter, and L. Helsen. (2021). ["Building optimization testing framework (BOPTEST) for simulation-based benchmarking of control strategies in buildings."](https://doi.org/10.1080/19401493.2021.1986574) *Journal of Building Performance Simulation*, 14(5), 586-610.

### Additional publications:
J. Arroyo, F. Spiessens, and L. Helsen. (2022). ["Comparison of Optimal Control Techniques for Building Energy Management."](https://doi.org/10.3389/fbuil.2022.849754) *Frontiers in Built Environment* 8.

T. Marzullo, S. Dey, N. Long, J. L. Vilaplana, and G. Henze. (2022). ["A high-fidelity building performance simulation test bed for the development and evaluation of advanced controls"](https://doi.org/10.1080/19401493.2022.2058091) *Journal of Building Performance Simulation*, 15(3), 379-397.

J. Arroyo, C. Manna, F. Spiessens, and L. Helsen. (2022). ["Reinforced model predictive control (RL-MPC) for building energy management."](https://doi.org/10.1016/j.apenergy.2021.118346) *Applied Energy* 309: 118346.

J. Arroyo, C. Manna, F. Spiessens, and L. Helsen. (2021). [“An OpenAI-Gym Environment for the Building Optimization Testing (BOPTEST) Framework.”](https://www.researchgate.net/profile/Javier-Arroyo/publication/354386346_An_OpenAI-Gym_environment_for_the_Building_Optimization_Testing_BOPTEST_framework/links/613616690360302a0082ffc1/An-OpenAI-Gym-environment-for-the-Building-Optimization-Testing-BOPTEST-framework.pdf) In *Proceedings of the 17th IBPSA Conference*, Sep 1 - 3. Bruges, Belgium.

F. Bünning, C. Pfister, A. Aboudonia, P. Heer, and J. Lygeros. (2021). [“Comparing Machine Learning Based Methods to Standard Regression Methods for MPC on a Virtual Testbed.”](https://www.research-collection.ethz.ch/bitstream/handle/20.500.11850/524933/BS2021_finalVersion.pdf?sequence=1&isAllowed=y) In *Proceedings of the 17th IBPSA Conference*, Sep 1 - 3. Bruges, Belgium.

T. Yang, K. Filonenko, K. Arendt, and C. Veje. (2020). [“Implementation and Performance Analysis of a Multi-Energy Building Emulator.”](https://ieeexplore.ieee.org/document/9236623) In *2020 6th IEEE International Energy Conference (ENERGYCon)*, Sep 28 - Oct 1. Gammarth, Tunisia, 451–456.

H. T. Walnum, I. Sartori, and M. Bagle. (2020). [“Model Predictive Control of District Heating Substations for Flexible Heating of Buildings.”](https://sintef.brage.unit.no/sintef-xmlui/handle/11250/2683181) In *SINTEF Proceedings no 5, ser. BuildSim-Nordic 2020*, Oct 13–14. Oslo, Norway: International Conference Organised by IBPSA-Nordic, 123–130.

J. Arroyo, F. Spiessens, and L. Helsen. (2020). [“Identification of Multi-zone Grey-box Building Models for Use in Model Predictive Control.”](https://doi.org/10.1080/19401493.2020.1770861) *Journal of Building Performance Simulation* 13 (4): 472–486.

D. Blum, F. Jorissen, S. Huang, Y. Chen, J. Arroyo, K. Benne, Y. Li, V. Gavan, L. Rivalin, L. Helsen, D. Vrabie, M. Wetter, and M. Sofos. (2019). [“Prototyping the BOPTEST framework for simulation-based testing of advanced control strategies in buildings.”](http://www.ibpsa.org/proceedings/BS2019/BS2019_211276.pdf) In *Proceedings of the 16th International Conference of IBPSA*, Sep 2 – 4. Rome, Italy.

S. Huang, Y. Chen, P. W. Ehrlich, and D. L. Vrabie. (2018). [“A Control-Oriented Building Envelope and HVAC System Simulation Model for a Typical Large Office Building.”](https://www.ashrae.org/File%20Library/Conferences/Specialty%20Conferences/2018%20Building%20Performance%20Analysis%20Conference%20and%20SimBuild/Papers/C101.pdf) In *Proceedings of 2018 Building Performance Modeling Conference and SimBuild co-organized by ASHRAE and IBPSA-USA*, Sep 26 - 28. Chicago, IL.
