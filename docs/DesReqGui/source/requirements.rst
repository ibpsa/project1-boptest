.. _SecRequirements:

Requirements
============

The following requirements are necessary to achieve the goal outlined in :ref:`SecGoal`:

1. Reference emulation models must simulate the physics, dynamics, and time-resolution necessary for controls design and assessment at the supervisory and local-loop levels.  This requires modeling of not only envelope heat transfer and airflow networks, but also dynamic actuators like valves and dampers.

2. The simulation environment must be standardized so that results for benchmarking are consistent.  This includes the solver and tolerance, computing environment, and implementation tools.

3. Data exchange between a test controller and the emulator should be facilitated by an interface that is independent of the modeling and controller programming languages. This prevents limitation of the allowable implementations of controllers and interfaces to the framework.

4. All exogenous data that defines a test case should be provided by the framework, such as weather, occupancy schedules, and energy prices.  In cases of MPC testing, it needs to be made available as forecasts.  Providing deterministic forecasts is the priority.  Stochastic forecasts will be considered as a future extension.

5. A standard set of key performance indicators (KPI) should be specified to facilitate benchmarking and comparison of controllers.  The specification needs to include equations or guidelines to unambiguously quantify the KPIs, enabling a fair and clear comparison between controllers.

6. Flexibility in synchronizing simulation and controller times to meet different application requirements. In Option 1, the simulation is advanced to the next time step according to real time, representing a realistic building-controller interaction.  In Option 2, the simulation is advanced to the next time step when the controller returns with an updated control action, which is easier for controller development and allows for reproducible tests.

7. All software is open source and documented to allow for inspection of the models, their underlying assumptions and the computing platform.
