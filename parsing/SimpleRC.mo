within ;
model SimpleRC
  "A simple thermal R1C1 model with sinusoidal outside air temperature and heating input."
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Blocks.Continuous.LimPID con(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Step set(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite
                           oveSet(   u(
      unit="K",
      min=273.15 + 10,
      max=273.15 + 35), description="Zone temperature setpoint")
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite
                           oveAct(
                                u(
      unit="W",
      min=0,
      max=3000), description="Control signal for heater thermal power")
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  IBPSA.Utilities.IO.SignalExchange.Read
                      TZone(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
                                         y(unit="K"),
    description="Zone temperature")
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  IBPSA.Utilities.IO.SignalExchange.Read
                      PHeat(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
                                              y(unit="W"),
    description="Heater electrical power")
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{20,20},{40,20}},
                                            color={191,0,0}));
  connect(cap.port, senTZone.port)
    annotation (Line(points={{40,20},{50,20}},
                                             color={191,0,0}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-20,20},{0,20}}, color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,20},{-42,20}},
                                               color={0,0,127}));
  connect(preHeat.port, cap.port)
    annotation (Line(points={{40,-20},{40,20}},          color={191,0,0}));
  connect(senTZone.T, con.u_m) annotation (Line(points={{70,20},{80,20},{80,-40},
          {-30,-40},{-30,-32}}, color={0,0,127}));
  connect(set.y, oveSet.u)
    annotation (Line(points={{-79,-20},{-72,-20}}, color={0,0,127}));
  connect(oveSet.y, con.u_s)
    annotation (Line(points={{-49,-20},{-42,-20}}, color={0,0,127}));
  connect(con.y, oveAct.u)
    annotation (Line(points={{-19,-20},{-12,-20}}, color={0,0,127}));
  connect(oveAct.y, preHeat.Q_flow)
    annotation (Line(points={{11,-20},{20,-20}}, color={0,0,127}));
  connect(oveAct.y, eff.u) annotation (Line(points={{11,-20},{14,-20},{14,-80},
          {18,-80}}, color={0,0,127}));
  connect(senTZone.T, TZone.u)
    annotation (Line(points={{70,20},{98,20}}, color={0,0,127}));
  connect(eff.y, PHeat.u) annotation (Line(points={{41,-80},{98,-80}},
                    color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2"), IBPSA(version="3.0.0")));
end SimpleRC;
