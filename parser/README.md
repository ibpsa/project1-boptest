``parser.py`` is used to parse a Modelica model for the signal exchange blocks and compile an FMU that connects top-level inputs and outputs to the appropriate blocks within the model.

To run example:

1. ``$ python parser.py`` to parse and export ``SimpleRC.mo`` as an FMU called ``wrapped.fmu``.

2. ``$ python simulate.py`` to simulate ``wrapped.fmu`` with no overwriting, then overwrite of setpoint, then overwrite of actuator.
