within BuildingControlEmulator.Devices.AirSide.Terminal.BaseClasses;
model VAV_advance_temp_sensor
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "Medium for the water";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat
    "Pressure drop in the water side";
  parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
    "Heat exchanger effectiveness";
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage Dam(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dpValve_nominal=PreDroAir,
    y_start=0.3)               annotation (Placement(transformation(extent={{-12,-10},
            {8,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEnt(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temLea(redeclare package Medium =
        MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1,
    transferHeat=true)
    annotation (Placement(transformation(extent={{30,10},{50,-10}})));
  Modelica.Fluid.Sensors.MassFlowRate masFloRat(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Sensors.Pressure preEnt(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{-16,-20},{-36,-40}})));
  Modelica.Fluid.Sensors.Pressure preLea(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{30,-20},{10,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Coil.BaseClasses.DryCoil heaCoil(redeclare package MediumAir = MediumAir,
      redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroWat=0,
    eps=eps,
    PreDroAir=0)
    annotation (Placement(transformation(extent={{-40,-4},{-60,16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
        MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
        MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Control.conPI pI(
    yMin=0.3,
    k=0.02,
    Ti=120)
    annotation (Placement(transformation(extent={{40,42},{20,62}})));
  Modelica.Blocks.Math.Gain gain(k=1/mAirFloRat/1.25)
                                 annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={70,28})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage ReheaVal(
    redeclare package Medium = MediumWat,
    m_flow_nominal=mWatFloRat,
    dpValve_nominal=PreDroWat,
    y_start=0.01)              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-20,50})));
  Modelica.Blocks.Interfaces.RealInput yVal
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));
equation
  connect(temEnt.port_a,port_a)  annotation (Line(
      points={{-88,0},{-88,0},{-100,0}},
      color={0,127,255},
      thickness=1));
  connect(Dam.port_b, temLea.port_a)
    annotation (Line(
      points={{8,0},{30,0}},
      color={0,127,255},
      thickness=1));
  connect(temLea.port_b,masFloRat. port_a) annotation (Line(
      points={{50,0},{60,0}},
      color={0,127,255},
      thickness=1));
  connect(masFloRat.port_b,port_b)  annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      thickness=1));
  connect(preLea.port,temLea. port_a) annotation (Line(
      points={{20,-20},{20,0},{30,0}},
      color={0,127,255},
      thickness=1));
  connect(preEnt.port, Dam.port_a)
    annotation (Line(
      points={{-26,-20},{-26,0},{-12,0}},
      color={0,127,255},
      thickness=1));
  connect(masFloRat.m_flow, gain.u) annotation (Line(
      points={{70,11},{70,23.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain.y, pI.Mea) annotation (Line(
      points={{70,32.4},{70,46},{42,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.SetPoi, AirFlowRatSetPoi) annotation (Line(
      points={{42,52},{60,52},{60,80},{-110,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ReheaVal.port_b, port_b_Wat)
    annotation (Line(
      points={{-20,60},{-20,100}},
      color={255,0,0},
      thickness=1));
  connect(heaCoil.port_a_Air, temEnt.port_b)
    annotation (Line(points={{-60,0},{-64,0},{-68,0}}, color={0,127,255}));
  connect(heaCoil.port_b_Air, Dam.port_a)
    annotation (Line(points={{-40,0},{-26,0},{-12,0}},
                                               color={0,127,255}));
  connect(ReheaVal.port_a, heaCoil.port_b_Wat) annotation (Line(
      points={{-20,40},{-22,40},{-22,28},{-60,28},{-60,12}},
      color={255,0,0},
      thickness=1));
  connect(heaCoil.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-40,12},{-40,36},{-80,36},{-80,100}},
      color={255,0,0},
      thickness=1));
  connect(booleanExpression.y, pI.On) annotation (Line(
      points={{-67,-70},{54,-70},{54,58},{42,58}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(pI.y, Dam.y) annotation (Line(
      points={{19,52},{-2,52},{-2,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ReheaVal.y, yVal) annotation (Line(
      points={{-32,50},{-40,50},{-40,40},{-110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temLea.T, TAirLea) annotation (Line(
      points={{40,-11},{40,-60},{110,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{102,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{90,0}},
          color={255,255,255},
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,58},{68,-66}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="VAV")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VAV_advance_temp_sensor;
