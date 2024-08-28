---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_bestest_hydronic_heat_pump/
---

# Test Case Name
``bestest_hydronic_heat_pump``

# Brief Description
This model represents a simplified residential dwelling for a family of 5
members, modeled as a single thermal zone, located in Brussels, Belgium.
The building envelope model is based on the BESTEST case 900 test case.
but it is scaled to an area that is four times larger. The rectangular floor
plan is 12 m by 16 m.  Internal walls are configured such that there are
around 12 rooms in the building.  The builiding further contains 24 m<sup>2</sup> of
windows on the south facade.

An air-to-water modulating heat pump of 15 kW nominal heating capacity
extracts energy from the ambient air to heat up the floor heating emission
system. A fan blows ambient air through the heat
pump evaporator and circulation pump pumps water from the heat pump to the
floorr when the heat pump is operating.

[Click here](/docs-testcases/bestest_hydronic_heat_pump/index.html) to view detailed documentation.

# Available Test Scenarios
### Time Periods
``peak_heat_day``
``typical_heat_day``

### Electricity Prices
``constant``
``dynamic``
``highly_dynamic``

# Dependencies
The Modelica model for this test case uses the [Modelica Standard Library](https://github.com/modelica/ModelicaStandardLibrary) and the [Modelica IDEAS Library](https://github.com/open-ideas/IDEAS).

The FMU for this test case is compiled by the open-source [JModelica.org](https://jmodelica.org/).
