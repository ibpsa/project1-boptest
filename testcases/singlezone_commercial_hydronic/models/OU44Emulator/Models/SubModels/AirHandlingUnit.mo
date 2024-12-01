within OU44Emulator.Models.SubModels;
model AirHandlingUnit
    Buildings.Fluid.Movers.SpeedControlled_y fanSu(
      addPowerToMedium=false,
      redeclare package Medium = Air,
      redeclare Data.AhuFanx4 per,
    allowFlowReversal=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(
                                                 redeclare package Medium = Air,
      m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(
                                                        redeclare package
      Medium =
          Air,
      m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
    ControlledEffectivenessNTU                           hex(
      redeclare package Medium1 = Air,
      redeclare package Medium2 = Air,
      allowFlowReversal1=false,
      allowFlowReversal2=false,
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m_flow_nominal,
      dp1_nominal=150,
      dp2_nominal=150,
    linearizeFlowResistance1=true,
    linearizeFlowResistance2=true,
    eps_nominal=0.80)
      annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(
                                                        redeclare package
      Medium =
          Air,
      m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
    Buildings.Fluid.Sensors.VolumeFlowRate senVolFloEx(
                                                 redeclare package Medium = Air,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal)
      annotation (Placement(transformation(extent={{48,30},{28,50}})));
    Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air)
      annotation (Placement(transformation(extent={{132,-40},{152,-20}})));
    Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air)
      annotation (Placement(transformation(extent={{102,40},{122,60}})));
    Buildings.Fluid.Movers.SpeedControlled_y fanEx(
      addPowerToMedium=false,
      redeclare package Medium = Air,
      redeclare Data.AhuFanx4 per,
    allowFlowReversal=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
      annotation (Placement(transformation(extent={{-68,30},{-88,50}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                        redeclare package
      Medium =
          Air,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal)
      annotation (Placement(transformation(extent={{-96,30},{-116,50}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                        redeclare package
      Medium =
          Air,
      m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                        redeclare package
      Medium =
          Air,
      m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
      annotation (Placement(transformation(extent={{108,-50},{128,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air)
      annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air)
      annotation (Placement(transformation(extent={{150,30},{170,50}})));
    Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-60,110})));
    replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"}) constrainedby
    Modelica.Media.Interfaces.PartialMedium;
    replaceable package Water = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;
    Modelica.Blocks.Interfaces.RealOutput qel annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-100,-106})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-72,-84},{-92,-64}})));
    Buildings.Fluid.Sources.Outside outEx(nPorts=1, redeclare package Medium =
          Air,
    use_C_in=true)
      annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
    Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package Medium =
          Air,
    use_C_in=true)
      annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
            extent={{-200,104},{-180,124}})));
    Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU
                                                         coil(redeclare package
      Medium1 =   Air,
      redeclare package Medium2 = Water,
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m2_flow_nominal,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dp1_nominal=200,
    linearizeFlowResistance1=true,
    linearizeFlowResistance2=true,
    dp2_nominal=15000,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    use_Q_flow_nominal=true,
    Q_flow_nominal=-250000,
    T_a1_nominal=287.15,
    T_a2_nominal=328.15)
      annotation (Placement(transformation(extent={{48,-56},{68,-36}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=20
      "Nominal mass flow rate - air";
    parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=2
      "Nominal mass flow rate - water";
    Modelica.Blocks.Interfaces.RealOutput Tsu annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={166,-80})));
  Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
    annotation (Placement(transformation(extent={{-98,-10},{-118,10}})));
  Buildings.Fluid.FixedResistances.PressureDrop resEx(
    redeclare package Medium = Air,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=150,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{90,30},{70,50}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoilIn(
    allowFlowReversal=false,
    redeclare package Medium = Water,
    m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{94,-82},{74,-62}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFanRet(description=
        "AHU return fan speed control signal", u(
      min=0,
      max=1,
      unit="1")) "Overwirte for return fan speed control signal"
    annotation (Placement(transformation(extent={{-28,70},{-48,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSup(description=
        "AHU supply fan speed control signal", u(
      min=0,
      max=1,
      unit="1")) "Overwrite for supply fan speed control signal" annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-60,52})));
  Buildings.Utilities.IO.SignalExchange.Read reaTSupAir(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="AHU supply air temperature") "Read supply air temperature"
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={131,-65})));

  Buildings.Utilities.IO.SignalExchange.Read reaTRetAir(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="AHU return air temperature") "Read returrn air temperature"
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-18,58})));

  Buildings.Utilities.IO.SignalExchange.Read reaFloSupAir(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"),
    description="AHU supply air volume flowrate")
    "Read supply air mass flow rate" annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={130,8})));

  Buildings.Utilities.IO.SignalExchange.Read reaTCoiSup(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="AHU heating coil supply water temperature")
    "Read heating coil supply water temperature" annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={120,-90})));

  Buildings.Utilities.IO.SignalExchange.Read reaTHeaRec(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description=
        "AHU air temperature exiting heat recovery in supply air stream")
    "Read air temperature exiting heat recovery in supply air stream"
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={20,-14})));

  Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PID,
      initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{-12,-8},{-32,12}})));
  Modelica.Blocks.Interfaces.RealInput TsupSet
    "Supply temperature setpoint for rotary wheel control" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-4,110})));
  Buildings.Utilities.IO.SignalExchange.Read reaFloExtAir(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"),
    description="AHU extract air volume flowrate")
    "Read extract air volume flow rate" annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={64,60})));

  Buildings.Controls.Continuous.LimPID conPIDfan(
    Td=300,
    Ti=10,
    k=0.005,
    yMin=0.2,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    reverseActing=true)
    annotation (Placement(transformation(extent={{22,70},{2,90}})));
