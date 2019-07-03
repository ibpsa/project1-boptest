# Testing

## Run all tests defined below
Command: ``$ make test_all``

A test report will be displayed and recorded to file upon completion called ``testing_report.txt``.

## Run tests for test case 1
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_testcase1``.

1. Compiles testcase1 model
2. Builds the test case image
3. Deploys the test case container in detached mode
4. Runs the Julia controller example for test case 1
5. Runs ``test_testcase1.py``, which includes the Python controller example for test case 1
6. Stops test case container
7. Removes test case image.


## Run tests for test case 2
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_testcase2``
1. Compiles testcase2 model
2. Builds the test case image
3. Deploys the test case container in detached mode
4. Runs the Julia controller example for test case 2
5. Runs ``test_testcase2.py``, which includes the Python controller example for test case 2
6. Stops test case container
7. Removes test case image.

## Run tests for parser
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_parser``
1. Runs ``test_parser.py``

## Run tests for data
First, check if Docker image ``jm`` exists.  If not, run command: ``$ make build_jm_image``.

Then, run the test with command: ``$ make test_data``
1. Compiles testcase2 model
2. Copies the data and testcase2/models folders as well as the testcase2/config.py, the testcase.py and kpis.json files into the ``jm`` Docker container. 
3. Runs ``test_data.py`` within the ``jm`` Docker container. The tests are performed within the container because some of them require JModelica.  

## Other notes
- ``utilities.py`` is used for common testing functions in Python.
- Each test in the ``makefile`` generates its own test log called ``<test_name>.log``.  If running all tests with ``$ make test_all``, then ``report.py`` reads and summarizes all test logs, finally writing this summary in ``testing_report.txt``.
