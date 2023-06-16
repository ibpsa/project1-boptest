within BuildingControlEmulator.Devices.FlowMover.Examples;
model DualFan "the example to model the air loop with two fans"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium model";
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=293.15) annotation (Placement(transformation(extent={{-96,10},{-76,30}})));
  BuildingControlEmulator.Devices.FlowMover.VAVSupplyFan PumSup(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5},
    numTemp=3,
    SpeRat=0.9,
    k=1,
    Ti=60,
    waitTime=10)
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
    annotation (Placement(transformation(extent={{-100,-6},{-88,6}})));
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
  BuildingControlEmulator.Devices.FlowMover.BaseClasses.WithoutMotor PumRet(
    redeclare package Medium = Medium,
    TimCon=10,
    HydEff={0.7,0.7,0.7,0.7,0.7},
    MotEff={0.7,0.7,0.7,0.7,0.7},
    PreCur(displayUnit="Pa") = {300,250,200,150,100},
    VolFloCur={0.3,0.5,0.7,0.9,1.5})
    annotation (Placement(transformation(extent={{-30,-90},{-50,-70}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{58,42},{78,62}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startValue=false, startTime=
        200) annotation (Placement(transformation(extent={{-92,60},{-72,80}})));
  Modelica.Blocks.Sources.Constant const[3](k=0)
    annotation (Placement(transformation(extent={{-100,-26},{-88,-14}})));
  Modelica.Blocks.Sources.Sine sine(f=1/60)
    annotation (Placement(transformation(extent={{-100,-46},{-88,-34}})));
  Modelica.Blocks.Sources.Sine sine1(f=1/60, phase=1.9198621771938)
    annotation (Placement(transformation(extent={{-80,-46},{-68,-34}})));
  Modelica.Blocks.Sources.Sine sine2(f=1/60, phase=0.34906585039887)
    annotation (Placement(transformation(extent={{-60,-46},{-48,-34}})));
  Modelica.Blocks.Sources.Constant const1[3](k=-0.5)
    annotation (Placement(transformation(extent={{-96,40},{-84,52}})));
equation
  connect(sin.ports[1], PumSup.port_a) annotation (Line(
      points={{-76,20},{-76,20},{-50,20}},
      color={0,127,255},
      thickness=1));
  connect(PumSup.port_b, val.port_a) annotation (Line(
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
  connect(PumRet.port_b, sin1.ports[1]) annotation (Line(
      points={{-50,-80},{-62,-80},{-76,-80}},
      color={0,127,255},
      thickness=1));
  connect(PumRet.port_a, res.port_b) annotation (Line(
      points={{-30,-80},{-30,-80},{70,-80},{70,-30}},
      color={0,127,255},
      thickness=1));
  connect(pressure.port, res.port_a) annotation (Line(
      points={{68,42},{68,36},{56,36},{56,20},{70,20},{70,-10}},
      color={0,127,255},
      thickness=1));
  connect(booleanStep.y, PumSup.On) annotation (Line(
      points={{-71,70},{-60,70},{-60,26},{-52,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(con.y, PumSup.PreSetPoi) annotation (Line(
      points={{-87.4,0},{-64,0},{-64,22},{-52,22}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PumSup.PreMea, senRelPre.p_rel) annotation (Line(
      points={{-52,10},{-56,10},{-56,-14},{14,-14},{14,-32},{9,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, PumSup.CooTempSetPoi) annotation (Line(
      points={{-87.4,-20},{-62,-20},{-62,18},{-52,18}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine2.y, PumSup.Temp[1]) annotation (Line(
      points={{-47.4,-40},{-36,-40},{-24,-40},{-24,-6},{-58,-6},{-58,12.6667},{
          -52,12.6667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine1.y, PumSup.Temp[2]) annotation (Line(
      points={{-67.4,-40},{-60,-40},{-60,14},{-52,14}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine.y, PumSup.Temp[3]) annotation (Line(
      points={{-87.4,-40},{-82,-40},{-82,10},{-68,10},{-68,15.3333},{-52,
          15.3333}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PumSup.yRet, PumRet.u) annotation (Line(
      points={{-29,11.8},{-14,11.8},{-14,-74},{-29,-74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const1.y, PumSup.HeaTempSetPoi) annotation (Line(
      points={{-83.4,46},{-56,46},{-56,30},{-52,30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000),
    Documentation(info="<html>
<p>This example models the fluild loop with a variable speed fan/pump</p>
</html>"));
end DualFan;
