.. _SecUseCases:

User Case Narratives
====================

Client Controller Tester
------------------------

The client represents the user who is testing a controller that they have developed on a BOPTEST test case.

The client will:

1. Download and install boptest runtime platform.  Establish connection through port mapping per installation instructions.

2. Through a defined runtime platform API, select a test case from available test cases.  The runtime platform will fetch the selected test case and deploy as a Docker container(s).

3. Through a defined runtime platform API, retrieve information about the test case, such as documentation and available control and measurement signals with meta data (e.g. units, descriptions, min, max)

4. Through a defined runtime platform API, set the simulation advancing scheme as either controller-blocked at control step or wall-clock multiplier.

	- A controller-blocked scheme is one where the simulation waits while the controller calculates the control action for the next control step.  Upon completion, the controller sends the control action to the simulation and the simulation advances one control step.  Upon completion, data is sent back to the controller to calculate a control action.  The process is repeated until the end of the simulation time.

	- A wall-clock multiplier scheme is one where the simulation advances as a multiplier of real time.  For instance, with a multiplier of one, the simulation advances one second every second of real time.  The simulation uses the most up-to-date values for control inputs.  The controller is free to retrieve the most up-to-date measurement output values at any time, and also update control input values at any time.

5. Link the controller to be tested to the test case through a defined controller API, which may be different than the runtime platform API (e.g. Haystack or custom).

6. Through a defined runtime platform API, select a scenario to test from the test case.

7. Through a defined runtime platform API, select whether the test case should be:

	- Run with controller testing data (default).  If this case is chosen, go to step 8 and continue.

	- Run with model identification data in which the boundary condition weather data is different, though statistically the same, as the controller testing data.  This case is if an MPC model needs to be identified prior to controller testing.  If this case is chosen, go to steps 9 and 11 as needed to identify model.

8. Through a defined runtime platform API, obtain initial forecasts of boundary conditions (e.g. weather, internal gains, energy pricing) as needed if MPC controller.

9. Through a defined runtime platform API, initiate the test and run to completion, exchanging measurement, forecast (if MPC controller), and updated control signal data according to one of the two schemes described in 4.

	- If a control signal min or max is violated, truncate the value to the minimum or maximum.

10. Receive report of KPI results for scenario test from runtime platform upon completion of test.

11. Through a defined runtime platform API, receive other data collected during the test, such as control signal or measurement trajectories, for further post processing.

12. Through a defined runtime platform API, manage available test cases and scenarios and proceed back to Step 2.

Reference Test Case Developer
-----------------------------

The reference test case developer represents the user who is creating reference test case emulator models, specifying control signals and measurements, providing location specific information, such as weather data, carbon emission factors, and electricity pricing, and setting simulation options (such as solver, tolerance, available communication steps).  The reference test case developer will:

1. Create the test case according to the specifications outlined in Sections IV in a local computing environment.

2. Submit test case for peer review according to Section IV of this document. Make adjustments as necessary to test case until pass peer review.

3. Post reference test case to github repository and subject to unit tests according Section IV of this document.

Custom Test Case Developer
-----------------------------

To be added...
