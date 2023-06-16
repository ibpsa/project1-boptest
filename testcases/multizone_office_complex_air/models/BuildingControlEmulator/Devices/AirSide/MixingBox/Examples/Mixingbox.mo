within BuildingControlEmulator.Devices.AirSide.MixingBox.Examples;
model Mixingbox
  extends Modelica.Icons.Example;
    package Medium = Buildings.Media.Air "Medium model";
  MixingBox mixBox(
    mTotAirFloRat=1,
    PreDro(displayUnit="Pa") = 2000,
    redeclare package Medium = Medium,
    mFreAirFloRat=0.9,
    DamMin=0.3,
    k=0.01,
    Ti=6,
    TemHig=289.15,
    TemLow=273.15)
           annotation (Placement(transformation(extent={{-16,-14},{16,18}})));
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
    use_T_in=true,
    p(displayUnit="Pa") = 100000,
    T=288.15) annotation (Placement(transformation(extent={{-44,64},{-24,84}})));
  Modelica.Blocks.Sources.BooleanPulse booleanStep1(startTime=0, period=200)
    annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Modelica.Blocks.Sources.Constant con(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-96,-26},{-78,-8}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=15,
    duration=600,
    startTime=0,
    offset=273.15 + 6)
              annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
equation
  connect(sin.ports[1], mixBox.port_Sup) annotation (Line(
      points={{32,-46},{9.6,-46},{9.6,-14.32}},
      color={0,127,255},
      thickness=1));
  connect(sou.ports[1], mixBox.port_Ret) annotation (Line(
      points={{-38,-46},{-9.28,-46},{-9.28,-14}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Fre, souOut.ports[1]) annotation (Line(
      points={{9.6,18},{22,18},{22,76},{-24,76}},
      color={0,127,255},
      thickness=1));
  connect(mixBox.port_Exh, souOut.ports[2]) annotation (Line(
      points={{-9.6,18},{-14,18},{-14,34},{-14,36},{-14,72},{-24,72}},
      color={0,127,255},
      thickness=1));
  connect(booleanStep1.y, mixBox.On) annotation (Line(
      points={{-79,62},{-46,62},{-46,14.8},{-19.2,14.8}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(con.y, mixBox.SetPoi) annotation (Line(
      points={{-77.1,-17},{-48,-17},{-48,2},{-19.2,2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ramp.y, souOut.T_in) annotation (Line(
      points={{-79,92},{-60,92},{-60,78},{-46,78}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mixBox.Tout, souOut.T_in) annotation (Line(
      points={{-19.2,-7.6},{-60,-7.6},{-60,78},{-46,78}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1200, __Dymola_Algorithm="Dassl"));
end Mixingbox;
