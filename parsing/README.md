Parsing
=======

Overview
--------
``parser.py`` is used to parse a Modelica model for the signal exchange blocks,
compile a test case FMU that connects top-level inputs and outputs to the
appropriate blocks within the model, parse KPIs associated with each output,
and move any test case data located in a ``Resources`` directory inside the
resulting test case FMU ``resources`` directory.  The resulting test case FMU
is called ``wrapped.fmu`` and KPI json is called ``kpis.json``. Signal exchange
blocks are contained in the package ``IBPSA.Utilities.IO.SignalExchange``.
The main function to use from ``parser.py`` is ``export_fmu()``.

Example
-------
To run example:

1. Make sure the Modelica IBPSA library is on the ``MODELICAPATH``.

2. ``$ python parser.py`` to parse and export ``SimpleRC.mo`` and ``kpis.json``

3. ``$ python simulate.py`` to simulate ``wrapped.fmu`` with no overwriting,
then overwrite of setpoint, then overwrite of actuator.

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
