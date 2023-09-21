---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_singlezone_commercial_hydronic/
---

# Test Case Name
``singlezone_commercial_hydronic``

# Brief Description
A single-zone representation of a university building with floor area of 8,500 m<sup>2</sup>
and peak occupancy of 1,350 people.  The location is Copenhagen, Denmark.
Occupancy in the building is modeled from real building occupancy measurements.

The single zone is served by a radiator for space heating served by
a district heating source.  Additionally, a single AHU with heating coil
and heat recovery provides outside air for ventilation.  The fan
is controlled based on zone CO2 measurements and the heating coil
is also served by the district heating source.

[Click here](/docs-testcases/singlezone_commercial_hydronic/index.html) to view detailed documentation.

# Available Test Scenarios
### Time Periods
``peak_heat_day``
``typical_heat_day``

### Electricity Prices
``constant``
``dynamic``
``highly_dynamic``
