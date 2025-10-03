---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_multizone_office_complex_air/
---

# Test Case Name
``multizone_office_complex_air``

# Brief Description
This test case represents a typical high-rise office building with variable air volume (VAV) systems, chiller plant,
and boiler plant.
The test case is located in Chicago, IL and based on the DOE Reference
Large Office Building Model (Constructed In or After 1980).
The original model has 12 floors with a basement. For simplicity, the middle 10
floors are treated as identical and are modeled as a single representative floor,
resulting in three modeled floors (ground, middle, and top), each served by a dedicated AHU
and associated VAV system.
Each AHU consists of a supply fan, a return fan, a cooling coil, a mixing box, and a freeze protection coil.
Each VAV terminal box serves one zone, adjusting the supply air flow rate via
a damper and heating the supply air with a water-based reheat
coil and modulating valve. The reheat coils are served by a boiler plant, while the
cooling coils are served by a water-cooled chiller plant with three identical chillers.

The building envelope and internal heat gains are modeled with EnergyPlus and
the HVAC system and its associated controls are modeled with the Modelica Buildings Library.
The data exchange between the EnergyPlus model and the Modelica model is
realized via Spawn of EnergyPlus.

[Click here](/docs-testcases/multizone_office_complex_air/index.html) to view detailed documentation.

# Available Test Scenarios
### Time Periods
``peak_heat_day``
``typical_heat_day``
``peak_cool_day``
``typical_cool_day``
``mix_day``
### Electricity Prices
``constant``
``dynamic``
``highly_dynamic``

# Dependencies
The Modelica model for this test case uses the [Modelica Standard Library](https://github.com/modelica/ModelicaStandardLibrary) and the [Modelica Buildings Library](https://simulationresearch.lbl.gov/modelica/index.html), as well as [Spawn of EnergyPlus](https://doi.org/10.1080/19401493.2023.2266414).

The FMU for this test case is compiled by [Dymola](https://www.3ds.com/products/catia/dymola) with binary model export.
