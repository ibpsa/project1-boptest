within BuildingControlEmulator.Devices.Fault.Examples;
model TemSensorDev
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium for water";

  Buildings.Fluid.Sources.MassFlowSource_T souW(
    redeclare package Medium = Medium,
    T=273.15 + 20,
    use_T_in=true,
    nPorts=1,
    m_flow=1) "Source for water"
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
  BuildingControlEmulator.Devices.Fault.TemSensorDev temSensorDev(
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    dt=2,
    FauTime=64300)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(sine.y, souW.T_in) annotation (Line(
      points={{61,-50},{80,-50},{80,-16},{60,-16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(souW.ports[1], temSensorDev.port_b) annotation (Line(
      points={{38,-20},{20,-20},{0,-20}},
      color={0,127,255},
      thickness=1));
  connect(temSensorDev.port_a, sinW.ports[1]) annotation (Line(
      points={{-20,-20},{-64,-20}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TemSensorDev;
