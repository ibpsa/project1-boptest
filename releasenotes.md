# Release Notes

## BOPTEST v0.3.0-dev

Released on xx/xx/xxxx.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Use python arrays instead of numpy arrays for storage of data in ``y_store`` and ``u_store`` in ``testcase.py`` for more efficient memory utilization, resulting in more consistent computation time for each advance step and faster overall test simulations.  This is for [#520](https://github.com/ibpsa/project1-boptest/issues/520).
- Specify version on master branch as ``<latest release>-dev`` instead of ``0.x.x``.  This is for [#516](https://github.com/ibpsa/project1-boptest/issues/516).
- Update tutorial in ``docs/workshops/BS21Workshop_20210831`` to be compatible with BOPTEST v0.3.0 deployed in BOPTEST-Service.  This is for [#507](https://github.com/ibpsa/project1-boptest/issues/507).
- Add ``get_html_IO.py`` to ``/data`` folder and remove it from ``/testcases`` folders to avoid code duplication. This is for [#464](https://github.com/ibpsa/project1-boptest/issues/464).
- Abstract the definition of input and output lists within if-else statements in the API unit tests in ``utilities.py`` to the setUp method in each test cases's specific testing file ``test_<testcase>``, by introducing the ``input`` and ``measurement`` attributes.  This is for [#463](https://github.com/ibpsa/project1-boptest/issues/463).
- Add unit test reporting script to each individual unit test target in the ``testing/makefile``.  This is for [#466](https://github.com/ibpsa/project1-boptest/issues/466).
- Add error message in case testcase path does not exist in ``testcase.py TestCase __Init__`` method.  This is for [#475](https://github.com/ibpsa/project1-boptest/issues/475).
- Update script ``get_html_IO.py`` to run with the latest API implementation by adding ``['payload']``. This is for [#487](https://github.com/ibpsa/project1-boptest/issues/487).
- Update ``twozone_apartment_hydronic`` documentation with reference to publication where envelope model was validated with experimental data. This is for [#496](https://github.com/ibpsa/project1-boptest/issues/496).
- Update ``twozone_apartment_hydronic`` ``weather.csv`` and ``generate_data.py`` by adding global horizontal radiation ``HGloHor``. This is for [#499](https://github.com/ibpsa/project1-boptest/issues/499).

**The following changes are not backwards-compatible but do not significantly change benchmark results:**

- Change the PUT ``forecast`` API to accept lists of variable names with the parameter ``point_names`` instead of returning data for all variables.  Also add parameters ``interval`` and ``horizon`` to that API endpoint.  Add API GET ``forecast_points`` to return available forecast point names and metadata.  Remove APIs GET and PUT ``forecast_parameters``.  This is for [#356](https://github.com/ibpsa/project1-boptest/issues/356).
- Change the PUT ``results`` API to accept lists of variable names with the parameter ``point_names`` instead of a single string variable name ``point_name``.  This is for [#398](https://github.com/ibpsa/project1-boptest/issues/398).

**The following new test cases have been added:**

- ``twozone_apartment_hydronic``, a 2-zone apartment based on a real newly built building in Milan, Italy, served by an air-to-water heat pump coupled with a floor heating system. This is for [#409](https://github.com/ibpsa/project1-boptest/issues/409).


## BOPTEST v0.3.0

Released on 07/27/2022.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Clarify ``README.md`` instructions for the deployment of a test case.  This for [#451](https://github.com/ibpsa/project1-boptest/issues/451).
- Split unit tests into parallel jobs on travis.  This is for [#450](https://github.com/ibpsa/project1-boptest/issues/450).
- Add simulation support for test case FMUs compiled using Spawn of EnergyPlus.  Does not address workflows for the compiling process for test case FMUs using Spawn.  This is for [#406](https://github.com/ibpsa/project1-boptest/issues/406).
- New project home page launched at [https://ibpsa.github.io/project1-boptest/](https://ibpsa.github.io/project1-boptest/).  This is for [#214](https://github.com/ibpsa/project1-boptest/issues/214).
- Add file exclusion list to ``data_manager.py`` when loading data from fmu resource directory.  This is for [#423](https://github.com/ibpsa/project1-boptest/issues/423).
- Specify better command on ``README.md`` for specifying test case to deploy on Windows.  This is for [#419](https://github.com/ibpsa/project1-boptest/issues/419).
- Remove dependency of example controllers on ``pathlib`` package.  This is for [#416](https://github.com/ibpsa/project1-boptest/issues/416).
- Fix and clarify ``README.md`` for the ``/initialize`` and other API end points.  This is for [#408](https://github.com/ibpsa/project1-boptest/issues/408).

**The following changes are not backwards-compatible but do not significantly change benchmark results:**

- Add the POST ``submit`` API to submit test results to the online dashboard under a user's account there.  This is for [#403](https://github.com/ibpsa/project1-boptest/issues/403).
- Update API to standardize return package format and information about about errors and warnings.  The new return package is in the form ``{"status":<status_code_int>, "message":<message_str>, "payload":<relevant_return_data>}``. Status codes are: 200, successful with or without warning; 400, bad input; 500, internal error.  Users should expect the data returned in ``"payload"`` to be the same as the previous version API, which should facilitate the necessary code modifications to maintain compatibility with the new API. This is for [#73](https://github.com/ibpsa/project1-boptest/issues/73).

**The following new test cases have been added:**

- ``multizone_office_simple_air``, a 5-zone building based on the U.S. DOE medium office reference building located in Chicago, IL, USA, served by a single-duct Variable Air Volume (VAV) with terminal reheat, air-cooled chiller, and air-to-water heat pump.  This is for [#273](https://github.com/ibpsa/project1-boptest/issues/273).

**The following new core KPIs have been added:**

- Peak Electricity Demand (``pele_tot`` in kW/m^2): The maximum 15-minute HVAC electrical demand over the test interval.  Returns ``null`` if test case has no electricity consumption.  This is for [#388](https://github.com/ibpsa/project1-boptest/issues/388).
- Peak Gas Demand (``pgas_tot`` in kW/m^2): The maximum 15-minute HVAC gas demand over the test interval.  Returns ``null`` if test case has no gas consumption.  This is for [#388](https://github.com/ibpsa/project1-boptest/issues/388).
- Peak District Heating Demand (``pdih_tot`` in kW/m^2): The maximum 15-minute HVAC district heating demand over the test interval.  Returns ``null`` if test case has no district heating consumption.  This is for [#388](https://github.com/ibpsa/project1-boptest/issues/388).

## BOPTEST v0.2.0

Released on 03/05/2022.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Make the test case parser compatible wth python 3.  This is for [#404](https://github.com/ibpsa/project1-boptest/issues/404).
- Use ``docker-compose`` for building and running test case.  Use of ``make build`` and ``make run`` deprecated.  See ``README.md`` for new deployment instructions.  This is for [#365](https://github.com/ibpsa/project1-boptest/issues/365).
- Posted developer tutorial given to IBPSA Project 1 WP1.2 during Rome expert meeting and updated for current version of BOPTEST.  Located at ``docs/tutorials/tutorial1_developer/BOPTEST_Tutorial1_developer_20220110.pdf``.  This is for [#358](https://github.com/ibpsa/project1-boptest/issues/358).
- For ``multizone_residential_hydronic``, correct one-port temperature sensors to two-port and update door models from ``Buildings.Airflow.Multizone.DoorDiscretizedOperable`` to ``Buildings.Airflow.Multizone.DoorDiscretizedOpen``.  This is for [#384](https://github.com/ibpsa/project1-boptest/issues/384).
- Refactor python-based example tests to utilize a single BOPTEST interface script.  This is for [#279](https://github.com/ibpsa/project1-boptest/issues/279).
- Fix ``data/data_generator`` to produce correct set points for defined occupied and unnoccupied times. This is for [#368](https://github.com/ibpsa/project1-boptest/issues/368).
- Freeze IBPSA Modelica library version in creation of ``jm`` image for unit testing.  This is for [#371](https://github.com/ibpsa/project1-boptest/issues/371).
- Update test cases to use Buildings v8.0.0 and IDEAS v2.2.1 commit f1fdd8b.  This is for [#362](https://github.com/ibpsa/project1-boptest/issues/362) and [#364](https://github.com/ibpsa/project1-boptest/issues/364).
- Add content to ``/docs/workshops`` for workshop at IBPSA Building Simulation 2021 Conference.  This is for [#348](https://github.com/ibpsa/project1-boptest/issues/348) and [#374](https://github.com/ibpsa/project1-boptest/issues/374).
- Update README.md to add links to ``boptest-service`` and ``boptest-gym``.  This is for [#353](https://github.com/ibpsa/project1-boptest/issues/353).
- Fix path for documentation images for bestest_hydronic_heat_pump test case.  This is for [#351](https://github.com/ibpsa/project1-boptest/issues/351).

**The following changes are backwards-compatible but do change benchmark results:**

- Correct calculation of mix day scenario in ``/data/find_days.py``.  This changes the reference day for the mix day scenario time period for the ``bestest_air`` test case.  This is for [#381](https://github.com/ibpsa/project1-boptest/issues/381).

**The following changes are not backwards-compatible but do not significantly change benchmark results:**

- Fix so that data returned through the API using ``/results`` and ``/advance`` for ``<control_signal_name>_u`` represents the "current value" of the control signal utilized within the emulator.  It is equal to the baseline controller value if not being overwritten and the overwritten value otherwise.  While this change does not change benchmark results, it is not backward compatible since the measurement signals available in some test cases that reported such "current values" (e.g. ``reaTSetHea_y`` in ``bestest_hydronic``) have been removed.  Users should instead request data for the control signal ``<control_signal_name>_u`` (e.g. ``oveTSetHea_u`` in ``bestest_hydronic``).  This is for [#364](https://github.com/ibpsa/project1-boptest/issues/364).

**The following new test cases have been added:**

- ``singlezone_commercial_hydronic``, a single-zone commercial hydronic model with district heating source, zone radiator, and air handling unit providing fresh air with CO2 control and heat recovery.  This is for [#162](https://github.com/ibpsa/project1-boptest/issues/162).


## BOPTEST v0.1.0

Released on 07/13/2021.

This is an initial development release.
