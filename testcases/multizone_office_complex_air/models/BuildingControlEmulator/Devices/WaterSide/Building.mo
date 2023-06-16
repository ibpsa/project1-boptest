within BuildingControlEmulator.Devices.WaterSide;
model Building "Simple model to simulate the demind side of the loop"
    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium water";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate ";
  parameter Modelica.Units.SI.Pressure dP_nominal "Nominal pressure drop";

  parameter Modelica.Units.SI.Temperature TBuiSetPoi
    "Set point of the building temperature";
    parameter Real GaiPi "Gain of the PI controller";
    parameter Real tIntPi "Integration time of the PI controller";
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-84,30},{-64,50}})));
  Modelica.Blocks.Sources.Constant TSet(k=TBuiSetPoi)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput Loa "Cooling load"
    annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dP_nominal,
    linearized=true,
    homotopyInitialization=false,
    l=0.0001,
    allowFlowReversal=false,
    riseTime=120)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Buildings.Controls.Continuous.LimPID conPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=GaiPi,
    Ti=tIntPi,
    reverseActing=not (true))
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Interfaces.RealOutput dP "Pressure difference"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTemBui
    "Room temperature sensor"
    annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=V,
    T_start=TBuiSetPoi)
          annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTLeaPri(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,10},{-60,-10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTEntPri(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Blocks.Interfaces.RealOutput TEntPri
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput TLeaPri
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Sources.RealExpression yVal(y=val.y)
    annotation (Placement(transformation(extent={{28,70},{48,90}})));
  parameter Modelica.Units.SI.Volume V=10
    "Volume of water in the secondary loop";


  Buildings.Fluid.Sensors.MassFlowRate senMasFloCHWSec(redeclare package Medium
      = Medium)
    annotation (Placement(transformation(extent={{-18,-10},{0,10}})));
  Modelica.Blocks.Sources.RealExpression LoaCal(y=m_flow*(TLeaPri - TEntPri)*
        4200)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Interfaces.RealOutput LoaCalSig "Value of Real output"
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    "Mass flow rate from port_a to port_b"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput y "Value of Real output"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=senTEntPri.T)
    annotation (Placement(transformation(extent={{32,-52},{52,-32}})));
  replaceable Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare
      package Medium =
        Medium) annotation (Placement(transformation(extent={{40,62},{60,42}})));
equation
  connect(prescribedHeatFlow.Q_flow, Loa) annotation (Line(
      points={{-84,40},{-109,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSet.y, conPI.u_s) annotation (Line(
      points={{-59,70},{-22,70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPI.y, val.y) annotation (Line(
      points={{1,70},{20,70},{20,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senTemBui.port, prescribedHeatFlow.port) annotation (Line(
      points={{-44,40},{-64,40}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(vol.heatPort,senTemBui. port) annotation (Line(
      points={{-42,10},{-44,10},{-44,40}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=1));
  connect(vol.ports[1], senTLeaPri.port_b) annotation (Line(
      points={{-34,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senTLeaPri.port_a, port_a) annotation (Line(
      points={{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senTEntPri.port_b, port_b) annotation (Line(
      points={{62,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_b, senTEntPri.port_a) annotation (Line(
      points={{30,0},{42,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(vol.ports[2],senMasFloCHWSec. port_a) annotation (Line(
      points={{-30,0},{-18,0}},
      color={0,127,255},
      thickness=1));
  connect(senMasFloCHWSec.port_b, val.port_a) annotation (Line(
      points={{0,0},{10,0}},
      color={0,127,255},
      thickness=1));
  connect(LoaCal.y, LoaCalSig) annotation (Line(
      points={{-39,-80},{-39,-80},{20,-80},{20,-100},{110,-100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(yVal.y, y) annotation (Line(
      points={{49,80},{110,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TEntPri, senTLeaPri.T) annotation (Line(
      points={{110,-60},{22,-60},{-70,-60},{-70,-11}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(m_flow, senMasFloCHWSec.m_flow) annotation (Line(
      points={{110,20},{50,20},{-9,20},{-9,11}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression.y, TLeaPri) annotation (Line(points={{53,-42},{90,-42},
          {90,-20},{110,-20}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTemBui.T, conPI.u_m) annotation (Line(
      points={{-24,40},{-16,40},{-10,40},{-10,58}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.port_a, senMasFloCHWSec.port_a) annotation (Line(points={{40,
          52},{26,52},{0,52},{0,26},{-18,26},{-18,0}}, color={0,127,255}));
  connect(senRelPre.port_b, port_b) annotation (Line(points={{60,52},{72,52},{72,
          0},{100,0}}, color={0,127,255}));
  connect(senRelPre.p_rel, dP) annotation (Line(
      points={{50,61},{50,61},{50,70},{80,70},{80,60},{110,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={
        Text(
          extent={{-32,-114},{40,-142}},
          lineColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{0,80},{-80,40},{80,40},{0,80}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,40},{60,-80}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,0},{0,0}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,10},{0,0},{-10,-10},{-10,10}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{10,10},{0,0},{10,-10},{10,10}},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-10,0}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{10,0},{90,0}},
          smooth=Smooth.None,
          color={0,0,255}),
        Ellipse(
          extent={{-42,-24},{-20,-50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-36,-30},{-26,-46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(
          points={{-20,-36},{0,-36},{0,0}},
          color={0,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}),      Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end Building;
