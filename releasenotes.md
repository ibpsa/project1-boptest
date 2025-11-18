# Release Notes

## BOPTEST v0.9.0

Released on 11/18/2025.

**The following changes are backwards compatible and do not significantly change benchmark results:**

- Add materials for BS2025 workshop at ``docs/workshops/BS25Workshop_20250828`` and add link for test case review document in ``testcases/README.md``. This is for [#785](https://github.com/ibpsa/project1-boptest/issues/785).
- For ``twozone_apartment_hydronic`` test case, update control documentation. This is for [#766](https://github.com/ibpsa/project1-boptest/issues/766).
- For BACnet interface, add support for faster-than-real-time and on-command simulation advance. Optional arguments ``--app_interval`` and ``--simulation_step`` were added to ``BopTestProxy.py`` to support this feature. This is for [#764](https://github.com/ibpsa/project1-boptest/issues/764).
- Update support to ``parsing/parser.py`` for test case compilation using Dymola to be able to specify solver and tolerance and to be able to use references to other string parameters in defining a string parameter.  This is for [#777](https://github.com/ibpsa/project1-boptest/issues/777).
- For unit tests on travis, remove custom installation of Docker.  This is for [#787](https://github.com/ibpsa/project1-boptest/issues/787).
- Copy ``kpis.json`` from ``jm`` Docker container to test case ``/models`` directory upon compilation and update ``kpis.json`` files where necessary in repo.  This is for [#789](https://github.com/ibpsa/project1-boptest/issues/789).
- Update Spawn version to ``light-0.4.3-7048a72798``, which is used in Modelica Buildings Library v9.1.1. This is for [#782](https://github.com/ibpsa/project1-boptest/issues/782).
- Add actuator travel KPI calculation spec to design docs, method to ``kpis/kpi_calculator.py``, and signal parsing process in ``parsing/parser.py``. Requires additional updates to test cases before available for use. This is for [#639](https://github.com/ibpsa/project1-boptest/issues/639).
- Update dashboard payload from ``/submit`` request to align with weather forecast uncertainty implementation. This is for [#721](https://github.com/ibpsa/project1-boptest/issues/721).
- Add error handling to the Python examples which catches API call errors and own Python errors by reporting the error and gracefully shutting down the test case. This is for [#794](https://github.com/ibpsa/project1-boptest/issues/794).
- For the ``/results`` API, use object storage via s3/minio instead of Redis to transfer data from ``worker`` to ``web`` if the returned data package is larger than 1 MB. This is for [#732](https://github.com/ibpsa/project1-boptest/issues/732).
- Update specification of test case ``config.json`` file in the design documentation. This is for [#809](https://github.com/ibpsa/project1-boptest/issues/809).

**The following changes are not backwards compatible, but do not change benchmark results:**

- For BACnet interface, add advance command and simulation time as an available BACnet points. The BACnet point for advancing was added as the first BACnet point object and simulation time was added as the second BACnet point object for each test case by updating all ``bacnet.ttl`` files.  This is not backwards compatible for the BACnet interface for clients referencing BACnet object numbers, since the object numbers are shifted by +2. This is for [#764](https://github.com/ibpsa/project1-boptest/issues/764).

**The following new test cases have been added:**

- ``multizone_office_complex_air``, a DOE reference large office building in Chicago, IL, modeled with 3 floors and 15 zones, with each floor served by a 5-zone AHU VAV system with single-duct terminal box reheat. A water-cooled chiller plant serves chilled water to cooling coils and a gas-fired boiler plant serves hot water to heating coils. Spawn is used to model the envelope in EnergyPlus and the HVAC and controls in Modelica. The test case FMU is compiled by Dymola.  This is for [#218](https://github.com/ibpsa/project1-boptest/issues/218), [#782](https://github.com/ibpsa/project1-boptest/issues/782), and [#792](https://github.com/ibpsa/project1-boptest/issues/792).


## BOPTEST v0.8.0

Released on 06/02/2025.

**The following changes are backwards compatible and do not significantly change benchmark results:**

- For ``bestest_hydronic_heat_pump`` test case, update heat pump documentation. This is for [#704](https://github.com/ibpsa/project1-boptest/issues/704).
- For ``multizone_hydronic_simple_hydronic`` test case, enable BACnet interface to work by creating the ``bacnet.ttl``. This is for [#735](https://github.com/ibpsa/project1-boptest/issues/735).
- Remove the ``scenario`` field from the test case ``config.json``. This is for [#719](https://github.com/ibpsa/project1-boptest/issues/719).
- Update dependencies and environment of ``worker`` container.  This is for [#663](https://github.com/ibpsa/project1-boptest/issues/663).  Changes are summarized as follows:
  - Remove scipy and matplotlib dependencies from ``worker`` container.
  - Substitute scipy.integrate.trapz with numpy.trapezoid in ``kpis/kpi_calculator.py``, scipy.interp1d linear with numpy.interp, and scipy.inter1d zero with a custom zero hold interpolation in ``data/data_manager.py``.
  - Update pyfmi from 2.12 to 2.14, update numpy from 1.26.4 to 2.2.1, and update pandas from 1.5.3 to 2.2.3.
  - Update Python from 3.10 to 3.11, and miniconda version from py310_24.30-1-Linux-x86_64 to py311_24.7.1-0-Linux-x86_64.
  - Update unit tests such that ``test_kpis.py``, ``test_forecast.py``, and ``test_testcase.py`` are run in the ``worker`` container, instead of the ``jm`` container.
- Update Spawn version to ``light-0.3.0-0fa49be497``, which uses a smaller file size and is used in Modelica Buildings Library v9.1.0.  This is for [#718](https://github.com/ibpsa/project1-boptest/issues/718).
- Add weather forecast uncertainty as new scenario options for dry bulb temperature and global horizontal irradiation.  The corresponding new scenario keys are ``temperature_uncertainty`` and ``solar_uncertainty``, which can take values ``None`` (default), ``'low'``, ``'medium'``, or ``'high'``.  A new scenario key ``seed`` is also added to set an integer seed for reproducible uncertainty generation.  The uncertainty models are based on [Zheng et al. (2025)](https://doi.org/10.1080/19401493.2025.2453537). This is for [#135](https://github.com/ibpsa/project1-boptest/issues/135).
- Add status flags properties to bacnet objects for all ``bacnet.ttl`` files. This is for [#762](https://github.com/ibpsa/project1-boptest/issues/762).
- Add support to ``parsing/parser.py`` for test case compilation using Dymola.  The parser can take argument ``tool='Dymola'``.  A user of the parser choosing Dymola requires access to a Dymola license with binary model export capability.  This is for [#755](https://github.com/ibpsa/project1-boptest/issues/755).
- Tag version for ``minio/minio`` and ``minio/mc`` docker images.  This is for [#769](https://github.com/ibpsa/project1-boptest/issues/769).

**The following changes are backwards compatible, but may change benchmark results:**

- For ``multizone_office_simple_hydronic`` test case, correct occupancy count .csv file within the resource directory of the test case FMU.  This will change the forecast of occupancy count provided to a test controller.  This is for [#726](https://github.com/ibpsa/project1-boptest/issues/726).

**The following changes are not backwards compatible, but do not change benchmark results:**

- Written and clarified ``testcase1`` and ``testcase3`` documentation. This is for [#582](https://github.com/ibpsa/project1-boptest/issues/582).
  - For ``testcase1``, changed naming of ``PHea`` to ``PHeaCoo`` for clarity regarding allowed heating and cooling regimes.
  - Similarly for ``testcase3``, changed ``PHeaNor`` and ``PHeaSou`` to ``PHeaCooNor`` and ``PHeaCooSou`` respectively.

**The following changes are not backwards-compatible and significantly change benchmark results:**

- Update ``singlezone_commercial_hydronic`` test case according to changes made for the Adrenalin competition and various issues. This is for [#702](https://github.com/ibpsa/project1-boptest/issues/702),
[#635](https://github.com/ibpsa/project1-boptest/issues/635),
[#432](https://github.com/ibpsa/project1-boptest/issues/432), and
[#733](https://github.com/ibpsa/project1-boptest/issues/733).
The changes are summarized as follows:
  - Hydronic system:
    - Added piping segments in hydronic system to increase thermal delay
    -	Resized valves and switched to two-way valves
    -	Switched to pressure driven pump in hydronic system
    -	Switched DH heat exchanger from constant effectiveness to plate HX model
  -	Ventilation:
    -	Added internal control of rotary heat exchanger
    -	Linked control of supply and extract fan for baseline controller
  -	Occupancy profile:
    -	Fixed missing data that resulted in day of week mismatch
  - Control I/O:
    - Changes to input and measurement names
    - Added new measurement points
  - Scenario changes for time periods
    - Peak Heat Day now centered around day 42
    - Typical Heat Day now centered around day 308

  Impacts on KPIs calculated compared to v0.7.1 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+3.26%  |
  |emis_tot               |+3.16%  |
  |tdis_tot               |-98.5%  |
  |idis_tot               |-99.5%  |
  |pele_tot               |-37.2%  |
  |pdih_tot               |-60.5%  |
  |cost_tot_constant      |+3.32%  |
  |cost_tot_dynamic       |+3.26%  |
  |cost_tot_highly_dynamic|+3.16%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+8.01%  |
  |emis_tot               |-2.86%  |
  |tdis_tot               |-99.8%  |
  |idis_tot               |-100%   |
  |pele_tot               |-12.7%  |
  |pdih_tot               |-59.0%  |
  |cost_tot_constant      |+16.6%  |
  |cost_tot_dynamic       |+15.3%  |
  |cost_tot_highly_dynamic|+14.6%  |


## BOPTEST v0.7.1

Released on 01/21/2025.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Add note to ``README.md`` about using environment variable ``BOPTEST_TIMEOUT`` to edit the timeout period for idle workers.  This is for [#715](https://github.com/ibpsa/project1-boptest/issues/715).
- Add note to ``README.md`` about a Julia interface implemented by [BOPTestAPI.jl](https://terion-io.github.io/BOPTestAPI.jl/stable/).  This is for [#707](https://github.com/ibpsa/project1-boptest/issues/707).
- Add github actions to build docker images for web and worker and post them as packages in the ibpsa repository.  This is for [#712](https://github.com/ibpsa/project1-boptest/issues/712).


## BOPTEST v0.7.0

Released on 11/25/2024.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Update pyfmi version from 2.11 to 2.12 and miniconda version from py310_23.1.0-1-Linux-x86_64 to py310_24.3.0-0-Linux-x86_64. This is for [#643](https://github.com/ibpsa/project1-boptest/issues/643).
- Remove support and unit testing of example python controllers using Python 2. This is for [#634](https://github.com/ibpsa/project1-boptest/issues/634).
- Add a warning message upon test case compilation in ``data/data_manager.py`` that is displayed if any of the weather variables in ``data/categories.json`` is not in ``<testcase_folder>/resources/weather.csv``. This is for [#500](https://github.com/ibpsa/project1-boptest/issues/500).
- Remove matplotlib requirement from travis unit testing. This is for [#655](https://github.com/ibpsa/project1-boptest/issues/655).
- Specify version of scipy to 1.13.0 in test case Dockerfile.  This is for [#657](https://github.com/ibpsa/project1-boptest/issues/657).
- Remove javascript controller example.  This is for [#664](https://github.com/ibpsa/project1-boptest/issues/664).
- Add a new directory ``/baselines``, containing baseline testing scripts and associated KPI results for the baseline controllers of all the testcases. This is for [#495](https://github.com/ibpsa/project1-boptest/issues/495).
- Add support to ``parsing/parser.py`` for test case compilation using [Modelon's OPTIMICA Compiler Toolkit (OCT)](https://help.modelon.com/latest/reference/oct/).  The parser can take arguments ``'JModelica'`` or ``'OCT'``, with ``'JModelica'`` as default.  A user still requires access to an OCT license and software on their set up.  This is for [#675](https://github.com/ibpsa/project1-boptest/issues/675).
- Changed ``bestest_hydronic`` and ``bestest_hydronic_heat_pump`` Modelica implementations in this repository to utilize the Modelica IDEAS Library as a dependency for component models, instead of serving as extensions from the Modelica IDEAS Library.  This is to simplify dependencies for maintaining the models, and is how other test cases are implemented.  It required duplication of the model implementations from the Modelica IDEAS Library into this repository.  This is for [#680](https://github.com/ibpsa/project1-boptest/issues/680).
- Add ``activate`` control inputs that were missing in ``bestest_hydronic`` and ``bestest_hydronic_heat_pump`` Modelica documentation.  This is for [#625](https://github.com/ibpsa/project1-boptest/issues/625).
- Updated ``examples/python/interface.py`` to print correct simulation time step, this is for [#686](https://github.com/ibpsa/project1-boptest/issues/686). Also removed clutter by printed custom KPI results, which is for [#692](https://github.com/ibpsa/project1-boptest/issues/692).

**The following new test cases have been added:**

- ``multizone_office_simple_hydronic``, a 2-zone typical office building in Brussels, Belgium, served by fan-coil units for space heating and cooling, air handling units for space ventilation, an air-source heat pump for hot water production, and an air-cooled chiller for chilled water production. FMU compiled by [OCT](https://help.modelon.com/latest/reference/oct/).  This is for [#465](https://github.com/ibpsa/project1-boptest/issues/465).

**The following changes are backwards-compatible, but might change benchmark results:**

- Fix calculation of computational time ratio (``time_rat``) in the case of a test where the test case was initialized after a test or simulation (use of ``/advance``) had already been done using the same test case deployment (i.e. the docker container had not been shutdown first and newly deployed).  The wait time between the last ``/advance`` before the new initialization and first ``/advance`` of the new initialization was incorrectly incorporated into the calculation as a control step and has been fixed, resulting in a lower computational time ratio.  The extent of impact depends on wait time between tests and control step and number of steps taken in the new test.  This is for [#673](https://github.com/ibpsa/project1-boptest/issues/673).
 - Update ``min`` and ``max`` parameters for heating (``oveTSetHea_u``) and cooling (``oveTSetCoo_u``) setpoints in ``bestest_air`` and ``bestest_hydronic`` test cases to ``min=278.15`` and ``max=308.15``.  This may change benchmark results as it expands the allowable min and max set points for these test cases from previous versions.  This is for [#658](https://github.com/ibpsa/project1-boptest/issues/658).

**The following changes are not backwards-compatible, but do not change benchmark results:**

> [!IMPORTANT]
> - Refactor the deployment architecture so as to migrate [BOPTEST-Service](https://github.com/NREL/boptest-service) code to the BOPTEST repository and make it the only deployment architecture for BOPTEST.  This is for [#617](https://github.com/ibpsa/project1-boptest/issues/617). Notable changes are for those who deploy and use BOPTEST locally, and they include:
>   - To use BOPTEST locally, users now deploy the web-service locally and select a test case to run using the appropriate API request.
>   - Users can run multiple test cases at the same time.
>   - The API requests to interact with a running test case now require the use of a ``testid``, which is received when selecting a test case and is used to uniquely route API requests the intended test case.
>   - Users can stop a test case with the appropriate API request without shutting down the web-service as a whole.  This is especially needed if a user wants to run a new test case, but has not allocated enough workers (command option when starting deploying web-service).

**The following changes are not backwards-compatible and significantly change benchmark results:**

- Update ``multizone_residential_hydronic`` test case overwrite input ``oveTSetPum`` to ``oveTSetPumBoi`` so that this set point change will control thermostat activating both the boiler and the circulation pump. Furthermore, pump control logic is changed from PI following error on set point to on/off depending on thermostat control signal. Lastly, a safety on boiler control is added, allowing it to turn on only if there is flow through the boiler. This safety is bypassed if controlling the boiler directly via ``boi_oveBoi_u``. This is for [#653](https://github.com/ibpsa/project1-boptest/issues/653) and [#660](https://github.com/ibpsa/project1-boptest/issues/660).  Impacts on KPIs calculated compared to v0.6.0 for indicated scenarios are as follows:

  Peak Heat Day
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+1.27%  |
  |emis_tot               |+0.47%  |
  |tdis_tot               |-2.70%  |
  |cost_tot_constant      |+2.78%  |
  |cost_tot_dynamic       |+2.96%  |
  |cost_tot_highly_dynamic|+2.26%  |

  Typical Heat Day
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot	              |+0.98%  |
  |emis_tot	              |+0.47%  |
  |tdis_tot	              |+3.58%  |
  |cost_tot_constant	  |+1.94%  |
  |cost_tot_dynamic	      |+2.06%  |
  |cost_tot_highly_dynamic|+1.59%  |


## BOPTEST v0.6.0

Released on 04/03/2024.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Add materials for RLEM23 workshop at ``docs/workshops/RlemWorkshop_20231112``. This is for [#585](https://github.com/ibpsa/project1-boptest/issues/585).
- Change JModelica docker container address  in ``testing/Dockerfile``. This is for [#590](https://github.com/ibpsa/project1-boptest/issues/590).
- Specify the Python version (3.7) used for building the wrapper to execute the example JavaScript controllers in the unit test. This is for [#594](https://github.com/ibpsa/project1-boptest/issues/594).
- Allow simulations and forecast to work across the end of the year to the next year. This is for [#239](https://github.com/ibpsa/project1-boptest/issues/239).
- Pin base Docker image to ``linux/x86_64`` platform. This is for [#608](https://github.com/ibpsa/project1-boptest/issues/608).
- Correct typo in design documentation about connecting inputs to overwrite blocks in wrapper model. This is for [#601](https://github.com/ibpsa/project1-boptest/issues/601).
- Add Git LFS configuration in the ``testing/Dockerfile`` image used in tests and compilation. This is for [#613](https://github.com/ibpsa/project1-boptest/issues/613).
- Correct typo in documentation for ``multizone_office_simple_air``, cooling setback temperature changed from 12 to 30. This is for [#605](https://github.com/ibpsa/project1-boptest/issues/605).
- Modify unit tests for test case scenarios to only simulate two days after warmup instead of the whole two-week scenario. This is for [#576](https://github.com/ibpsa/project1-boptest/issues/576).
- Fix unit tests for possible false passes in certain test cases. This is for [#620](https://github.com/ibpsa/project1-boptest/issues/620).
- Add ``activate`` control inputs to all test case documentation and update ``get_html_IO.py`` to print one file with all inputs, outputs, and forecasts. This is for [#555](https://github.com/ibpsa/project1-boptest/issues/555).
- Add storing of scenario result trajectories, kpis, and test information to simulation directory within test case docker container. This is for [#626](https://github.com/ibpsa/project1-boptest/issues/626).


## BOPTEST v0.5.0

Released on 10/04/2023.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Add materials for BS2023 workshop at ``docs/workshops/BS23Workshop_20230904``. This is for [#552](https://github.com/ibpsa/project1-boptest/issues/552).
- Allow forecast horizons of 0 to retrieve boundary condition data at current time like pricing or temperature setpoints. This is for [#554](https://github.com/ibpsa/project1-boptest/issues/554).
- Update ``docs/tutorials/tutorial1_developer`` and ``docs/workshops/BS21Workshop_20210831``.  This is for [#532](https://github.com/ibpsa/project1-boptest/issues/532).
- In examples and unit test Python requests, use ``json`` attribute instead of ``data``.  This is for [#528](https://github.com/ibpsa/project1-boptest/issues/528).
- In unit test checking fetching of single forecast variable, specify specific forecast point to check for each test case.  This is for [#529](https://github.com/ibpsa/project1-boptest/issues/529).
- Update ``KPI_Calculator.get_computational_time_ratio`` to return ``None`` if no simulation steps have been processed. This is for [#540](https://github.com/ibpsa/project1-boptest/issues/540).
- Add ``forecastParameters`` to dashboard submission with empty dictionary and update url for submitting dashboard results.  This is for [#548](https://github.com/ibpsa/project1-boptest/issues/548).
- Fix so that results can be submitted to dashboard if sitting at end of scenario time period instead of needing to try to advance one step past.  This is for [#546](https://github.com/ibpsa/project1-boptest/issues/546).
- Fix for just-in-time adding example python controller scripts to PYTHONPATH.  This is for [#565](https://github.com/ibpsa/project1-boptest/issues/565).
- Add an interface for interacting with a test case through BACnet.  See new directory ``bacnet``.  This is for [#547](https://github.com/ibpsa/project1-boptest/issues/547).
- Update Flask API argument type for overwrite values in the ``/advance`` request to be float to prevent truncation.  This is for [#577](https://github.com/ibpsa/project1-boptest/issues/577).

**The following changes are backwards-compatible, but might change benchmark results:**

- Fix check on control input overwrite in ``testcase.TestCase.advance`` when overwriting a value of 0. This will change results if using BOPTEST-Service and delivering control input overwrites, with value of 0, in an /advance request using the ``json`` attribute with the python requests library.  This is for [#533](https://github.com/ibpsa/project1-boptest/issues/533).

**The following changes are not backwards-compatible, but do not significantly change benchmark results:**

- Update BOPTEST test case Docker container to use Python 3.10, pyfmi 2.11, and co-simulation FMUs.  Also convert all test case FMUs to co-simulation. This is for [#146](https://github.com/ibpsa/project1-boptest/issues/146).
  - Non-backwards compatible due to stricter check by Flask REST API to require content as application/json.  If using Python ``requests``, use the ``json`` parameter instead of ``data``.
  - Tends to slightly speed up simulation time for simpler, single-zone models, while more significantly slowing simulation time for more complex, multi-zone models.  Refer to [this comment](https://github.com/ibpsa/project1-boptest/pull/536#issuecomment-1585183094) for some benchmarking.


## BOPTEST v0.4.0

Released on 03/21/2023.

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
