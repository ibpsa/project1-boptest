within IDEAS.Experimental.Electric.BaseClasses.AC;
model PotentialSensor
  "For use  with loads. Either symmetrically divided over 3 phases (numPha=3) or single phase (numPha=1)."

  Modelica.Blocks.Interfaces.RealOutput VGrid(start=0) annotation (Placement(
        transformation(extent={{98,-10},{118,10}}), iconTransformation(extent={
            {94,-10},{114,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin vi
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
equation

  VGrid =  (vi.v.re^2 + vi.v.im^2)^0.5;
  vi.i.re=0;
  vi.i.im=0;

  annotation (Icon(graphics={
        Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
        Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
        Line(points={{0,70},{0,40}}, color={0,0,0}),
        Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
        Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
        Line(points={{70,0},{94,0}}, color={0,0,0}),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
        Polygon(
          points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString="V"),
        Line(points={{-70,0},{-94,0}}, color={0,0,0})}), Diagram(graphics));
end PotentialSensor;
