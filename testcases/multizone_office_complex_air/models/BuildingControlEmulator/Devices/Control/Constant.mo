within BuildingControlEmulator.Devices.Control;
model Constant "\"Controller for constant speed fans or pumps\""
  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(On, booleanToReal.u) annotation (Line(
      points={{-120,0},{-66,0},{-20,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanToReal.y, y) annotation (Line(
      points={{3,0},{60,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,50},{62,-48}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="ConstantSpeed")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end Constant;
