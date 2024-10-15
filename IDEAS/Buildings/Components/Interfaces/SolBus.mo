within IDEAS.Buildings.Components.Interfaces;
connector SolBus
  "Bus containing solar radiation for various incidence angles as well as external convection coefficients"
  extends Modelica.Icons.SignalBus;
  parameter Boolean outputAngles = true "Set to false when linearising in Dymola only";
  IDEAS.Buildings.Components.Interfaces.RealConnector HDirTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector HSkyDifTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector HGroDifTil(unit="W/(m2)",start=100) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector hForcedConExt(unit="W/(m2.K)",start=10) "Coefficient for forced convection at exterior surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector angInc(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector angZen(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector angAzi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg",
    start=1) if outputAngles;
  IDEAS.Buildings.Components.Interfaces.RealConnector Tenv(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min = 0.0,
    start = 293.15,
    nominal = 300,
    displayUnit="degC") "Equivalent radiant temperature" annotation ();


  annotation (Documentation(info="<html>
<p>
Connector that contains all solar irridiation information for one inclination and tilt angle.
</p>
</html>", revisions="<html>
<ul>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Add RealConnector for coefficient for forced convection at exterior surface.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
August 24, 2018, by Damien Picard:<br/>
Add start value for linearisation.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed Reals into connectors for JModelica compatibility.
Other compatibility changes. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end SolBus;
