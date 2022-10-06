---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_twozone_apartment_hydronic/
---

# Test Case Name
``twozone_apartment_hydronic``

# Brief Description
The test case is a two-room with one bathroom apartment in Milan, Italy. The floor
area is 44.5 m<sup>2</sup> and the apartment is well-insulated with an external
transmittance equal to 0.46 W/m<sup>2</sup>K. The external facing façade is South-East
oriented with a total window area of 8 m<sup>2</sup>. The apartment is occupied by one
person considered as a worker.

The heating system consists of two floor radiant heating circuits, one for
each room. The heat is supplied by a 5 kW air source heat pump. The embedded control
is such that each thermal
zone has its own thermostat and is controlled independently. The pump works
to provide a constant head, tuned to provide each floor heating circuit their
respective design water mass flow rate when the circuit valve is open.
The heat pump supply water temperature set point is calculated via a climatic
curve that depends on the external temperature.

[Click here](/docs-testcases/twozone_apartment_hydronic/index.html) to view detailed documentation.

# Available Test Scenarios
### Time Periods
``peak_heat_day``
``typical_heat_day``
### Electricity Prices
``constant``
``dynamic``
``highly_dynamic``
