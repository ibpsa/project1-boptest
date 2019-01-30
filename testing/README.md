# Testing

## Run tests for test case 1
Command: ``$ make test_testcase1``
1) Builds the test case image
2) Deploys the test case container in detached mode
3) Runs ``../examples/twoday-p.py``
4) Stops test case container
5) Removes test case image.

## Run tests for compiling testcase 1 model
Command: ``$ make test_compile_model_testcase1``
1) Runs ``../testcase1/models/compile_fmu.py`` to export testcase1 wrapper fmu.

## Run tests for test case 2
Command: ``$ make test_testcase2``
1) Builds the test case image
2) Deploys the test case container in detached mode
3) Runs ``../examples/szvav-sup.py``
4) Stops test case container
5) Removes test case image.

## Run tests for compiling testcase 2 model
Command: ``$ make test_compile_model_testcase2``
1) Runs ``../testcase2/models/compile_fmu.py`` to export testcase2 wrapper fmu.

## Run tests for parser
Command: ``$ make test_parser``
1) Runs ``../parser/parser.py`` to export example wrapper fmu.
2) Runs ``../parser/simulate.py`` to simulate the wrapper fmu in three different configurations.
