within SimpleAir.BaseClasses;
model Thermostat
  "Implements basic control of FCU to maintain zone air temperature"
  Modelica.Blocks.Interfaces.RealInput TZon "Measured zone air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput yHea "Heating control signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yCoo "Cooling control signal"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Fan control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Or orFan
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealInput TSetHea
    "Heating temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput TSetCoo
    "Cooling temperature setpoint for zone air"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Logical.OnOffController conCoo(bandwidth=2)
    "Controller for cooling"
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2
    annotation (Placement(transformation(extent={{70,30},{90,50}})));
  Modelica.Blocks.Logical.OnOffController conHea(bandwidth=2)
    "Controller for heating"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(conHea.y, booleanToReal2.u)
    annotation (Line(points={{-9,40},{68,40}}, color={255,0,255}));
  connect(booleanToReal1.y, yCoo)
    annotation (Line(points={{91,80},{110,80}}, color={0,0,127}));
  connect(booleanToReal2.y, yHea)
    annotation (Line(points={{91,40},{110,40}}, color={0,0,127}));
  connect(conHea.y, orFan.u2) annotation (Line(points={{-9,40},{28,40},{28,-8},
          {38,-8}}, color={255,0,255}));
  connect(orFan.y, booleanToReal3.u)
    annotation (Line(points={{61,0},{70,0}}, color={255,0,255}));
  connect(booleanToReal3.y, yFan)
    annotation (Line(points={{93,0},{110,0}}, color={0,0,127}));
  connect(TZon, conHea.u) annotation (Line(points={{-120,0},{-40,0},{-40,34},{
          -32,34}}, color={0,0,127}));
  connect(TZon, conCoo.u) annotation (Line(points={{-120,0},{-60,0},{-60,74},{
          -32,74}}, color={0,0,127}));
  connect(TSetCoo, conCoo.reference) annotation (Line(points={{-120,80},{-60,80},
          {-60,86},{-32,86}}, color={0,0,127}));
  connect(TSetHea, conHea.reference) annotation (Line(points={{-120,40},{-40,40},
          {-40,46},{-32,46}}, color={0,0,127}));
  connect(not1.y, booleanToReal1.u)
    annotation (Line(points={{21,80},{68,80}}, color={255,0,255}));
  connect(conCoo.y, not1.u)
    annotation (Line(points={{-9,80},{-2,80}}, color={255,0,255}));
  connect(not1.y, orFan.u1) annotation (Line(points={{21,80},{32,80},{32,0},{38,
          0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,60},{62,-60}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,24},{26,-16}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="T"),              Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end Thermostat;
