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

2. Configure ``BACpypes.ini``, particularly the IP address to define where the BACnet device will sit on the network.

3. In a new terminal, run ``$ python BopTestProxy.py bestest_air 0 0`` to deploy the BACnet device and objects for the test case ``bestest_air`` (or choose another) and initialize it with start time of 0 and warmup period of 0.

4. Use a BACnet application to locate the device and objects on the network and communicate with them. The simulation time in seconds is exposed through the interface as the second BACnet object ``time`` for all test cases.

5. By default, the BACnet device will advance the BOPTEST simulation 5 seconds in simulation every 5 seconds of real time.  See the section below for additional time management options.  Note that the first BACnet object ``advance`` is reserved for optional use as described below.

## Faster-than-real-time simulation and advancing on-demand

Two additional command line arguments for the BACnet interface can be used to control time advancement of the simulation. ``--app_interval(-ai)`` is the application refresh interval time in seconds and ``--simulation_step(-s)`` is the simulation advance time step in seconds with each application refresh. These arguments can be used in two ways:

1. Accelerate the simulation speed with respect to real time: For example, if ``-ai=1`` and ``-s=2``, the application will refresh every one second and advance the simulation by two seconds with each refresh, effectively running it at a speed of 2x with respect to real time.

    This example can be deployed with the following command:

    ```
    $ python BopTestProxy.py bestest_air 0 0 --app_interval=1 --simulation_step=2
    ```

2. Advance the simulation on-command: The argument ``--app_interval(-ai)`` can be set equal to ``oncommand``. This will make use of the first BACnet input object called ``advance`` on the BACnet interface device. ``advance`` is an integer that starts at 0.  A client can advance the simulation one step (the value of ``--simulation_step(-s)``) by writing an integer greater than the current value to ``advance`` (i.e. a value of 1, then a value of 2, and so on). The BACnet interface checks the value of ``advance`` every 100ms to see if the simulation needs to be advanced. The value of ``advance`` can be reset by writing a 0 to it, to avoid a client needing to write ever-increasing numbers. Resetting the value to 0 does not advance the simulation, until the client increments once again.

    An example for on-command advancement with a simulation step of 60 seconds can be deployed with the following command:

    ```
    $ python BopTestProxy.py bestest_air 0 0 --app_interval=oncommand --simulation_step=60
    ```


## References

``BopTestProxy.py`` code is based on a prototype written by Erik Paulson (https://github.com/epaulson/boptest-bacnet-proxy)
and is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

``/example/SimpleReadWrite.py`` is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.

``/example/SimpleRead.py`` is based on the BACpypes Python package distributed under an
MIT License.  See license.md in the root of this repositoriy for details.
