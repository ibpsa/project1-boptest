within BuildingControlEmulator.Devices.AirSide.Terminal.BaseClasses.Examples;
model VAV
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumWat = Buildings.Media.Water "Medium model";
  package MediumAir = Buildings.Media.Air "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat=3
    "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat=mAirFloRat*0.3*(308.15 -
      288.15)/4.2/(333.15 - 323.15) "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroAir=100
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat=1000
    "Pressure drop in the water side";
  parameter Modelica.Units.SI.Efficiency eps(max=1) = 0.8
    "Heat exchanger effectiveness";




  Buildings.Fluid.Sources.Boundary_pT souWat(
    nPorts=1,
    redeclare package Medium = MediumWat,
    p(displayUnit="Pa") = 100000 + PreDroWat,
    T=353.15)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(
    nPorts=1,
    p(displayUnit="Pa") = 100000,
    redeclare package Medium = MediumWat,
    T=278.15) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Fluid.Sources.Boundary_pT souAir(
    nPorts=1,
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000 + PreDroAir*2,
    T=286.03) annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
  Buildings.Fluid.Sources.Boundary_pT sinAir(
    nPorts=1,
    p(displayUnit="Pa") = 100000,
    redeclare package Medium = MediumAir,
    T=278.15) annotation (Placement(transformation(extent={{80,50},{60,70}})));
  BuildingControlEmulator.Devices.AirSide.Terminal.BaseClasses.VAV vAV(redeclare
      package MediumAir =                                                                    MediumAir, redeclare
      package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroAir=PreDroAir,
    PreDroWat=PreDroWat,
    eps=eps,
    pI(k=1, Ti=60))
    annotation (Placement(transformation(extent={{-14,-10},{10,12}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-80,-46},{-60,-26}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=86400, startTime=0)
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
  Modelica.Blocks.Sources.Ramp ramp1(duration=86400)
    annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
equation
  connect(vAV.port_a, souAir.ports[1])
    annotation (Line(points={{-14,1},{-26,1},{-26,-6},{-26,-60},{60,-60}}, color={0,127,255}));
  connect(vAV.port_b,sinAir. ports[1]) annotation (Line(points={{10,1},{40,1},{40,60},{60,60}}, color={0,127,255}));
  connect(vAV.port_b_Wat, sinWat.ports[1])
    annotation (Line(
      points={{-4.4,12},{-4.4,60},{-60,60}},
      color={255,0,0},
      thickness=1));
  connect(vAV.port_a_Wat, souWat.ports[1]) annotation (Line(
      points={{-11.6,12},{-12,12},{-12,20},{-12,22},{-42,22},{-42,-60},{-60,-60}},
      color={255,0,0},
      thickness=1));
  connect(booleanExpression.y, vAV.On)
    annotation (Line(points={{-59,-36},{-30,-36},{-30,-7.8},{-15.2,-7.8}}, color={255,0,255}));
  connect(ramp.y, vAV.AirFlowRatSetPoi)
    annotation (Line(points={{-59,32},{-44,32},{-28,32},{-28,9.8},{-15.2,9.8}}, color={0,0,127}));
  connect(vAV.yVal, ramp1.y)
    annotation (Line(points={{-15.2,5.4},{-52,5.4},{-52,-8},{-59,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end VAV;
