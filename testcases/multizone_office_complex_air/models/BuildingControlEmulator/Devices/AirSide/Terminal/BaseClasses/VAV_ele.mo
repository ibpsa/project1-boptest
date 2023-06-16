within BuildingControlEmulator.Devices.AirSide.Terminal.BaseClasses;
model VAV_ele
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "medium for the air";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir
    "pressure drop in the air side";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal
    "rated heat flow rate for heating";

  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage Dam(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dpValve_nominal=PreDroAir) annotation (Placement(transformation(extent={{-12,-10},
            {8,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temEnt(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temLea(redeclare package Medium =
        MediumAir)
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
  Control.conPI pI(k=0.01, Ti=60)
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Gain gain(k=1/mAirFloRat)
                                 annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={70,28})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput yVal
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput TAirLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dp_nominal=0,
    Q_flow_nominal=Q_flow_nominal)
                          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
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
      points={{70,32.4},{70,44},{42,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.SetPoi, AirFlowRatSetPoi) annotation (Line(
      points={{42,50},{52,50},{60,50},{60,80},{-110,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.On, On) annotation (Line(
      points={{42,56},{52,56},{52,-80},{-110,-80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(temEnt.port_b, hea.port_a) annotation (Line(
      points={{-68,0},{-60,0}},
      color={0,127,255},
      thickness=1));
  connect(hea.port_b, Dam.port_a) annotation (Line(
      points={{-40,0},{-12,0}},
      color={0,127,255},
      thickness=1));
  connect(yVal, hea.u) annotation (Line(
      points={{-110,40},{-68,40},{-68,6},{-62,6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.y, Dam.y) annotation (Line(
      points={{19,50},{-2,50},{-2,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temLea.T, TAirLea) annotation (Line(
      points={{40,-11},{40,-62},{110,-62},{110,-60}},
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
end VAV_ele;
