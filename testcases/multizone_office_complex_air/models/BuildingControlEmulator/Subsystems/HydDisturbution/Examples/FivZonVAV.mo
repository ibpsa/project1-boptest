within BuildingControlEmulator.Subsystems.HydDisturbution.Examples;
model FivZonVAV
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air "Medium model for air";

    package MediumWat = Buildings.Media.Water "Medium model for water";


  parameter Modelica.Units.SI.Pressure PreAirDroMai1=140
    "Pressure drop 1 across the duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai2=140
    "Pressure drop 2 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai3=120
    "Pressure drop 3 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroMai4=152
    "Pressure drop 4 across the main duct";

  parameter Modelica.Units.SI.Pressure PreAirDroBra1=0
    "Pressure drop 1 across the duct branch 1";

  parameter Modelica.Units.SI.Pressure PreAirDroBra2=0
    "Pressure drop 1 across the duct branch 2";

  parameter Modelica.Units.SI.Pressure PreAirDroBra3=0
    "Pressure drop 1 across the duct branch 3";

  parameter Modelica.Units.SI.Pressure PreAirDroBra4=0
    "Pressure drop 1 across the duct branch 4";

  parameter Modelica.Units.SI.Pressure PreAirDroBra5=0
    "Pressure drop 1 across the duct branch 5";

  parameter Modelica.Units.SI.Pressure PreWatDroMai1=79712*0.2
    "Pressure drop 1 across the pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai2=79712*0.2
    "Pressure drop 2 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai3=79712*0.2
    "Pressure drop 3 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai4=79712*0.2
    "Pressure drop 4 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroBra1=0
    "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.Units.SI.Pressure PreWatDroBra2=0
    "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.Units.SI.Pressure PreWatDroBra3=0
    "Pressure drop 1 across the pipe branch 3";

  parameter Modelica.Units.SI.Pressure PreWatDroBra4=0
    "Pressure drop 1 across the pipe branch 4";

  parameter Modelica.Units.SI.Pressure PreWatDroBra5=0
    "Pressure drop 1 across the pipe branch 5";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1=10.92*1.2
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2=2.25*1.2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3=1.49*1.2
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4=1.9*1.2
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5=1.73*1.2
    "mass flow rate for vav 5";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat1=mAirFloRat1*0.3*(35 -
      12.88)/4.2/20 "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat2=mAirFloRat2*0.3*(35 -
      12.88)/4.2/20 "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat3=mAirFloRat3*0.3*(35 -
      12.88)/4.2/20 "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat4=mAirFloRat4*0.3*(35 -
      12.88)/4.2/20 "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat5=mAirFloRat5*0.3*(35 -
      12.88)/4.2/20 "mass flow rate for vav 5";

  parameter Modelica.Units.SI.Pressure PreDroAir1=200
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat1=79712
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir2=124
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroWat2=79712
    "Pressure drop in the water side of vav 2";
  parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";

  parameter Modelica.Units.SI.Pressure PreDroAir3=124
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroWat3=79712
    "Pressure drop in the water side of vav 3";
  parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir4=124
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4=79712
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir5=124
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat5=79712
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";


  Buildings.Fluid.Sources.Boundary_pT souAir(
    p(displayUnit="Pa") = 100000 + PreAirDroMai1 + PreAirDroMai2 + PreAirDroMai3 + PreAirDroMai4 + PreAirDroBra5 + PreDroAir5,
    redeclare package Medium = MediumAir,
    nPorts=1,
    T=286.02) annotation (Placement(transformation(extent={{-100,18},{-80,38}})));

  Buildings.Fluid.Sources.Boundary_pT sinAir(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000,
    nPorts=1,
    T=299.15) annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));

  Modelica.Blocks.Sources.Ramp ramp[5](duration=86400, height=1*1000*10)
                                                                 annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  BuildingControlEmulator.Subsystems.HydDisturbution.FivZonVAV fivZonVAV(
    vAV(pI(k=1, Ti=60)),
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    PreAirDroMai1=PreAirDroMai1,
    PreAirDroMai2=PreAirDroMai2,
    PreAirDroMai3=PreAirDroMai3,
    PreAirDroMai4=PreAirDroMai4,
    PreAirDroBra1=PreAirDroBra1,
    PreAirDroBra2=PreAirDroBra2,
    PreAirDroBra3=PreAirDroBra3,
    PreAirDroBra4=PreAirDroBra4,
    PreAirDroBra5=PreAirDroBra5,
    PreWatDroMai1=PreWatDroMai1,
    PreWatDroMai2=PreWatDroMai2,
    PreWatDroMai3=PreWatDroMai3,
    PreWatDroMai4=PreWatDroMai4,
    PreWatDroBra1=PreWatDroBra1,
    PreWatDroBra2=PreWatDroBra2,
    PreWatDroBra3=PreWatDroBra3,
    PreWatDroBra4=PreWatDroBra4,
    PreWatDroBra5=PreWatDroBra5,
    mAirFloRat1=mAirFloRat1,
    mAirFloRat2=mAirFloRat2,
    mAirFloRat3=mAirFloRat3,
    mAirFloRat4=mAirFloRat4,
    mAirFloRat5=mAirFloRat5,
    mWatFloRat1=mWatFloRat1,
    mWatFloRat2=mWatFloRat2,
    mWatFloRat3=mWatFloRat3,
    mWatFloRat4=mWatFloRat4,
    mWatFloRat5=mWatFloRat5,
    PreDroAir1=PreDroAir1,
    PreDroWat1=PreDroWat1,
    eps1=eps1,
    PreDroAir2=PreDroAir2,
    PreDroWat2=PreDroWat2,
    eps2=eps2,
    PreDroAir3=PreDroAir3,
    PreDroWat3=PreDroWat3,
    eps3=eps3,
    PreDroAir4=PreDroAir4,
    PreDroWat4=PreDroWat4,
    eps4=eps4,
    PreDroAir5=PreDroAir5,
    PreDroWat5=PreDroWat5,
    eps5=eps5)
    annotation (Placement(transformation(extent={{-28,-28},{18,22}})));
  Buildings.Fluid.Sources.Boundary_pT souWat(
    p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 + PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
    nPorts=1,
    redeclare package Medium = MediumWat,
    T=353.15) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(
    p(displayUnit="Pa") = 100000,
    nPorts=1,
    redeclare package Medium = MediumWat,
    T=299.15) annotation (Placement(transformation(extent={{20,70},{0,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](y=true) annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  Modelica.Blocks.Sources.Ramp ramp1[
                                    5](duration=86400, height=1) annotation (Placement(transformation(extent={{-100,58},
            {-80,78}})));
  Modelica.Blocks.Sources.Ramp ramp2[
                                    5](duration=86400,
    height=-1,
    offset=1)                                                    annotation (Placement(transformation(extent={{-72,-70},{-52,-50}})));
equation

  connect(fivZonVAV.port_a_Air, souAir.ports[1]) annotation (Line(points={{-28,7},{-72,7},{-72,28},{-80,28}},   color={0,127,255}));
  connect(fivZonVAV.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-28,-18},{-50,-18},{-72,-18},{-72,-40},{-80,-40}}, color={0,127,255}));
  connect(souWat.ports[1], fivZonVAV.port_a_Wat) annotation (Line(points={{-40,80},{-28,80},{-28,56},{-60,56},{-60,
          22},{-14.2,22}},                                                                                                         color={0,127,255}));
  connect(sinWat.ports[1], fivZonVAV.port_b_Wat) annotation (Line(points={{0,80},{
          -10,80},{-20,80},{-20,36},{4,36},{4,22},{4.2,22}},                                                                             color={0,127,255}));
  connect(ramp.y, fivZonVAV.Q_flow) annotation (Line(points={{-79,-80},{-60,-80},{-40,-80},{-40,-23},{-30.3,-23}}, color={0,0,127}));
  connect(booleanExpression.y, fivZonVAV.On) annotation (Line(points={{-79,-16},{-40,-16},{-40,-3},{-30.3,-3}}, color={255,0,255}));
  connect(ramp1.y, fivZonVAV.AirFlowRatSetPoi) annotation (Line(points={{-79,68},
          {-50,68},{-50,22},{-30.3,22}},                                                                                          color={0,0,127}));
  connect(ramp2.y, fivZonVAV.yVal) annotation (Line(points={{-51,-60},{-24,-60},{-24,-34},{-52,-34},{-52,12},{-30.3,
          12}},                                                                                                             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=259200, __Dymola_Algorithm="Dassl"));
end FivZonVAV;
