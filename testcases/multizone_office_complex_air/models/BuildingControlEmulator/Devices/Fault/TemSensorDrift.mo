within BuildingControlEmulator.Devices.Fault;
model TemSensorDrift
  extends BaseClasses.TemperatureTwoPort;
  Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                          final unit="K",
                                          displayUnit = "degC",
                                          min = 0,
                                          start=T_start)
    "Temperature of the passing fluid"
       annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));

  parameter Modelica.Units.SI.TemperatureDifference dt=0
    "Constant deviation of temperature measurement";
  parameter Modelica.Units.SI.Time FauTime=0 "Time when faults start to occur";
  parameter Modelica.Units.SI.Time DraftTime=0 "Length of the drift period";

  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=DraftTime)
    annotation (Placement(transformation(extent={{-54,42},{-34,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=noEvent(if time > FauTime then dt else 0))
    annotation (Placement(transformation(extent={{-90,42},{-70,62}})));
equation

  T = T_real + firstOrder.y;
  connect(realExpression.y, firstOrder.u)
    annotation (Line(points={{-69,52},{-62.5,52},{-56,52}}, color={0,0,127},
      pattern=LinePattern.Dash));
    annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
end TemSensorDrift;
