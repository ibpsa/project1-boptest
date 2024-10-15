within IDEAS.Fluid.Actuators.Valves;
model TwoWayEqualPercentageLinear
  "Two way valve with mixed equal-percentage and linear characteristic"
  extends IDEAS.Fluid.Actuators.Valves.TwoWayPolynomial(
    final c={0,0.5304,-0.7698,1.2278});
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 14, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Two way valve with a mixed equal percentage / linear valve opening characteristic.
The characteristic is linear for valve openings smaller than 30 % and equal percentage otherwise.
This valve characteristic is based on the Siemens VVF series.
</p>
<p>
This model is based on the partial valve model
<a href=\"modelica://IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve\">
IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve</a>.
Check this model for more information, such
as the regularization near the origin.
</p>
</html>"));
end TwoWayEqualPercentageLinear;
