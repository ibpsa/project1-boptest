within MultiZoneOfficeSimpleAir.BaseClasses;
model AirCooledChiller "Air cooled chiller model (York YCAL0033EE)"
  replaceable package MediumA = Buildings.Media.Air "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";
  Buildings.Fluid.Chillers.ElectricEIR chi(
    redeclare package Medium1 = MediumA,
    redeclare package Medium2 = MediumW,
    dp1_nominal=0,
    dp2_nominal=0,
    per=Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_York_YCAL0033EE_101kW_3_1COP_AirCooled())
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Sources.Constant TSetChws(k=TSetSup)
    "Chilled water temperature set point"
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData conSou(
    redeclare package Medium = MediumA,
    m_flow=chi.m1_flow_nominal,
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
  Modelica.Blocks.Interfaces.RealOutput PChi
    "Electric power consumed by chiller"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPChi(
    description="Electric power consumed by chiller",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by chiller"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Electric_Power_Sensor;
          qudt:hasQuantityKind quantitykind:ElectricPower;
          qudt:hasUnit qudt:W.
          ")),
      Placement(transformation(extent={{76,90},{96,110}})));
  parameter Modelica.SIunits.Temperature TSetSup
  "Supply water temperature set point";
  parameter Modelica.SIunits.HeatFlowRate QEva_flow_min = -Modelica.Constants.inf
    "Maximum heat flow rate for cooling (negative)";
  parameter Modelica.SIunits.PressureDifference dp_nominal=45000
    "Nominal pump head";
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package Medium =
        MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Return water tempearture sensor"
    annotation (Placement(transformation(extent={{80,10},{60,-10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRet(
    description="Return water temperature of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return water temperature of chiller"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Chilled_Water_Temperature_Sensor;
          qudt:hasQuantityKind quantitykind:Temperature;
          qudt:hasUnit qudt:K.
          ")),
          Placement(transformation(extent={{60,-60},{80,-40}})));

  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Supply flow sensor for heat pump"
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaFloSup(
    description="Supply water flow rate of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply water flow rate of chiller"
    annotation (      __Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Chilled_Water_Flow_Sensor;
          qudt:hasQuantityKind quantitykind:VolumeFlowRate;
          qudt:hasUnit qudt:M3-PER-SEC.
          ")),
          Placement(transformation(extent={{-40,-80},{-20,-60}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(
    redeclare package Medium = MediumW,
    m_flow_nominal=chi.m2_flow_nominal) "Return water tempearture sensor"
                                             annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={0,-20})));
  Buildings.Fluid.Movers.FlowControlled_dp pum(
    redeclare package Medium = MediumW,
    m_flow_nominal=chi.m2_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=dp_nominal)  "Chilled water pump"
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Constant dp(k=dp_nominal)
                                              "Chilled water pump"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Buildings.Fluid.Sources.Boundary_pT refPres(redeclare package Medium =
        MediumW, nPorts=1) "Reference pressure"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTSup(
    description="Supply water temperature of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply water temperature of chiller"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Chilled_Water_Temperature_Sensor;
          qudt:hasQuantityKind quantitykind:Temperature;
          qudt:hasUnit qudt:K.
          ")),
          Placement(transformation(extent={{60,-90},{80,-70}})));

  Modelica.Blocks.Sources.BooleanConstant on(k=true) "Chiller on"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));

  Modelica.Blocks.Interfaces.RealOutput PPum
    "Electric power consumed by distribution pump"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPPumDis(
    description="Electric power consumed by chilled water distribution pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by distribution pump"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Electric_Power_Sensor;
          qudt:hasQuantityKind quantitykind:ElectricPower;
          qudt:hasUnit qudt:W.
          ")),
      Placement(transformation(extent={{76,70},{96,90}})));

equation
  connect(TSetChws.y, chi.TSet) annotation (Line(points={{39,90},{10,90},{10,-12},
          {18,-12},{18,-13}},
                           color={0,0,127}));
  connect(chi.port_b1, conSin.ports[1]) annotation (Line(points={{40,-4},{42,-4},
          {42,30},{80,30}}, color={0,127,255}));
  connect(conSou.weaBus, weaBus) annotation (Line(
      points={{-80,30.2},{-80,100},{-100,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(chi.P, reaPChi.u) annotation (Line(points={{41,-1},{50,-1},{50,40},{70,
          40},{70,100},{74,100}},    color={0,0,127}));
  connect(reaPChi.y, PChi)
    annotation (Line(points={{97,100},{110,100}}, color={0,0,127}));
  connect(senTemRet.T,reaTRet. u) annotation (Line(points={{70,-11},{70,-20},{
          50,-20},{50,-50},{58,-50}},           color={0,0,127}));
  connect(senSupFlo.V_flow,reaFloSup. u) annotation (Line(points={{-80,11},{-80,
          20},{-50,20},{-50,-70},{-42,-70}},
                                           color={0,0,127}));
  connect(senSupFlo.port_b, sup)
    annotation (Line(points={{-90,0},{-100,0}}, color={0,127,255}));
  connect(chi.port_a2, senTemRet.port_b) annotation (Line(points={{40,-16},{60,
          -16},{60,0}},        color={0,127,255}));
  connect(senTemRet.port_a, ret)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(chi.port_b2, senTemSup.port_a)
    annotation (Line(points={{20,-16},{20,-20},{10,-20}}, color={0,127,255}));
  connect(senTemSup.port_b, pum.port_a)
    annotation (Line(points={{-10,-20},{-20,-20}}, color={0,127,255}));
  connect(pum.port_b, senSupFlo.port_a) annotation (Line(points={{-40,-20},{-60,
          -20},{-60,0},{-70,0}}, color={0,127,255}));
  connect(dp.y, pum.dp_in)
    annotation (Line(points={{-39,90},{-30,90},{-30,-8}}, color={0,0,127}));
  connect(refPres.ports[1], senSupFlo.port_a)
    annotation (Line(points={{-60,-70},{-60,0},{-70,0}}, color={0,127,255}));
  connect(senTemSup.T, reaTSup.u)
    annotation (Line(points={{0,-31},{0,-80},{58,-80}}, color={0,0,127}));
  connect(on.y, chi.on) annotation (Line(points={{1,70},{8,70},{8,-7},{18,-7}},
        color={255,0,255}));
  connect(conSou.ports[1], chi.port_a1) annotation (Line(points={{-60,30},{-38,30},
          {-38,32},{0,32},{0,-4},{20,-4}}, color={0,127,255}));
  connect(reaPPumDis.y, PPum)
    annotation (Line(points={{97,80},{110,80}}, color={0,0,127}));
  connect(reaPPumDis.u, pum.P) annotation (Line(points={{74,80},{68,80},{68,42},
          {-44,42},{-44,-11},{-41,-11}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirCooledChiller;
