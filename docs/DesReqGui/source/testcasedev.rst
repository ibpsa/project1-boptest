.. _SecTestCaseDev:

Reference Test Case Development
===============================

This section outlines the development requirements of a reference test case.  A reference test case consists of the following components:

1. Modelica model

	- Include documentation html in .mo file

	- The model should include the “uses” Modelica annotation to specify the names and versions of additional Modelica libraries on which it depends.

2. FMU

	- Include boundary condition  data (this is: weather data, occupancy schedules, energy pricing, emission factors, internal gains and comfort set-points) in resources folder.
	- Generated without run-time license restrictions.
	- Generated as co-simulation or model-exchange that can be integrated with the CVode solver at a tolerance of 10e-6.
	- Each scenario using model should have own FMU.
	- Template scripts will be developed to help the model developer generate the test case FMU.  See Parts B, C, and D of this section.

3. Documentation

4. BOPTEST API Configuration

Test Case Repository
--------------------

Each test case will be stored and maintained in a repository under the IBPSA github account with an appropriate name.  The repository will have the following structure:

::

	TestCaseName			// Test case directory name
	|--model			// Model directory
	|  |--Resources			// Resources directory with test case data
	|  |--model.mo 			// Modelica model file
	|  |--model.fmu 		// BOPTEST ready FMU
	|  |  |--resources 		// Resources directory
	|  |  |  |--kpis.json 		// JSON mapping outputs to KPI calculations
	|  |  |  |--weather.mos 	// Weather data for model simulation in Modelica
	|  |  |  |--weather.csv 	// Weather data for forecasting
	|  |  |  |--occupancy.csv 	// Occupancy schedules
	|  |  |  |--internalGains.csv 	// Internal gain schedules
	|  |  |  |--prices.csv 		// Energy pricing schedules
	|  |  |  |--emissions.csv 	// Energy emission factor schedules
	|  |  |  |--setpoints.csv 	// Thermal comfort region schedules
	|--doc				// Documentation directory
	|  |--doc.html 			// Copy of .mo file documentation
	|  |--images 			// Image directory
	|  |  |--image1.png 		// Image for model documentation
	|--config.py 			// BOPTEST configuration file





