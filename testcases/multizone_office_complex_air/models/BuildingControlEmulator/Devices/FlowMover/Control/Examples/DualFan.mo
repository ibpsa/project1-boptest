within BuildingControlEmulator.Devices.FlowMover.Control.Examples;
model DualFan "the example to model the air loop with two fans"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=293.15) annotation (Placement(transformation(extent={{-96,10},{-76,30}})));
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor Pum(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    m_flow_nominal=1*1000,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    m_flow_nominal=1*1000,
    redeclare package Medium = Medium,
    dp_nominal=100)                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-20})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      = Medium) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-32})));
  Modelica.Blocks.Sources.Constant con(k=50)
    annotation (Placement(transformation(extent={{-86,-26},{-74,-14}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=60,
    startTime=50,
    height=-0.5,
    offset=1) annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=293.15) annotation (Placement(transformation(extent={{-96,-90},{-76,-70}})));
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor Pum1(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-30,-90},{-50,-70}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{58,42},{78,62}})));
  BuildingControlEmulator.Devices.FlowMover.Control.VAVDualFanControl
    vAVDualFanControl(
    k=1,
    Ti=60,
    waitTime=10,
    SpeRat=0.9)
    annotation (Placement(transformation(extent={{-50,-34},{-30,-14}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startValue=false, startTime=
        200) annotation (Placement(transformation(extent={{-92,60},{-72,80}})));
  Modelica.Blocks.Sources.BooleanPulse booleanStep1(startTime=0, period=30)
    annotation (Placement(transformation(extent={{-98,-60},{-78,-40}})));
equation
  connect(sin.ports[1], Pum.port_a) annotation (Line(
      points={{-76,20},{-76,20},{-50,20}},
      color={0,127,255},
      thickness=1));
  connect(Pum.port_b, val.port_a) annotation (Line(
      points={{-30,20},{30,20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, res.port_a) annotation (Line(
      points={{50,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));

  connect(ramp.y, val.y) annotation (Line(
      points={{5,70},{22,70},{40,70},{40,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.port_a, val.port_a) annotation (Line(
      points={{0,-22},{0,20},{30,20}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.port_b, res.port_a) annotation (Line(
      points={{0,-42},{0,-52},{60,-52},{60,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  connect(Pum1.port_b, sin1.ports[1]) annotation (Line(
      points={{-50,-80},{-62,-80},{-76,-80}},
      color={0,127,255},
      thickness=1));
  connect(Pum1.port_a, res.port_b) annotation (Line(
      points={{-30,-80},{-30,-80},{70,-80},{70,-30}},
      color={0,127,255},
      thickness=1));
  connect(pressure.port, res.port_a) annotation (Line(
      points={{68,42},{68,36},{56,36},{56,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  connect(con.y, vAVDualFanControl.SetPoi) annotation (Line(
      points={{-73.4,-20},{-62,-20},{-62,-22},{-52,-22}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.p_rel, vAVDualFanControl.Mea) annotation (Line(
      points={{9,-32},{26,-32},{26,-58},{-62,-58},{-62,-26},{-52,-26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanStep.y, vAVDualFanControl.On) annotation (Line(
      points={{-71,70},{-60,70},{-60,-18},{-52,-18}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(vAVDualFanControl.ySup, Pum.u) annotation (Line(
      points={{-29,-20},{-12,-20},{-12,40},{-56,40},{-56,26},{-51,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Pum1.u, vAVDualFanControl.yRet) annotation (Line(
      points={{-29,-74},{-12,-74},{-12,-28},{-29,-28}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanStep1.y, vAVDualFanControl.CyclingOn) annotation (Line(
      points={{-77,-50},{-58,-50},{-58,-30},{-52,-30}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000),
    Documentation(info="<html>
<p>This example models the fluild loop with a variable speed fan/pump</p>
</html>"));
end DualFan;
