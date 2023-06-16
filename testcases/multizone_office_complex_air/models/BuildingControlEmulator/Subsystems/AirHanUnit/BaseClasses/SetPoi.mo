within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses;
model SetPoi "SetPoint Controller"
  parameter Integer n "dimenison of the setpoint vector";
  parameter Real setpoint_on[n] "the values of setpoint during 'on' period";
  parameter Real setpoint_off[n] "the values of setpoint during 'off' period";

  Modelica.Blocks.Sources.RealExpression realExpression[n](y=noEvent(if Occ then setpoint_on else setpoint_off))
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Interfaces.BooleanInput  Occ
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput SetPoi[n]
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  connect(realExpression.y, SetPoi) annotation (Line(points={{9,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-42,38},{44,-46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="SetPo"),
        Text(
          extent={{-142,122},{158,162}},
          textString="%name",
          textColor={0,0,255})}),
                               Diagram(coordinateSystem(preserveAspectRatio=false)));
end SetPoi;
