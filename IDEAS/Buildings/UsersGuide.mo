within IDEAS.Buildings;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;

annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
The main goal of the IDEAS Buildings library is to set up models that allow simulating
building envelope models. These models may be coupled to
models from the Fluid or Electric packages.
In this user guide we outline the main principles of the library. 
</p>
<h4>Model physics</h4>
<p>
The main physical principles that are modelled in IDEAS are 
</p>
<ul>
<li>
interior and exterior convection, 
</li>
<li>
interior and exterior longwave radiation, 
</li>
<li>
interior and exterior shortwave radiation,
</li>
<li>
thermal conduction through surfaces,
</li>
<li>
window shading,
</li>
<li>
infiltration of air.
</li>
</ul>
<p>
Furthermore models for specifying additional boundary conditions are
</p>
<ul>
<li>
occupancy model for computing internal gains,
</li>
<li>
comfort model for computing thermal comfort.
</li>
</ul>
<p>
A qualitative description of these models can be found below. 
If you need to know the implementation then look
at the Modelica equation sections.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection>Interior convection</a><br/>
Interior convection is modelled between surfaces
and the zone air volume. Correlations are
used to compute the heat flow rate from the temperature difference.
By default these correlations are non-linear but they may be linearised as well.<br/>
Air cavities within walls are simulated using a correlation
that takes into account both radiative and convective heat transfer.
It is assumed that the cavity is not ventilated.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExteriorConvection>Exterior convection</a><br/>
Exterior convection is modelled using a wind speed dependent correlation.
</p>
<p>
Interior longwave radiation<br/>
Interior longwave radiation between surfaces may be modelled using two appraoches; 
either using an 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution>
equivalent radiative star point
</a> 
or using 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistributionViewFactor>
view factors
</a>.
Longwave radiation equations are linearised by default to avoid
large non-linear algebraic loops. 
Computations using a fourth order equation may be enabled by setting 
<code>linIntRad=false</code> in the zone model.
Surface emissivities are taken into account in these computations.
The view factor implementation assumes the zone to have a rectangular geometry.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorHeatRadiation>Exterior longwave radiation</a><br/>
Exterior longwave radiation is simulated by computing heat exchange with a weighted temperature of
the outside air and the sky temperature.
The weighting factor depends on the surface orientation.
These equations are linear by default, but may be computed using a fourth order
equation using <code>linExtRad=false</code>.
</p>
<p>
Interior shortwave radiation<br/>
Interior shortwave radiation occurs
whenever sun light enters the zone through a window.
When passing through the window, part of the sun light
is <a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.SwWindowResponse>absorbed</a>.
In 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwGainDistribution>
IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwGainDistribution
</a> 
we assume that the light always hits the floor. 
A fraction of the light, equal to the emissivity of the material,
will be absorbed. The remaining fraction is reflected within the 
zone and is absorbed by the remaining surfaces.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ExteriorSolarAbsorption>Exterior shortwave radiation</a><br/>
Exterior shortwave radiation injects heat on
the outer surface of surfaces. 
The magnitude of this heat injection depends on the surface emissivity and orientation and
the weather conditions (direct and diffuse solar radiation). 
Surface shading by objects is currently not supported.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer>Thermal conduction</a><br/>
Thermal conduction through solids is modelled using
a series discretisation of the wall.
</p>
<p>
Window shading<br/>
A few models allow to compute the shading of windows.
These models limit the amount of direct or diffuse 
solar irradation hitting the window.
Long wave radiation computations are not affected.
</p>
<p>
<a href=modelica://IDEAS.Buildings.Components.ZoneAirModels.AirLeakage>Air infiltration</a><br/>
Air infiltration is computed for each zone
independently, assuming a user provided constant n50 value.
Air exchange between zones is not modelled by default,
but may be added manually.
</p>
<h4>Model overview</h4>
<p>
The main models in the Buildings package are:
</p>
<ul>
<li>
<a href=modelica://IDEAS.Buildings.Components.OuterWall>IDEAS.Buildings.Components.OuterWall</a><br/>
This is the main wall model that should be used to
simulate a wall or roof between a zone and the outside environment.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.BoundaryWall>IDEAS.Buildings.Components.BoundaryWall</a><br/>
This is a wall model that should be used
to simulate a wall between a zone and a prescribed temperature or prescribed heat flow rate boundary condition.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.InternalWall>IDEAS.Buildings.Components.InternalWall</a><br/>
This is a wall model that should be used
to simulate a wall or floor between two zones.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.SlabOnGround>IDEAS.Buildings.Components.SlabOnGround</a><br/>
This is a floor model that should be used to
simulate floors on solid ground.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.Window>IDEAS.Buildings.Components.Window</a><br/>
This model should be used to model windows or other transparant surfaces.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.Zone>IDEAS.Buildings.Components.Zone</a><br/>
This model is the zone model to which the above surfaces and HVAC may be connected.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.Shading>IDEAS.Buildings.Components.Shading</a><br/>
This package contains shading models for the window model.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.ThermalBridges>IDEAS.Buildings.Components.ThermalBridges</a><br/>
The thermal bridges package allows to consider line losses in the window model.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.ZoneAirModels>IDEAS.Buildings.Components.ZoneAirModels</a><br/>
This package contains various zone air models that may be used in the zone model.
The 
<a href=modelica://IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir>IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir</a>
model is the only realistic zone air model.
The other models should only be used for purposes such as debugging.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.Comfort>IDEAS.Buildings.Components.Comfort</a><br/>
The models in this package may be selected in the zone model to evaluate the occupancy comfort.
Currently only Fanger is implemented.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.InternalGains>IDEAS.Buildings.Components.InternalGains</a><br/>
The models in this package may be selected in the zone model to define the occupancy
impact on the zone. I.e. this model may add heat or moisture into the zone depending on the 
number of occupants and the type of occupants.
</li>
<li>
<a href=modelica://IDEAS.Buildings.Components.OccupancyType>IDEAS.Buildings.Components.OccupancyType</a><br/>
The models in this package may be selected in the zone model to define
the occupancy characteristics. I.e. how they perceive comfort and how/which internal gains
they cause.
</li>
</ul>
<h4>Typical use</h4>
<p>
We refer to the examples for some demonstrations of how to use the Building models.
Note that you must make sure that each model contains an instance of 
<a href=modelica://IDEAS.BoundaryConditions.SimInfoManager>IDEAS.BoundaryConditions.SimInfoManager</a>
since this defines the boundary conditions of the model. 
This instance must have the keyword <code>inner</code>.
The SimInfoManager may be used to define
some general model properties (see the parameters list),
as well as the location of the modelled building,
which affects the solar calculations.
</p>
<p>
The user should make sure that the <code>propsBus</code> ports
of each surface are connected to one zone model.
</p>
<p>
The 
<a href=modelica://IDEAS.Templates>IDEAS Templates</a>
may be used to provide some structure to your model but they need not be used.
</p>
<h4>Examples</h4>
<p>
<a href=modelica://IDEAS.Buildings.Examples>IDEAS.Buildings.Examples</a>
contains examples that demonstrate several functionalities of the library.
<a href=modelica://IDEAS.Buildings.Components.Examples>IDEAS.Buildings.Components.Examples</a>
contains examples that focus more on the component level
and that are primarily used for unit test purposes.
<a href=modelica://IDEAS.Buildings.Validation.Tests>IDEAS.Buildings.Validation.Tests</a>
contains examples that verify the implementation of some models.
These models often contain a 'Command' that runs the model and
shows some results.

</p>
<h4>Validation</h4>
<p>
IDEAS is validated using BESTEST. 
The validation models may be found in package
<a href=modelica://IDEAS.Buildings.Validation>IDEAS.Buildings.Validation</a>.
</p>
<p>
In addition to this conservation of energy may be checked.
An example of how to do this may be found in 
<a href=modelica://IDEAS.Buildings.Validation.Tests.EnergyConservationValidation>IDEAS.Buildings.Validation.Tests.EnergyConservationValidation</a>.
</p>
<h4>Unit tests</h4>
<p>
Many of the example models are unit tested. 
Developers use this to check model consistency
when model equations are changed.
</p>
</html>", revisions="<html>
<ul><li>
22 october 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end UsersGuide;
