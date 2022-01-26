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
- ``/docs`` contains design documentation and delivered workshop content.

## Quick-Start to Deploy a Test Case
1) Download this repository.
2) Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).
3) Build and deploy a test case using the following commands executed in the root directory of this repository and where <testcase_dir_name> is the name of the test case subdirectory located in [/testcases](https://github.com/ibpsa/project1-boptest/tree/master/testcases):
 
  * Linux or macOS: ``$ TESTCASE=<testcase_dir_name> docker-compose up`` 
  * Windows PowerShell: ``> (setx TESTCASE "<testcase_dir_name>") -and (docker-compose up)``
  * A couple notes:
    * The first time this command is run, the image ``boptest_base`` will be built.  This takes about a minute.  Subsequent usage will use the already-built image and deploy much faster.  
    * If you update your BOPTEST repository, use the command ``docker rmi boptest_base`` to remove the image so it can be re-built with the updated repository upon next deployment.
    * ``TESTCASE`` is simply an environment variable.  Consistent with use of docker-compose, you may also edit the value of this variable in the ``.env`` file and then use ``docker-compose up``.

4) In a separate process, use the test case API defined below to interact with the test case using your test controller.  Alternatively, view and run an example test controller as described below.
5) Shutdown the test case by the command ``docker-compose down`` executed in the root directory of this repository

## Run an example test controller:

* For Python-based example controllers:
  * Build and deploy ``testcase1``.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase1.py`` to test a simple proportional feedback controller on this test case over a two-day period.
  * Build and deploy ``testcase1``.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase1_scenario.py`` to test a simple proportional feedback controller on this test case over a test period defined using the ``/scenario`` API.
  * Build and deploy ``testcase2``.  Then, in a separate terminal, use ``$ cd examples/python/ && python testcase2.py`` to test a simple supervisory controller on this test case over a two-day period.

* For Julia-based example controllers:
  * Build and deploy ``testcase1``.  Then, in a separate terminal, use ``$ cd examples/julia && make build Script=testcase1 && make run Script=testcase1`` to test a simple proportional feedback controller on this test case over a two-day period.  Note that the Julia-based controller is run in a separate Docker container.
  * Build and deploy ``testcase2``.  Then, in a separate terminal, use ``$ cd examples/julia && make build Script=testcase2 && make run Script=testcase2`` to test a simple supervisory controller on this test case over a two-day period.  Note that the Julia-based controller is run in a separate Docker container.
  * Once either test is done, use ``$ make remove-image Script=testcase1`` or ``$ make remove-image Script=testcase2`` to removes containers, networks, volumes, and images associated with these Julia-based examples.

* For JavaScript-based example controllers:
  * In a separate terminal, use ``$ cd examples/javascript && make build Script=testcase1 && make run Script=testcase1`` to test a simple proportional feedback controller on the testcase1 over a two-day period.
  * In a separate terminal, use ``$ cd examples/javascript && make build Script=testcase2 && make run Script=testcase2`` to test a simple supervisory controller on the testcase2 over a two-day period.
  * Ince the test is done, use ``$ make remove-image Script=testcase1`` or ``$ make remove-image Script=testcase2`` to removes containers, networks, volumes, and images, and use ``$ cd examples/javascript && rm geckodriver`` to remove the geckodriver file.
  * Note that those two controllers can also be executed by web browers, such as chrome or firefox.

## Test Case RESTful API
- To interact with a deployed test case, use the API defined in the table below by sending RESTful requests to: ``http://127.0.0.1:5000/<request>``

Example RESTful interaction:

- Receive a list of available measurement names and their metadata: ``$ curl http://127.0.0.1:5000/measurements``
- Receive a forecast of boundary condition data: ``$ curl http://127.0.0.1:5000/forecast``
- Advance simulation of test case 2 with new heating and cooling temperature setpoints: ``$ curl http://127.0.0.1:5000/advance -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"``.  Leave an empty json to advance the simulation using the setpoints embedded in the model.

