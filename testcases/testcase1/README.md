BOPTEST Test Case 1
===================
This test is a simple RC network with feedback controlled heating device.

Structure
---------

- ``doc/`` contains documentation of the test case.
- ``models/`` contains the emulation model files for the test case.
- ``config.py`` defines the configuration of the test case for building the Docker image.

Compile the Model
-----------------

The Modelica model makes use of the signal overwrite blocks and uses the 
overwrite block parser (``<repo_root>/parser/parser.py``) to compile the FMU.

1. Add the root of the BOPTEST repository to the PYTHONPATH environment variable.

2. ``$ cd models``

3. ``$ python compile_fmu.py`` to compile the model FMU using the overwrite block parser.

4. The resulting FMU will be named ``wrapped.fmu``.
