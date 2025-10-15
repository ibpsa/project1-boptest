within MultizoneOfficeComplexAir.BaseClasses.Component.WaterSide.Boiler;
model Boiler "Boiler with local control"
  replaceable package MediumHW =
     Modelica.Media.Interfaces.PartialMedium
    "Medium in the hot water side";
  parameter Modelica.Units.SI.Pressure dPHW_nominal
    "Pressure difference at the chilled water side";
  parameter Modelica.Units.SI.MassFlowRate mHW_flow_nominal
    "Nominal mass flow rate at the chilled water side";
  parameter Modelica.Units.SI.Temperature THW
    "The start temperature of chilled water side";
  parameter Modelica.Units.SI.TemperatureDifference dTHW_nominal
    "Temperature difference between the outlet and inlet of the module";
  parameter Real GaiPi "Gain of the component PI controller";
  parameter Real tIntPi "Integration time of the component PI controller";
  parameter Real eta[:] "Fan efficiency";

  BaseClasses.BoilerPolynomial boi(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = MediumHW,
    m_flow_nominal=mHW_flow_nominal,
    T_nominal=THW,
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Polynomial,
    Q_flow_nominal=dTHW_nominal*mHW_flow_nominal*4200,
    a=eta,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    dp_nominal=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-38})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_CHW(redeclare package Medium =
        MediumHW)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_HW(redeclare package Medium =
        MediumHW)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,70},{110,90}}),
        iconTransformation(extent={{90,70},{110,90}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTHWLea(
    redeclare package Medium = MediumHW,
    m_flow_nominal=mHW_flow_nominal,
    T_start=THW) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valHW(
    redeclare package Medium = MediumHW,
    m_flow_nominal=mHW_flow_nominal,
    dpValve_nominal=dPHW_nominal)
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Blocks.Interfaces.RealInput On(min=0,max=1)
    "True to enable compressor to operate, or false to disable the operation of the compressor"
    annotation (Placement(transformation(extent={{-118,-50},{-100,-30}}),
        iconTransformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealInput THWSet
    "Temperature setpoint of chilled water" annotation (Placement(
        transformation(extent={{-118,30},{-100,50}}), iconTransformation(extent=
           {{-140,10},{-100,50}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTHWEnt(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=mHW_flow_nominal) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,0})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloHW(redeclare package Medium =
        MediumHW)
    annotation (Placement(transformation(extent={{72,-10},{54,10}})));
  Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
        MediumHW)
    annotation (Placement(transformation(extent={{2,10},{22,30}})));
  Buildings.Fluid.Sensors.Pressure senPreHWLea(redeclare package Medium =
        MediumHW)
    annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-70,-18},{-54,-2}})));
  .MultizoneOfficeComplexAir.BaseClasses.Component.conPI conPI(Ti=2400, k=1)
    annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=boi.T)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
equation
  connect(senTHWLea.port_b, valHW.port_a) annotation (Line(
      points={{40,-80},{60,-80}},
      color={255,0,0},
      thickness=1));
  connect(valHW.port_b, port_b_CHW) annotation (Line(
      points={{80,-80},{100,-80}},
      color={255,0,0},
      thickness=1));
  connect(senPreHWLea.port, port_b_CHW) annotation (Line(
      points={{88,-50},{88,-50},{88,-80},{100,-80}},
      color={255,0,0},
      thickness=1));
  connect(senMasFloHW.port_b, senTHWEnt.port_a) annotation (Line(
      points={{54,0},{47,0},{40,0}},
      color={255,0,0},
      thickness=1));
  connect(senMasFloHW.port_a, port_a_HW) annotation (Line(
      points={{72,0},{80,0},{80,80},{100,80}},
      color={255,0,0},
      thickness=1));
  connect(senTHWEnt.port_b, boi.port_a) annotation (Line(
      points={{20,0},{0,0},{0,-28}},
      color={255,0,0},
      thickness=1));
  connect(boi.port_b, senTHWLea.port_a)
    annotation (Line(
      points={{0,-48},{0,-80},{20,-80}},
      color={255,0,0},
      thickness=1));
  connect(senPreCWEnt.port, boi.port_a) annotation (Line(
      points={{12,10},{12,0},{0,0},{0,-28},{6.10623e-016,-28}},
      color={255,0,0},
      thickness=1));
  connect(On, valHW.y) annotation (Line(points={{-109,-40},{-44,-40},{-44,-24},
          {70,-24},{70,-68}}, color={0,0,127}));

  connect(realToBoolean.u, valHW.y) annotation (Line(points={{-71.6,-10},{-80,-10},
          {-80,-40},{-44,-40},{-44,-24},{70,-24},{70,-68}}, color={0,0,127}));
  connect(realToBoolean.y, conPI.On) annotation (Line(
      points={{-53.2,-10},{-40,-10},{-40,10},{-80,10},{-80,46},{-66,46}},
      color={255,0,255}));
  connect(conPI.set, THWSet)
    annotation (Line(points={{-66,40},{-109,40}}, color={0,0,127}));
  connect(conPI.y, boi.y)
    annotation (Line(
      points={{-43,40},{-8,40},{-8,-26}},
      color={0,0,127}));
  connect(realExpression.y,conPI.mea)  annotation (Line(
      points={{-49,-30},{-30,-30},{-30,22},{-76,22},{-76,34},{-66,34}},
      color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-44,-144},{50,-112}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-54,50},{60,32}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,-50},{62,-68}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,72},{100,82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-10},{-42,-22},{-22,-22},{-32,-10}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-10},{-42,0},{-22,0},{-32,-10}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,32},{-30,0}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,-22},{-30,-50}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,32},{38,-50}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,10},{58,-32}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{36,10},{18,-22},{54,-22},{36,10}},
          lineColor={255,170,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-86},{100,-76}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-152,106},{148,146}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>",
        info="<html>
<p><span style=\"font-family: Arial;\">This model is a single boiler with its local control.</span></p>
</html>"));
end Boiler;
