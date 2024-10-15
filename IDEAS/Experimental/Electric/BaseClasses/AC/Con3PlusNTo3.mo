within IDEAS.Experimental.Electric.BaseClasses.AC;
model Con3PlusNTo3
  "Converts the 3 phases plus Neutral to 3 phases representation to wich powers can be connected"

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    fourWire[4]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    threeWire[3]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  for i in 1:3 loop
    fourWire[i].v - fourWire[4].v = threeWire[i].v;
    threeWire[i].i = -fourWire[i].i;
    .Connections.branch(threeWire[i].reference, fourWire[i].reference);
    threeWire[i].reference.gamma = fourWire[i].reference.gamma;
  end for;
  -fourWire[4].i = fourWire[1].i + fourWire[2].i + fourWire[3].i;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Line(
          points={{12,-20},{38,-20},{40,-20},{50,-18},{60,-10},{70,-4},{90,0}},
          color={205,133,63},
          smooth=Smooth.None),
        Line(
          points={{8,18},{38,18},{40,18},{50,16},{60,10},{70,4},{90,0}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{10,-2},{40,-2},{60,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-8,-20},{-38,-20},{-40,-20},{-50,-18},{-60,-10},{-70,-4},{
              -90,0}},
          color={205,133,63},
          smooth=Smooth.None),
        Line(
          points={{-12,18},{-38,18},{-40,18},{-50,16},{-60,10},{-70,4},{-90,0}},
          color={135,135,135},
          smooth=Smooth.None),
        Line(
          points={{-10,-2},{-40,-2},{-60,0},{-90,0}},
          color={0,0,0},
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
This model converts the 3 phases plus neutral to 3-phases representation to wich powers can be connected.
</p>
<p>
This implementation is based upon the Laws of Kirchhoff.
</p>
</html>", revisions="<html>
<ul>
<li>
January 22, 2015 by Juan Van Roy:<br/>
Check model (+ typo).
</li>
</ul>
</html>"));
end Con3PlusNTo3;
