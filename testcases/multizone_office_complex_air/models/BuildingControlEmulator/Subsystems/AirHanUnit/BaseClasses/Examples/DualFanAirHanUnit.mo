within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.Examples;
model DualFanAirHanUnit
  extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air "Medium model";
  package MediumWat = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat=18.3*1.2
    "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat=18.3*1.2*11.1/6.67/4.2
    "mass flow rate for water";
  parameter Modelica.Units.SI.Pressure PreDroCoiAir=50
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir=100
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat=79712
    "Pressure drop in the water side";
  parameter Real Coi_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Coi_Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";


  parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat=18.3*1.2*0.5
    "mass flow rate for fresh air";
  parameter Modelica.Units.SI.Temperature TemEcoHig=273.15 + 15.58
    "the highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemEcoLow=273.15 + 0
    "the lowest temeprature when the economizer is on";
  parameter Real MixingBoxDamMin = 0.3 "the minimum damper postion";
  parameter Real MixingBox_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time MixingBox_Ti(min=Modelica.Constants.small)=
       0.5 "Time constant of Integrator block";

  parameter Real Fan_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Fan_Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";
  parameter Real Fan_SpeRat = 0.9
      "Speed ratio";
  parameter Integer numTemp(min=1) = 1
      "The size of the temeprature vector";
  parameter Real HydEff[:] = {0.93*0.65,0.93*0.7,0.93,0.93*0.6} "Hydraulic efficiency";
  parameter Real MotEff[:] = {0.6045*0.65,0.6045*0.7,0.6045,0.6045*0.6} "Motor efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]={10,15,20,20*2}*0.1
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure SupPreCur[:]={900,700,500,500*0.5}
    "Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[:]={200,150,100,50}
    "Pressure curve";
  DuaFanAirHanUnit duaFanAirHanUnit(redeclare package MediumAir = MediumAir, redeclare
      package MediumWat =                                                                                  MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    PreDroWat=PreDroWat,
    mFreAirFloRat=mFreAirFloRat,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    Fan_SpeRat=Fan_SpeRat,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    SupPreCur=SupPreCur,
    RetPreCur=RetPreCur,
    Coi_k=1,
    Coi_Ti=60,
    MixingBox_Ti=60,
    Fan_Ti=60,
    UA=-mAirFloRat*(1000*17)/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        273.15 + 6,
        273.15 + 12,
        273.15 + 30,
        273.15 + 12.88))            annotation (Placement(transformation(extent={{-14,26},{14,50}})));
  Buildings.Fluid.Sources.Boundary_pT souWat(
    nPorts=1,
    redeclare package Medium = MediumWat,
    p(displayUnit="Pa") = 100000 + PreDroWat,
    T=279.15)
    annotation (Placement(transformation(extent={{36,78},{16,98}})));
  Buildings.Fluid.Sources.Boundary_pT sinWat(
    nPorts=1,
    p(displayUnit="Pa") = 100000,
    redeclare package Medium = MediumWat,
    T=293.15) annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dpValve_nominal=353,
    use_inputFilter=false,
    init=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    dp_nominal=100,
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat)         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={38,20})));
  Buildings.Fluid.MixingVolumes.MixingVolume
                                         vol(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=2,
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    V=10)  annotation (Placement(transformation(extent={{-6,-78},{14,-58}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{-54,-90},{-34,-70}})));
  Devices.Control.conPI pI(
    conPID(reverseAction=true),
    Ti=60,
    k=0.01) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.BooleanExpression On(y=true) annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 24)
    annotation (Placement(transformation(extent={{-78,-78},{-58,-58}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      =                                                                         MediumAir)
    annotation (Placement(transformation(extent={{64,50},{44,70}})));
  Modelica.Blocks.Sources.RealExpression TSupSetPoi(y=273.15 + 12.88)
    annotation (Placement(transformation(extent={{-98,42},{-78,62}})));
  Modelica.Blocks.Sources.RealExpression CoolSetPoi(y=273.15 + 24)
    annotation (Placement(transformation(extent={{-102,-2},{-82,18}})));
  Modelica.Blocks.Sources.RealExpression PreSetPoi(y=353) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=12*3600,
    height=mAirFloRat*10*1000,
    offset=0)                    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-34,-64},{-22,-52}})));
  Buildings.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false)
    annotation (Placement(transformation(extent={{-106,102},{-86,122}})));
  Modelica.Blocks.Sources.RealExpression TOut(y=273.15 + 20) annotation (Placement(transformation(extent={{-138,102},{-118,122}})));
  Modelica.Blocks.Sources.RealExpression RH(y=0.6) annotation (Placement(transformation(extent={{-140,76},{-120,96}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  souAir(
    nPorts=3,
    p(displayUnit="Pa"),
    X={0.02,1 - 0.02},
    use_X_in=true,
    redeclare package Medium = MediumAir,
    use_C_in=false,
    use_T_in=true)
    annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
  Modelica.Blocks.Sources.RealExpression TZ(y=vol.T) annotation (Placement(transformation(extent={{-106,-50},{-86,-30}})));
  Modelica.Blocks.Sources.RealExpression HeaSetPoi(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
equation
  connect(duaFanAirHanUnit.port_b_Wat, sinWat.ports[1])
    annotation (Line(
      points={{-5.6,50},{-12,50},{-12,90},{-20,90}},
      color={0,127,255},
      thickness=1));
  connect(duaFanAirHanUnit.port_a_Wat, souWat.ports[1])
    annotation (Line(
      points={{2.8,50},{6,50},{10,50},{10,88},{16,88}},
      color={0,127,255},
      thickness=1));
  connect(vol.ports[1], senTem.port_b)
    annotation (Line(
      points={{2,-78},{2,-80},{-34,-80}},
      color={0,127,255},
      thickness=1));
  connect(senTem.port_a, duaFanAirHanUnit.port_a_Air)
    annotation (Line(
      points={{-54,-80},{-80,-80},{-80,0},{14,0},{14,28.4}},
      color={0,127,255},
      thickness=1));
  connect(pI.y, val.y) annotation (Line(
      points={{-19,-30},{-19,-30},{72,-30},{72,20},{56,20},{56,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(On.y, duaFanAirHanUnit.On)
    annotation (Line(
      points={{-77,32},{-48,32},{-48,26},{-15.4,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(pI.On, duaFanAirHanUnit.On) annotation (Line(
      points={{-42,-24},{-66,-24},{-66,32},{-48,32},{-48,26},{-15.4,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(realExpression.y, pI.SetPoi)
    annotation (Line(
      points={{-57,-68},{-50,-68},{-50,-30},{-42,-30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.port_b_Air, res.port_a)
    annotation (Line(
      points={{14,38},{38,38},{38,30}},
      color={0,127,255},
      thickness=1));
  connect(res.port_b, val.port_a) annotation (Line(
      points={{38,10},{38,0},{46,0}},
      color={0,127,255},
      thickness=1));
  connect(val.port_b, vol.ports[2])
    annotation (Line(
      points={{66,0},{80,0},{80,-78},{6,-78}},
      color={0,127,255},
      thickness=1));
  connect(senRelPre.p_rel, duaFanAirHanUnit.PreMea) annotation (Line(
      points={{54,51},{54,44},{44,44},{44,45.2},{15.4,45.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.ZonTemp[1], senTem.T) annotation (Line(
      points={{15.4,30.8},{22,30.8},{22,-46},{-44,-46},{-44,-69}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.DisTemPSetPoi, TSupSetPoi.y)
    annotation (Line(
      points={{-15.4,35.6},{-58,35.6},{-58,52},{-77,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PreSetPoi.y, duaFanAirHanUnit.PreSetPoi) annotation (Line(
      points={{-39,-10},{-30,-10},{-20,-10},{-20,30.8},{-15.4,30.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.port, vol.heatPort)
    annotation (Line(points={{-22,-58},{-18,-58},{-12,-58},{-12,-68},{-6,-68}}, color={191,0,0}));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{61,-60},{68,-60},{70,-60},{70,-42},{-40,-42},{-40,-58},{-34,-58}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelPre.port_a, val.port_a)
    annotation (Line(points={{64,60},{70,60},{70,28},{44,28},{44,4},{38,4},{38,0},{46,0}}, color={0,127,255}));
  connect(TOut.y, x_pTphi.T) annotation (Line(points={{-117,112},{-108,112}}, color={0,0,127}));
  connect(RH.y, x_pTphi.phi) annotation (Line(points={{-119,86},{-112,86},{-112,106},{-108,106}}, color={0,0,127}));
  connect(souAir.ports[1], duaFanAirHanUnit.port_Exh_Air)
    annotation (Line(points={{-76,80.6667},{-46,80.6667},{-46,38},{-14.28,38}}, color={0,127,255}));
  connect(duaFanAirHanUnit.port_Fre_Air, souAir.ports[2])
    annotation (Line(points={{-14,45.2},{-44,45.2},{-44,78},{-76,78}}, color={0,127,255}));
  connect(x_pTphi.X, souAir.X_in)
    annotation (Line(points={{-85,112},{-74,112},{-74,94},{-108,94},{-108,74},{-98,74}}, color={0,0,127}));
  connect(senRelPre.port_b, souAir.ports[3])
    annotation (Line(points={{44,60},{-16,60},{-16,75.3333},{-76,75.3333}}, color={0,127,255}));
  connect(TZ.y, pI.Mea) annotation (Line(
      points={{-85,-40},{-74,-40},{-74,-38},{-42,-38},{-42,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(souAir.T_in, TOut.y) annotation (Line(points={{-98,82},{-117,82},{-117,112}}, color={0,0,127}));
  connect(HeaSetPoi.y, duaFanAirHanUnit.HeaTempSetPoi[1]) annotation (Line(
      points={{-81,-20},{-30,-20},{-30,47.6},{-15.4,47.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(CoolSetPoi.y, duaFanAirHanUnit.CooTempSetPoi[1]) annotation (Line(
      points={{-81,8},{-38,8},{-38,42.8},{-15.4,42.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.TOut, x_pTphi.T) annotation (Line(
      points={{-15.4,28.4},{-48,28.4},{-48,18},{-112,18},{-112,112},{-108,112}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Cvode"));
end DualFanAirHanUnit;
