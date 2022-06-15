---
layout: page
title: Test Cases
subtitle: Ready-made building emulators
hero_height: is-fullwidth
show_sidebar: false
menubar: testcases_menubar
permalink: /testcases/ibpsa/testcases_ibpsa_multizone_office_complex_air/
---


<h1><span style="color:grey">Test Case Name</span></h1>
``multizone_office_complex_air``

<h1><span style="color:grey">Brief Description</span></h1>
<span style="color:grey">
This test case represents a variable air volume (VAV) system that serves a
typical high-rise office building (46,320 m<sup>2</sup>). The building is
based on the U.S. DOE prototype building for a large commercial building
and has 12 floors with five zones per floor. The VAV system contains 12 AHUs.
Each AHU serves one floor and is connected to five VAV terminal boxes. Each
AHU consists of a supply fan, a return fan, a cooling coil, and a mixing box.
Each VAV terminal box serves one zone, adjusting the supply air flow rate via
a damper and heating the supply air with a water-based reheat
coil and modulating valve. The reheat coils are served by a boiler, while the
cooling coils are served by three identical chillers.
</span>

<span style="color:grey">
When implementing this higher-fidelity building model, we employ both
EnergyPlus and Modelica Buildings Library. Specifically, we modeled the
building envelope and internal heat gain with EnergyPlus and modeled
the VAV system and its associated control with Modelica Buildings Library.
The data exchange between the EnergyPlus model and the Modelica model is
realized via Spawn-of-EnergyPlus.
</span>
<h1><span style="color:grey">(Under Development)</span></h1>
