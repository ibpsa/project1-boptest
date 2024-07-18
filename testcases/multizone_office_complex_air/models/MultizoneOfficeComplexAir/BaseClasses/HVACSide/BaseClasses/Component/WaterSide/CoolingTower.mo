within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide;
package CoolingTower
  "This package contains the modules which can be used to simulate the cooling towers"

  model MultiCoolingTowers
    "This model is designed to simulate the cooling tower systwm with N towers"
    replaceable package MediumCW =
         Modelica.Media.Interfaces.PartialMedium
      "Medium in the  condenser water side";
    parameter Modelica.Units.SI.Power P_nominal[n]
      "Nominal cooling tower power (at y=1)";
    parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
      "Temperature difference between the outlet and inlet of the tower ";
    parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
      "Nominal approach temperature";
    parameter Modelica.Units.SI.Temperature TWetBul_nominal
      "Nominal wet bulb temperature";
    parameter Modelica.Units.SI.Pressure dP_nominal
      "Pressure difference between the outlet and inlet of the tower ";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal[n]
      "Nominal mass flow rate at condenser water wide";
    parameter Real GaiPi "Gain of the tower PI controller";
    parameter Real tIntPi "Integration time of the tower PI controller";
    parameter Real v_flow_rate[n,:] "Air volume flow rate ratio";
    parameter Real eta[n,:] "Fan efficiency";
    parameter Modelica.Units.SI.Temperature TCW_start
      "The start temperature of condenser water side";

    parameter Integer n
      "the number of cooling towers";
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
        Medium =                                                               MediumCW)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
        Medium =                                                               MediumCW)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput TWetBul
      "Entering air wet bulb temperature"
      annotation (Placement(transformation(extent={{-118,-69},{-100,-51}})));
    Modelica.Blocks.Interfaces.RealInput TCWSet
      "Temperature set point of the condenser water"
      annotation (Placement(transformation(extent={{-118,70},{-100,88}})));
    VSDCoolingTower ct[n](
      redeclare package MediumCW = MediumCW,
      P_nominal=P_nominal,
      dTCW_nominal=dTCW_nominal,
      dTApp_nominal=dTApp_nominal,
      TWetBul_nominal=TWetBul_nominal,
      dP_nominal=dP_nominal,
      mCW_flow_nominal=mCW_flow_nominal,
      GaiPi=GaiPi,
      tIntPi=tIntPi,
      eta=eta,
      TCW_start=TCW_start,
      v_flow_rate=v_flow_rate,
      conPI(reverseActing=false))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealInput On[n]
      "Temperature set point of the condenser water"
      annotation (Placement(transformation(extent={{-118,30},{-100,48}})));
    Modelica.Blocks.Interfaces.RealOutput P[n]
      "Electric power consumed by compressor"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
  equation

    for i in 1:n loop
      connect(ct[i].port_a_CW, port_a_CW);
      connect(ct[i].port_b_CW, port_b_CW);
      connect(ct[i].TSet, TCWSet);
       connect(TWetBul, ct[i].TWetBul);
         connect(ct[i].P, P[i]);
    end for;

    connect(ct.On, On) annotation (Line(
        points={{-12,4},{-60,4},{-60,39},{-109,39}},
        color={0,0,127},
        pattern=LinePattern.Dash));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),           Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-44,-144},{50,-112}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(
            extent={{-14,68},{14,40}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,76},{10,68}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-10,72},{-2,70}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{2,72},{10,70}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-8,60},{-10,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-8,60},{-6,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,60},{-2,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,60},{2,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,60},{6,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,60},{10,54}},
            color={255,0,0},
            smooth=Smooth.None),
          Rectangle(
            extent={{-14,8},{14,-20}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,16},{10,8}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-10,12},{-2,10}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{2,12},{10,10}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-8,0},{-10,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-8,0},{-6,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,0},{-2,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,0},{2,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,0},{6,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,0},{10,-6}},
            color={255,0,0},
            smooth=Smooth.None),
          Rectangle(
            extent={{-14,-52},{14,-80}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,-44},{10,-52}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-10,-48},{-2,-50}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{2,-48},{10,-50}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-8,-60},{-10,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-8,-60},{-6,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,-60},{-2,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,-60},{2,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,-60},{6,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{8,-60},{10,-66}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-100,0},{-40,0},{-40,60},{8,60}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-40,0},{8,0}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-40,0},{-40,-60},{8,-60}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{14,40},{40,40},{40,0},{90,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{14,-20},{40,-20},{40,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{14,-80},{40,-80},{40,-20}},
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
  end MultiCoolingTowers;

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
    replaceable MultiCoolingTowers mulCooTowSys(
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
    Bypass byp(
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

    .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
      conPI(k=1, Ti=60)
      annotation (Placement(transformation(extent={{-40,38},{-20,58}})));
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
        points={{-19,48},{0,48},{0,22},{-20,22},{-20,-2},{-2,-2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senTCWEntChi.T,conPI.mea)  annotation (Line(
        points={{70,-69},{70,70},{-58,70},{-58,42},{-42,42}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realExpression.y, conPI.set) annotation (Line(
        points={{-53,20},{-48,20},{-48,48},{-42,48}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realExpression1.y, conPI.On) annotation (Line(
        points={{-59,80},{-50,80},{-50,54},{-42,54}},
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

  model VSDCoolingTower "the cooling tower"
    replaceable package MediumCW =
        Modelica.Media.Interfaces.PartialMedium
      "Medium in the condenser water side";
    parameter Modelica.Units.SI.Power P_nominal
      "Nominal cooling tower component power (at y=1)";
    parameter Modelica.Units.SI.TemperatureDifference dTCW_nominal
      "Temperature difference between the outlet and inlet of the module";
    parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
      "Nominal approach temperature";
    parameter Modelica.Units.SI.Temperature TWetBul_nominal
      "Nominal wet bulb temperature";
    parameter Modelica.Units.SI.Pressure dP_nominal
      "Pressure difference between the outlet and inlet of the module ";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal
      "Nominal mass flow rate";
    parameter Real GaiPi "Gain of the component PI controller";
    parameter Real tIntPi "Integration time of the component PI controller";
    parameter Real v_flow_rate[:] "Volume flow rate ratio";
    parameter Real eta[:] "Fan efficiency";
    parameter Modelica.Units.SI.Temperature TCW_start
      "The start temperature of condenser water side";
    BaseClasses.YorkCalc yorkCalc(
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal,
      dp_nominal=0,
      TRan_nominal=dTCW_nominal,
      TAirInWB_nominal=TWetBul_nominal,
      TApp_nominal=dTApp_nominal,
      fraPFan_nominal=P_nominal/mCW_flow_nominal,
      T_start=TCW_start,
      fanRelPow(r_V=v_flow_rate, r_P=eta))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_CW(redeclare package
        Medium =
          MediumCW)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_CW(redeclare package
        Medium =
          MediumCW)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal,
      dpValve_nominal=dP_nominal)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    .MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.conPI
      conPI(k=GaiPi, Ti=tIntPi)
      annotation (Placement(transformation(extent={{-30,72},{-10,92}})));
    Modelica.Blocks.Interfaces.RealInput On(min=0,max=1) "On signal"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput TSet
      "Temperature setpoint of the condenser water"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput TWetBul
      "Entering air wet bulb temperature"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=yorkCalc.PFan) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
    Modelica.Blocks.Interfaces.RealOutput P "Power of the cooling tower module"
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTCWEnt(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-78,0})));
    replaceable Buildings.Fluid.Sensors.TemperatureTwoPort senTCWLea(
      allowFlowReversal=true,
      redeclare package Medium = MediumCW,
      m_flow_nominal=mCW_flow_nominal) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={44,0})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloCW(redeclare package
        Medium =
          MediumCW)
      annotation (Placement(transformation(extent={{60,-10},{78,10}})));
    Buildings.Fluid.Sensors.Pressure senPreCWLea(redeclare package Medium =
          MediumCW)
      annotation (Placement(transformation(extent={{94,-16},{74,-36}})));
    Buildings.Fluid.Sensors.Pressure senPreCWEnt(redeclare package Medium =
          MediumCW)
      annotation (Placement(transformation(extent={{-22,-16},{-42,-36}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean
      annotation (Placement(transformation(extent={{-86,20},{-72,34}})));
  equation
    connect(yorkCalc.port_a, val.port_b) annotation (Line(
        points={{0,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(yorkCalc.TAir, TWetBul) annotation (Line(
        points={{-2,4},{-20,4},{-20,-40},{-120,-40}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(realExpression.y, P) annotation (Line(
        points={{21,-40},{110,-40}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(val.port_a, senTCWEnt.port_b) annotation (Line(
        points={{-60,0},{-68,0}},
        color={0,127,255},
        thickness=1));
    connect(senTCWEnt.port_a, port_a_CW) annotation (Line(
        points={{-88,0},{-100,0}},
        color={0,127,255},
        thickness=1));
    connect(yorkCalc.port_b, senTCWLea.port_a) annotation (Line(
        points={{20,0},{34,0}},
        color={0,127,255},
        thickness=1));
    connect(senTCWLea.port_b, senMasFloCW.port_a) annotation (Line(
        points={{54,0},{56,0},{60,0}},
        color={0,127,255},
        thickness=1));
    connect(senMasFloCW.port_b, port_b_CW) annotation (Line(
        points={{78,0},{100,0}},
        color={0,127,255},
        thickness=1));
    connect(senPreCWLea.port, port_b_CW) annotation (Line(
        points={{84,-16},{84,0},{100,0}},
        color={0,127,255},
        thickness=1));
    connect(senPreCWEnt.port, val.port_b) annotation (Line(
        points={{-32,-16},{-32,-16},{-32,0},{-40,0}},
        color={0,127,255},
        thickness=1));
    connect(realToBoolean.u, On) annotation (Line(
        points={{-87.4,27},{-92,27},{-92,40},{-120,40}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realToBoolean.y, conPI.On) annotation (Line(
        points={{-71.3,27},{-54,27},{-54,88},{-32,88}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(conPI.set, TSet) annotation (Line(
        points={{-32,82},{-76,82},{-76,80},{-120,80}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(senTCWLea.T,conPI.mea)  annotation (Line(
        points={{44,11},{44,11},{44,40},{-44,40},{-44,76},{-32,76}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(conPI.y, yorkCalc.y) annotation (Line(
        points={{-9,82},{12,82},{12,22},{-20,22},{-20,8},{-2,8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(val.y, On) annotation (Line(
        points={{-50,12},{-50,40},{-120,40}},
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
            extent={{-52,34},{58,-34}},
            lineColor={0,0,255},
            textString="CoolingTower"),
          Text(
            extent={{-44,-146},{50,-114}},
            lineColor={0,0,255},
            textString="%name")}));
  end VSDCoolingTower;

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
    Buildings.Fluid.Sensors.MassFlowRate senMasFloTow(redeclare package
        Medium =         MediumCW)
      annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
    Modelica.Blocks.Interfaces.RealOutput m_flow
      "Mass flow rate through the cooling towers"
      annotation (Placement(transformation(extent={{100,70},{120,90}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFloByp(redeclare package
        Medium =         MediumCW) annotation (Placement(transformation(
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

  package BaseClasses
    model YorkCalc
      "Cooling tower with variable speed using the York calculation for the approach temperature"
      extends
        Buildings.Fluid.HeatExchangers.CoolingTowers.BaseClasses.CoolingTower;
      parameter Modelica.Units.SI.Efficiency eps(
        min=0.1,
        max=1) = 1 "Heat exchanger effectiveness";
      import cha =
        Buildings.Fluid.HeatExchangers.CoolingTowers.BaseClasses.Characteristics;

      parameter Modelica.Units.SI.Temperature TAirInWB_nominal=273.15 + 25.55
        "Design inlet air wet bulb temperature"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.Units.SI.TemperatureDifference TApp_nominal(displayUnit=
            "K") = 3.89 "Design approach temperature"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.Units.SI.TemperatureDifference TRan_nominal(displayUnit=
            "K") = 5.56 "Design range temperature (water in - water out)"
        annotation (Dialog(group="Nominal condition"));
      parameter Real fraPFan_nominal(unit="W/(kg/s)") = 275/0.15
        "Fan power divided by water mass flow rate at design condition"
        annotation(Dialog(group="Fan"));
      parameter Modelica.Units.SI.Power PFan_nominal=fraPFan_nominal*m_flow_nominal
        "Fan power" annotation (Dialog(group="Fan"));

      replaceable parameter cha.fan fanRelPow(
           r_V = {0, 0.1,   0.3,   0.6,   1},
           r_P = {0, 0.1^3, 0.3^3, 0.6^3, 1})
        constrainedby cha.fan
        "Fan relative power consumption as a function of control signal, fanRelPow=P(y)/P(y=1)"
        annotation (
        choicesAllMatching=true,
        Placement(transformation(extent={{60,60},{80,80}})),
        Dialog(group="Fan"));

      parameter Real yMin(min=0.01, max=1, unit="1") = 0.3
        "Minimum control signal until fan is switched off (used for smoothing between forced and free convection regime)"
        annotation(Dialog(group="Fan"));

      parameter Real fraFreCon(min=0, max=1) = 0.125
        "Fraction of tower capacity in free convection regime";

      Modelica.Blocks.Interfaces.RealInput y(unit="1") "Fan control signal"
         annotation (Placement(transformation(
              extent={{-140,60},{-100,100}})));

      Modelica.Blocks.Interfaces.RealInput TAir(
        min=0,
        unit="K",
        displayUnit="degC")
        "Entering air wet bulb temperature"
         annotation (Placement(transformation(
              extent={{-140,20},{-100,60}})));

      Modelica.Blocks.Interfaces.RealOutput PFan(
        final quantity="Power",
        final unit="W")=
          Buildings.Utilities.Math.Functions.spliceFunction(
            pos=cha.normalizedPower(per=fanRelPow, r_V=y, d=fanRelPowDer) * PFan_nominal,
            neg=0,
            x=y-yMin+yMin/20,
            deltax=yMin/20)
        "Electric power consumed by fan"
        annotation (Placement(transformation(extent={{100,70},{120,90}}),
            iconTransformation(extent={{100,70},{120,90}})));

      Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.BoundsYorkCalc bou
        "Bounds for correlation";

      Modelica.Units.SI.TemperatureDifference TRan(displayUnit="K") = T_a - T_b
        "Range temperature";
      Modelica.Units.SI.TemperatureDifference TAppAct(displayUnit="K")=
        Buildings.Utilities.Math.Functions.spliceFunction(
        pos=TAppCor,
        neg=TAppFreCon,
        x=y - yMin + yMin/20,
        deltax=yMin/20) "Approach temperature difference";
      Modelica.Units.SI.MassFraction FRWat=m_flow/mWat_flow_nominal
        "Ratio actual over design water mass flow ratio";
      Modelica.Units.SI.MassFraction FRAir=y
        "Ratio actual over design air mass flow ratio";

    protected
      package Water =  Buildings.Media.Water "Medium package for water";
      parameter Real FRWat0(min=0, start=1, fixed=false)
        "Ratio actual over design water mass flow ratio at nominal condition";
      parameter Modelica.Units.SI.Temperature TWatIn0(fixed=false)
        "Water inlet temperature at nominal condition";
      parameter Modelica.Units.SI.Temperature TWatOut_nominal(fixed=false)
        "Water outlet temperature at nominal condition";
      parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal(
        min=0,
        start=m_flow_nominal,
        fixed=false) "Nominal water mass flow rate";

      Modelica.Units.SI.TemperatureDifference dTMax(displayUnit="K") = T_a - TAir
        "Maximum possible temperature difference";
      Modelica.Units.SI.TemperatureDifference TAppCor(
        min=0,
        displayUnit="K")=
        Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
        TRan=TRan,
        TWetBul=TAir,
        FRWat=FRWat,
        FRAir=Buildings.Utilities.Math.Functions.smoothMax(
          x1=FRWat/bou.liqGasRat_max,
          x2=FRAir,
          deltaX=0.01)) "Approach temperature for forced convection";
      Modelica.Units.SI.TemperatureDifference TAppFreCon(
        min=0,
        displayUnit="K") = (1 - fraFreCon)*dTMax + fraFreCon*
        Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
        TRan=TRan,
        TWetBul=TAir,
        FRWat=FRWat,
        FRAir=1) "Approach temperature for free convection";

      final parameter Real fanRelPowDer[size(fanRelPow.r_V,1)](each fixed=false)
        "Coefficients for fan relative power consumption as a function of control signal";

      Modelica.Units.SI.Temperature T_a "Temperature in port_a";
      Modelica.Units.SI.Temperature T_b "Temperature in port_b";

      Modelica.Blocks.Sources.RealExpression QWat_flow(
        y = eps*m_flow*(
          Medium.specificEnthalpy(Medium.setState_pTX(
            p=port_b.p,
            T=TAir + TAppAct,
            X=inStream(port_b.Xi_outflow))) -
          inStream(port_a.h_outflow)))
        "Heat input into water"
        annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
    initial equation
      TWatOut_nominal = TAirInWB_nominal + TApp_nominal;
      TRan_nominal = TWatIn0 - TWatOut_nominal; // by definition of the range temp.
      TApp_nominal = Buildings.Fluid.HeatExchangers.CoolingTowers.Correlations.yorkCalc(
                       TRan=TRan_nominal, TWetBul=TAirInWB_nominal,
                       FRWat=FRWat0, FRAir=1); // this will be solved for FRWat0
      mWat_flow_nominal = m_flow_nominal/FRWat0;

      // Derivatives for spline that interpolates the fan relative power
      fanRelPowDer = Buildings.Utilities.Math.Functions.splineDerivatives(
                x=fanRelPow.r_V,
                y=fanRelPow.r_P,
                ensureMonotonicity=Buildings.Utilities.Math.Functions.isMonotonic(x=fanRelPow.r_P,
                                                                                  strict=false));
      // Check validity of relative fan power consumption at y=yMin and y=1
      assert(cha.normalizedPower(per=fanRelPow, r_V=yMin, d=fanRelPowDer) > -1E-4,
        "The fan relative power consumption must be non-negative for y=0."
      + "\n   Obtained fanRelPow(0) = " + String(cha.normalizedPower(per=fanRelPow, r_V=yMin, d=fanRelPowDer))
      + "\n   You need to choose different values for the parameter fanRelPow.");
      assert(abs(1-cha.normalizedPower(per=fanRelPow, r_V=1, d=fanRelPowDer))<1E-4, "The fan relative power consumption must be one for y=1."
      + "\n   Obtained fanRelPow(1) = " + String(cha.normalizedPower(per=fanRelPow, r_V=1, d=fanRelPowDer))
      + "\n   You need to choose different values for the parameter fanRelPow."
      + "\n   To increase the fan power, change fraPFan_nominal or PFan_nominal.");

      // Check that a medium is used that has the same definition of enthalpy vs. temperature.
      // This is needed because below, T_a=Water.temperature needed to be hard-coded to use
      // Water.* instead of Medium.* in the function calls due to a bug in OpenModelica.
      assert(abs(Medium.specificEnthalpy_pTX(p=101325, T=273.15, X=Medium.X_default) -
                 Water.specificEnthalpy_pTX(p=101325, T=273.15, X=Medium.X_default)) < 1E-5 and
             abs(Medium.specificEnthalpy_pTX(p=101325, T=293.15, X=Medium.X_default) -
                 Water.specificEnthalpy_pTX(p=101325, T=293.15, X=Medium.X_default)) < 1E-5,
             "The selected medium has an enthalpy computation that is not consistent
  with the one in Buildings.Media.Water
  Use a different medium, such as Buildings.Media.Water.");
    equation
      // States at the inlet and outlet

      if allowFlowReversal then
        if homotopyInitialization then
          T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                     h=homotopy(actual=actualStream(port_a.h_outflow),
                                                simplified=inStream(port_a.h_outflow)),
                                     X=homotopy(actual=actualStream(port_a.Xi_outflow),
                                                simplified=inStream(port_a.Xi_outflow))));
          T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                     h=homotopy(actual=actualStream(port_b.h_outflow),
                                                simplified=port_b.h_outflow),
                                     X=homotopy(actual=actualStream(port_b.Xi_outflow),
                                                simplified=port_b.Xi_outflow)));

        else
          T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                     h=actualStream(port_a.h_outflow),
                                     X=actualStream(port_a.Xi_outflow)));
          T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                     h=actualStream(port_b.h_outflow),
                                     X=actualStream(port_b.Xi_outflow)));
        end if; // homotopyInitialization

      else // reverse flow not allowed
        T_a=Water.temperature(Water.setState_phX(p=port_a.p,
                                   h=inStream(port_a.h_outflow),
                                   X=inStream(port_a.Xi_outflow)));
        T_b=Water.temperature(Water.setState_phX(p=port_b.p,
                                   h=inStream(port_b.h_outflow),
                                   X=inStream(port_b.Xi_outflow)));
      end if;

      connect(QWat_flow.y, preHea.Q_flow)
        annotation (Line(points={{-59,-60},{-40,-60}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-104,70},{-70,32}},
              lineColor={0,0,127},
              textString="TWB"),
            Text(
              extent={{-50,4},{42,-110}},
              lineColor={255,255,255},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString="York"),
            Rectangle(
              extent={{-100,81},{-70,78}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{78,-58},{102,-62}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{78,-60},{82,-4}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{70,-58},{104,-96}},
              lineColor={0,0,127},
              textString="TLvg"),
            Rectangle(
              extent={{70,56},{82,52}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{78,54},{82,80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{64,114},{98,76}},
              lineColor={0,0,127},
              textString="PFan"),
            Ellipse(
              extent={{0,62},{54,50}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-54,62},{0,50}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{78,82},{100,78}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-98,100},{-86,84}},
              lineColor={0,0,127},
              textString="y")}),
    Documentation(info="<html>
<p>
Model for a steady-state or dynamic cooling tower with variable speed fan using the York calculation for the
approach temperature at off-design conditions.
</p>
<h4>Thermal performance</h4>
<p>
To compute the thermal performance, this model takes as parameters
the approach temperature, the range temperature and the inlet air wet bulb temperature
at the design condition. Since the design mass flow rate (of the chiller condenser loop)
is also a parameter, these parameters define the rejected heat.
</p>
<p>
For off-design conditions, the model uses the actual range temperature and a polynomial
to compute the approach temperature for free convection and for forced convection, i.e.,
with the fan operating. The polynomial is valid for a York cooling tower.
If the fan input signal <code>y</code> is below the minimum fan revolution <code>yMin</code>,
then the cooling tower operates in free convection mode, otherwise it operates in
the forced convection mode.
For numerical reasons, this transition occurs in the range of <code>y &isin; [0.9*yMin, yMin]</code>.
</p>
<h4>Fan power consumption</h4>
<p>
The fan power consumption at the design condition can be specified as follows:
</p>
<ul>
<li>
The parameter <code>fraPFan_nominal</code> can be used to specify at the
nominal conditions the fan power divided by the water flow rate. The default value is
<i>275</i> Watts for a water flow rate of <i>0.15</i> kg/s.
</li>
<li>
The parameter <code>PFan_nominal</code> can be set to the fan power at nominal conditions.
If a user does not set this parameter, then the fan power will be
<code>PFan_nominal = fraPFan_nominal * m_flow_nominal</code>, where <code>m_flow_nominal</code>
is the nominal water flow rate.
</li>
</ul>
<p>
In the forced convection mode, the actual fan power is
computed as <code>PFan=fanRelPow(y) * PFan_nominal</code>, where
the default value for the fan relative power consumption at part load is
<code>fanRelPow(y)=y<sup>3</sup></code>.
In the free convection mode, the fan power consumption is zero.
For numerical reasons, the transition of fan power from the part load mode
to zero power consumption in the free convection mode occurs in the range
<code>y &isin; [0.9*yMin, yMin]</code>.
<br/>
To change the fan relative power consumption at part load in the forced convection mode,
points of fan controls signal and associated relative power consumption can be specified.
In between these points, the values are interpolated using cubic splines.
</p>
<h4>Comparison the cooling tower model of EnergyPlus</h4>
<p>
This model is similar to the model <code>Cooling Tower:Variable Speed</code> that
is implemented in the EnergyPlus building energy simulation program version 6.0.
The main differences are
</p>
<ol>
<li>
Not implemented are the basin heater power consumption, and
the make-up water usage.
</li>
<li>
The model has no built-in control to switch individual cells of the tower on or off.
To switch cells on or off, use multiple instances of this model, and use your own
control law to compute the input signal <code>y</code>.
</li>
</ol>
<h4>Assumptions and limitations</h4>
<p>
This model requires a medium that has the same computation of the enthalpy as
<a href=\"Buildings.Media.Water\">
Buildings.Media.Water</a>,
which computes
</p>
<p align=\"center\" style=\"font-style:italic;\">
 h = c<sub>p</sub> (T-T<sub>0</sub>),
</p>
<p>
where
<i>h</i> is the enthalpy,
<i>c<sub>p</sub> = 4184</i> J/(kg K) is the specific heat capacity,
<i>T</i> is the temperature in Kelvin and
<i>T<sub>0</sub> = 273.15</i> Kelvin.
If this is not the case, the simulation will stop with an error message.
The reason for this limitation is that as of January 2015, OpenModelica
failed to translate the model if <code>Medium.temperature()</code> is used
instead of
<code>Water.temperature()</code>.
</p>
<h4>References</h4>
<p>
<a href=\"http://www.energyplus.gov\">EnergyPlus 2.0.0 Engineering Reference</a>, April 9, 2007.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 16, 2020, by Michael Wetter:<br/>
Refactored model to avoid mixing textual equations and connect statements.
</li>
<li>
December, 22, 2019, by Kathryn Hinkelman:<br/>
Corrected fan power consumption.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1691\">
issue 1691</a>.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Corrected wrong type for <code>FRWat0</code>, as this variable
can take on values that are bigger than <i>1</i>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/567\">issue 567</a>.
</li>
<li>
January 2, 2015, by Michael Wetter:<br/>
Replaced <code>Medium.temperature()</code> with
<code>Water.temperature()</code> in order for the model
to work with OpenModelica.
Added an <code>assert</code> that stops the simulation if
an incompatible medium is used.
</li>
<li>
November 13, 2014, by Michael Wetter:<br/>
Added missing <code>each</code> keyword for <code>fanRelPowDer</code>.
Added regularization in computation of <code>TAppCor</code>.
Removed intermediate states with temperatures.
</li>
<li>
May 30, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 9, 2013, by Michael Wetter:<br/>
Simplified the implementation for the situation if
<code>allowReverseFlow=false</code>.
Avoided the use of the conditionally enabled variables <code>sta_a</code> and
<code>sta_b</code> as this was not proper use of the Modelica syntax.
</li>
<li>
September 29, 2011, by Michael Wetter:<br/>
Revised model to use cubic spline interpolation instead of a polynomial.
</li>
<li>
July 12, 2011, by Michael Wetter:<br/>
Introduced common base class for
<a href=\"modelica://Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc\">Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc</a>
and
<a href=\"modelica://Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach\">Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach</a>
so that they can be used as replaceable models.
</li>
<li>
May 12, 2011, by Michael Wetter:<br/>
Added binding equations for <code>Q_flow</code> and <code>mXi_flow</code>.
</li>
<li>
March 8, 2011, by Michael Wetter:<br/>
Removed base class and unused variables.
</li>
<li>
February 25, 2011, by Michael Wetter:<br/>
Revised implementation to facilitate scaling the model to different nominal sizes.
Removed parameter <code>mWat_flow_nominal</code> since it is equal to <code>m_flow_nominal</code>,
which is the water flow rate from the chiller condenser loop.
</li>
<li>
May 16, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end YorkCalc;
  end BaseClasses;
end CoolingTower;
