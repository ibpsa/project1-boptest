within ;
model SimpleRC
  "A simple thermal R1C1 model with sinusoidal outside air temperature and a feedback controlled heater."
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Step set(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Continuous.LimPID con(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  TestOverWrite.Overwrite oveAct
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Blocks.Continuous.Integrator intEHeat(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  TestOverWrite.Read TRooAir
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  TestOverWrite.Read ETotHea
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  TestOverWrite.Read PHea
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{20,0},{40,0}},color={191,0,0}));
  connect(cap.port, senTZone.port)
    annotation (Line(points={{40,0},{60,0}}, color={191,0,0}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-20,0},{0,0}},   color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,0},{-42,0}}, color={0,0,127}));
  connect(con.y, oveAct.u)
    annotation (Line(points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(oveAct.y, preHeat.Q_flow)
    annotation (Line(points={{-19,-30},{0,-30}},color={0,0,127}));
  connect(preHeat.port, cap.port)
    annotation (Line(points={{20,-30},{40,-30},{40,0}}, color={191,0,0}));
  connect(senTZone.T, con.u_m) annotation (Line(points={{80,0},{90,0},{90,-60},
          {-60,-60},{-60,-42}},
                           color={0,0,127}));
  connect(senTZone.T, TRooAir.u)
    annotation (Line(points={{80,0},{98,0}}, color={0,0,127}));
  connect(eff.y, intEHeat.u)
    annotation (Line(points={{21,-90},{58,-90}}, color={0,0,127}));
  connect(oveAct.y, eff.u) annotation (Line(points={{-19,-30},{-10,-30},{-10,
          -90},{-2,-90}}, color={0,0,127}));
  connect(PHea.u, intEHeat.u) annotation (Line(points={{98,-40},{40,-40},{40,
          -90},{58,-90}}, color={0,0,127}));
  connect(set.y, con.u_s)
    annotation (Line(points={{-79,-30},{-72,-30}}, color={0,0,127}));
  connect(intEHeat.y, ETotHea.u)
    annotation (Line(points={{81,-90},{98,-90}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2")));
end SimpleRC;
