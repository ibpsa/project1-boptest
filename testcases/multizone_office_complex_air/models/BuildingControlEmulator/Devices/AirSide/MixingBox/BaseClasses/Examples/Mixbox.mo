within BuildingControlEmulator.Devices.AirSide.MixingBox.BaseClasses.Examples;
model Mixbox
  extends Modelica.Icons.Example;
    package Medium = Buildings.Media.Air "Medium model";
  MixBox mixBox(                   mTotAirFloRat=1,
    PreDro(displayUnit="Pa") = 2000,
    redeclare package Medium = Medium,
    mFreAirFloRat=0.9)                              annotation (Placement(transformation(extent={{-16,-14},{16,18}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=1,
    p(displayUnit="Pa") = 100000 - 2000,
    T=293.15) annotation (Placement(transformation(extent={{52,-56},{32,-36}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    nPorts=1,
    p(displayUnit="Pa") = 100000 + 2000,
    T=299.15)
    annotation (Placement(transformation(extent={{-58,-56},{-38,-36}})));
  Buildings.Fluid.Sources.Boundary_pT souOut(
    redeclare package Medium = Medium,
    nPorts=2,
    p(displayUnit="Pa") = 100000,
    T=288.15) annotation (Placement(transformation(extent={{-42,64},{-22,84}})));
  Modelica.Blocks.Sources.Constant DamPos(k=1) "Damper position"
    annotation (Placement(transformation(extent={{-78,-8},{-58,12}})));
equation
  connect(sin.ports[1], mixBox.port_Sup) annotation (Line(
      points={{32,-46},{9.6,-46},{9.6,-14}},
      color={0,127,255},
      thickness=1));
  connect(sou.ports[1], mixBox.port_Ret) annotation (Line(
      points={{-38,-46},{-11.2,-46},{-11.2,-14}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Fre, souOut.ports[1]) annotation (Line(
      points={{9.6,18},{10,18},{10,76},{-22,76}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Exh, souOut.ports[2]) annotation (Line(
      points={{-11.2,18},{-10,18},{-10,36},{-12,36},{-12,72},{-22,72}},
      color={0,127,255},
      thickness=1));
  connect(DamPos.y, mixBox.DamPos) annotation (Line(
      points={{-57,2},{-40,2},{-19.2,2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000));
end Mixbox;
