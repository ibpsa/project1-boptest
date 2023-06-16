within BuildingControlEmulator.Devices.Fault;
model PreSensorDrift
  extends BaseClasses.Pressure;
  parameter Modelica.Units.SI.Pressure dp=0
    "Constant deviation of pressure measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";
  parameter Modelica.Units.SI.Time DraftTime=0 "Length of the drift period";
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=DraftTime)
    annotation (Placement(transformation(extent={{-56,42},{-36,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=noEvent(if time >
        FauTime then dp else 0))
    annotation (Placement(transformation(extent={{-90,42},{-70,62}})));
  Modelica.Blocks.Interfaces.RealOutput p(final quantity="AbsolutePressure",
                                          final unit="Pa",
                                          min=0) "Pressure at port"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  p =  p_real + firstOrder.y;
  connect(realExpression.y, firstOrder.u)
    annotation (Line(
      points={{-69,52},{-58,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PreSensorDrift;
