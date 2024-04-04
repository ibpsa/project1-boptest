# BACnet Interface

The contents of this directory enables a BACnet interface to be deployed on top of a BOPTEST test case.
In this way, BACnet applications and controllers can be used to communicate with BOPTEST measurement and control points.

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

3. In a new terminal, run ``$ python BopTestProxy.py 0 0`` to deploy the BACnet device and objects for the test case and initialize the test case with start time of 0 and warmup period of 0.

4. Use a BACnet application to locate the device and objects on the network and communicate with them.

## References

``BopTestProxy.py`` code is based on a prototype written by Erik Paulson (https://github.com/epaulson/boptest-bacnet-proxy)
and is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

``/example/SimpleReadWrite.py`` is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.
