within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model WriteWaterPlant "Collection of Water System overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput TW_set_in
    "Supply chilled/hot water setpoint"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput dp_set_in
    "differential pressure setpoint"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TW_set(description=
        "Chilled/hot water supply setpoint", u(
      unit="K")) "Chilled/hot water supply setpoint"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite dp_set(description=
        "Differential pressure setpoint", u(
      unit="Pa")) "Differential pressure setpoint"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TW_set_out
    "Chilled/hot water supply setpoint"
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput dp_set_out
    "differential pressure setpoint"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
equation
  connect(dp_set.y, dp_set_out)
    annotation (Line(points={{11,-40},{110,-40}}, color={0,0,127}));
  connect(dp_set.u, dp_set_in)
    annotation (Line(points={{-12,-40},{-120,-40}}, color={0,0,127}));
  connect(TW_set.y, TW_set_out)
    annotation (Line(points={{11,60},{110,60}}, color={0,0,127}));
  connect(TW_set.u, TW_set_in)
    annotation (Line(points={{-12,60},{-120,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}),                                  graphics={
          Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,22},{30,-18}},
          lineColor={0,0,0},
          textString="Write
Wat"),  Text(
          extent={{-152,122},{148,162}},
          textString="%name",
          textColor={0,0,255})}),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}})));
end WriteWaterPlant;
