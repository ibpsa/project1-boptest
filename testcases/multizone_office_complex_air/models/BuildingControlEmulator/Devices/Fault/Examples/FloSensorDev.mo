within BuildingControlEmulator.Devices.Fault.Examples;
model FloSensorDev
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium for water";

  Buildings.Fluid.Sources.MassFlowSource_T souW(
    redeclare package Medium = Medium,
    T=273.15 + 20,
    use_T_in=true,
    m_flow=1,
    nPorts=1) "Source for water"
    annotation (Placement(transformation(extent={{58,-30},{38,-10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2.5,
    offset=275.15 + 7.5,
    f=1/86400)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Buildings.Fluid.Sources.Boundary_pT sinW(redeclare package Medium = Medium,
      nPorts=1) "Sink for water" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,-20})));
  BuildingControlEmulator.Devices.Fault.FloSensorDev floSensorDev(
    redeclare package Medium = Medium,
    FauTime=14300,
    dm=0.1)
    annotation (Placement(transformation(extent={{0,-30},{-20,-10}})));
equation
  connect(sine.y, souW.T_in) annotation (Line(
      points={{61,-50},{80,-50},{80,-16},{60,-16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(floSensorDev.port_a, souW.ports[1]) annotation (Line(
      points={{0,-20},{20,-20},{38,-20}},
      color={0,127,255},
      thickness=1));
  connect(floSensorDev.port_b, sinW.ports[1]) annotation (Line(
      points={{-20,-20},{-64,-20}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end FloSensorDev;
