within BuildingControlEmulator.Systems.Examples;
model FloorDX
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air "Medium model for air";

  parameter Modelica.Units.SI.Pressure PreDroCoiAir=50
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir=50
    "Pressure drop in the air side";

  parameter Modelica.Units.SI.Temperature TemEcoHig=273.15 + 15.58
    "the highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemEcoLow=273.15 + 0
    "the lowest temeprature when the economizer is on";
  parameter Real MixingBoxDamMin = 0.3 "the minimum damper postion";

  parameter Modelica.Units.SI.Time waitTime(min=0) = 1800
    "Wait time before transition fires";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]={(mAirFloRat1 +
      mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*0.5,(
      mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*
      0.7,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
      /1.2,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)
      /1.2*2} "Volume flow rate curve";
  parameter Real HydEff[:] = {0.93*0.65,0.93*0.7,0.93,0.93*0.6} "Hydraulic efficiency";
  parameter Real MotEff[:] = {0.6045*0.65,0.6045*0.7,0.6045,0.6045*0.6} "Motor efficiency";

  parameter Modelica.Units.SI.Pressure SupPreCur[:]={1400,1000,700,700*0.5}
    "Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[:]={600,400,200,100}
    "Pressure curve";

  parameter Modelica.Units.SI.Time minOffTim(min=0) = 900 "Minimum off time";
  parameter Modelica.Units.SI.Time minOnTim(min=0) = 0 "Minimum on time";
  parameter Real dT = 0.5
      "Temperature control deadband";

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


  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1=2.72
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2=0.82
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3=0.63
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4=0.78
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5=1.56
    "mass flow rate for vav 5";


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



  BuildingControlEmulator.Systems.FloorDX
                                        floorDX(
    redeclare package MediumAir = MediumAir,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    waitTime=waitTime,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    SupPreCur=SupPreCur,
    RetPreCur=RetPreCur,
    minOffTim=minOffTim,
    minOnTim=minOnTim,
    dT=dT,
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
    PreDroAir2=PreDroAir2,
    PreDroAir3=PreDroAir3,
    PreDroAir4=PreDroAir4,
    PreDroAir5=PreDroAir5,
    Q_flow_nominal1=Q_flow_nominal1,
    Q_flow_nominal2=Q_flow_nominal2,
    Q_flow_nominal3=Q_flow_nominal3,
    Q_flow_nominal4=Q_flow_nominal4,
    Q_flow_nominal5=Q_flow_nominal5,
    datCoi=datCoi)
    annotation (Placement(transformation(extent={{-24,-18},{26,24}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=2,
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Sources.Ramp loa1(duration=86400, height=33000)
    annotation (Placement(transformation(extent={{-2,-60},{18,-40}})));
  Modelica.Blocks.Sources.Constant const[5](k=273.15 + 24)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 12.88)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant const2(k=400)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.Ramp ramp1[
                                    5](duration=86400, height=1,
    offset=0.3)                                                  annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Modelica.Blocks.Sources.Ramp ramp2[
                                    5](duration=86400,
    offset=0,
    height=0)                                                    annotation (Placement(transformation(extent={{-72,-60},
            {-52,-40}})));
  Modelica.Blocks.Sources.Constant const3[5](k=273.15 + 20)
    annotation (Placement(transformation(extent={{0,-100},{-20,-80}})));
  parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.SingleSpeed.York_Sunline_ZF240
    datCoi
    annotation (Placement(transformation(extent={{40,82},{60,102}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 30)
    annotation (Placement(transformation(extent={{100,12},{80,32}})));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal1=1200
    "rated heat flow rate for heating of vav 1";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal2=4500
    "rated heat flow rate for heating of vav 2";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal3=6700
    "rated heat flow rate for heating of vav 3";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal4=4500
    "rated heat flow rate for heating of vav 4";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal5=4500
    "rated heat flow rate for heating of vav 5";



  Modelica.Blocks.Sources.Ramp loa2(duration=86400, height=10000)
    annotation (Placement(transformation(extent={{34,-60},{54,-40}})));
  Modelica.Blocks.Sources.Ramp loa3(duration=86400, height=7600)
    annotation (Placement(transformation(extent={{68,-60},{88,-40}})));
  Modelica.Blocks.Sources.Ramp loa4(duration=86400, height=9500)
    annotation (Placement(transformation(extent={{18,-98},{38,-78}})));
  Modelica.Blocks.Sources.Ramp loa5(duration=86400, height=19000)
    annotation (Placement(transformation(extent={{54,-98},{74,-78}})));
equation
  connect(floorDX.port_Fre_Air, sou.ports[1])
    annotation (Line(points={{-24,11.4},{-56,11.4},{-56,2},{-80,2}},
                                                                   color={0,127,255}));
  connect(floorDX.port_Exh_Air, sou.ports[2])
    annotation (Line(points={{-24,-5.4},{-80,-5.4},{-80,-2}}, color={0,127,255}));
  connect(const1.y, floorDX.DisTemPSetPoi) annotation (Line(
      points={{-79,-30},{-46,-30},{-46,15.6},{-27,15.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const2.y, floorDX.PreSetPoi) annotation (Line(
      points={{-79,-70},{-38,-70},{-38,7.41},{-26.75,7.41}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanExpression.y, floorDX.OnZon) annotation (Line(
      points={{-79,-96},{-34,-96},{-34,-18},{-27,-18}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(floorDX.OnFan, floorDX.OnZon) annotation (Line(
      points={{-27,-9.6},{-34,-9.6},{-34,-18},{-27,-18}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(ramp1.y, floorDX.AirFlowRatSetPoi) annotation (Line(
      points={{-79,90},{-54,90},{-54,-0.99},{-26.75,-0.99}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ramp2.y, floorDX.yVal) annotation (Line(
      points={{-51,-50},{-42,-50},{-42,-13.8},{-27,-13.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, floorDX.ZonCooTempSetPoi) annotation (Line(
      points={{-79,50},{-44,50},{-44,24},{-27,24}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const3.y, floorDX.ZonHeaTempSetPoi) annotation (Line(
      points={{-21,-90},{-50,-90},{-50,19.8},{-27,19.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const4.y, floorDX.TOut) annotation (Line(
      points={{79,22},{50,22},{50,19.59},{28.75,19.59}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(loa1.y, floorDX.Q_flow[1]);
  connect(loa2.y, floorDX.Q_flow[2]);
  connect(loa3.y, floorDX.Q_flow[3]);
  connect(loa4.y, floorDX.Q_flow[4]);
  connect(loa5.y, floorDX.Q_flow[5]);


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=86400));
end FloorDX;
