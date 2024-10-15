within IDEAS.Fluid.Actuators.Valves.Simplified;
model ThreeWayValveSwitch "Switches between two circuits"
  extends BaseClasses.Partial3WayValve;
  parameter Modelica.SIunits.MassFlowRate mFlowMin = 0.01
    "Minimum outlet flowrate for mixing to start";

  Modelica.Blocks.Interfaces.BooleanInput switch
    "if true, the flow goes from leg a2 to leg b. Otherwise from leg a1"                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,102}), iconTransformation(
       extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,80})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=-port_b.m_flow)
    "Outlet flow rate"
    annotation (Placement(transformation(extent={{78,50},{34,70}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,32})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=1 - l, realFalse=l)
                                                   annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={4.44089e-16,70})));
equation
  connect(product.u2, booleanToReal.y) annotation (Line(
      points={{16,44},{16,60},{0,60},{0,63.4},{-1.33227e-15,63.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch, booleanToReal.u) annotation (Line(
      points={{0,102},{0,77.2},{1.11022e-15,77.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realExpression.y, product.u1) annotation (Line(
      points={{31.8,60},{28,60},{28,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, idealSource.m_flow_in) annotation (Line(
      points={{22,21},{24,21},{24,-50},{8,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={
        Polygon(
          points={{-60,30},{-60,-30},{0,0},{-60,30}},
          lineColor={100,100,100},
          smooth=Smooth.None),
        Polygon(
          points={{60,30},{60,-30},{0,0},{60,30}},
          lineColor={100,100,100},
          smooth=Smooth.None),
        Polygon(
          points={{-30,30},{-30,-30},{30,0},{-30,30}},
          lineColor={100,100,100},
          smooth=Smooth.None,
          origin={0,-30},
          rotation=90),
        Line(
          points={{-70,30},{-70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,30},{70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-30,-70},{30,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-76,-20},{-22,16}},
          lineColor={255,0,0},
          textString="0"),
        Text(
          extent={{-28,-62},{26,-26}},
          lineColor={255,0,0},
          textString="1")}),
    Documentation(revisions="<html>
<ul>
<li>March 26, 2018 by Filip Jorissen:<br/> 
Implemented valve leakage,
see <a href=\"https://github.com/open-ideas/IDEAS/issues/782\">#782</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
<li>January 2014, Dieter Patteeuw:<br/> 
First implementation
</li>
</ul>
</html>
"));
end ThreeWayValveSwitch;
