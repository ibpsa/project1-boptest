within ;
model TwoZones
  "A simple thermal R2C2 model of two symmetric zones: north and south. It has sinusoidal outside air temperature and a feedback controlled heaters."
  parameter String zonNorName="North" "Parameter used to designate north zone";
  parameter String zonSouName="South" "Parameter used to designate south zone";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capSou(C=1e6)
    "Thermal capacitance of south zone"
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor resSou(R=0.01)
    "Thermal resistance of south zone to outside"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZonSou
    "Room air temperature sensor of south zone"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    "Set the outside air temperature"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10) "Artificial outside air temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Step setSou(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24) "Room temperature sepoint for south zone"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Continuous.LimPID conSou(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    "Feedback controller of south zone for the heater based on room temperature"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveActSou(u(
      unit="W",
      min=-10000,
      max=10000), description="Heater thermal power of south zone")
    "Overwrite the heating power of south zone"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaSou
    "Set the heating power to the south zone"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Math.Gain effSou(k=1/0.99) "Heater efficiency in south zone"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  IBPSA.Utilities.IO.SignalExchange.Read TRooAirSou(
    y(unit="K"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    description="Zone air temperature of south zone",
    zone=zonSouName)   "Read the room air temperature of south zone"
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));

  IBPSA.Utilities.IO.SignalExchange.Read PHeaCooSou(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heater power of south zone")
                                "Read the heater power consumed in south zone"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));

  Modelica.Blocks.Math.Abs absSou
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  IBPSA.Utilities.IO.SignalExchange.Read CO2RooAirSou(
    y(unit="ppm"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Zone air CO2 concentration of south zone",
    zone=zonSouName)   "Read the room air CO2 concentration in south zone"
    annotation (Placement(transformation(extent={{160,-40},{180,-20}})));

  Modelica.Blocks.Sources.Sine conCO2Sou(
    amplitude=250,
    freqHz=1/(3600*24),
    offset=750) "Concetration of CO2 in south zone"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capNor(C=1e6)
    "Thermal capacitance of north zone"
    annotation (Placement(transformation(extent={{30,60},{50,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor resNor(R=0.01)
    "Thermal resistance of north zone to outside"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZonNor
    "Room air temperature sensor of north zone"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.Step setNor(
    height=2,
    offset=273.15 + 20,
    startTime=3600*24) "Room temperature sepoint for north zone"
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Modelica.Blocks.Continuous.LimPID conNor(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=2000,
    yMin=0,
    yMax=100000)
    "Feedback controller of north zone for the heater based on room temperature"
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveActNor(u(
      unit="W",
      min=-10000,
      max=10000), description="Heater thermal power of north zone")
    "Overwrite the heating power of north zone"
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaNor
    "Set the heating power to the north zone"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Modelica.Blocks.Math.Gain effNor(k=1/0.99) "Heater efficiency in north zone"
    annotation (Placement(transformation(extent={{0,150},{20,170}})));
  IBPSA.Utilities.IO.SignalExchange.Read TRooAirNor(
    y(unit="K"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    description="Zone air temperature of north zone",
    zone=zonNorName)   "Read the room air temperature of north zone"
    annotation (Placement(transformation(extent={{80,120},{60,140}})));

  IBPSA.Utilities.IO.SignalExchange.Read PHeaCooNor(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heater power of north zone")
                                "Read the heater power consumed in north zone"
    annotation (Placement(transformation(extent={{80,150},{100,170}})));

  Modelica.Blocks.Math.Abs absNor
    annotation (Placement(transformation(extent={{30,150},{50,170}})));
  IBPSA.Utilities.IO.SignalExchange.Read CO2RooAirNor(
    y(unit="ppm"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    description="Zone air CO2 concentration of north zone",
    zone=zonNorName)   "Read the room air CO2 concentration in north zone"
    annotation (Placement(transformation(extent={{160,80},{180,100}})));

  Modelica.Blocks.Sources.Sine conCO2Nor(
    amplitude=250,
    freqHz=1/(3600*24),
    offset=750) "Concetration of CO2 in north zone"
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
equation
  connect(resSou.port_b, capSou.port)
    annotation (Line(points={{20,0},{40,0}}, color={191,0,0}));
  connect(capSou.port, senTZonSou.port)
    annotation (Line(points={{40,0},{60,0}}, color={191,0,0}));
  connect(preTOut.port, resSou.port_a) annotation (Line(points={{-20,30},{-10,30},
          {-10,0},{0,0}}, color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,30},{-42,30}},
                                               color={0,0,127}));
  connect(conSou.y, oveActSou.u)
    annotation (Line(points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(oveActSou.y, preHeaSou.Q_flow)
    annotation (Line(points={{-19,-30},{0,-30}}, color={0,0,127}));
  connect(preHeaSou.port, capSou.port)
    annotation (Line(points={{20,-30},{40,-30},{40,0}}, color={191,0,0}));
  connect(oveActSou.y, effSou.u) annotation (Line(points={{-19,-30},{-10,-30},{-10,
          -80},{-2,-80}}, color={0,0,127}));
  connect(setSou.y, conSou.u_s)
    annotation (Line(points={{-79,-30},{-72,-30}}, color={0,0,127}));
  connect(senTZonSou.T, TRooAirSou.u) annotation (Line(points={{80,0},{90,0},{90,
          -50},{82,-50}}, color={0,0,127}));
  connect(TRooAirSou.y, conSou.u_m)
    annotation (Line(points={{59,-50},{-60,-50},{-60,-42}}, color={0,0,127}));
  connect(effSou.y, absSou.u)
    annotation (Line(points={{21,-80},{28,-80}}, color={0,0,127}));
  connect(absSou.y, PHeaCooSou.u)
    annotation (Line(points={{51,-80},{78,-80}}, color={0,0,127}));
  connect(conCO2Sou.y, CO2RooAirSou.u)
    annotation (Line(points={{141,-30},{158,-30}}, color={0,0,127}));
  connect(resNor.port_b, capNor.port)
    annotation (Line(points={{20,60},{40,60}}, color={191,0,0}));
  connect(capNor.port, senTZonNor.port)
    annotation (Line(points={{40,60},{60,60}}, color={191,0,0}));
  connect(preTOut.port, resNor.port_a) annotation (Line(points={{-20,30},{-10,30},
          {-10,60},{0,60}}, color={191,0,0}));
  connect(conNor.y, oveActNor.u)
    annotation (Line(points={{-49,100},{-42,100}}, color={0,0,127}));
  connect(oveActNor.y, preHeaNor.Q_flow)
    annotation (Line(points={{-19,100},{0,100}}, color={0,0,127}));
  connect(setNor.y, conNor.u_s)
    annotation (Line(points={{-79,100},{-72,100}}, color={0,0,127}));
  connect(effNor.y, absNor.u)
    annotation (Line(points={{21,160},{28,160}}, color={0,0,127}));
  connect(absNor.y, PHeaCooNor.u)
    annotation (Line(points={{51,160},{78,160}}, color={0,0,127}));
  connect(conCO2Nor.y, CO2RooAirNor.u)
    annotation (Line(points={{141,90},{158,90}}, color={0,0,127}));
  connect(senTZonNor.T, TRooAirNor.u) annotation (Line(points={{80,60},{90,60},{
          90,130},{82,130}}, color={0,0,127}));
  connect(effNor.u, preHeaNor.Q_flow) annotation (Line(points={{-2,160},{-10,160},
          {-10,100},{0,100}}, color={0,0,127}));
  connect(TRooAirNor.y, conNor.u_m)
    annotation (Line(points={{59,130},{-60,130},{-60,112}}, color={0,0,127}));
  connect(preHeaNor.port, capNor.port)
    annotation (Line(points={{20,100},{40,100},{40,60}}, color={191,0,0}));
  annotation (uses(Modelica(version="3.2.2"), IBPSA(version="3.0.0")),
      experiment(
      StopTime=60,
      Interval=1,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-100,-100},{220,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{220,180}})));
end TwoZones;