equation
    connect(fanSu.port_a, senTemIn2.port_b)
      annotation (Line(points={{-10,-40},{-16,-40}}, color={0,127,255}));
    connect(senTemIn2.port_a, hex.port_b2) annotation (Line(points={{-36,-40},{
            -40,-40},{-40,-6},{-46,-6}}, color={0,127,255}));
    connect(senTemEx1.port_b, hex.port_a1) annotation (Line(points={{-38,40},
          {-44,40},{-44,6},{-46,6}},  color={0,127,255}));
    connect(hex.port_a2, senTemIn1.port_b) annotation (Line(points={{-66,-6},{-72,
            -6},{-72,-40},{-80,-40}},     color={0,127,255}));
    connect(senPreIn.port, senTemIn3.port_b)
      annotation (Line(points={{142,-40},{128,-40}}, color={0,127,255}));
    connect(senPreEx.port, port_a1)
      annotation (Line(points={{112,40},{160,40}}, color={0,127,255}));
    connect(senPreIn.port, port_b1) annotation (Line(points={{142,-40},{160,-40}},
                                  color={0,127,255}));
    connect(add.y, qel) annotation (Line(points={{-93,-74},{-100,-74},{-100,
          -106}},
          color={0,0,127}));
    connect(senTemEx2.port_b, outEx.ports[1])
      annotation (Line(points={{-116,40},{-120,40}}, color={0,127,255}));
    connect(senTemIn1.port_a, outSu.ports[1])
      annotation (Line(points={{-100,-40},{-120,-40}}, color={0,127,255}));
    connect(weaBus, outEx.weaBus) annotation (Line(
        points={{-160,-2},{-150,-2},{-150,4},{-140,4},{-140,40.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(weaBus, outSu.weaBus) annotation (Line(
        points={{-160,-2},{-150,-2},{-150,-6},{-140,-6},{-140,-39.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
  connect(cCO2.y, outEx.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
          32},{-142,32}}, color={0,0,127}));
  connect(cCO2.y, outSu.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
          -48},{-142,-48}}, color={0,0,127}));
  connect(senVolFloEx.port_a, resEx.port_b)
    annotation (Line(points={{48,40},{70,40}}, color={0,127,255}));
  connect(resEx.port_a, senPreEx.port)
    annotation (Line(points={{90,40},{112,40}}, color={0,127,255}));
  connect(port_a2, senTemCoilIn.port_a) annotation (Line(points={{100,-100},{100,
          -72},{94,-72}}, color={0,127,255}));
  connect(senTemCoilIn.port_b,coil. port_a2)
    annotation (Line(points={{74,-72},{68,-72},{68,-52}}, color={0,127,255}));
  connect(y, oveFanSup.u)
    annotation (Line(points={{-60,110},{-60,61.6}}, color={0,0,127}));
  connect(senTemIn3.T, reaTSupAir.u) annotation (Line(points={{118,-29},{118,
          -20},{131,-20},{131,-56.6}}, color={0,0,127}));
  connect(reaTSupAir.y, Tsu) annotation (Line(points={{131,-72.7},{131,-80},{
          166,-80}}, color={0,0,127}));
  connect(senTemEx1.T, reaTRetAir.u) annotation (Line(points={{-28,51},{-28,58},
          {-25.2,58}},                    color={0,0,127}));
  connect(senTemCoilIn.T, reaTCoiSup.u) annotation (Line(points={{84,-61},{92,
          -61},{92,-60},{106,-60},{106,-90},{112.8,-90}}, color={0,0,127}));
  connect(coil.port_b2, port_b2) annotation (Line(points={{48,-52},{40,-52},{
          40,-100}}, color={0,127,255}));
  connect(senTemIn2.T, reaTHeaRec.u) annotation (Line(points={{-26,-29},{-26,
          -26},{-6,-26},{-6,-14},{12.8,-14}}, color={0,0,127}));
  connect(oveFanRet.y, fanEx.y)
    annotation (Line(points={{-49,80},{-78,80},{-78,52}},
                                                        color={0,0,127}));
  connect(oveFanSup.y, fanSu.y) annotation (Line(points={{-60,43.2},{-60,20},
          {0,20},{0,-28}}, color={0,0,127}));
  connect(fanEx.port_b, senTemEx2.port_a)
    annotation (Line(points={{-88,40},{-96,40}}, color={0,127,255}));
  connect(fanEx.port_a, hex.port_b1) annotation (Line(points={{-68,40},{-62,40},
          {-62,14},{-70,14},{-70,6},{-66,6}}, color={0,127,255}));
  connect(senTemEx1.port_a, senVolFloEx.port_b)
    annotation (Line(points={{-18,40},{28,40}}, color={0,127,255}));
  connect(senTemIn2.T, conPID.u_m) annotation (Line(points={{-26,-29},{-26,-26},
          {-6,-26},{-6,-18},{-22,-18},{-22,-10}}, color={0,0,127}));
  connect(conPID.y, hex.rel_eps_contr) annotation (Line(points={{-33,2},{-38,2},
          {-38,14},{-56,14},{-56,8.8}}, color={0,0,127}));
  connect(conPID.u_s, TsupSet)
    annotation (Line(points={{-10,2},{-4,2},{-4,110}}, color={0,0,127}));
  connect(reaFloSupAir.u, senVolFloIn.V_flow)
    annotation (Line(points={{122.8,8},{88,8},{88,-29}},color={0,0,127}));
  connect(senTemIn3.port_a, senVolFloIn.port_b)
    annotation (Line(points={{108,-40},{98,-40}}, color={0,127,255}));
  connect(senVolFloIn.port_a,coil. port_b1)
    annotation (Line(points={{78,-40},{68,-40}}, color={0,127,255}));
  connect(coil.port_a1, fanSu.port_b)
    annotation (Line(points={{48,-40},{10,-40}}, color={0,127,255}));
  connect(senVolFloEx.V_flow, reaFloExtAir.u)
    annotation (Line(points={{38,51},{38,60},{56.8,60}}, color={0,0,127}));
  connect(conPIDfan.y, oveFanRet.u)
    annotation (Line(points={{1,80},{-26,80}}, color={0,0,127}));
  connect(senVolFloEx.V_flow, conPIDfan.u_m) annotation (Line(points={{38,51},{
          38,62},{12,62},{12,68}}, color={0,0,127}));
  connect(conPIDfan.u_s, senVolFloIn.V_flow) annotation (Line(points={{24,80},{
          100,80},{100,8},{88,8},{88,-29}}, color={0,0,127}));
  connect(add.u1, fanEx.P) annotation (Line(points={{-70,-68},{-64,-68},{-64,
          -26},{-84,-26},{-84,26},{-92,26},{-92,49},{-89,49}}, color={0,0,127}));
  connect(fanSu.P, add.u2) annotation (Line(points={{11,-31},{22,-31},{22,-80},
          {-70,-80}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -100},{160,100}}), graphics={
          Rectangle(
            extent={{-160,100},{160,-100}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-20,60},{20,20}}, lineColor={28,108,200}),
          Line(points={{12,56},{12,24},{-20,40},{12,56}}, color={28,108,200}),
          Ellipse(extent={{-20,-20},{20,-60}}, lineColor={28,108,200}),
          Line(points={{-12,-24},{-12,-56},{20,-40},{-12,-24}}, color={28,108,200}),
          Line(points={{20,-40},{150,-40}}, color={28,108,200}),
          Line(points={{-20,-40},{-150,-40}}, color={28,108,200}),
          Line(points={{-150,40},{-20,40}}, color={28,108,200}),
          Line(points={{20,40},{150,40}}, color={28,108,200}),
          Line(points={{-82,40},{-122,-40}}, color={28,108,200}),
          Line(points={{-122,40},{-82,-40}}, color={28,108,200}),
          Rectangle(
            extent={{62,-20},{82,-60}},
            lineColor={28,108,200},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Line(points={{0,72},{0,60}}, color={0,0,0}),
          Line(points={{-60,90},{-60,-10},{0,-10},{0,-20}},
                                                        color={0,0,0}),
          Line(points={{0,72},{-60,72}}, color={0,0,0}),
          Line(
            points={{2,-60},{2,-74},{-100,-74},{-100,-96}},
            color={0,0,0},
            pattern=LinePattern.Dash),
          Line(
            points={{0,20},{0,12},{-40,12},{-40,-74}},
            color={0,0,0},
            pattern=LinePattern.Dash),
          Line(points={{-150,44},{-150,36}}, color={28,108,200}),
          Line(points={{-150,-36},{-150,-44}}, color={28,108,200}),
          Line(points={{100,-90},{100,-54},{82,-54}}, color={238,46,47}),
          Line(points={{62,-54},{40,-54},{40,-90}}, color={28,108,200}),
          Line(
            points={{156,-80},{130,-80},{130,-40}},
            color={0,140,72},
            pattern=LinePattern.Dash)}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-160,-100},{160,100}})),
    experiment(
      StartTime=3240000,
      StopTime=3960000,
      Interval=600.0012,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"));
end AirHandlingUnit;
