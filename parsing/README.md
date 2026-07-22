Parsing
=======

Overview
--------
``parser.py`` is used to parse a Modelica model for the signal exchange blocks,
from the IBPSA Modelica Library in ``IBPSA.Utilities.IO.SignalExchange``,
compile a test case FMU, using a supported tool as described below, that connects top-level inputs and outputs to the appropriate blocks within the model, parse KPIs associated with each output,
and move any test case data, located in the test case's ``Resources`` directory or otherwise, inside the
resulting test case FMU ``resources`` directory.  The resulting test case FMU
is called ``wrapped.fmu`` and KPI json is called ``kpis.json``.

The main function to use from ``parser.py`` is ``export_fmu()``.

A required dependency, other than one of the Modelica FMU compilation tools mentioned below, is the python package [PyFMI](https://github.com/modelon-community/PyFMI) (``pyfmi``), due to the process by which ``parser.py`` extracts information from the model via the FMI standard.

Examples
--------
To run the example in this directory:

1. Make sure the Modelica IBPSA Library is on the ``MODELICAPATH``.

2. ``$ python parser.py`` to parse and export ``SimpleRC.mo`` and ``kpis.json``

3. ``$ python simulate.py`` to simulate ``wrapped.fmu`` with no overwriting,
then overwrite of setpoint, then overwrite of actuator (requires [PyFMI](https://github.com/modelon-community/PyFMI) (``pyfmi``) python package).

See also the example usage for each test case in their respective ``models`` directory.  Each test case contains a ``compile_fmu.py`` file that is used to invoke the parser for that test case, which can be run within the directory using ``$ python compile_fmu.py``.  To run, the dependent Modelica libraries for that test case need to be on the ``MODELICAPATH`` and the computing environment must have access to one of the Modelica FMU compilation tools as described below.

FMU Compilation Tool Support
----------------------------

**Tool Options**

The ``export_fmu()`` function takes an argument `tool` that defines which
compilation tool should be used to compile the test case FMU.  Supported
tools with tested versions are [Dymola](https://www.3ds.com/products/catia/dymola) (``'dymola'``) v2025x, [OpenModelica](https://openmodelica.org/) (``'openmodelica'``) v1.24.4, and
[Optimica](https://help.modelon.com/latest/reference/oct/) (``'OCT'``) v1.51.6.
Optimica and Dymola are commercial compilers
and require access to licenses to run.

Use of Dymola requires access to
a license with the binary model export add-on, in order to run the resulting FMU within the BOPTEST framework.  Use of Dymola also makes use of its ``dmc`` program for CLI execution within python, therefore ``dmc`` must be available and added to the ``PATH`` environment variable.

Use of OpenModelica makes use of the [OMPython](https://github.com/OpenModelica/OMPython) (``OMPython``) python package as an API to its compiler within python, and is thus an additional dependency to be installed.  Use of OpenModelica also has been observed to have limitations for compiling relatively complex models into test case FMUs, including test case models in this repository, see additional notes below.

**Continuous Integration Testing**

Continuous integration tests are set up to test the parser using OpenModelica for the test case ``testcase1``.  Optimica and Dymola tools have been tested successfully offline, and will continue to be tested periodically.  Issues should be reported through GitHub as they come up.

**Repository FMU Compilation**

All test case FMUs in this repository other than ``testcase1`` have been compiled with Dymola with binary model export due to issues compiling those test cases with OpenModelica.  These issues are being addressed through time and compilation of test case FMUs will switch to OpenModelica as possible.
