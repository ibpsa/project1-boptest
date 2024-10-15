within IDEAS.Experimental.Electric.BaseClasses.DC;
model Con1PlusNTo1
  "Converts the single-phase plus Neutral to single-phase representation to wich powers can be connected"

  Modelica.Electrical.Analog.Interfaces.PositivePin
    twoWire[2]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin
    oneWire[1]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  twoWire[1].v - twoWire[2].v = oneWire[1].v;
  oneWire[1].i = -twoWire[1].i;

  -twoWire[2].i = twoWire[1].i;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Line(
          points={{10,-2},{40,-2},{60,0},{90,0}},
          color={205,133,63},
          smooth=Smooth.None),
        Line(
          points={{-10,-2},{-40,-2},{-60,0},{-90,0}},
          color={205,133,63},
          smooth=Smooth.None),
        Line(
          points={{-14,38},{-40,38},{-50,34},{-70,10},{-90,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{-70,12},{-100,-12}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,12},{70,-12}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-6,60},{6,-60}},
          color={135,135,135},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}),        Diagram(graphics),Documentation(info="<html>
<p>
This model converts the 1 phase plus neutral (two-phase system) to a single-phase representation for DC (unipolar) networks to wich powers can be connected.
</p>
<p>
This implementation is based upon the Laws of Kirchhoff.
</p>
</html>", revisions="<html>
<ul>
<li>
January 22, 2015 by Juan Van Roy:<br/>
First implementation.
</li>
</ul>
</html>"));
end Con1PlusNTo1;