| Interaction                                                           | Request                                                   |
|-----------------------------------------------------------------------|-----------------------------------------------------------|
| Advance simulation with control input and receive measurements.        |  POST ``advance`` with json data "{<input_name>:<value>}" |
| Initialize simulation to a start time using a warmup period in seconds.     |  PUT ``initialize`` with arguments ``start_time=<value>``, ``warmup_time=<value>``|
| Receive communication step in seconds.                                 |  GET ``step``                                             |
| Set communication step in seconds.                                     |  PUT ``step`` with argument ``step=<value>``              |
| Receive sensor signal point names (y) and metadata.                          |  GET ``measurements``                                     |
| Receive control signal point names (u) and metadata.                        |  GET ``inputs``                                           |
| Receive test result data for the given point name between the start and final time in seconds. |  PUT ``results`` with arguments ``point_name=<string>``, ``start_time=<value>``, ``final_time=<value>``|
| Receive test KPIs.                                                     |  GET ``kpi``                                              |
| Receive test case name.                                                |  GET ``name``                                             |
| Receive boundary condition forecast from current communication step.   |  GET ``forecast``                                         |
| Receive boundary condition forecast parameters in seconds.             |  GET ``forecast_parameters``                              |
| Set boundary condition forecast parameters in seconds.                 |  PUT ``forecast_parameters`` with arguments ``horizon=<value>``, ``interval=<value>``|
| Receive current test scenario.                                         |  GET ``scenario``                                   |
| Set test scenario. Setting the argument ``time_period`` performs an initialization with predefined start time and warmup period and will only simulate for predefined duration. |  PUT ``scenario`` with optional arguments ``electricity_price=<string>``, ``time_period=<string>``.  See README in [/testcases](https://github.com/ibpsa/project1-boptest/tree/master/testcases) for options and test case documentation for details.|
| Receive BOPTEST version.                                               |  GET ``version``                                             |
## Development

This repository uses pre-commit to ensure that the files meet standard formatting conventions (such as line spacing, layout, etc).
Presently only a handful of checks are enabled and will expanded in the near future. To run pre-commit first install
pre-commit into your Python version using pip `pip install pre-commit`. Pre-commit can either be manually by calling
`pre-commit run --all-files` from within the BOPTEST checkout directory, or you can install pre-commit to be run automatically
as a hook on all commits by calling `pre-commit install` in the root directory of the BOPTEST GitHub checkout.

## More Information

### Use Cases and Development Requirements
See the [wiki](https://github.com/ibpsa/project1-boptest/wiki) for use cases and development requirements.

### Deployment as a Web-Service
BOPTEST is implemented as a web-service in the ``boptest-service`` [branch](https://github.com/ibpsa/project1-boptest/tree/boptest-service) of this repository.

### OpenAI-Gym Environment
An OpenAI-Gym environment for BOPTEST is implemented in [ibpsa/project1-boptest-gym](https://github.com/ibpsa/project1-boptest-gym).

### Results Dashboard
A proposed BOPTEST home page and dashboard for creating accounts and sharing results is published here https://xd.adobe.com/view/0e0c63d4-3916-40a9-5e5c-cc03f853f40a-783d/.

## Publications
### To cite, please use:
D. Blum, J. Arroyo, S. Huang, J. Drgona, F. Jorissen, H.T. Walnum, Y. Chen, K. Benne, D. Vrabie, M. Wetter, and L. Helsen. (2021). ["Building optimization testing framework (BOPTEST) for simulation-based benchmarking of control strategies in buildings."](https://doi.org/10.1080/19401493.2021.1986574) *Journal of Building Performance Simulation*, 14(5), 586-610.

### Additional publications:
J. Arroyo, C. Manna, F. Spiessens, and L. Helsen. (2022). ["Reinforced model predictive control (RL-MPC) for building energy management."](https://doi.org/10.1016/j.apenergy.2021.118346) *Applied Energy* 309: 118346.

J. Arroyo, C. Manna, F. Spiessens, and L. Helsen. (2021). [“An OpenAI-Gym Environment for the Building Optimization Testing (BOPTEST) Framework.”](https://www.researchgate.net/profile/Javier-Arroyo/publication/354386346_An_OpenAI-Gym_environment_for_the_Building_Optimization_Testing_BOPTEST_framework/links/613616690360302a0082ffc1/An-OpenAI-Gym-environment-for-the-Building-Optimization-Testing-BOPTEST-framework.pdf) In *Proceedings of the 17th IBPSA Conference*, Sep 1 - 3. Bruges, Belgium.

F. Bünning, C. Pfister, A. Aboudonia, P. Heer, and J. Lygeros. (2021). “Comparing Machine Learning Based Methods to Standard Regression Methods for MPC on a Virtual Testbed.” In *Proceedings of the 17th IBPSA Conference*, Sep 1 - 3. Bruges, Belgium.

T. Yang, K. Filonenko, K. Arendt, and C. Veje. (2020). [“Implementation and Performance Analysis of a Multi-Energy Building Emulator.”](https://ieeexplore.ieee.org/document/9236623) In *2020 6th IEEE International Energy Conference (ENERGYCon)*, Sep 28 - Oct 1. Gammarth, Tunisia, 451–456.

H. T. Walnum, I. Sartori, and M. Bagle. (2020). [“Model Predictive Control of District Heating Substations for Flexible Heating of Buildings.”](https://sintef.brage.unit.no/sintef-xmlui/handle/11250/2683181) In *SINTEF Proceedings no 5, ser. BuildSim-Nordic 2020*, Oct 13–14. Oslo, Norway: International Conference Organised by IBPSA-Nordic, 123–130.

J. Arroyo, F. Spiessens, and L. Helsen. (2020). [“Identification of Multi-zone Grey-box Building Models for Use in Model Predictive Control.”](https://doi.org/10.1080/19401493.2020.1770861) *Journal of Building Performance Simulation* 13 (4): 472–486.

D. Blum, F. Jorissen, S. Huang, Y. Chen, J. Arroyo, K. Benne, Y. Li, V. Gavan, L. Rivalin, L. Helsen, D. Vrabie, M. Wetter, and M. Sofos. (2019). [“Prototyping the BOPTEST framework for simulation-based testing of advanced control strategies in buildings.”](http://www.ibpsa.org/proceedings/BS2019/BS2019_211276.pdf) In *Proceedings of the 16th International Conference of IBPSA*, Sep 2 – 4. Rome, Italy.

S. Huang, Y. Chen, P. W. Ehrlich, and D. L. Vrabie. (2018). “A Control-Oriented Building Envelope and HVAC System Simulation Model for a Typical Large Office Building.” In *Proceedings of 2018 Building Performance Modeling Conference and SimBuild co-organized by ASHRAE and IBPSA-USA*, Sep 26 - 28. Chicago, IL.
