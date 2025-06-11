# BACnet Interface

The contents of this directory enables a BACnet interface to be deployed on top of a BOPTEST test case.
In this way, BACnet applications and controllers can be used to communicate with BOPTEST measurement and control points. The simulation time in seconds is exposed through the interface as the variable ``time``.

## Architecture Concept

The concept is that a single BACnet Device is deployed which contains BACnet objects that correspond to all measurement and control points of the deployed test case.
Thus, it is expected that BACnet applications communicate with the objects on this device.

Behind the scenes, the program emulating this BACnet Device is also responsible for translating input/output data communicated over BACnet into data communication using the native BOPTEST HTTP RESTful API.  In addition, this program automatically advances the BOPTEST test case forward so as to act as a real building moving through time.  The advancement occurs every 5 seconds of real time and runs the simulation for 5 seconds of simulation time using the control values written to the BACnet objects at the time of this advancement.

The BACnet objects are configured based on a .ttl file for each test case located in their respective BOPTEST repository directory.  These files were created by running ``create_ttl.py`` for each specific test case.  The .ttl defines BACnet object properties in the form of Brick semantic syntax.  While providing a comprehensive Brick model is not a focus, yet, Brick is used as a convient method to store BACnet object configuration data, and also serve as a starting point for future semantic representation and integration with BOPTEST.

## Python Package Dependencies

- Python 3
- ``bacpypes``
- ``rdflib``

## Getting Started

1. Deploy a BOPTEST test case of your choice.

2. Configure ``BACpypes.ini``, particularly the address to define where the BACnet device will sit on the network.

3. In a new terminal, run ``$ python BopTestProxy.py bestest_air 0 0`` to deploy the BACnet device and objects for the test case ``bestest_air`` (or choose another) and initialize it with start time of 0 and warmup period of 0.

4. Use a BACnet application to locate the device and objects on the network and communicate with them.

## Faster than real time simulation and advance on demand

In order to advance the simulation faster than real time the optional arguments ``--app_interval(-ai)`` and ``--simulation_step(-s)`` can be used. These are respectively the application refresh interval time in seconds, and the simulation advance time step in seconds  with each application refresh. For example if ``-ai=1`` and ``-s=2`` the application will refresh every second advancing the simulation by two seconds, effectively running it at a speed of 2x with respect to real time. 
In order to advance the simulation on demand, the argument ``--app_interval(-ai)`` should be set equal to ``oncommand``. This will create a new BACnet input called ``advance``. ``advance`` is an integer input that starts at 0 and each increment advances the simulation by a ``--simulation_step(-s)`` amount. Every 100ms the value is checked to see if the simulation needs to be advanced. ``advance`` can be reset by setting it 0 to avoid everincreasing numbers.


## References

``BopTestProxy.py`` code is based on a prototype written by Erik Paulson (https://github.com/epaulson/boptest-bacnet-proxy)
and is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

``/example/SimpleReadWrite.py`` is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

``/example/SimpleRead.py`` is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.
