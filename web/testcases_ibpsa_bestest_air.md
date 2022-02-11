---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_bestest_air/
---

# Test Case Name
``bestest_air``

# Description
The building is a single room based on the BESTEST Case 900 model definition,
located near Denver, CO, USA.  The floor area is 48 m^2.
There are four exterior walls facing the cardinal directions and a flat roof.
The south wall containstwo windows.  The usage is a two-person office with a light load density.

Heating and cooling is provided to the office using an idealized four-pipe
fan coil unit (FCU).
The FCU contains a fan, cooling coil, heating coil,
and filter.  The fan draws room air into the unit, blows it over the coils
and through the filter, and supplies the conditioned air back to the room.
There is a variable speed drive serving the fan motor.  The cooling coil
is served by chilled water produced by a chiller and the heating coil is
served by hot water produced by a gas boiler.  The central plant is not
explicitly modeled.

[Click here](/docs-testcases/bestest_air/index.html) to view detailed documentation.

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
