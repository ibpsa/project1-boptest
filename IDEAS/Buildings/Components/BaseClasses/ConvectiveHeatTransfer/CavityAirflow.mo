within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
model CavityAirflow "Model for air flow through a cavity"
  parameter Boolean linearise = false
    "=true, to linearise the relation between heat flow rate and temperature difference";

  parameter Real CD=0.65 "Discharge coefficient";
  parameter Modelica.SIunits.Length h = 2
    "Height of (rectangular) cavity in wall";
  parameter Modelica.SIunits.Length w = 1
    "Width of (rectangular) cavity in wall";
  parameter Modelica.SIunits.Acceleration g = Modelica.Constants.g_n
    "Gravity, for computation of buoyancy";
  parameter Modelica.SIunits.Pressure p = 101300
    "Absolute pressure for computation of buoyancy";
  parameter Modelica.SIunits.Density rho = p/r/T
    "Nominal density for computation of buoyancy mass flow rate";
  parameter Modelica.SIunits.SpecificHeatCapacity c_p = 1013
   "Nominal heat capacity for computation of buoyancy heat flow rate";
  parameter Modelica.SIunits.Temperature T = 293
   "Nominal temperature for linearising heat flow rate";
  parameter Modelica.SIunits.TemperatureDifference dT = 1
   "Nominal temperature difference when linearising heat flow rate"
   annotation(Dialog(enable=linearise));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Port for connections between layers"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Port for connections between layers"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
protected
  constant Real r = 287 "Gas constant";
  // Assuming the same entering and leaving flow rate
  // between .bottom and top half of the cavity
  // Assuming uniform flow through both parts.
  // dp= rho * g * h/4 * (1-T1/T2) - buoyancy: horizontal pressure differences
  // factor 4: distance between door center and center of top/bottom door half
  // v = sqrt(2 * dp/rho) - Bernoulli
  // dotm = v*h/2*w*rho*cp  - Mass flow rate
  // G = dotm * c_p
  final parameter Real coeff1 = CD*c_p*rho*w*h/2*sqrt(0.5*g*h) "Bernoulli-based thermal conductance";
  final parameter Real coeff2 = sqrt(abs(1-T/(T+dT)));
  Modelica.SIunits.ThermalConductance G=
    coeff1*(if linearise
           then coeff2
 else
    sqrt(abs(1-port_a.T/port_b.T)));
    // We don't need a regularisation for the square root since this
    // equation should not end up in an algebraic loop
    // when used correctly in IDEAS.
    // However, laminar flow could be approximated better.

equation

  port_a.Q_flow+port_b.Q_flow=0;
  port_a.Q_flow=(port_a.T-port_b.T)*G;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,80},{60,-84}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={85,75,55},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,72},{56,-84}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{56,72},{-36,66},{-36,-90},{56,-84},{56,72}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-10},{-16,-8},{-16,-14},{-30,-16},{-30,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<h4>Assumptions and limitations</h4>
<p>
The cavity model assumes that the temperature difference between both zones is constant
along the zone heights and that this causes a pressure difference between the zones
due to buoyancy. 
We assume that the pressure at the height of the center of the opening is 
equal in both zones.
Based on this pressure difference, the mass flow rate is computed using Bernoulli,
from which a heat flow rate is computed.
This model deals with stratification in a very simplified way. 
Very large openings can lead to small time constants, which can cause problems
for the time integrator.
Only thermal effects are modelled: there is no mass transport of air or moisture.
The influence of the cavity on the radiative heat exchange is not modelled.
</p>
</html>"));
end CavityAirflow;
