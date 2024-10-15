within IDEAS.Experimental.Electric.BaseClasses.DC;
model WattsLawPlug "For use  with loads."
  parameter Integer nLoads=1;
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug vi(m=
        1) annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput[nLoads] P annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}), iconTransformation(extent={{-100,40},
            {-80,60}})));

  Modelica.Blocks.Math.Sum sum_P(final nin=nLoads)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

equation
  sum_P.y = vi.pin[1].v * vi.pin[1].i;

  connect(P, sum_P.u) annotation (Line(
      points={{-100,40},{-96,40},{-96,50},{-82,50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Ellipse(
          extent={{-80,60},{40,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,0},{100,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,24},{-26,-26}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,0},{-26,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-14,0},{6,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-14,24},{-14,-26}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{40,60},{40,-60}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(graphics),Documentation(info="<html>
<p>
This model converts the power to a nodal voltage and current for DC (unipolar) loads.
</p>
</html>", revisions="<html>
<ul>
<li>
January 22, 2015 by Juan Van Roy:<br/>
First implementation.
</li>
</ul>
</html>"));
end WattsLawPlug;
