# Testing

## Run tests for test case 1
Command: ``$ make test_testcase1``
1) Compiles testcase1 model
2) Builds the test case image
3) Deploys the test case container in detached mode
4) Runs ``../testcase1/testing/tests.py``
5) Stops test case container
6) Removes test case image.

## Run tests for test case 2
Command: ``$ make test_testcase2``
1) Compiles testcase2 model
2) Builds the test case image
3) Deploys the test case container in detached mode
4) Runs ``../testcase2/testing/tests.py``
5) Stops test case container
6) Removes test case image.

## Run tests for parser
Command: ``$ make test_parser``
1) Runs ``../parser/testing/tests.py``
