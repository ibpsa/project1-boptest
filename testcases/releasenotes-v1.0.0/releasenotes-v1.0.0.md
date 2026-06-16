# Release Notes for Test Cases for v1.0.0

These notes summarize specific changes to test case models from BOPTEST v0.9.0 to v1.0.0, as referred to in the ``releasenotes.md`` in the root of the repository and not including general updates made to all test cases as described there (e.g. updates to library versions, compilation tools, and environment of the ``worker`` container).

## Baseline KPI Changes
For changes in KPIs from embedded baseline controllers from v0.9.0 to v1.0.0 for each test case, time period scenario, and electricity price scenario, see [kpis-v1.0.0.html](kpis-v1.0.0.html).

## Model Changes

### bestest_air
- Updated fan coil to use ``Buildings.Fluid.Movers.Preconfigured``.
- Time period scenario days changed for ``peak_heat_day``, ``typical_heat_day``, ``typical_cool_day``, and ``mix_day``.


### bestest_hydronic
- Use a newly created local mover component for the circulation pump ``BaseClasses/FlowControlled_dp.mo``, which wraps ``IDEAS.Fluid.Movers.FlowControlled_dp`` with the same parameters used in ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` but maintains the stage input, as ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` only supports real input in Building v12.1.0.
- Updated weather file to ``BEL_VLG_Uccle.064470_TMYx.2007_2021.mos`` to reflect changes in IDEAS. Updated ``weather.csv`` to reflect change in weather file.
- Fixed the ``energyDynamics`` parameter on the heat pump to use ``Modelica.Fluid.Types.Dynamics.DynamicFreeInitial``.
- Time period scenario days changed for ``peak_heat_day`` and ``typical_heat_day``.


### bestest_hydronic_heat_pump
- Use a newly created local mover component for the circulation pump ``BaseClasses/FlowControlled_dp.mo``, which wraps ``IDEAS.Fluid.Movers.FlowControlled_dp`` with the same parameters used in ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` but maintains the stage input, as ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` only supports real input in Building v12.1.0.
- Updated weather file to ``BEL_VLG_Uccle.064470_TMYx.2007_2021.mos`` to reflect changes in IDEAS. Updated ``weather.csv`` to reflect change in weather file.
- Time period scenario days changed for ``peak_heat_day`` and ``typical_heat_day``.


### singlezone_commercial_hydronic
- Updated fans and pumps to use ``Buildings.Fluid.Movers.Preconfigured`` where existing performance curves were problematic or not representative.
- Tuned ``AirHandlingUnit.mo`` PI controller to reduce oscillations.
- Combine pressure drops across different equipment in the same hydronic loop into fewer components and increase buffer volume size to increase numerical stability.
- Copied ``occ.txt`` resource file into the test case's Modelica package directory and updated the path reference to load the file from this location in ``RealOccupancy.mo``.
- Updated weather file path to test case Modelica path instead of relative path to external resource.
- Time period scenario days changed for ``typical_heat_day``.


### twozone_apartment_hydronic
- Added ``dayZon_reaTRooOpe_y`` and ``nigZon_reaTRooOpe_y`` outputs to expose the operative temperature of the zones.  Update BACnet interface points accordingly.  This is for [#791](https://github.com/ibpsa/project1-boptest/issues/791).
- Calculate thermal discomfort KPI based on operative instead of air temperature. This is for [#791](https://github.com/ibpsa/project1-boptest/issues/791).
- Updated occupancy profiles and set back temperature (using 17°C) in thermostat models and associated ``.csv`` files in the test case's ``Resources`` directory. This is for [#539](https://github.com/ibpsa/project1-boptest/issues/539).
- Corrected infiltration airflow in the model to the value specified in the documentation, reducing the model value by about half.
- Updated pumps to use ``Buildings.Fluid.Movers.Preconfigured``.
- Updated documentation to correct material property typos.  This is for [#806](https://github.com/ibpsa/project1-boptest/issues/806).
- Time period scenario days changed for ``peak_heat_day`` and ``typical_heat_day``.


### multizone_residential_hydronic
- Reduce number of elements in radiators from 5 to 3 to increase numerical stability.
- Changed feedback controllers from Modelica ``Buildings.Controls.Continuous.LimPID`` to CDL ``Buildings.Controls.OBC.CDL.Reals.PID``.
- Updated pumps to use ``Buildings.Fluid.Movers.Preconfigured``.
- Fixed building dimensions and updated documentation. This is for [#834](https://github.com/ibpsa/project1-boptest/issues/834).
- Time period scenario days changed for ``peak_heat_day`` and ``typical_heat_day``.


### multizone_office_simple_air
- Replaced Modelica control blocks with CDL blocks in ``ASHRAE2006.mo``, like ``Buildings.Controls.OBC.CDL.Reals.Switch``, ``Buildings.Controls.OBC.CDL.Reals.Sources.Constant``, ``Buildings.Controls.OBC.CDL.Reals.MultiMin``, and ``Buildings.Controls.OBC.CDL.Reals.Hysteresis``.
- Removed the customized ``Economizer.mo`` model entirely.
- Updated fans and pumps in ``AirCooledChiller.mo``, ``AirToWaterHeatPump.mo``, and ``PartialHVAC.mo`` to use ``Buildings.Fluid.Movers.Preconfigured``.
- Updated connections and StateGraph transitions in ``ModeSelector.mo``.
- Updated damper models and default control in VAV boxes to reflect updates in the Buildings library in the ``Buildings.Examples.VAVReheat.ASHRAE2006`` model. This also fixes [#612](https://github.com/ibpsa/project1-boptest/issues/612).
- Time period scenario days changed for ``peak_heat_day``, ``typical_heat_day``, and ``typical_cool_day``.


### multizone_office_simple_hydronic
- Update ``Ideal_Production.mo`` to instantiate ``TSetIn`` as a ``Real`` to avoid compilation error in Dymola.


### multizone_office_complex_air
- Relocate the supply air temperature measurement from cooling coil outlet to supply fan outlet.  This is for [#842](https://github.com/ibpsa/project1-boptest/issues/842).


### testcase1
- Added ``displayUnit="ppm"`` to the ``CO2RooAir`` signal exchange read block.


### testcase2
- Changed weather file reader to reference the weather file path from the Modelica Buildings Library.


### testcase3
- No additional changes.
