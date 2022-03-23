within TwoZoneApartmentHydronic.Components;
model HydronicSystem "Hydronic circuit"
  replaceable package MediumW = Buildings.Media.Water "Medium model";
  parameter Modelica.SIunits.MassFlowRate mflow_n= 700/3600 "nominal flow rate";
  parameter Modelica.SIunits.Pressure DP_n= 500 "nominal flow rate";
  parameter Integer QhpDes=5000 "Design Qhp";
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage ValNigZ(
    redeclare package Medium = MediumW,
    allowFlowReversal=true,
    linearized=true,
    dpValve_nominal(displayUnit="Pa") = DP_n,
    m_flow_nominal=mflow_n,
    riseTime=240,
    dpFixed_nominal=DP_n,
    from_dp=false,
    use_inputFilter=true)  "FloorHeatingValve" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={60,40})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temSup(redeclare package Medium =
        MediumW, m_flow_nominal=mflow_n)
    annotation (Placement(transformation(extent={{-5,-6},{5,6}},
        rotation=0,
        origin={-33,0})));
  Buildings.Fluid.FixedResistances.Junction splVal1(
    dp_nominal={DP_n,DP_n,DP_n},
    m_flow_nominal=mflow_n*{1,-1,-1},
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Flow splitter" annotation (Placement(transformation(
        extent={{-12,12},{12,-12}},
        rotation=0,
        origin={18,0})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage ValDayZ(
    redeclare package Medium = MediumW,
    allowFlowReversal=true,
    linearized=true,
    dpValve_nominal(displayUnit="Pa") = DP_n,
    m_flow_nominal=mflow_n,
    riseTime=240,
    dpFixed_nominal=DP_n,
    from_dp=false,
    use_inputFilter=true)  "Radiator valve" annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=0,
        origin={55,80})));
  Buildings.Fluid.FixedResistances.Junction splVal2(
    dp_nominal={DP_n,DP_n,DP_n},
    m_flow_nominal=mflow_n*{1,-1,1},
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState) "Flow splitter"
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-16,-50})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[2](redeclare each package
      Medium = MediumW)
    "Outlet port of Hydronic system" annotation (Placement(transformation(
          extent={{80,100},{100,20}}), iconTransformation(extent={{80,100},{100,
            20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-212,-94},{-180,-66}}),
        iconTransformation(extent={{-200,22},{-160,62}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_a[2](redeclare package Medium =
          MediumW)                          "Return water from rooms"
    annotation (Placement(transformation(extent={{80,-100},{100,-20}}),
        iconTransformation(extent={{80,-100},{100,-20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort DayZRet(redeclare package Medium
      = MediumW, m_flow_nominal=mflow_n)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=0,
        origin={40,-40})));
  Buildings.Fluid.Sensors.TemperatureTwoPort NigZRet(redeclare package Medium
      = MediumW, m_flow_nominal=mflow_n)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=0,
        origin={64,-80})));
  Modelica.Blocks.Interfaces.RealInput ValConDayZon "Valve control day zone"
    annotation (Placement(transformation(extent={{-215,70},{-184,102}}),
        iconTransformation(extent={{-199,-66},{-172,-38}})));
  Buildings.Fluid.Sensors.MassFlowRate mflowTotin(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-20,-6},{-8,6}})));
  Buildings.Fluid.Sensors.MassFlowRate m_flowDayZin(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{22,14},{34,26}})));
  Buildings.Fluid.Sensors.MassFlowRate m_flowNigZin(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{36,-6},{48,6}})));
  Buildings.Fluid.Sensors.MassFlowRate m_flowNigZout(redeclare package Medium
      = MediumW)
    annotation (Placement(transformation(extent={{30,-86},{18,-74}})));
  Buildings.Fluid.Sensors.MassFlowRate m_flowDayZout(redeclare package Medium
      = MediumW)
    annotation (Placement(transformation(extent={{22,-46},{10,-34}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                               pump(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=true,
    addPowerToMedium=false,
    use_inputFilter=true,
    m_flow_nominal=mflow_n,
    nominalValuesDefineDefaultPressureCurve=true,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    riseTime=10,
    dp_nominal=25000,
    constantMassFlowRate=mflow_n)        "Pump"
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
  Buildings.Fluid.Sources.Boundary_pT BoundaryConditions(
    redeclare package Medium = MediumW,
    use_p_in=false,
    p(displayUnit="Pa") = 300000,
    nPorts=1) "Boundary condition for flow source"
    annotation (Placement(transformation(extent={{-166,34},{-154,46}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThresholdValDayZ(threshold=
        0.9) annotation (Placement(transformation(extent={{26,68},{6,88}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThresholdValNigZ(threshold=
        0.9) annotation (Placement(transformation(extent={{26,40},{6,60}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temDis_out(redeclare package
      Medium = MediumW, m_flow_nominal=mflow_n) annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-72,-40})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-62,20})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTHea(u(
      unit="K",
      min=273.15,
      max=273.15 + 45), description="Heat system supply temperature")
    "Overwrite for heating system supply temperature "
    annotation (Placement(transformation(extent={{-146,-88},{-130,-72}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTHeat(y(unit="K"), description=
        "Heat system supply temperature")
    "Read for heating system supply temperature "
    annotation (Placement(transformation(extent={{-120,-88},{-104,-72}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveMDayZ(u(
      unit="1",
      min=0,
      max=1), description="Signal Day zone valve")
    "Overwrite day zone valve signal" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-170,86})));
  IBPSA.Utilities.IO.SignalExchange.Read reaMDayZ(y(unit="1"), description=
        "Signal Day zone valve") "Overwrite day zone valve signal"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-146,86})));
  IBPSA.Utilities.IO.SignalExchange.Read reaMNigZ(y(unit="1"), description=
        "Signal Night zone valve") "Overwrite night zone valve signal"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-146,60})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveMNigZ(u(
      unit="1",
      min=0,
      max=1), description="Signal Night zone valve")
    "Overwrite night zone valve signal" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-170,60})));
  Buildings.Controls.SetPoints.Table HeatingCurve(table=[273.15 - 8,45;
        273.15,43; 22 + 273.15,22], offset=273.15)
    annotation (Placement(transformation(extent={{-174,-88},{-158,-72}})));
  IBPSA.Utilities.IO.SignalExchange.Read TretFloHea(description=
        "Zone return temperature floor heating", y(unit="K"))
    "Return temperature Floor heating"
    annotation (Placement(transformation(extent={{-54,-38},{-36,-20}})));
  TwoZoneApartmentHydronic.Components.HP_AirWater_TSet AirHeaPum(
    dp_nominal=1,
    tauHeatLoss=3600,
    cDry=10000,
    mWater=4,
    QNom=QhpDes,
    redeclare package Medium = MediumW,
    m_flow_nominal=mflow_n)
    annotation (Placement(transformation(extent={{-188,-6},{-158,26}})));
  IBPSA.Utilities.IO.SignalExchange.Read PeleHeaPum(
    description="Electric consumption of the heat pump",
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Electric consumption heat pump"
    annotation (Placement(transformation(extent={{-174,-28},{-158,-12}})));
  Modelica.Blocks.Sources.RealExpression COPhp(y=AirHeaPum.COP)
    annotation (Placement(transformation(extent={{-196,-48},{-168,-32}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaCOPhp(
    description="air source heat pump COP",
    y(unit="1"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
    "Electric consumption heat pump"
    annotation (Placement(transformation(extent={{-152,-48},{-136,-32}})));
  Modelica.Blocks.Interfaces.RealInput ValConNigZon "Valve control night zone"
    annotation (Placement(transformation(extent={{-215,44},{-184,76}}),
        iconTransformation(extent={{-199,-98},{-172,-70}})));
  Modelica.Blocks.Math.Gain gainValNigZon(k=mflow_n/2)
    "Multply by Night Zone nominal flow rate" annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-44,50})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-14,78})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,50})));
  Modelica.Blocks.Math.Gain gainValDayZon(k=mflow_n/2)
    "Multply by Day Zone nominal flow rate" annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-44,78})));
equation
  connect(ValDayZ.port_b, ports_b[1]) annotation (Line(points={{62,80},{90,80}},
                                            color={0,127,255}));
  connect(ValNigZ.port_b, ports_b[2]) annotation (Line(points={{68,40},{90,40}},
                                    color={0,127,255}));
  connect(ports_a[1], DayZRet.port_a) annotation (Line(points={{90,-80},{90,-40},
          {48,-40}},                            color={0,127,255}));
  connect(ports_a[2], NigZRet.port_a) annotation (Line(points={{90,-40},{90,-80},
          {72,-80}},                            color={0,127,255}));
  connect(mflowTotin.port_b, splVal1.port_1) annotation (Line(points={{-8,0},{6,
          0}},                    color={0,127,255}));
  connect(splVal1.port_3, m_flowDayZin.port_a) annotation (Line(points={{18,12},
          {18,20},{22,20}},            color={0,127,255}));
  connect(m_flowDayZin.port_b, ValDayZ.port_a) annotation (Line(points={{34,20},
          {40,20},{40,80},{48,80}},    color={0,127,255}));
  connect(splVal1.port_2, m_flowNigZin.port_a) annotation (Line(points={{30,0},{
          36,0}},                      color={0,127,255}));
  connect(m_flowNigZin.port_b, ValNigZ.port_a) annotation (Line(points={{48,0},{
          48,40},{52,40}},           color={0,127,255}));
  connect(NigZRet.port_b, m_flowNigZout.port_a) annotation (Line(points={{56,-80},
          {30,-80}},                   color={0,127,255}));
  connect(m_flowNigZout.port_b, splVal2.port_1) annotation (Line(points={{18,-80},
          {0,-80},{0,-60},{-16,-60}}, color={0,127,255}));
  connect(DayZRet.port_b, m_flowDayZout.port_a) annotation (Line(points={{32,-40},
          {22,-40}},                   color={0,127,255}));
  connect(m_flowDayZout.port_b, splVal2.port_3) annotation (Line(points={{10,-40},
          {0,-40},{0,-50},{-6,-50}}, color={0,127,255}));
  connect(pump.port_b, temSup.port_a) annotation (Line(points={{-56,0},{-38,0}},
                                     color={0,127,255}));
  connect(ValDayZ.y_actual, greaterThresholdValDayZ.u) annotation (Line(
        points={{58.5,85.6},{34.75,85.6},{34.75,78},{28,78}},       color={0,
          0,127}));
  connect(ValNigZ.y_actual, greaterThresholdValNigZ.u) annotation (Line(
        points={{64,45.6},{60.5,45.6},{60.5,50},{28,50}},   color={0,0,127}));
  connect(add.y, pump.m_flow_in) annotation (Line(points={{-62,11.2},{-62,7.2}},
                                     color={0,0,127}));
  connect(BoundaryConditions.ports[1], AirHeaPum.port_b) annotation (Line(
        points={{-154,40},{-154,19.6},{-158,19.6}}, color={0,127,255}));
  connect(splVal2.port_2, temDis_out.port_a) annotation (Line(points={{-16,-40},
          {-64,-40}},                          color={0,127,255}));
  connect(AirHeaPum.PEl, PeleHeaPum.u) annotation (Line(points={{-182,-6},{-182,
          -20},{-175.6,-20}}, color={0,0,127}));
  connect(booleanToReal1.y, gainValNigZon.u)
    annotation (Line(points={{-27,50},{-34.4,50}}, color={0,0,127}));
  connect(weaBus.TDryBul, HeatingCurve.u) annotation (Line(
      points={{-196,-80},{-175.6,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(HeatingCurve.y, oveTHea.u)
    annotation (Line(points={{-157.2,-80},{-147.6,-80}}, color={0,0,127}));
  connect(oveTHea.y, reaTHeat.u)
    annotation (Line(points={{-129.2,-80},{-121.6,-80}}, color={0,0,127}));
  connect(reaTHeat.y, AirHeaPum.TSet) annotation (Line(points={{-103.2,-80},{-102,
          -80},{-102,-60},{-200,-60},{-200,40},{-182,40},{-182,29.2}}, color={0,
          0,127}));
  connect(COPhp.y, reaCOPhp.u)
    annotation (Line(points={{-166.6,-40},{-153.6,-40}}, color={0,0,127}));
  connect(oveMNigZ.y, reaMNigZ.u)
    annotation (Line(points={{-161.2,60},{-155.6,60}}, color={0,0,127}));
  connect(ValConNigZon, oveMNigZ.u)
    annotation (Line(points={{-199.5,60},{-179.6,60}}, color={0,0,127}));
  connect(ValConDayZon, oveMDayZ.u)
    annotation (Line(points={{-199.5,86},{-179.6,86}}, color={0,0,127}));
  connect(oveMDayZ.y, reaMDayZ.u)
    annotation (Line(points={{-161.2,86},{-155.6,86}}, color={0,0,127}));
  connect(greaterThresholdValDayZ.y, booleanToReal.u)
    annotation (Line(points={{5,78},{-2,78}}, color={255,0,255}));
  connect(reaMDayZ.y, ValDayZ.y) annotation (Line(points={{-137.2,86},{-128,86},
          {-128,98},{55,98},{55,89.6}}, color={0,0,127}));
  connect(reaMNigZ.y, ValNigZ.y) annotation (Line(points={{-137.2,60},{-120,60},
          {-120,94},{72,94},{72,58},{60,58},{60,49.6}}, color={0,0,127}));
  connect(gainValDayZon.u, booleanToReal.y)
    annotation (Line(points={{-34.4,78},{-25,78}}, color={0,0,127}));
  connect(AirHeaPum.port_b, pump.port_a) annotation (Line(points={{-158,19.6},{-100,
          19.6},{-100,0},{-68,0}}, color={0,127,255}));
  connect(temSup.port_b, mflowTotin.port_a)
    annotation (Line(points={{-28,0},{-20,0}}, color={0,127,255}));
  connect(booleanToReal1.u, greaterThresholdValNigZ.y)
    annotation (Line(points={{-4,50},{5,50}}, color={255,0,255}));
  connect(gainValNigZon.y, add.u2) annotation (Line(points={{-52.8,50},{-57.2,50},
          {-57.2,29.6}}, color={0,0,127}));
  connect(gainValDayZon.y, add.u1) annotation (Line(points={{-52.8,78},{-66.8,78},
          {-66.8,29.6}}, color={0,0,127}));
  connect(AirHeaPum.port_a, temDis_out.port_b) annotation (Line(points={{-158,0.4},
          {-140,0.4},{-140,0},{-120,0},{-120,-40},{-80,-40}}, color={0,127,255}));
  connect(temDis_out.T, TretFloHea.u) annotation (Line(points={{-72,-31.2},{-72,
          -29},{-55.8,-29}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-200,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{100,100}})),
    Documentation(info="<html>
<ul>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"));
end HydronicSystem;
