within IDEAS.Buildings.Components.Shading;
model ShadingControlInclined "Shading controller for inclined surfaces"
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));

  parameter Modelica.SIunits.Irradiance threshold = 150
    "Shading closed when total external sola irradation is above this threshold";
  parameter Modelica.SIunits.Angle inc "Inclination angle";
  parameter Modelica.SIunits.Angle azi "Azimuth angle";

  Modelica.Blocks.Interfaces.RealOutput y "control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greater(threshold=threshold)
    "Greater comparison"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=1, realFalse=0)
    "Boolean to real conversion"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
protected
  IDEAS.BoundaryConditions.SolarIrradiation.RadSolData radSolData(
    inc=inc,
    azi=azi)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
equation
  connect(add3_1.u1, radSolData.HDirTil) annotation (Line(points={{-42,8},{-70,
          8},{-70,2},{-79.4,2}},color={0,0,127}));
  connect(add3_1.u2, radSolData.HSkyDifTil) annotation (Line(points={{-42,0},{
          -79.4,0}},               color={0,0,127}));
  connect(add3_1.u3, radSolData.HGroDifTil) annotation (Line(points={{-42,-8},{
          -70,-8},{-70,-2},{-79.4,-2}},
                                    color={0,0,127}));
  connect(greater.u, add3_1.y)
    annotation (Line(points={{8,0},{-19,0}}, color={0,0,127}));
  connect(booToRea.u, greater.y)
    annotation (Line(points={{58,0},{31,0}}, color={255,0,255}));
  connect(booToRea.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  annotation (
    Icon(graphics={Rectangle(
          extent={{-74,56},{74,-58}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{48,36},{54,-40}},
          lineColor={70,70,70},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{22,36},{28,-40}},
          lineColor={70,70,70},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-4,36},{2,-40}},
          lineColor={70,70,70},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-30,36},{-24,-40}},
          lineColor={70,70,70},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-54,34},{-46,26}},
          lineColor={255,255,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-34,-6},{-22,-6},{-16,-12},{-22,-18},{-34,-18},{-34,-6}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-8,10},{4,10},{10,4},{4,-2},{-8,-2},{-8,10}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),Polygon(
          points={{18,-2},{30,-2},{36,-8},{30,-14},{18,-14},{18,-2}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),Polygon(
          points={{46,14},{58,14},{64,8},{58,2},{46,2},{46,14}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<h4>General description</h4>
<p>
This model creates a control signal for a shading device.
The shading device is closed when the solar irradiation on the inclined face reaches a threshold.
No hysteresis is used since weather files slow solar intensity variations anyway.
</p>
</html>", revisions="<html>
<ul>
<li>
April 12 2021, by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end ShadingControlInclined;
