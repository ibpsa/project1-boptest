``parser.py`` is used to parse a Modelica model for the signal exchange blocks, 
compile an FMU that connects top-level inputs and outputs to the
appropriate blocks within the model, and parse KPIs associated with each output.
The resulting FMU is called ``wrapped.fmu`` and KPI json is called ``kpis.json``. 
Signal exchange blocks are contained in the package ``IBPSA.Utilities.IO.SignalExchange``.

To run example:

1. Make sure the Modelica IBPSA library is on the ``MODELICAPATH``.

2. ``$ python parser.py`` to parse and export ``SimpleRC.mo`` and ``kpis.json``

3. ``$ python simulate.py`` to simulate ``wrapped.fmu`` with no overwriting, then overwrite of setpoint, then overwrite of actuator.
