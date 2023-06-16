within BuildingControlEmulator.Devices.Fault.Examples;
model PreSensorDrift
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Water "Medium for water";

  Buildings.Fluid.Sources.Boundary_pT      souW(
    redeclare package Medium = Medium,
    T=273.15 + 20,
    use_p_in=true,
    nPorts=1) "Source for water"
    annotation (Placement(transformation(extent={{12,-28},{-8,-8}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/86400,
    amplitude=2000,
    offset=100000)
    annotation (Placement(transformation(extent={{-6,-58},{14,-38}})));
  BuildingControlEmulator.Devices.Fault.PreSensorDrift preSensorDev(
    redeclare package Medium = Medium,
    dp(displayUnit="Pa") = 200,
    FauTime=43200,
    DraftTime=40000)
    annotation (Placement(transformation(extent={{-42,4},{-22,24}})));
equation
  connect(sine.y, souW.p_in) annotation (Line(
      points={{15,-48},{34,-48},{34,-10},{14,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(preSensorDev.port, souW.ports[1]) annotation (Line(
      points={{-32,4},{-32,-18},{-8,-18}},
      color={0,127,255},
      thickness=1));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PreSensorDrift;
