within BuildingControlEmulator.Devices.WaterSide;
model Bypass "Three way bypass valve"
  replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium
    "Medium condenser water side";
  parameter Modelica.Units.SI.Pressure dPByp_nominal
    "Pressure difference between the outlet and inlet of the valve ";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealInput yBypVal "(0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloTow(redeclare package Medium =
                       MediumCW)
    annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    "Mass flow rate through the cooling towers"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloByp(redeclare package Medium =
                       MediumCW) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,-20})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_bypass
    "Mass flow rate through the bypass "
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  replaceable Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valByp(
    redeclare package Medium = MediumCW,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dPByp_nominal)               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,10})));
equation
  connect(port_a2, port_b2) annotation (Line(
      points={{-100,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valByp.port_b, senMasFloByp.port_a) annotation (Line(
      points={{0,0},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFloByp.port_b, port_b2) annotation (Line(
      points={{0,-30},{0,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFloTow.port_b, port_b1) annotation (Line(
      points={{-80,40},{-100,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFloByp.m_flow, m_flow_bypass) annotation (Line(
      points={{11,-20},{60,-20},{60,-80},{110,-80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senMasFloTow.m_flow, m_flow) annotation (Line(
      points={{-70,51},{-70,60},{80,60},{80,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senMasFloTow.port_a, port_a1) annotation (Line(
      points={{-60,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valByp.port_a, port_a1) annotation (Line(
      points={{0,20},{0,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valByp.y, yBypVal) annotation (Line(
      points={{-12,10},{-40,10},{-40,80},{-120,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,32},{56,-32}},
          lineColor={0,0,255},
          textString="BypassValve"),
        Text(
          extent={{-44,-142},{50,-110}},
          lineColor={0,0,255},
          textString="%name")}));
end Bypass;
