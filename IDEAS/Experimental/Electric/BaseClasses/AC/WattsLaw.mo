within IDEAS.Experimental.Electric.BaseClasses.AC;
model WattsLaw "For use  with loads"
  parameter Integer numPha=1 "Choose the number of phases" annotation (choices(
        choice=1 "Single-phase", choice=3 "Symmetrical three-phase"));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin[numPha]
    vi annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput P(start=0) annotation (Placement(
        transformation(extent={{-90,20},{-50,60}}),  iconTransformation(extent={{-70,40},
            {-50,60}})));
  Modelica.Blocks.Interfaces.RealInput Q(start=0) annotation (Placement(
        transformation(extent={{-100,-20},{-60,20}}), iconTransformation(extent={{-80,0},
            {-60,20}})));
equation
  for i in 1:numPha loop
    P/numPha =  vi[i].v.re*vi[i].i.re+vi[i].v.im*vi[i].i.im;
    Q/numPha = -vi[i].v.re*vi[i].i.im+vi[i].v.im*vi[i].i.re;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{50,0},{90,0}}, color={0,0,0}),
        Line(
          points={{0,50},{0,-50}},
          color={175,175,175},
          smooth=Smooth.None),
        Text(
          extent={{-38,42},{42,-38}},
          lineColor={0,0,0},
          fontName="Symbol",
          textString="W")}),     Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                         graphics),Documentation(info="<html>
<p>
This model converts the apparent power to a nodal voltage and current. It can be used for single-phase (numPha=1) loads or three-phase (numPha=3) loads (symmetrically divided over all phases)
</p>
</html>", revisions="<html>
<ul>
<li>
January 22, 2015 by Juan Van Roy:<br/>
Documentation added.
</li>
</ul>
</html>"));
end WattsLaw;
