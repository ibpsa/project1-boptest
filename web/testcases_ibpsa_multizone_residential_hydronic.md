---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_multizone_residential_hydronic/
---

# Test Case Name
``multizone_residential_hydronic``

# Brief Description
The emulator building represents a residential French dwelling
compliant with the French Thermal regulation of 2012, i.e. the French
national building energy regulation.  The location is Bordeaux, France.
Therefore, the typology is defined to be representative of French new dwellings. The total floor area of
six conditioned zones is 81.08 m^2. There are also two unconditioned zones
(an attic and attached garage).

Each zone has its own radiator equipped with a thermostatic valve that is
uses a PI controller to modulate water flow through the radiator in order
to maintain the zone heating set point.  The water through the heating
emission system is heated by a gas boiler.  Domestic hot water is not included.

[Click here](/docs-testcases/multizone_residential_hydronic/index.html) to view detailed documentation.

# Available Test Scenarios
### Time Periods
``peak_heat_day``
``typical_heat_day``

### Electricity Prices
``constant``
``dynamic``
``highly_dynamic``
