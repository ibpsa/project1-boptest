within IDEAS.Experimental.Electric.Photovoltaics.Components;
model SimpleInverter

  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  //v1,i1 =DC  <-> v2,i2 = AC

  parameter Real eff=0.95;
  //For now
  flow Modelica.SIunits.ActivePower P_dc;
  flow Modelica.SIunits.ActivePower P;
  flow Modelica.SIunits.ApparentPower S;
  flow Modelica.SIunits.ReactivePower Q;
  parameter Real cosphi=1;
  //For now

equation
  S^2 = P^2 + Q^2;
  P = S*cosphi;
  P = eff*P_dc;
  P_dc = i1*v1;
  p2.v = 230;
  // Should also be V_node, but since p2.i depends on p2.v and P, P calculated in DCGrid is not dependent on this p2.v
  p2.v*p2.i = P;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Line(
          points={{-100,50},{100,50}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-50},{100,-50}},
          color={85,170,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-60},{60,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{38,-30},{34,-38},{30,-38},{24,-18}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{16,-26},{20,-18},{24,-18},{30,-38}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,34},{-20,34}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,40},{-20,40}},
          color={0,0,0},
          smooth=Smooth.None)}), Documentation(revisions="<html>
<ul>
<li>
October 21, 2015 by Filip Jorissen:<br/>
Changed class declaration to model declaration for issue 398.
</li>
</ul>
</html>"));
end SimpleInverter;
