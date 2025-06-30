within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model WriteWaterPlant "Collection of Water System overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput TWSet_in
    "Supply chilled/hot water setpoint" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}), iconTransformation(extent={{-140,40},{
            -100,80}})));
  Modelica.Blocks.Interfaces.RealInput dpSet_in
    "differential pressure setpoint" annotation (Placement(transformation(
          extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},
            {-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TWSet(description=
        "Chilled/hot water supply setpoint", u(unit="K"))
    "Chilled/hot water supply setpoint"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite dpSet(description=
        "Differential pressure setpoint", u(unit="Pa"))
    "Differential pressure setpoint"
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
  connect(dpSet.y, dp_set_out)
    annotation (Line(points={{11,-40},{110,-40}}, color={0,0,127}));
  connect(dpSet.u, dpSet_in)
    annotation (Line(points={{-12,-40},{-120,-40}}, color={0,0,127}));
  connect(TWSet.y, TW_set_out)
    annotation (Line(points={{11,60},{110,60}}, color={0,0,127}));
  connect(TWSet.u, TWSet_in)
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
