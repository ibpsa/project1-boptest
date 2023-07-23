# IBPSA Project 1 - BOPTEST

[![Build Status](https://travis-ci.com/ibpsa/project1-boptest.svg?branch=master)](https://travis-ci.com/ibpsa/project1-boptest)

Building Optimization Performance Tests

Visit the [BOPTEST Home Page](https://ibpsa.github.io/project1-boptest/) for more information about the project, software, and documentation.

This repository contains code for the Building Optimization Performance Test framework (BOPTEST)
that is being developed as part of the [IBPSA Project 1](https://ibpsa.github.io/project1/).


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
3) To build and deploy a test case, use the following commands within the root directory of the extracted software:

  * Linux or macOS: ``$ TESTCASE=<testcase_name> docker-compose up``
  * Windows PowerShell: ``> ($env:TESTCASE="<testcase_name>") -and (docker-compose up)``
  * A couple notes:
    * Replace ``<testcase_name>`` with the name of the test case you wish to deploy.  Test case names can be found in the ["testcases" directory](https://github.com/ibpsa/project1-boptest/tree/master/testcases) or on the ["Test Cases" web page](https://ibpsa.github.io/project1-boptest/testcases/index.html).
    * The first time this command is run, the image ``boptest_base`` will be built. This takes about a minute. Subsequent usage will use the already-built image and deploy much faster.
    * If you update your BOPTEST repository, use the command ``docker rmi boptest_base`` to remove the image so it can be re-built with the updated repository upon next deployment.
    * ``TESTCASE`` is simply an environment variable. Consistent with use of docker-compose, you may also edit the value of this variable in the ``.env`` file and then use ``docker-compose up``.

4) In a separate process, use the test case API defined below to interact with the test case using your test controller.  Alternatively, view and run an example test controller as described below.
5) Shutdown the test case by the command ``docker-compose down`` executed in the root directory of this repository

## Run an example test controller:

* For Python-based example controllers:
  * Add the directory path to the root of this repository to the ``PYTHONPATH`` environment variable.
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
- The API will return a JSON in the form ``{"status":<status_code_int>, "message":<message_str>, "payload":<relevant_return_data>}``. Status codes in ``"status"`` are integers: ``200`` for successful with or without warning, ``400`` for bad input error, or ``500`` for internal error.  Data returned in ``"payload"`` is the data of interest relvant to the specific API request, while the string in ``"message"`` will report any warnings or error messages to help debug encountered problems.

Example RESTful interaction:

- Receive a list of available measurement names and their metadata: ``$ curl http://127.0.0.1:5000/measurements``
- Receive a forecast of boundary condition data: ``$ curl http://127.0.0.1:5000/forecast``
- Advance simulation of test case 2 with new heating and cooling temperature setpoints: ``$ curl http://127.0.0.1:5000/advance -d '{"oveTSetRooHea_u":293.15,"oveTSetRooHea_activate":1, "oveTSetRooCoo_activate":1,"oveTSetRooCoo_u":298.15}' -H "Content-Type: application/json"``.  Leave an empty json to advance the simulation using the setpoints embedded in the model.

| Interaction                                                           | Request                                                   |
|-----------------------------------------------------------------------|-----------------------------------------------------------|
| Advance simulation with control input and receive measurements.        |  POST ``advance`` with optional json data "{<input_name>:<value>}" |
| Initialize simulation to a start time using a warmup period in seconds.  Also resets point data history and KPI calculations.     |  PUT ``initialize`` with required arguments ``start_time=<value>``, ``warmup_period=<value>``|
| Receive communication step in seconds.                                 |  GET ``step``                                             |
| Set communication step in seconds.                                     |  PUT ``step`` with required argument ``step=<value>``              |
| Receive sensor signal point names (y) and metadata.                          |  GET ``measurements``                                     |
| Receive control signal point names (u) and metadata.                        |  GET ``inputs``                                           |
| Receive test result data for the given point names between the start and final time in seconds. |  PUT ``results`` with required arguments ``point_names=<list of strings>``, ``start_time=<value>``, ``final_time=<value>``|
| Receive test KPIs.                                                     |  GET ``kpi``                                              |
| Receive test case name.                                                |  GET ``name``                                             |
| Receive boundary condition forecast from current communication step for the given point names for the horizon and at the interval in seconds.   |  PUT ``forecast`` with required arguments ``point_names=<list of strings>``, ``horizon=<value>``, ``interval=<value>``|
| Receive boundary condition forecast available point names and metadata. |  GET ``forecast_points``                              |
| Receive current test scenario.                                         |  GET ``scenario``                                   |
| Set test scenario. Setting the argument ``time_period`` performs an initialization with predefined start time and warmup period and will only simulate for predefined duration. |  PUT ``scenario`` with optional arguments ``electricity_price=<string>``, ``time_period=<string>``.  See README in [/testcases](https://github.com/ibpsa/project1-boptest/tree/master/testcases) for options and test case documentation for details.|
| Receive BOPTEST version.                                               |  GET ``version``                                             |
| Submit KPIs, other test information, and optional string tags (up to 10) to online dashboard.  Requires a formal test scenario to be completed, initialized using the PUT ``scenario`` API. |  POST ``submit`` with required argument ``api_key=<string>`` and optional arguments ``tag#=<string>`` where # is an integer between 1 and 10.  The API key can be obtained from the user account registered with the online dashboard.|

## Development
Community development is welcome through reporting [issues](https://github.com/ibpsa/project1-boptest/issues) and/or making pull requests. If making a pull request,
make sure an issue is opened first, name the development branch according to the convention ``issue<issue#>_<descriptor>``, and cite in the pull request which issue is being addressed.

This repository uses pre-commit to ensure that the files meet standard formatting conventions (such as line spacing, layout, etc).
Presently only a handful of checks are enabled and will expanded in the near future. To run pre-commit first install
pre-commit into your Python version using pip `pip install pre-commit`. Pre-commit can either be manually by calling
`pre-commit run --all-files` from within the BOPTEST checkout directory, or you can install pre-commit to be run automatically
as a hook on all commits by calling `pre-commit install` in the root directory of the BOPTEST GitHub checkout.

## Additional Software

### Deployment as a Web-Service
BOPTEST is delpoyed as a web-service using [BOPTEST-Service](https://github.com/NREL/boptest-service).
See the related [section in the user guide](https://ibpsa.github.io/project1-boptest/docs-userguide/getting_started.html#public-web-service) for getting started.

### OpenAI-Gym Environment
An OpenAI-Gym environment for BOPTEST is implemented in [ibpsa/project1-boptest-gym](https://github.com/ibpsa/project1-boptest-gym).
See the documentation there for getting started.

### Results Dashboard
A proposed BOPTEST home page and dashboard for creating accounts and sharing results is published here https://xd.adobe.com/view/0e0c63d4-3916-40a9-5e5c-cc03f853f40a-783d/.

## Use Cases and Development Requirements
See the [wiki](https://github.com/ibpsa/project1-boptest/wiki) for use cases and development requirements.

## Publications

### To cite, please use:
D. Blum, J. Arroyo, S. Huang, J. Drgona, F. Jorissen, H.T. Walnum, Y. Chen, K. Benne, D. Vrabie, M. Wetter, and L. Helsen. (2021). ["Building optimization testing framework (BOPTEST) for simulation-based benchmarking of control strategies in buildings."](https://doi.org/10.1080/19401493.2021.1986574) *Journal of Building Performance Simulation*, 14(5), 586-610.

### Additional publications:
See the [Publications](https://ibpsa.github.io/project1-boptest/publications/index.html) page.
