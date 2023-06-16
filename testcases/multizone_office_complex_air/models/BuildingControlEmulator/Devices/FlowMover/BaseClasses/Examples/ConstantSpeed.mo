within BuildingControlEmulator.Devices.FlowMover.BaseClasses.Examples;
model ConstantSpeed "This example models the fluild loop with a constant speed fan/pump"
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  Buildings.Obsolete.Fluid.Sources.FixedBoundary sin(
    redeclare package Medium = Medium,
    nPorts=2,
    p=100000,
    T=293.15) annotation (Placement(transformation(extent={{-102,8},{-82,28}})));
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor PumSec(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-18,10},{2,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium,
    dpValve_nominal=50,
    m_flow_nominal=1*1000)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    m_flow_nominal=1*1000,
    dp_nominal=50,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={88,-20})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      = Medium) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={12,-32})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=60,
    xi_start=0)
    annotation (Placement(transformation(extent={{42,-26},{54,-14}})));
  Modelica.Blocks.Sources.Constant con(k=50)
    annotation (Placement(transformation(extent={{24,-26},{36,-14}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=60,
    startTime=50,
    height=-0.5,
    offset=1) annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor PumPri(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-80,-56})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-50,-34})));
  Modelica.Blocks.Sources.Step step(
    startTime=30,
    height=1,
    offset=0)
    annotation (Placement(transformation(extent={{-6,-74},{-26,-54}})));
  Buildings.Fluid.FixedResistances.PressureDrop res1(
    m_flow_nominal=1*1000,
    redeclare package Medium = Medium,
    dp_nominal=50)                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-22})));
  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    m_flow_nominal={500,500,1000},
    dp_nominal={12.5,12.5,25},
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal={500,500,1000},
    dp_nominal={12.5,12.5,25},
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-90}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(PumSec.port_b, val.port_a) annotation (Line(
      points={{2,20},{40,20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b,res. port_a) annotation (Line(
      points={{60,20},{88,20},{88,-10}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.p_rel,conPID. u_m) annotation (Line(
      points={{21,-32},{48,-32},{48,-27.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(con.y,conPID. u_s) annotation (Line(
      points={{36.6,-20},{40.8,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPID.y, PumSec.u) annotation (Line(
      points={{54.6,-20},{70,-20},{70,-48},{-30,-48},{-30,26},{-19,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ramp.y,val. y) annotation (Line(
      points={{5,70},{22,70},{50,70},{50,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.port_a, val.port_a) annotation (Line(
      points={{12,-22},{12,20},{40,20}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.port_b, res.port_a) annotation (Line(
      points={{12,-42},{12,-62},{74,-62},{74,20},{88,20},{88,-10}},
      color={0,127,255},
      thickness=1));
  connect(step.y, PumPri.u) annotation (Line(
      points={{-27,-64},{-56,-64},{-56,-72},{-74,-72},{-74,-67}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PumPri.port_b, res1.port_b) annotation (Line(
      points={{-80,-46},{-80,-32}},
      color={0,127,255},
      thickness=1));
  connect(res1.port_a, sin.ports[1]) annotation (Line(
      points={{-80,-12},{-80,20},{-82,20}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_2, PumSec.port_a) annotation (Line(
      points={{-40,20},{-18,20}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_1, sin.ports[2]) annotation (Line(
      points={{-60,20},{-82,20},{-82,16}},
      color={0,127,255},
      thickness=1));
  connect(PumPri.port_a, jun1.port_2) annotation (Line(
      points={{-80,-66},{-80,-80},{-60,-80}},
      color={0,127,255},
      thickness=1));
  connect(jun1.port_1, res.port_b) annotation (Line(
      points={{-40,-80},{88,-80},{88,-30}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_3, massFlowRate.port_a) annotation (Line(
      points={{-50,10},{-50,10},{-50,-26}},
      color={0,127,255},
      thickness=1));
  connect(massFlowRate.port_b, jun1.port_3) annotation (Line(
      points={{-50,-42},{-50,-70}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100),
    Documentation(info="<html>
<p>This example models the fluild loop with a constant speed fan/pump</p>
</html>"));
end ConstantSpeed;
