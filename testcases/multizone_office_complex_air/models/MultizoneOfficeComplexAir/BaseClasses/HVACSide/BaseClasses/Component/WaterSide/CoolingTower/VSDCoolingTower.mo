within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.WaterSide.CoolingTower;
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
