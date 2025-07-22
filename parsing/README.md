Parsing
=======

Overview
--------
``parser.py`` is used to parse a Modelica model for the signal exchange blocks,
compile a test case FMU that connects top-level inputs and outputs to the
appropriate blocks within the model, parse KPIs associated with each output,
and move any test case data, located in the ``Resources`` directory or otherwise, inside the
resulting test case FMU ``resources`` directory.  The resulting test case FMU
is called ``wrapped.fmu`` and KPI json is called ``kpis.json``. Signal exchange
blocks are contained in the package ``IBPSA.Utilities.IO.SignalExchange``.
The main function to use from ``parser.py`` is ``export_fmu()``.

Examples
--------
To run the example in this directory:

1. Make sure the Modelica IBPSA library is on the ``MODELICAPATH``.

2. ``$ python parser.py`` to parse and export ``SimpleRC.mo`` and ``kpis.json``

3. ``$ python simulate.py`` to simulate ``wrapped.fmu`` with no overwriting,
then overwrite of setpoint, then overwrite of actuator.

See also example usage for each test case in their ``models`` directory.  Each test case contains a ``compile_fmu.py`` file that is used to invoke the parser for that test case, which can be run within the directory using ``$ python compile_fmu.py``.  To run, the dependent Modelica libraries need to be specified on the ``MODELICAPATH`` and the computing environment must have access to one of the Modelica compilation tools as described below.

FMU Compilation Tool Support
----------------------------
The ``export_fmu()`` function takes an argument `tool` that defines which
compilation tool should be used to compile the test case FMU.  Supported
tools are [JModelica](https://jmodelica.org/) (``'JModelica'``, default),
[Optimica](https://help.modelon.com/latest/reference/oct/) (``'OCT'``),
and [Dymola](https://www.3ds.com/products/catia/dymola) (``'Dymola'``).
Note that Optimica and Dymola are commercial compilers
and require appropriate licenses to run.  Use of Dymola requires access to
a license with binary model export capabilities, in order to run the resulting
FMU within the BOPTEST framework.

Note that the python package [PyFMI](https://github.com/modelon-community/PyFMI) (``pyfmi``) is a dependency no matter the tool due to the process by which ``parser.py`` extracts information from the model via the FMI standard.

Continuous integration tests are set up to test the parser using JModelica.  Optimica and Dymola tools have been tested successfully offline, and will continue to be tested periodically.  Issues should be reported through GitHub as they come up.
