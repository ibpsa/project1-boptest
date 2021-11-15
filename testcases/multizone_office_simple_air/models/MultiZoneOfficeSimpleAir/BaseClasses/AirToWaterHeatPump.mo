within MultiZoneOfficeSimpleAir.BaseClasses;
model AirToWaterHeatPump "Air to water heat pump model"
  replaceable package MediumA = Buildings.Media.Air "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";
  Modelica.Blocks.Sources.Constant TSetHws(k=TSetSup)
    "Heat pump water supply temperature set point"
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData conSou(
    redeclare package Medium = MediumA,
    m_flow=heaPum.m2_flow_nominal,
    nPorts=1)
    "Source for condenser air"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Fluid.Sources.Boundary_pT conSin(redeclare package Medium = MediumA,
      nPorts=1)
    "Sink for condenser air flow"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a ret(redeclare package Medium = MediumW)
                                            "Return water port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b sup(redeclare package Medium = MediumW)
                                            "Supply water port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Blocks.Interfaces.RealOutput PHeaPum
    "Electric power consumed by heat pump"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPHeaPum(
    description="Electric power consumed by heat pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by heat pump"
    annotation (Placement(transformation(extent={{76,90},{96,110}})));
  parameter Modelica.SIunits.Temperature TSetSup
  "Supply water temperature set point";
  parameter Modelica.SIunits.HeatFlowRate QCon_flow_max = Modelica.Constants.inf
    "Maximum heat flow rate for heating";
  Buildings.Fluid.HeatPumps.Carnot_TCon heaPum(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    QCon_flow_nominal=QCon_flow_max,
    etaCarnot_nominal=0.3,
    dp1_nominal=0,
    dp2_nominal=0,
    QCon_flow_max=QCon_flow_max)
    annotation (Placement(transformation(extent={{40,16},{20,-4}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumW, m_flow_nominal=heaPum.m1_flow_nominal)
    "Supply flow sensor for heat pump"
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package Medium =
        MediumW, m_flow_nominal=heaPum.m1_flow_nominal)
    "Return water tempearture sensor"
    annotation (Placement(transformation(extent={{80,10},{60,-10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRet(
    description="Return water temperature of heat pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return water temperature of heat pump"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));

  Buildings.Utilities.IO.SignalExchange.Read reaFloSup(
    description="Supply water flow rate of heat pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply water flow rate of heat pump"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

  Buildings.Fluid.Movers.FlowControlled_dp pum(
    redeclare package Medium = MediumW,
    m_flow_nominal=heaPum.m1_flow_nominal,
    addPowerToMedium=false) "Heat pump water pump"
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
        MediumW, m_flow_nominal=heaPum.m1_flow_nominal)
           "Return water tempearture sensor" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={0,-20})));
  Buildings.Fluid.Sources.Boundary_pT refPres(redeclare package Medium =
        MediumW, nPorts=1) "Reference pressure"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Constant dp(k=6000) "Chilled water pump"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTSup(
    description="Supply water temperature of heat pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply water temperature of heat pump"
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));

equation
  connect(conSou.weaBus, weaBus) annotation (Line(
      points={{-80,30.2},{-80,100},{-100,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(reaPHeaPum.y, PHeaPum)
    annotation (Line(points={{97,100},{110,100}}, color={0,0,127}));
  connect(TSetHws.y, heaPum.TSet) annotation (Line(points={{39,90},{30,90},{30,40},
          {52,40},{52,-3},{42,-3}}, color={0,0,127}));
  connect(conSou.ports[1], heaPum.port_a2) annotation (Line(points={{-60,30},{0,
          30},{0,12},{20,12}}, color={0,127,255}));
  connect(heaPum.port_b2, conSin.ports[1]) annotation (Line(points={{40,12},{60,
          12},{60,30},{80,30}}, color={0,127,255}));
  connect(reaPHeaPum.u, heaPum.P) annotation (Line(points={{74,100},{68,100},{68,
          20},{10,20},{10,6},{19,6}}, color={0,0,127}));
  connect(senSupFlo.port_b, sup)
    annotation (Line(points={{-90,0},{-100,0}}, color={0,127,255}));
  connect(ret, senTemRet.port_a)
    annotation (Line(points={{100,0},{80,0}}, color={0,127,255}));
  connect(senTemRet.port_b, heaPum.port_a1)
    annotation (Line(points={{60,0},{40,0}}, color={0,127,255}));
  connect(senTemRet.T, reaTRet.u) annotation (Line(points={{70,-11},{70,-20},{
          50,-20},{50,-50},{58,-50}},           color={0,0,127}));
  connect(senSupFlo.V_flow, reaFloSup.u) annotation (Line(points={{-80,11},{-80,
          16},{-50,16},{-50,-70},{-42,-70}},
                                           color={0,0,127}));
  connect(heaPum.port_b1, senTemSup.port_a) annotation (Line(points={{20,0},{14,
          0},{14,-20},{10,-20}}, color={0,127,255}));
  connect(senTemSup.port_b, pum.port_a)
    annotation (Line(points={{-10,-20},{-20,-20}}, color={0,127,255}));
  connect(pum.port_b, senSupFlo.port_a) annotation (Line(points={{-40,-20},{-60,
          -20},{-60,0},{-70,0}}, color={0,127,255}));
  connect(refPres.ports[1], senSupFlo.port_a)
    annotation (Line(points={{-60,-70},{-60,0},{-70,0}}, color={0,127,255}));
  connect(dp.y, pum.dp_in)
    annotation (Line(points={{-39,90},{-30,90},{-30,-8}}, color={0,0,127}));
  connect(senTemSup.T, reaTSup.u)
    annotation (Line(points={{0,-31},{0,-80},{58,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirToWaterHeatPump;
