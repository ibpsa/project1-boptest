# Release Notes for Test Cases for v1.0.0

These notes summarize specific changes to test case models from BOPTEST v0.9.0 to v1.0.0, as referred to in the ``releasenotes.md`` in the root of the repository and not including general updates made to all test cases as described there (e.g. updates to library versions, compilation tools, and environment of the ``worker`` container).

## BESTEST Air
### Model Changes
- Updated fan coil to use ``Buildings.Fluid.Movers.Preconfigured``.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Mix Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Peak Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## BESTEST Hydronic

### Model Changes
- Use a newly created local mover component for the circulation pump ``BaseClasses/FlowControlled_dp.mo``, which wraps ``IDEAS.Fluid.Movers.FlowControlled_dp`` with the same parameters used in ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` but maintains the stage input, as ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` only supports real input in Building v12.1.0.
- Updated weather file to ``BEL_VLG_Uccle.064470_TMYx.2007_2021.mos`` to reflect changes in IDEAS. Updated ``weather.csv`` and scenario days in ``days.json`` to reflect change in weather file.
- Fixed the ``energyDynamics`` parameter on the heat pump to use ``Modelica.Fluid.Types.Dynamics.DynamicFreeInitial``.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## BESTEST Hydronic Heat Pump

### Model Changes
- Use a newly created local mover component for the circulation pump ``BaseClasses/FlowControlled_dp.mo``, which wraps ``IDEAS.Fluid.Movers.FlowControlled_dp`` with the same parameters used in ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` but maintains the stage input, as ``Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp`` only supports real input in Building v12.1.0.
- Updated weather file to ``BEL_VLG_Uccle.064470_TMYx.2007_2021.mos`` to reflect changes in IDEAS. Updated ``weather.csv`` and scenario days in ``days.json`` to reflect change in weather file.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Single Zone Commercial Hydronic

### Model Changes
- Updated fans and pumps to use ``Buildings.Fluid.Movers.Preconfigured`` where existing performance curves were problematic or not representative.
- Tuned ``AirHandlingUnit.mo`` PI controller to reduce oscillations.
- Combine pressure drops across different equipment in the same hydronic loop into fewer components and increase buffer volume size to increase numerical stability.
- Copied ``occ.txt`` resource file into the test case's Modelica package directory and updated the path reference to load the file from this location in ``RealOccupancy.mo``.
- Updated weather file path to test case Modelica path instead of relative path to external resource.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Two Zone Apartment Hydronic

### Model Changes
- Updated documentation to correct material property typos.  This is for [#806](https://github.com/ibpsa/project1-boptest/issues/806).
- Added ``dayZon_reaTRooOpe_y`` and ``nigZon_reaTRooOpe_y`` outputs to expose the operative temperature of the zones.  This is for [#791](https://github.com/ibpsa/project1-boptest/issues/791)
- Updated occupancy profiles and set back temperature (using 16°C) in thermostat models and associated ``.csv`` files in the test case's ``Resources`` directory. This is for [#539](https://github.com/ibpsa/project1-boptest/issues/539).
- Corrected infiltration airflow in the model to the value specified in the documentation, reducing the model value by about half.
- Updated pumps to use ``Buildings.Fluid.Movers.Preconfigured``.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Multizone Residential Hydronic

### Model Changes
- Reduce number of elements in radiators from 5 to 3 to increase numerical stability.
- Changed feedback controllers from Modelica ``Buildings.Controls.Continuous.LimPID`` to CDL ``Buildings.Controls.OBC.CDL.Reals.PID``.
- Updated pumps to use ``Buildings.Fluid.Movers.Preconfigured``.
- Fixed building dimensions and updated documentation. This is for [#834](https://github.com/ibpsa/project1-boptest/issues/834).

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Multizone Office Simple Air

### Model Changes
- Replaced Modelica control blocks with CDL blocks in ``ASHRAE2006.mo``, like ``Buildings.Controls.OBC.CDL.Reals.Switch``, ``Buildings.Controls.OBC.CDL.Reals.Sources.Constant``, ``Buildings.Controls.OBC.CDL.Reals.MultiMin``, and ``Buildings.Controls.OBC.CDL.Reals.Hysteresis``.
- Removed the customized ``Economizer.mo`` model entirely.
- Updated fans and pumps in ``AirCooledChiller.mo``, ``AirToWaterHeatPump.mo``, and ``PartialHVAC.mo`` to use ``Buildings.Fluid.Movers.Preconfigured``.
- Updated connections and StateGraph transitions in ``ModeSelector.mo``.
- Updated damper models and default control in VAV boxes to reflect updates in the Buildings library in the ``Buildings.Examples.VAVReheat.ASHRAE2006`` model. This also fixes [#612](https://github.com/ibpsa/project1-boptest/issues/612).

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Mix Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Peak Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Multizone Office Simple Hydronic

### Model Changes
- Update ``Ideal_Production.mo`` to instantiate ``TSetIn`` as a ``Real`` to avoid compilation error in Dymola.

### KPI Changes
Changes in baseline KPIs compared to v0.9.0 for indicated scenarios are as follows:

  **Peak Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Heat Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Mix Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Typical Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |-x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |

  **Peak Cool Day**
  |KPI                    |% Change|
  |-----------------------|--------|
  |ener_tot               |+x.xx%  |
  |emis_tot               |+x.xx%  |
  |tdis_tot               |-x.xx%  |
  |idis_tot               |-x.xx%  |
  |pele_tot               |-x.xx%  |
  |pdih_tot               |-x.xx%  |
  |cost_tot_constant      |+x.xx%  |
  |cost_tot_dynamic       |+x.xx%  |
  |cost_tot_highly_dynamic|+x.xx%  |


## Multizone Office Air Complex

### Model Changes
No additional changes.

### KPI Changes
No changes.


## Testcase 1

### Model Changes
- Added ``displayUnit="ppm"`` to the ``CO2RooAir`` signal exchange read block.

### KPI Changes
Not applicable.


## Testcase 2

### Model Changes
- Changed weather file reader to reference the weather file path from the Modelica Buildings Library.

### KPI Changes
Not applicable.


## Testcase 3

### Model Changes
No additional changes.

### KPI Changes
Not applicable.
