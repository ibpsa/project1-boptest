within ;
model SimpleRC_Input
  "A simple thermal R1C1 model with sinusoidal outside air temperature and heating input."
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput TZone
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Interfaces.RealInput QHeat "Heating input to zone"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Interfaces.RealOutput PHeat "Power consumption of heater"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput EHeat "Energy consumption of heater"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Continuous.Integrator intEHeat(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0)
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{0,0},{20,0}}, color={191,0,0}));
  connect(cap.port, senTZone.port)
    annotation (Line(points={{20,0},{40,0}}, color={191,0,0}));
  connect(senTZone.T, TZone)
    annotation (Line(points={{60,0},{110,0}}, color={0,0,127}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-40,0},{-20,0}}, color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,0},{-62,0}}, color={0,0,127}));
  connect(preHeat.port, cap.port)
    annotation (Line(points={{-20,-50},{20,-50},{20,0}}, color={191,0,0}));
  connect(preHeat.Q_flow, QHeat)
    annotation (Line(points={{-40,-50},{-120,-50}}, color={0,0,127}));
  connect(eff.u, QHeat) annotation (Line(points={{-42,-70},{-80,-70},{-80,-50},
          {-120,-50}}, color={0,0,127}));
  connect(eff.y, PHeat) annotation (Line(points={{-19,-70},{40,-70},{40,-60},{
          110,-60}}, color={0,0,127}));
  connect(intEHeat.y,EHeat)
    annotation (Line(points={{81,-80},{110,-80}}, color={0,0,127}));
  connect(intEHeat.u, PHeat) annotation (Line(points={{58,-80},{40,-80},{40,-70},
          {40,-70},{40,-60},{110,-60}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2")));
end SimpleRC_Input;
