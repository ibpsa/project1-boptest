within IDEAS.Fluid.Actuators.Valves;
model ThreeWayEqualPercentageMixedLinear
  "Three way valve with mixed equal percentage and linear characteristics"
    extends IDEAS.Fluid.Actuators.BaseClasses.PartialThreeWayValve(
    final fraK=1,
    redeclare IDEAS.Fluid.Actuators.Valves.TwoWayEqualPercentageLinear res1,
    redeclare IDEAS.Fluid.Actuators.Valves.TwoWayLinear res3);
equation
  connect(inv.y, res3.y) annotation (Line(points={{-62.6,46},{20,46},{20,46},{
          20,-50},{12,-50}},
                         color={0,0,127}));
  connect(y_actual, inv.u2) annotation (Line(points={{50,70},{84,70},{84,32},{-68,
          32},{-68,41.2}},
                         color={0,0,127}));
  connect(y_actual, res1.y) annotation (Line(points={{50,70},{84,70},{84,32},{
          -50,32},{-50,12}},
        color={0,0,127}));
  annotation (                       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-72,24},{-34,-20}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%")}),
defaultComponentName="val",
Documentation(info="<html>
<p>
Three way valve with mixed equal percentage characteristics
between <code>port_1</code> and <code>port_2</code>
and linear opening characteristic between <code>port_3</code> and <code>port_2</code>.
Such opening characteristics are typical for valves from Siemens three-way valves.
</p><p>
This model is based on the partial valve models
<a href=\"modelica://IDEAS.Fluid.Actuators.BaseClasses.PartialThreeWayValve\">
IDEAS.Fluid.Actuators.BaseClasses.PartialThreeWayValve</a> and
<a href=\"modelica://IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve\">
IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve</a>.
See
<a href=\"modelica://IDEAS.Fluid.Actuators.BaseClasses.PartialThreeWayValve\">
IDEAS.Fluid.Actuators.BaseClasses.PartialThreeWayValve</a>
for the implementation of the three way valve
and see
<a href=\"modelica://IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve\">
IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValve</a>
for the implementation of the regularization near the origin.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 14, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ThreeWayEqualPercentageMixedLinear;
