within BuildingControlEmulator.Devices.Control.Examples;
model conPI "This example models the PI controller"
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
    package MediumW = Buildings.Media.Water "Medium for chilled water";
  BuildingControlEmulator.Devices.Control.conPI conPI(
    conPID(reverseAction=true),
    Ti=60,
    k=10) annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = MediumW,
    m_flow_nominal=1,
    dpValve_nominal=1000)
    annotation (Placement(transformation(extent={{-32,-30},{-12,-10}})));
  Buildings.Fluid.Sources.Boundary_pT Sou(
    nPorts=1,
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 101325 + 2000,
    T=278.15) "Sou for CHW" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-20})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 101325 + 1000,
    nPorts=1) "Sink for CHW" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={78,-20})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    nPorts=2,
    T_start=273.15+10,
    redeclare package Medium = MediumW,
    m_flow_nominal=1,
    V=1)  annotation (Placement(transformation(extent={{16,-6},{36,14}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.Ramp ramp(                  duration=86400/2,
    height=-0.5*10*4200,
    offset=1*10*4200)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT(redeclare package Medium =
        MediumW, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vol.T)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(const.y, conPI.SetPoi) annotation (Line(
      points={{-79,30},{-76,30},{-76,50},{-64,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanExpression.y, conPI.On) annotation (Line(
      points={{-79,88},{-76,88},{-76,56},{-64,56}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(conPI.y, val.y) annotation (Line(
      points={{-41,50},{-22,50},{-22,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Sou.ports[1], val.port_a) annotation (Line(
      points={{-60,-20},{-46,-20},{-32,-20}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, vol.ports[1]) annotation (Line(
      points={{-12,-20},{24,-20},{24,-6}},
      color={0,127,255},
      thickness=1));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(
      points={{10,30},{18,30},{18,20},{2,20},{2,4},{16,4}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-59,-50},{-50,-50},{-50,30},{-10,30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senT.port_b, sin.ports[1]) annotation (Line(
      points={{60,-20},{68,-20}},
      color={0,127,255},
      thickness=1));
  connect(senT.port_a, vol.ports[2]) annotation (Line(
      points={{40,-20},{28,-20},{28,-6}},
      color={0,127,255},
      thickness=1));
  connect(realExpression.y, conPI.Mea) annotation (Line(
      points={{-79,0},{-70,0},{-70,44},{-64,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_NumberOfIntervals=4000));
end conPI;
