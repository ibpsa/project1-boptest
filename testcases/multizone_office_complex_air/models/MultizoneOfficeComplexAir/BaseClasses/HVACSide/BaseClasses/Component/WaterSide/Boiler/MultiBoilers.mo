within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.Boiler;
model MultiBoilers "The boiler system with N boilers and associated local controllers."
  replaceable package MediumHW =
     Modelica.Media.Interfaces.PartialMedium
    "Medium in the hot water side";
  parameter Modelica.Units.SI.Pressure dPHW_nominal
    "Pressure difference at the chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal[:]
    "Nominal mass flow rate at the chilled water side";
  parameter Modelica.Units.SI.Temperature THW_start
    "The start temperature of chilled water side";
  parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
    "Temperature difference between the outlet and inlet of the module";
  parameter Real eta[n,:] "Fan efficiency";
  Modelica.Blocks.Interfaces.RealInput On[n](min=0,max=1) "On signal"    annotation (Placement(transformation(extent={{-118,
            -31},{-100,-49}})));
  Modelica.Blocks.Interfaces.RealInput THWSet
    "Temperature setpoint of the chilled water"
    annotation (Placement(transformation(extent={{-118,31},{-100,49}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_HW(redeclare package
      Medium =
        MediumHW)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
        iconTransformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package
      Medium =
        MediumHW)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEntChi(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,80})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLeaChi(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal),
    T_start=THW_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,-80})));
  Modelica.Blocks.Interfaces.RealOutput Rat[n] "compressor speed ratio"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Boiler boi[n](
    redeclare package MediumHW = MediumHW,
    dPHW_nominal=dPHW_nominal,
    mHW_flow_nominal=mHW_flow_nominal,
    dTHW_nominal=dTHW_nominal,
    eta=eta,
    each boi(T_nominal(displayUnit="K")),
    THW=THW_start,
    GaiPi=1,
    tIntPi=60)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  parameter Integer n
    "Number of boilers";

equation
  connect(senTHWEntChi.port_a, port_a_HW) annotation (Line(
      points={{60,80},{100,80}},
      color={255,0,0},
      thickness=1));
  connect(senTHWLeaChi.port_b, port_b_HW) annotation (Line(
      points={{62,-80},{100,-80}},
      color={255,0,0},
      thickness=1));
  connect(port_b_HW, port_b_HW) annotation (Line(
      points={{100,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  for i in 1:n loop
    connect(boi[i].port_a_HW, senTHWEntChi.port_b);
    connect(boi[i].port_b_CHW, senTHWLeaChi.port_a);
    connect(boi[i].THWSet, THWSet);
    connect(boi[i].On, On[i]);
  end for;
  connect(On, Rat) annotation (Line(points={{-109,-40},{110,-40}},           color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-28,80},{26,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,-40},{26,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,-80},{102,-80}},
          color={255,0,0}),
        Line(
          points={{40,-80},{40,50},{26,50}},
          color={255,0,0}),
        Line(
          points={{26,-70},{40,-70}},
          color={255,0,0}),
        Line(
          points={{26,-48},{60,-48},{60,80}},
          color={255,0,0}),
        Line(
          points={{100,80},{60,80}},
          color={255,0,0}),
        Line(
          points={{26,72},{60,72}},
          color={255,0,0}),
        Ellipse(
          extent={{20,56},{30,44}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,54},{28,46}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-64},{30,-76}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,-66},{28,-74}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,78},{30,66}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-44},{30,-56}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-154,104},{146,144}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(coordinateSystem(preserveAspectRatio=false)));
end MultiBoilers;
