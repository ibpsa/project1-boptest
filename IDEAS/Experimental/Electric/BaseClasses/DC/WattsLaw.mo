within IDEAS.Experimental.Electric.BaseClasses.DC;
model WattsLaw "For use  with loads"

Modelica.Electrical.Analog.Interfaces.NegativePin[1] vi
    annotation (Placement(transformation(extent={{90,10},{110,-10}}),
        rotation=0));

  Modelica.Blocks.Interfaces.RealInput P(start=0) annotation (Placement(
        transformation(extent={{-130,-10},{-90,30}}),iconTransformation(extent={{-110,10},
            {-90,30}})));

equation
  P = vi[1].v * vi[1].i;

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
          points={{-46,0},{-26,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-14,0},{6,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{40,60},{40,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,24},{-26,-26}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-14,24},{-14,-26}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                         graphics),Documentation(info="<html>
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
end WattsLaw;
