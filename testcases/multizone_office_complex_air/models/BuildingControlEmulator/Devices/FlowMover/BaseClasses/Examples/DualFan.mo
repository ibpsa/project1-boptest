within BuildingControlEmulator.Devices.FlowMover.BaseClasses.Examples;
model DualFan "the example to model the air loop with two fans"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sin(
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
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
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
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=60,
    xi_start=0)
    annotation (Placement(transformation(extent={{34,-26},{46,-14}})));
  Modelica.Blocks.Sources.Constant con(k=50)
    annotation (Placement(transformation(extent={{14,-26},{26,-14}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=60,
    startTime=50,
    height=-0.5,
    offset=1) annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sin1(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=293.15)
    annotation (Placement(transformation(extent={{-96,-90},{-76,-70}})));
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor Pum1(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-18,-90},{-38,-70}})));
  Modelica.Blocks.Math.Gain gain(k=0.9)
    annotation (Placement(transformation(extent={{10,-68},{2,-60}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{58,42},{78,62}})));
equation
  connect(sin.ports[1], Pum.port_a) annotation (Line(
      points={{-76,20},{-76,20},{-40,20}},
      color={0,127,255},
      thickness=1));
  connect(Pum.port_b, val.port_a) annotation (Line(
      points={{-20,20},{30,20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, res.port_a) annotation (Line(
      points={{50,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));

  connect(senRelPre.p_rel, conPID.u_m) annotation (Line(
      points={{9,-32},{40,-32},{40,-27.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(con.y, conPID.u_s) annotation (Line(
      points={{26.6,-20},{28,-20},{32.8,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPID.y, Pum.u) annotation (Line(
      points={{46.6,-20},{50,-20},{50,-48},{-50,-48},{-50,26},{-41,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
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
      points={{-38,-80},{-76,-80}},
      color={0,127,255},
      thickness=1));
  connect(Pum1.port_a, res.port_b) annotation (Line(
      points={{-18,-80},{-18,-80},{70,-80},{70,-30}},
      color={0,127,255},
      thickness=1));
  connect(gain.u, Pum.u) annotation (Line(
      points={{10.8,-64},{32,-64},{32,-48},{-50,-48},{-50,26},{-41,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain.y, Pum1.u) annotation (Line(
      points={{1.6,-64},{-8,-64},{-8,-74},{-17,-74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pressure.port, res.port_a) annotation (Line(
      points={{68,42},{68,36},{56,36},{56,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100),
    Documentation(info="<html>
<p>This example models the fluild loop with a variable speed fan/pump</p>
</html>"));
end DualFan;
