# Testing

## Run all tests defined below
Command: ``$ make test_all``

A test report will be displayed and recorded to file upon completion called ``testing_report.txt``.

NOTE: To pass all tests, they must be run in a Linux environment and with JModelica.org installed.
This is due to the requirement of compiling FMUs and simulating them in a Docker container with Ubuntu OS.

## Run tests for test case 1
Command: ``$ make test_testcase1``
1) Compiles testcase1 model
2) Builds the test case image
3) Deploys the test case container in detached mode
4) Runs the Julia controller example for test case 1
5) Runs ``test_testcase1.py``, which includes the Python controller example for test case 1
6) Stops test case container
7) Removes test case image.


## Run tests for test case 2
Command: ``$ make test_testcase2``
1) Compiles testcase2 model
2) Builds the test case image
3) Deploys the test case container in detached mode
4) Runs the Julia controller example for test case 2
5) Runs ``test_testcase2.py``, which includes the Python controller example for test case 2
6) Stops test case container
7) Removes test case image.

## Run tests for parser
Command: ``$ make test_parser``
1) Runs ``test_parser.py``

## Other notes
- ``utilities.py`` is used for common testing functions in Python.
- Each test in the ``makefile`` generates its own test log called ``<test_name>.log``.  If running all tests with ``$ make test_all``, then ``report.py`` reads and summarizes all test logs, finally writing this summary in ``testing_report.txt``.
