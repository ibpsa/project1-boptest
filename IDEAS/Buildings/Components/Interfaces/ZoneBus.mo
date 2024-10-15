within IDEAS.Buildings.Components.Interfaces;
connector ZoneBus
  extends Modelica.Icons.SignalBus;
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  parameter Integer numIncAndAziInBus
    "Number of calculated azimuth angles, set to sim.numIncAndAziInBus";
  parameter Boolean outputAngles = true "Set to false when linearising in Dymola only";
  parameter Boolean use_port_1 = false;
  parameter Boolean use_port_2 = false;

  IDEAS.Buildings.Components.Interfaces.RealConnector QTra_design(
    final quantity="Power",
    final unit="W") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector area(
    final quantity="Area",
    final unit="m2") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector epsLw(
    final quantity="Emissivity",
    final unit="1") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector epsSw(
    final quantity="Emissivity",
    final unit="1") annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surfCon annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b surfRad annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b iSolDif annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Qgai
    "Heat gains in model" annotation ();
  Modelica.Fluid.Interfaces.FluidPort_a port_1(
    redeclare package Medium = Medium) if
       use_port_1
    "Port for interzonal air flow: middle or bottom port";
  Modelica.Fluid.Interfaces.FluidPort_a port_2(
    redeclare package Medium = Medium) if
       use_port_2
    "Port for detailed interzonal air flow: top port";
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.EnergyPort E
    "Internal energy in model" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector inc(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector azi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector v50(final unit="m3/h") "v50 if the surface has a custome q50 value" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector q50_zone(final unit="m3/(h.m2)") "v50 of the surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.BooleanConnector use_custom_q50 "true if custome q50 value is assigned to surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.BooleanConnector use_custom_n50 "true if the zone n50 is a custom value";
  annotation (Documentation(info="<html>
<p>
Connector that contains a weather bus and further
contains variables and connectors for exchanging 
heat and information between a zone and a surface.
</p>
</html>", revisions="<html>
<ul>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
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
end ZoneBus;
