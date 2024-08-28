---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_multizone_office_simple_hydronic/
---

# Test Case Name
``multizone_office_simple_hydronic``

# Brief Description
The test case represents an office HVAC system with two zones in Belgium.
The building represented is a rectangular building
of 40x25 m and 15 m of height, including five floors each 3 m high.
Hence, the total floor area to be conditioned is 5000 m<sup>2</sup>.
For modeling, the building is divided in two zones of equal floor area,
with their main facades oriented towards north (NZ) and south (SZ) respectively,
and with five internal floors included for thermal mass.
Each zone has a window-to-wall ratio of 50%.

Each zone is equipped with independent air handling units (AHUs) for ventilation
and fan-coil units (also known as ventiloconvectors) for space heating and cooling.
Heating water is produced by an air-source heat pump and chilled water is produced by an air-cooled chiller.

[Click here](/docs-testcases/multizone_office_simple_hydronic/index.html) to view detailed documentation.

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
The Modelica model for this test case uses the [Modelica Standard Library](https://github.com/modelica/ModelicaStandardLibrary), [Modelica Buildings Library](https://simulationresearch.lbl.gov/modelica/index.html), and [Modelica IDEAS Library](https://github.com/open-ideas/IDEAS).

The FMU for this test case is compiled by [Modelon's OPTIMICA Compiler Toolkit (OCT)](https://help.modelon.com/latest/reference/oct/).
