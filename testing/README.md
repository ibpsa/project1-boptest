# Testing

## Run all tests defined below
Command: ``$ make test_all``

A test report will be displayed and recorded to file upon completion called ``testing_report.txt``.

## Run tests for test case with name ``<testcase>``
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_<testcase>``.

1. Compiles <testcase> model
2. Builds the test case image
3. Deploys the test case container in detached mode
4. Runs the Julia controller example for <testcase>
5. Runs ``test_<testcase>.py``
6. Stops test case container
7. Removes test case image.

## Run tests for parser
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_parser``
1. Runs ``test_parser.py``

## Run tests for data
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_data``
1. Compiles testcase2 and testcase3 models
2. Copies the ``/data``, ``/forecast``, and ``/kpis`` directories as well as ``testcases/testcase2`` and ``testcases/testcase3`` directories into the ``jm`` Docker container.
3. Runs ``test_data.py`` within the ``jm`` Docker container. The tests are performed within the container because some of them require JModelica.
4. Copies references results and test log out of ``jm`` Docker container, then stops ``jm`` Docker container.


## Run tests for forecaster
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_forecast``
1. Compiles testcase2 and testcase3 models
2. Copies the ``/data``, ``/forecast``, and ``/kpis`` directories as well as ``testcases/testcase2`` and ``testcases/testcase3`` directories into the ``jm`` Docker container.
3. Runs ``test_forecast.py`` within the ``jm`` Docker container. The tests are performed within the container because some of them require JModelica.
4. Copies references results and test log out of ``jm`` Docker container, then stops ``jm`` Docker container.

## Run tests for kpi calculator
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_kpis``
1. Compiles testcase2 and testcase3 models
2. Copies the ``/data``, ``/forecast``, and ``/kpis`` directories as well as ``testcases/testcase2`` and ``testcases/testcase3`` directories into the ``jm`` Docker container.
3. Runs ``test_kpis.py`` within the ``jm`` Docker container. The tests are performed within the container because some of them require JModelica.
4. Copies references results and test log out of ``jm`` Docker container, then stops ``jm`` Docker container.

## Run tests for readme commands
Command: ``$ make test_readme_commands``

This test builds and runs testcase2, and then makes the API calls shown on the file ``../README.md``.

## Other notes
- ``utilities.py`` is used for common testing functions in Python.
- Each test in the ``makefile`` generates its own test log called ``<test_name>.log``.  If running all tests with ``$ make test_all``, then ``report.py`` reads and summarizes all test logs, finally writing this summary in ``testing_report.txt``.
- The Python package versions for the testing environment can be found in the file ``../.travis.yml`` under the job ``python: 3.9``.
- An additional make target ``test_python2`` runs the example controllers implemented in Python in ``../examples/python`` for testcase1, testcase2, and testcase3 in a Python 2.7 environment, defined by the file ``../.travis.yml`` under the job ``python: 2.7``.
