===========
API Summary
===========

To interact with a deployed test case, use the API defined in the sections below by sending RESTful requests as follows:

- If Single Test Case on Local Computing Resource, send API requests to localhost port 5000 as ``http://127.0.0.1:5000/<request>``.
- If using Public Web Service, send API requests to ``<url>/<request>/<testid>``, where ``<testid>`` is your returned testid upon test case selection.  See the section Getting Started for more information.

Each API request will return a JSON in the form ``{"status":<status_code_int>, "message":<message_str>, "payload":<relevant_return_data>}``, where:

- Data returned in ``"payload"`` is the data of interest relvant to the specific API request and is defined in the **Returns** section of each section below.
- Status codes in ``"status"`` are integers: ``200`` for successful with or without warning, ``400`` for bad input error, or ``500`` for internal error.
- The string in ``"message"`` will report any warnings or error messages to help debug encountered problems.

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

- **Description:** Receive available sensor signal output point names (y) and metadata.

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

- **Description:** Receive available control signal input point names (u) and metadata.

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

- **Description:** Receive the current control step.  This is the amount of simulation time that will pass when the next control step is taken.

- **Arguments:** None.

- **Returns:**

    ::

        <step>  // float, control step in seconds

PUT /step
---------

- **Description:** Set the current control step.  This is the amount of simulation time that will pass when the next control step is taken.

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
                <value>,    // float, point values at start time
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

GET /forecast_points
--------------------

- **Description:** Receive available forecast point names and metadata.

- **Arguments:** None.

- **Returns:**

    ::

        {
            <point_name>:                   // str, name of point
                {"Description": <value>,    // str, description of point
                 "Unit": <value>,           // str, unit of point
                 },
            ...
        }

PUT /forecast
-------------

- **Description:** Receive boundary condition forecasts from current time.

- **Arguments:**

    ::

        point_names     // required, list of str, name of points
        horizon         // required, float, horizon of forecast in seconds
        interval        // required, float, interval of forecast in seconds

- **Returns:**

    ::

        {
            "time":
                <values>,   // array of floats, time values at interval for horizon
            <point_name>:   // str, name of point
                <values>,   // array of floats, forecast values at interval for horizon
            ...
        }

POST /advance
-------------

- **Description:** Advance simulation one control step with optional control input(s) and receive measurements.  If specified, control input value(s) will be constant over the control step.  Use <input_name_u> to specify value and corresponding <input_name_activate> to enable value overwrite for the input.

- **Arguments:**

    ::

        <input_name_u>          // optional, float, value of input point to overwrite
        <input_name_activate>   // optional, float, enable corresponding input overwrite if greater than 0 (default is 0)

- **Returns:**

    ::

        {
            <point_name>:   // str, name of point
                <value>,    // float, point value at time at end of control step
            ...
        }

PUT /results
------------

- **Description:** Receive simulation data for the given point names over a time period.  Data for control input points will be the values used for simulation, meaning embedded default control if not overwritten or user-specified value if overwritten.

- **Arguments:**

    ::

        point_names     // required, list of str, name of points
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

GET /kpi_disaggregated
----------------------

- **Description:** Receive KPI values disaggregated into contributing components (e.g. each equipment or zone).
                   The returned results are in absolute values, that is, they are not normalized by floor area or by number of zones.
                   Calculated from start time and do not include warmup periods.

- **Arguments:** None.

- **Returns:**

    ::

        {
            "cost":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC energy cost in $ or Euro
            "emis":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC energy emissions in kgCO2e
            "ener":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC energy total usage in kWh
            "pele":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC at the overall peak electrical demand in kW
            "pgas":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC at the overall peak gas demand in kW
            "pdih":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to HVAC at the overall peak district heating demand in kW
            "idis":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to indoor air quality discomfort in ppmh
            "tdis":<kpi_ele_name>:<kpi_ele_value>,     // dict, Contribution of each element to thermal discomfort in Kh
        }

GET /submit
-----------

- **Description:** Post test results to online dashboard located at (url coming soon).  A complete test scenario (including full time period) must be finished before results can be submitted to the dashboard.

- **Arguments:**

    ::

        api_key         // required, str, API key generated for user account on dashboard.
        tag<n>          // optional, str, Tag to characterize result and which can be filtered upon in the online dashboard. Up to 10 tags are allowed, specifed by <n>=1-10.

- **Returns:**

    ::

        {
            "identifier":<uid>,       // str, Unique identifier for result posted to dashboard}
        }
