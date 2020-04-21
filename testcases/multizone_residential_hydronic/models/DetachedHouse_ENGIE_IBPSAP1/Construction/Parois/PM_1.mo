within DetachedHouse_ENGIE_IBPSAP1.Construction.Parois;
model PM_1

  Modelica.Blocks.Interfaces.RealOutput PM "Connector of Real output signals"
    annotation (Placement(transformation(extent={{60,58},{98,96}})));

  Modelica.Blocks.Interfaces.BooleanInput Occupation
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-102,38},{-62,78}})));
  Modelica.Blocks.Interfaces.BooleanInput HeatingSeason
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-102,78},{-62,118}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-56,88},{-36,108}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-20,66},{0,86}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0.5, realFalse=
        0) annotation (Placement(transformation(extent={{16,66},{36,86}})));
equation
  connect(HeatingSeason, not1.u)
    annotation (Line(points={{-82,98},{-58,98}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{-35,98},{-32,98},{-32,
          76},{-22,76}}, color={255,0,255}));
  connect(Occupation, and1.u2) annotation (Line(points={{-82,58},{-34,58},{
          -34,68},{-22,68}}, color={255,0,255}));
  connect(and1.y, booleanToReal.u)
    annotation (Line(points={{1,76},{4,76},{14,76}}, color={255,0,255}));
  connect(booleanToReal.y, PM)
    annotation (Line(points={{37,76},{79,76},{79,77}}, color={0,0,127}));
  annotation (                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-60,40},{60,120}})),
    Icon(coordinateSystem(extent={{-60,40},{60,120}})),
    Documentation(info="<html>
<h4>Pilotage des parois mobiles</h4>
<p>Ce pilotage d&eacute;pend de la saison de chauffe et de l&apos;occupation du b&acirc;timent.</p>
<p>Si l&apos;on est en p&eacute;riode d&apos;&eacute;t&eacute; et que le b&acirc;timent est occup&eacute;, on baisse les parois mobiles &agrave; moiti&eacute;.</p>
</html>"));
end PM_1;
