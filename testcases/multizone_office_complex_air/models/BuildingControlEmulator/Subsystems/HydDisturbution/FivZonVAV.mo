within BuildingControlEmulator.Subsystems.HydDisturbution;
model FivZonVAV
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "medium for the air";

  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "medium for the water";


  parameter Modelica.Units.SI.Pressure PreAirDroMai1
    "pressure drop 1 across the duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai2
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai3
    "Pressure drop 3 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai4
    "Pressure drop 4 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroBra1
    "Pressure drop 1 across the duct branch 1";

  parameter Modelica.Units.SI.Pressure PreAirDroBra2
    "Pressure drop 1 across the duct branch 2";

  parameter Modelica.Units.SI.Pressure PreAirDroBra3
    "Pressure drop 1 across the duct branch 3";

  parameter Modelica.Units.SI.Pressure PreAirDroBra4
    "Pressure drop 1 across the duct branch 4";

  parameter Modelica.Units.SI.Pressure PreAirDroBra5
    "Pressure drop 1 across the duct branch 5";

  parameter Modelica.Units.SI.Pressure PreWatDroMai1
    "Pressure drop 1 across the pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai2
    "Pressure drop 2 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai3
    "Pressure drop 3 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai4
    "Pressure drop 4 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroBra1
    "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.Units.SI.Pressure PreWatDroBra2
    "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.Units.SI.Pressure PreWatDroBra3
    "Pressure drop 1 across the pipe branch 3";

  parameter Modelica.Units.SI.Pressure PreWatDroBra4
    "Pressure drop 1 across the pipe branch 4";

  parameter Modelica.Units.SI.Pressure PreWatDroBra5
    "Pressure drop 1 across the pipe branch 5";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5
    "mass flow rate for vav 5";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat1
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat3
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat4
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat5
    "mass flow rate for vav 5";


  parameter Modelica.Units.SI.Pressure PreDroAir1
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat1
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";


  parameter Modelica.Units.SI.Pressure PreDroAir2
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroWat2
    "Pressure drop in the water side of vav 2";
  parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";

  parameter Modelica.Units.SI.Pressure PreDroAir3
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroWat3
    "Pressure drop in the water side of vav 3";
  parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 3";

  parameter Modelica.Units.SI.Pressure PreDroAir4
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 4";


  parameter Modelica.Units.SI.Pressure PreDroAir5
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat5
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 5";



  FivZonNetWor ReheatWatNet(redeclare package Medium = MediumWat,
    PreDroMai1=PreWatDroMai1,
    PreDroMai2=PreWatDroMai2,
    PreDroMai3=PreWatDroMai3,
    PreDroMai4=PreWatDroMai4,
    PreDroBra1=PreWatDroBra1,
    PreDroBra2=PreWatDroBra2,
    PreDroBra3=PreWatDroBra3,
    PreDroBra4=PreWatDroBra4,
    PreDroBra5=PreWatDroBra5,
    mFloRat1=mWatFloRat1,
    mFloRat2=mWatFloRat2,
    mFloRat3=mWatFloRat3,
    mFloRat4=mWatFloRat4,
    mFloRat5=mWatFloRat5)
    annotation (Placement(transformation(extent={{-76,64},{-46,30}})));
  FivZonNetWor AirNetWor(
    redeclare package Medium = MediumAir,
    PreDroMai1=PreAirDroMai1,
    PreDroMai2=PreAirDroMai2,
    PreDroMai3=PreAirDroMai3,
    PreDroMai4=PreAirDroMai4,
    mFloRat1=mAirFloRat1,
    mFloRat2=mAirFloRat2,
    mFloRat3=mAirFloRat3,
    mFloRat4=mAirFloRat4,
    mFloRat5=mAirFloRat5,
    PreDroBra1=PreAirDroBra1,
    PreDroBra2=PreAirDroBra2,
    PreDroBra3=PreAirDroBra3,
    PreDroBra4=PreAirDroBra4,
    PreDroBra5=PreAirDroBra5) annotation (Placement(transformation(extent={{-74,-52},{-44,-18}})));
  Devices.AirSide.Terminal.BaseClasses.VAV_advance_temp_sensor vAV[5](
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat={mAirFloRat1,mAirFloRat2,mAirFloRat3,mAirFloRat4,mAirFloRat5},
    mWatFloRat={mWatFloRat1,mWatFloRat2,mWatFloRat3,mWatFloRat4,mWatFloRat5},
    PreDroAir={PreDroAir1,PreDroAir2,PreDroAir3,PreDroAir4,PreDroAir5},
    PreDroWat={PreDroWat1,PreDroWat2,PreDroWat3,PreDroWat4,PreDroWat5},
    eps={eps1,eps2,eps3,eps4,eps5})
    annotation (Placement(transformation(extent={{20,-2},{40,18}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol[5](
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=10,
    m_flow_nominal={mAirFloRat1,mAirFloRat2,mAirFloRat3,mAirFloRat4,mAirFloRat5},
    V=10)     annotation (Placement(transformation(extent={{20,-84},{40,-64}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow fixedHeatFlow[5]
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[5]
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
        MediumWat) "Second port, typically outlet"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
        MediumWat) "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5]
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.BooleanInput On[5]
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temZon[5](redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{8,-56},{-12,-36}})));
  Modelica.Blocks.Interfaces.RealOutput pre "Pressure at port"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression[5](y=vol.heatPort.T)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
equation

  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,-80},{
          0,-80},{0,-74},{20,-74}}, color={191,0,0}));
  connect(fixedHeatFlow.Q_flow, Q_flow)
    annotation (Line(points={{-40,-80},{-110,-80}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV.port_a_Wat, ReheatWatNet.ports_b) annotation (Line(points={{22,18},
          {22,39.18},{-46,39.18}}, color={255,0,0},
      thickness=1));
  connect(vAV.port_b_Wat, ReheatWatNet.ports_a) annotation (Line(points={{28,18},
          {28,57.54},{-46,57.54}}, color={255,0,0},
      thickness=1));
  connect(vAV.port_a, AirNetWor.ports_b) annotation (Line(points={{20,8},{-20,8},
          {-20,-27.18},{-44,-27.18}}, color={0,140,72},
      thickness=0.5));
  for i in 1:5 loop
    connect(vAV[i].port_b, vol[i].ports[1]);
    connect(temZon[i].port_b, AirNetWor.ports_a[i]);
    connect(temZon[i].port_a, vol[i].ports[2]);
  end for;


  connect(ReheatWatNet.port_b, port_b_Wat) annotation (Line(points={{-76,57.2},{-74,57.2},{-74,64},{40,64},{40,100}},
                                         color={255,0,0},
      thickness=1));
  connect(ReheatWatNet.port_a, port_a_Wat) annotation (Line(points={{-76,40.2},{-76,40.2},{-76,40},{-82,40},{-82,76},
          {-40,76},{-40,100}},                             color={255,0,0},
      thickness=1));
  connect(AirNetWor.port_a, port_a_Air)
    annotation (Line(points={{-74,-28.2},{-88,-28.2},{-88,40},{-100,40}}, color={0,140,72},

      thickness=0.5));
  connect(AirNetWor.port_b, port_b_Air)
    annotation (Line(points={{-74,-45.2},{-80,-45.2},{-80,-60},{-100,-60}}, color={0,140,72},

      thickness=0.5));
  connect(vAV.AirFlowRatSetPoi, AirFlowRatSetPoi) annotation (Line(
      points={{19,16},{-10,16},{-34,16},{-34,100},{-110,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV.yVal, yVal) annotation (Line(
      points={{19,12},{-40,12},{-40,60},{-110,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV.On, On) annotation (Line(
      points={{19,0},{6,0},{-10,0},{-110,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(AirNetWor.p, pre) annotation (Line(
      points={{-42.5,-35},{-8,-35},{-8,-20},{58,-20},{58,-40},{110,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression.y, TZon) annotation (Line(
      points={{65,40},{110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,40},{80,40}}, color={0,127,255}),
        Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
        Line(points={{80,40},{80,-60}}, color={0,127,255}),
        Line(points={{50,40},{50,-60}}, color={0,127,255}),
        Line(points={{20,40},{20,-60}}, color={0,127,255}),
        Line(points={{-10,40},{-10,-60}}, color={0,127,255}),
        Line(points={{-40,40},{-40,-60}}, color={0,127,255}),
        Rectangle(
          extent={{-46,0},{-34,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,0},{-4,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{14,0},{26,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{44,0},{56,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{74,0},{86,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,90},{-40,60}}, color={255,0,0}),
        Line(points={{-60,60},{-40,60}}, color={255,0,0}),
        Line(points={{-60,60},{-60,-12}}, color={255,0,0}),
        Line(points={{64,20},{-60,20}}, color={255,0,0}),
        Line(points={{-24,20},{-24,-12}}, color={255,0,0}),
        Line(points={{6,20},{6,-12}}, color={255,0,0}),
        Line(points={{36,20},{36,-12}}, color={255,0,0}),
        Line(points={{64,20},{64,-12}}, color={255,0,0}),
        Line(points={{-60,-12},{-46,-12}}, color={255,0,0}),
        Line(points={{-24,-12},{-16,-12}}, color={255,0,0}),
        Line(points={{6,-12},{14,-12}}, color={255,0,0}),
        Line(points={{36,-12},{44,-12}}, color={255,0,0}),
        Line(points={{64,-12},{74,-12}}, color={255,0,0}),
        Line(points={{90,-32},{-36,-32}}, color={255,0,0}),
        Line(points={{-36,-20},{-36,-32}}, color={255,0,0}),
        Line(points={{-6,-20},{-6,-32}}, color={255,0,0}),
        Line(points={{24,-20},{24,-32}}, color={255,0,0}),
        Line(points={{54,-20},{54,-32}}, color={255,0,0}),
        Line(points={{84,-20},{84,-32}}, color={255,0,0}),
        Line(points={{90,60},{90,-32}}, color={255,0,0}),
        Line(points={{40,60},{90,60}}, color={255,0,0}),
        Line(points={{40,90},{40,60}}, color={255,0,0}),
        Text(
          extent={{-152,-146},{148,-106}},
          textColor={0,0,255},
          textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
end FivZonVAV;
