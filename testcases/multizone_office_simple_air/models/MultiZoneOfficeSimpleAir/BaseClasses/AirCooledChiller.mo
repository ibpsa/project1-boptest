within MultiZoneOfficeSimpleAir.BaseClasses;
model AirCooledChiller "Air cooled chiller model"
  replaceable package MediumA = Buildings.Media.Air "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";
  Buildings.Fluid.Chillers.Carnot_TEva chi(
    redeclare package Medium1 = MediumA,
    redeclare package Medium2 = MediumW,
    QEva_flow_nominal=QEva_flow_min,
    etaCarnot_nominal=0.3,
    dp1_nominal=0,
    dp2_nominal=0,
    QEva_flow_min=QEva_flow_min)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Sources.Constant TSetChws(k=273.15 + 12)
    "Chilled water temperature set point"
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData conSou(
    redeclare package Medium = MediumA,
    m_flow=chi.m1_flow_nominal,                             nPorts=1)
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
    annotation (Placement(transformation(extent={{76,90},{96,110}})));
  parameter Modelica.SIunits.HeatFlowRate QEva_flow_min
    "Maximum heat flow rate for cooling (negative)";
  Buildings.Fluid.Sources.Boundary_pT sinChw(
    redeclare package Medium = MediumW,
    p=300000,
    T=285.15,
    nPorts=1) "Sink" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={10,-50})));
  Buildings.Fluid.Sources.Boundary_pT souChw(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=285.15,
    nPorts=1) "Source" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-50,-50})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package Medium
      = MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Return water tempearture sensor"
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTRet(
    description="Return water temperature of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Return water temperature of chiller"
    annotation (Placement(transformation(extent={{62,-60},{82,-40}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Supply flow sensor for heat pump"
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  Buildings.Utilities.IO.SignalExchange.Read reaFloSup(
    description="Supply water flow rate of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="m3/s")) "Supply water flow rate of chiller"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
equation
  connect(TSetChws.y, chi.TSet) annotation (Line(points={{39,90},{14,90},{14,0},
          {18,0},{18,-1}}, color={0,0,127}));
  connect(conSou.ports[1], chi.port_a1) annotation (Line(points={{-60,30},{0,30},
          {0,-4},{20,-4}},   color={0,127,255}));
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
  connect(chi.P, reaPChi.u) annotation (Line(points={{41,-10},{50,-10},{50,40},{
          70,40},{70,100},{74,100}}, color={0,0,127}));
  connect(reaPChi.y, PChi)
    annotation (Line(points={{97,100},{110,100}}, color={0,0,127}));
  connect(chi.port_b2, sinChw.ports[1])
    annotation (Line(points={{20,-16},{10,-16},{10,-40}}, color={0,127,255}));
  connect(senTemRet.T,reaTRet. u) annotation (Line(points={{72,11},{72,14},{92,
          14},{92,-20},{50,-20},{50,-50},{60,-50}},
                                                color={0,0,127}));
  connect(senSupFlo.V_flow,reaFloSup. u) annotation (Line(points={{-70,11},{-70,
          16},{-60,16},{-60,10},{-42,10}}, color={0,0,127}));
  connect(souChw.ports[1], senSupFlo.port_a)
    annotation (Line(points={{-50,-40},{-50,0},{-60,0}}, color={0,127,255}));
  connect(senSupFlo.port_b, sup)
    annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
  connect(chi.port_a2, senTemRet.port_b) annotation (Line(points={{40,-16},{60,
          -16},{60,0},{62,0}}, color={0,127,255}));
  connect(senTemRet.port_a, ret)
    annotation (Line(points={{82,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirCooledChiller;
