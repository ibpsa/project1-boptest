within BuildingControlEmulator.Subsystems.HydDisturbution.Examples;
model FivZonVAVDX
  import BuildingControlEmulator;

  extends Modelica.Icons.Example;

  package MediumAir = Buildings.Media.Air "Medium model for air";

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

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal1=10.92*1000*20*1.2
    "rated heat flow rate for heating of vav 1";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal2=2.25*1.2*1000*20
    "rated heat flow rate for heating of vav 2";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal3=1.49*1.2*1000*20
    "rated heat flow rate for heating of vav 3";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal4=1.9*1.2*1000*20
    "rated heat flow rate for heating of vav 4";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal5=1.73*1.2*1000*20
    "rated heat flow rate for heating of vav 5";

  parameter Modelica.Units.SI.Pressure PreDroAir1=200
    "Pressure drop in the air side of vav 1";


  parameter Modelica.Units.SI.Pressure PreDroAir2=124
    "Pressure drop in the air side of vav 2";



  parameter Modelica.Units.SI.Pressure PreDroAir3=124
    "Pressure drop in the air side of vav 3";


  parameter Modelica.Units.SI.Pressure PreDroAir4=124
    "Pressure drop in the air side of vav 4";



  parameter Modelica.Units.SI.Pressure PreDroAir5=124
    "Pressure drop in the air side of vav 1";



  Buildings.Fluid.Sources.Boundary_pT souAir(
    p(displayUnit="Pa") = 100000 + PreAirDroMai1 + PreAirDroMai2 + PreAirDroMai3 + PreAirDroMai4 + PreAirDroBra5 + PreDroAir5,
    redeclare package Medium = MediumAir,
    nPorts=1,
    T=286.02) annotation (Placement(transformation(extent={{-88,30},{-68,50}})));

  Buildings.Fluid.Sources.Boundary_pT sinAir(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000,
    nPorts=1,
    T=299.15) annotation (Placement(transformation(extent={{-88,-22},{-68,-2}})));

  Modelica.Blocks.Sources.Ramp ramp[5](duration=86400, height=1*1000*10)
                                                                 annotation (Placement(transformation(extent={{-88,-84},
            {-68,-64}})));
  BuildingControlEmulator.Subsystems.HydDisturbution.FivZonVAVDX
                                                               fivZonVAVDX(
                                                                         redeclare
      package MediumAir =                                                                              MediumAir,
    PreAirDroMai1=PreAirDroMai1,
    PreAirDroMai2=PreAirDroMai2,
    PreAirDroMai3=PreAirDroMai3,
    PreAirDroMai4=PreAirDroMai4,
    PreAirDroBra1=PreAirDroBra1,
    PreAirDroBra2=PreAirDroBra2,
    PreAirDroBra3=PreAirDroBra3,
    PreAirDroBra4=PreAirDroBra4,
    PreAirDroBra5=PreAirDroBra5,
    mAirFloRat1=mAirFloRat1,
    mAirFloRat2=mAirFloRat2,
    mAirFloRat3=mAirFloRat3,
    mAirFloRat4=mAirFloRat4,
    mAirFloRat5=mAirFloRat5,
    PreDroAir1=PreDroAir1,
    Q_flow_nominal1=Q_flow_nominal1,
    PreDroAir2=PreDroAir2,
    Q_flow_nominal2=Q_flow_nominal2,
    PreDroAir3=PreDroAir3,
    Q_flow_nominal3=Q_flow_nominal3,
    PreDroAir4=PreDroAir4,
    Q_flow_nominal4=Q_flow_nominal4,
    PreDroAir5=PreDroAir5,
    Q_flow_nominal5=Q_flow_nominal5)                                     annotation (Placement(transformation(extent={{-14,-22},
            {32,28}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](y=true) annotation (Placement(transformation(extent={{-86,-4},
            {-66,16}})));
  Modelica.Blocks.Sources.Ramp ramp1[
                                    5](duration=86400,
    height=1,
    offset=0)                                                    annotation (Placement(transformation(extent={{-86,68},
            {-66,88}})));
  Modelica.Blocks.Sources.Ramp ramp2[
                                    5](duration=86400,
    height=1,
    offset=0)                                                    annotation (Placement(transformation(extent={{-88,-54},
            {-68,-34}})));
equation

  connect(fivZonVAVDX.port_a_Air, souAir.ports[1]) annotation (Line(points={{-14,13},
          {-58,13},{-58,40},{-68,40}},                                                                          color={0,127,255}));
  connect(fivZonVAVDX.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-14,-12},
          {-68,-12}},                                                                                                           color={0,127,255}));
  connect(ramp.y, fivZonVAVDX.Q_flow) annotation (Line(points={{-67,-74},{-26,
          -74},{-26,-17},{-16.3,-17}},                                                                               color={0,0,127}));
  connect(booleanExpression.y, fivZonVAVDX.On) annotation (Line(points={{-65,6},
          {-26,6},{-26,3},{-16.3,3}},                                                                             color={255,0,255}));
  connect(ramp1.y, fivZonVAVDX.AirFlowRatSetPoi)
    annotation (Line(points={{-65,78},{-36,78},{-36,28},{-16.3,28}},                   color={0,0,127}));
  connect(ramp2.y, fivZonVAVDX.yVal) annotation (Line(points={{-67,-44},{-38,
          -44},{-38,18},{-16.3,18}},                                                                                        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=259200, __Dymola_Algorithm="Dassl"));
end FivZonVAVDX;
