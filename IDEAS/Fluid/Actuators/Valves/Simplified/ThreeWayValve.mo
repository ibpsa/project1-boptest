within IDEAS.Fluid.Actuators.Valves.Simplified;
model ThreeWayValve "Ideal mixing point"
  extends Modelica.Icons.ObsoleteModel;
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);


  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium) "Hot fluid inlet"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium) "Cold fluid inlet"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Fluid outlet"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
initial equation
  assert(false, "In " + getInstanceName() + ": this model is deprecated and will be removed in a future version of IDEAS. Use IDEAS.Fluid.FixedResistances.Junction instead.", level=AssertionLevel.warning);

equation
  connect(port_a1, port_b) annotation (Line(
      points={{-100,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a1, port_a2) annotation (Line(
      points={{-100,0},{0,0},{0,-100}},
      color={0,127,255},
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
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li>
February 21, 2019 by Filip Jorissen:<br/> 
Deprecated model.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end ThreeWayValve;
