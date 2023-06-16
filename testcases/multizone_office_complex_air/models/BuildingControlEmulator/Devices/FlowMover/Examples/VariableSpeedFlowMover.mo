within BuildingControlEmulator.Devices.FlowMover.Examples;
model VariableSpeedFlowMover
  "This example models the fluild loop with a variable speed fan/pump"
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=2,
    p=100000,
    T=293.15) annotation (Placement(transformation(extent={{-96,8},{-76,28}})));
  VariableSpeedMover                                                 Pum(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    dpValve_nominal=50,
    m_flow_nominal=1*1000)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    m_flow_nominal=1*1000,
    dp_nominal=50,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-20})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      = Medium) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={8,-12})));
  Modelica.Blocks.Sources.Constant con(k=50)
    annotation (Placement(transformation(extent={{-64,-14},{-52,-2}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=60,
    startTime=50,
    height=-0.5,
    offset=1) annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  Modelica.Blocks.Sources.BooleanPulse booleanStep(period=10, startTime=500)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
equation
  connect(sin.ports[1], Pum.port_a) annotation (Line(
      points={{-76,20},{-76,20},{-30,20}},
      color={0,127,255},
      thickness=1));
  connect(Pum.port_b, val.port_a) annotation (Line(
      points={{-10,20},{30,20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, res.port_a) annotation (Line(
      points={{50,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  connect(res.port_b, sin.ports[2]) annotation (Line(
      points={{70,-30},{70,-30},{70,-60},{-74,-60},{-74,16},{-76,16}},
      color={0,127,255},
      thickness=1));

  connect(ramp.y, val.y) annotation (Line(
      points={{5,70},{22,70},{40,70},{40,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.port_a, val.port_a) annotation (Line(
      points={{8,-2},{8,20},{30,20}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.port_b, res.port_a) annotation (Line(
      points={{8,-22},{8,-52},{60,-52},{60,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  connect(booleanStep.y, Pum.On) annotation (Line(
      points={{-59,80},{-40,80},{-40,26},{-32,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(con.y, Pum.SetPoi) annotation (Line(
      points={{-51.4,-8},{-44,-8},{-44,22},{-32,22}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.p_rel, Pum.Mea) annotation (Line(
      points={{-1,-12},{-18,-12},{-40,-12},{-40,14},{-32,14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100),
    Documentation(info="<html>
<p>This example models the fluild loop with a variable speed fan/pump</p>
</html>"));
end VariableSpeedFlowMover;
