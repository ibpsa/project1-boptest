===========
API Summary
===========

GET /version
------------

- **Description:** Receive BOPTEST version.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "version":<value>    // str, X.Y.Z
        }

GET /name
---------

- **Description:** Receive test case name.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "name":<testcase_name>    // str, name of test case
        }


GET /measurements
-----------------

- **Description:** Receive sensor signal point names (y) and metadata.

- **Arguments:** None.

- **Returns:**

    ::

        {
            <point_name>:           // str, name of point
                {"Description": ,   // str, description of point
                 "Unit": ,          // str, unit of point
                 "Minimum": ,       // float or null, minimum point value
                 "Maximum": ,       // float or null, maximum point value
                 },
            ...
        }

GET /inputs
------------

- **Description:** Receive control signal point names (u) and metadata.

- **Arguments:** None.

- **Returns:**

    ::

        {
            <point_name>:                   // str, name of point
                {"Description": <value>,    // str, description of point
                 "Unit": <value>,           // str, unit of point
                 "Minimum": <value>,        // float or null, minimum point value
                 "Maximum": <value>,        // float or null, maximum point value
                 },
            ...
        }

GET /step
---------

- **Description:** Receive the current control step.  This is the amount of simulation time that will pass when the next simulation step is taken.

- **Arguments:** None.

- **Returns:**

    ::

        <step>  // float, control step in seconds

PUT /step
---------

- **Description:** Set the current control step.  This is the amount of simulation time that will pass when the next simulation step is taken.

- **Arguments:**

    ::

        step    // required, float, control step in seconds

- **Returns:**

    ::

        <step>  // str, set control step in seconds

PUT /initialize
--------------

- **Description:** Initialize simulation to a start time using a specified warmup period. Also resets point data history and KPI calculations.

- **Arguments:**

    ::

        start_time      // required, float, start time in seconds
        warmup_period   // required, float, warmup period length in seconds

- **Returns:**

    ::

        {
            <point_name>:   // str, name of point
                <value>,    // float, point value at start times
            ...
        }

GET /scenario
-------------

- **Description:** Receive current test scenario.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "electricity_price":<value>     // str, current electricity price scenario
            "time_period":<value>           // str, current time period scenario
        }

PUT /scenario
-------------

- **Description:** Set current test scenario.  Setting ``time_period`` results in similar behavior to ``PUT /initialize``, except uses a pre-determined start time and warmup period as defined within BOPTEST according to the selected scenario.

- **Arguments:**

    ::

        electricity_price   // optional, str, electricity price scenario
        time_period         // optional, str, time period scenario

- **Returns:**

    ::

        {
            "electricity_price":<value>,    // str, set electricity price scenario
            {<point_name>:                  // str, name of point
                <value>,                    // float, point value at start time
            ...
            }
        }

GET /forecast
-------------

- **Description:** Receive boundary condition forecasts from current communication step.

- **Arguments:** None.

- **Returns:**

    ::

        {
            <point_name>:   // str, name of point
                <values>,   // array of floats, forecast values at interval for horizon
            ...
        }

GET /forecast_parameters
------------------------

- **Description:** Receive the current boundary condition forecast parameter values.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "horizon":<value>   // float, horizon of forecast in seconds
            "interval":<value>  // float, interval of forecast in seconds
        }

PUT /forecast_parameters
------------------------

- **Description:** Set the current boundary condition forecast parameters.

- **Arguments:**

    ::

        horizon   // required, float, horizon of forecast in seconds
        interval  // required, float, interval of forecast in seconds

- **Returns:**

    ::

        {
            "horizon":<value>   // float, set horizon of forecast in seconds
            "interval":<value>  // float, set interval of forecast in seconds
        }

POST /advance
-------------

- **Description:** Advance simulation one control step with optional control input(s) and receive measurements.  If specified, control input value(s) will be constant over the control step.

- **Arguments:**

    ::

        input_name  // optional, float, value of input point

- **Returns:**

    ::

        {
            <point_name>:   // str, name of point
                <value>,    // float, point value at time at end of control step
            ...
        }

PUT /results
------------

- **Description:** Receive simulation data for the given point name over a time period.

- **Arguments:**

    ::

        point_name      // required, str, name of point
        start_time      // required, float, start time of data to collect
        final_time      // required, float, final time of data to collect

- **Returns:**

    ::

        {
            "time":
                <values>,   // array of floats, values of time in seconds over time period
            <point_name>:   // str, name of point
                <values>,   // array of floats, point values over time period
        }

GET /kpi
--------

- **Description:** Receive KPI values.  Calculated from start time and do not include warmup periods.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "cost_tot":<value>,     // float, HVAC energy cost in $/m2 or Euro/m2
            "emis_tot":<value>,     // float, HVAC energy emissions in kgCO2e/m2
            "ener_tot":<value>,     // float, HVAC energy total in kWh/m2
            "pele_tot":<value>,     // float, HVAC peak electrical demand in kW/m2
            "pgas_tot":<value>,     // float, HVAC peak gas demand in kW/m2
            "pdih_tot":<value>,     // float, HVAC peak district heating demand in kW/m2
            "idis_tot":<value>,     // float, Indoor air quality discomfort in ppmh/zone
            "tdis_tot":<value>,     // float, Thermal discomfort in Kh/zone
            "time_rat":<value>      // float, Computational time ratio in s/ss
        }
