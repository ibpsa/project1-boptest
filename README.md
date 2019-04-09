# IBPSA Project 1 - BOPTEST
Building Optimization Performance Tests

This repository contains prototype code for the Building Optimization Performance Test framework (BOPTEST)
that is being developed as part of the IBPSA Project 1 (https://ibpsa.github.io/project1/).

## Structure
- ``\testcase#`` contains prototype code for a test case, including docs, models, and configuration settings.
- ``\examples`` contains prototype code for interacting with a test case and running example tests with simple controllers.
                Those controllers are implemented in both Python (Version 2.7) and Julia (Version 1.0.3)
- ``\parser`` contains prototype code for a script that parses a Modelica model using signal exchange blocks and outputs a wrapper FMU.
- ``\template`` contains template Modelica code for a test case emulator model.

## Run Prototype Test Cases
1) Build the test case by ``$ TESTCASE=testcase# make build`` where # is the number of the test case to build.
2) Deploy the test case by ``$ TESTCASE=testcase# make run`` where # is the number of the test case that has been built.
3) In a separate process, use the test case API defined below to interact with the test case.
4) Run an example controller test: 

    For Python based controllers:
- in a separate terminal, use ``$ python examples/twoday-p.py`` to test a simple proportional feedback controller on the testcase1 over a two-day period.
- in a separate terminal, use ``$ python examples/szvav-sup.py`` to test a simple supervisory controller on the testcase2 over a two-day period. 

  For Julia based controllers:
  
  install docker compose based on the instruction from https://docs.docker.com/compose/install/, then
- in a separate terminal, use ``$ Script=twoday-p docker-compose up`` to test a simple proportional feedback controller on the testcase1 over a two-day period.
- in a separate terminal, use ``$ Script=szvav-sup docker-compose up`` to test a simple supervisory controller on the testcase2 over a two-day period.
Once the test is done, use ``docker-compose down`` to stop containers and removes containers, networks, volumes, and images created by ``docker-compose up``.

## Test Case RESTful API
- To interact, send RESTful requests to: ``http://127.0.0.1:5000/<request>``
- To shutdown: ``Ctrl+C`` to close port, ``Ctrl+D`` to exit docker container.

Example RESTful interaction:

- Receive a list of available measurements: ``$ curl http://127.0.0.1:5000/measurements``
- Advance simulation of test case 2 with new heating and cooling temperature setpoints: ``$ curl http://127.0.0.1:5000/advance -d '{"TSetRooHea":293.15,"TSetRooCoo":298.15}' -H "Content-Type: application/json"``

| Interaction                                                    | Request                                                   |
|----------------------------------------------------------------|-----------------------------------------------------------|
| Advance simulation with control input and receive measurements |  POST ``advance`` with json data "{<input_name>:<value>}" |
| Reset simulation to beginning                                  |  PUT ``reset`` with no data                               |
| Receive communication step in seconds                          |  GET ``step``                                             |
| Set communication step in seconds                              |  PUT ``step`` with data ``step=<value>``                  |
| Receive sensor signal names (y)                                |  GET ``measurements``                                     |
| Receive control signal names (u)                               |  GET ``inputs``                                           |
| Receive test result data                                       |  GET ``results``                                          |
| Receive test KPIs                                              |  GET ``kpi``                                              |
| Receive test case name                                         |  GET ``name``                                             |


## More Information
See the [wiki](https://github.com/ibpsa/project1-boptest/wiki) for use cases and development requirements.
