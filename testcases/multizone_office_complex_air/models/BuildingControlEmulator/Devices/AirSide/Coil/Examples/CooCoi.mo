within BuildingControlEmulator.Devices.AirSide.Coil.Examples;
model CooCoi
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package Medium1 = Buildings.Media.Water "Medium model";
  package Medium2 = Buildings.Media.Air "Medium model";
  BuildingControlEmulator.Devices.AirSide.Coil.CooCoil
                                               Coi(
    redeclare package MediumAir = Medium2,
    redeclare package MediumWat = Medium1,
    mWatFloRat=1,
    PreDroAir(displayUnit="Pa") = 1000,
    PreDroWat(displayUnit="Pa") = 1000,
    mAirFloRat=1,
    UA=4.2*1000,
    k=1,
    Ti=60) annotation (Placement(transformation(extent={{-20,14},{22,-28}})));
  Buildings.Fluid.Sources.Boundary_pT souWat(
    nPorts=1,
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 100000,
    T=278.15)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(
    nPorts=1,
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 100000 - 1000,
    T=293.15) annotation (Placement(transformation(extent={{94,-70},{74,-50}})));
  Buildings.Fluid.Sources.Boundary_pT sinAir(
    nPorts=1,
    p(displayUnit="Pa"),
    redeclare package Medium = Medium2,
    T=293.15) annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temLeaWat(redeclare package Medium
      = Medium1)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Buildings.Fluid.Sources.Boundary_pT souAir(
    nPorts=1,
    p(displayUnit="Pa") = 101325 + 1000,
    redeclare package Medium = Medium2,
    X={0.02,1 - 0.02},
    use_T_in=true,
    use_X_in=true)
    annotation (Placement(transformation(extent={{82,32},{62,52}})));
  Buildings.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false)
    annotation (Placement(transformation(extent={{18,70},{38,90}})));
  Modelica.Blocks.Sources.Constant temSou(k=273.15 + 20)
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant relHum(k=0.8) "Relative humidity"
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Sources.Constant relHum1(k=273.15 + 10)
                                                 "Relative humidity"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=500, startValue=false)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(souWat.ports[1], Coi.port_a_Wat) annotation (Line(
      points={{-60,-60},{-40,-60},{-40,-23.8},{-20,-23.8}},
      color={0,127,255},
      thickness=1));
  connect(Coi.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-20.42,9.8},
          {-40,9.8},{-40,48},{-60,48}}, color={0,127,255},
      thickness=1));
  connect(sinWat.ports[1], temLeaWat.port_b) annotation (Line(
      points={{74,-60},{60,-60}},
      color={0,127,255},
      thickness=1));
  connect(temLeaWat.port_a, Coi.port_b_Wat) annotation (Line(
      points={{40,-60},{30,-60},{30,-24},{26,-24},{26,-23.8},{22,-23.8}},
      color={0,127,255},
      thickness=1));
  connect(souAir.ports[1], Coi.port_a_Air)
    annotation (Line(points={{62,42},{22,42},{22,9.8}}, color={0,127,255},
      thickness=1));
  connect(relHum.y,x_pTphi. phi) annotation (Line(
      points={{-9,30},{-6,30},{-6,74},{16,74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temSou.y,x_pTphi. T) annotation (Line(
      points={{-39,80},{16,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(souAir.T_in,x_pTphi. T) annotation (Line(
      points={{84,46},{90,46},{90,58},{-28,58},{-28,80},{16,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(x_pTphi.X, souAir.X_in) annotation (Line(
      points={{39,80},{68,80},{98,80},{98,38},{84,38}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(relHum1.y, Coi.SetPoi) annotation (Line(
      points={{-79,10},{-50,10},{-50,-2.8},{-24.2,-2.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanStep.y, Coi.On) annotation (Line(
      points={{-79,-30},{-50,-30},{-50,-15.4},{-24.2,-15.4}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000));
end CooCoi;
