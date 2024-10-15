within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ExteriorSolarAbsorption
  "Shortwave radiation absorption on an exterior surface"
  parameter Modelica.SIunits.Area A
    "Surface area";
  parameter Modelica.SIunits.Emissivity epsSw
    "Short wave solar absorption coefficient";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Port for heat exchange"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput solDir(unit="W/m2")
    "Direct solar irradiation on surface"
    annotation (Placement(transformation(extent={{120,40},{80,80}})));
  Modelica.Blocks.Interfaces.RealInput solDif(unit="W/m2")
    "Diffuse solar irradiation on surface"
    annotation (Placement(transformation(extent={{120,0},{80,40}})));

protected
  parameter Modelica.SIunits.Area ASw = - A*epsSw "Constant folding";

equation
  port_a.Q_flow = ASw*(solDir + solDif);

  annotation (Icon(graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-40,10},{40,10}}, color={191,0,0}),
        Line(points={{-40,10},{-30,16}}, color={191,0,0}),
        Line(points={{-40,10},{-30,4}}, color={191,0,0}),
        Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
        Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
        Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
        Line(points={{-40,30},{40,30}}, color={191,0,0}),
        Line(points={{-40,30},{-30,36}}, color={191,0,0}),
        Line(points={{-40,30},{-30,24}},color={191,0,0}),
        Line(points={{-40,-10},{-30,-4}},color={191,0,0}),
        Line(points={{-40,-10},{-30,-16}}, color={191,0,0})}), Documentation(
        info="<html>
<p>Transmitted shortwave solar radiation is distributed over all surfaces in the zone in a prescribed scale. This scale is an input value which may be dependent on the shape of the zone and the location of the windows, but literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption.</p>
</html>", revisions="<html>
<ul>
<li>
August 12, 2020 by Filip Jorissen:<br/>
No longer using connector and initial equation for <code>epsSw</code>.
<a href=\"https://github.com/open-ideas/IDEAS/issues/1162\">#1162</a>.
</li>
<li>
October 29, 2018 by Filip Jorissen:<br/>
Improved documentation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/950\">#950</a>.
</li>
<li>
Refactored solar absorption to include parameter for A.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end ExteriorSolarAbsorption;
