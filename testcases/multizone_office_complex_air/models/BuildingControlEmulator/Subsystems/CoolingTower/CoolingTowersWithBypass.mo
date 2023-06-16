within BuildingControlEmulator.Subsystems.CoolingTower;
model CoolingTowersWithBypass
  "This model is designed to simulate the cooling tower system with N way bypass valve"
  replaceable package MediumCW =
       Modelica.Media.Interfaces.PartialMedium
    "Medium condenser water side";
  parameter Modelica.Units.SI.Temperature TCWLowSet
    "The lower temperatre limit of condenser water entering the chiller plant";
  parameter Modelica.Units.SI.Power P_nominal[n] "Nominal tower power (at y=1)";
  parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
    "Temperature difference between the outlet and inlet of the tower";
  parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
    "Nominal approach temperature";
  parameter Modelica.Units.SI.Temperature TWetBul_nominal
    "Nominal wet bulb temperature";
  parameter Modelica.Units.SI.Pressure dP_nominal
    "Pressure difference between the outlet and inlet of the tower ";
  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[:]
    "Nominal mass flow rate at condenser water wide";
  parameter Real v_flow_rate[n,:] "Air volume flow rate ratio";
  parameter Real eta[n,:] "Fan efficiency";
  parameter Modelica.Units.SI.Pressure dPByp_nominal
    "Pressure difference between the outlet and inlet of the bypass valve ";
  parameter Modelica.Units.SI.Temperature TCW_start
    "The start temperature of condenser water side";
  parameter Integer n
    "the number of cooling towers";
  replaceable  BuildingControlEmulator.Subsystems.CoolingTower.MultiCoolingTowers mulCooTowSys(
    redeclare package MediumCW = MediumCW,
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    v_flow_rate=v_flow_rate,
    TCW_start=TCW_start,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    eta=eta,
    n=n,
    GaiPi=1,
    tIntPi=60)
             annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  BuildingControlEmulator.Devices.WaterSide.Bypass byp(
    redeclare package MediumCW = MediumCW,
    dPByp_nominal=dPByp_nominal,
    m_flow_nominal=sum(mCW_flow_nominal))
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Interfaces.RealInput On[n] "On signal"
    annotation (Placement(transformation(extent={{-118,51},{-100,69}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumCW)
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEntChi(
      redeclare package Medium = MediumCW,
    T_start=TCW_start,
    m_flow_nominal=sum(mCW_flow_nominal))
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Blocks.Interfaces.RealInput TWetBul
    "Entering air wet bulb temperature"
    annotation (Placement(transformation(extent={{-118,-69},{-100,-51}})));
  Modelica.Blocks.Interfaces.RealInput TCWSet
    "Temperature set point of the condenser water"
    annotation (Placement(transformation(extent={{-118,-9},{-100,9}})));

  Devices.Control.conPI conPI(k=1, Ti=60)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=TCWLowSet)
                                                        annotation (Placement(transformation(extent={{-74,10},{-54,30}})));
  Modelica.Blocks.Sources.BooleanExpression realExpression1(y=true)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
equation
  connect(mulCooTowSys.port_b_CW, byp.port_a2) annotation (Line(
      points={{-20,-30},{-8,-30},{-8,-14},{0,-14}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(byp.port_b1, mulCooTowSys.port_a_CW) annotation (Line(
      points={{0,-6},{-60,-6},{-60,-30},{-40,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(byp.port_a1, port_a) annotation (Line(
      points={{20,-6},{40,-6},{40,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(byp.port_b2, senTCWEntChi.port_a) annotation (Line(
      points={{20,-14},{40,-14},{40,-80},{60,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senTCWEntChi.port_b, port_b) annotation (Line(
      points={{80,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(mulCooTowSys.TWetBul, TWetBul) annotation (Line(
      points={{-40.9,-36},{-80,-36},{-80,-60},{-109,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(mulCooTowSys.TCWSet, TCWSet) annotation (Line(
      points={{-40.9,-22.1},{-72,-22.1},{-72,0},{-109,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPI.y, byp.yBypVal) annotation (Line(
      points={{-19,50},{-8,50},{0,50},{0,22},{-20,22},{-20,-2},{-2,-2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTCWEntChi.T, conPI.Mea) annotation (Line(
      points={{70,-69},{70,-69},{70,70},{-58,70},{-58,44},{-42,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression.y, conPI.SetPoi) annotation (Line(
      points={{-53,20},{-48,20},{-48,50},{-42,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression1.y, conPI.On) annotation (Line(
      points={{-59,80},{-50,80},{-50,56},{-42,56}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(On, mulCooTowSys.On) annotation (Line(
      points={{-109,60},{-94,60},{-80,60},{-80,-26.1},{-40.9,-26.1}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-42,-144},{52,-112}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-40,68},{-12,40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,76},{-16,68}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,72},{-28,70}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,72},{-16,70}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-34,60},{-36,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-34,60},{-32,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,60},{-28,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,60},{-24,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,60},{-20,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,60},{-16,54}},
          color={255,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-40,8},{-12,-20}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,16},{-16,8}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,12},{-28,10}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,12},{-16,10}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-34,0},{-36,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-34,0},{-32,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,0},{-28,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,0},{-24,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,0},{-20,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,0},{-16,-6}},
          color={255,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-40,-52},{-12,-80}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-44},{-16,-52}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-48},{-28,-50}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,-48},{-16,-50}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-34,-60},{-36,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-34,-60},{-32,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,-60},{-28,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,-60},{-24,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,-60},{-20,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-18,-60},{-16,-66}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{60,60},{60,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Polygon(
          points={{60,0},{50,10},{70,10},{60,0}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,0},{50,-12},{70,-12},{60,0}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{90,60},{100,60},{-34,60}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,60},{0,0},{-34,0}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,0},{0,-60},{-34,-60}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-12,40},{10,40},{10,-80},{60,-80},{60,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{100,-80},{60,-80}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-12,-20},{10,-20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-12,-80},{10,-80}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li>
March 30, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end CoolingTowersWithBypass;
