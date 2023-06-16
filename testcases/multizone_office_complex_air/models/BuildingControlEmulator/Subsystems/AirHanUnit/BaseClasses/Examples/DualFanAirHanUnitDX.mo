within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses.Examples;
model DualFanAirHanUnitDX
  extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air "Medium model";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat=1.2*0.944
    "mass flow rate for air";
  parameter Modelica.Units.SI.Pressure PreDroCoiAir=50
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir=100
    "Pressure drop in the air side";


  parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat=1.2*0.944*0.5
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
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]={10,15,20,20*2}
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure SupPreCur[:]={900,700,500,500*0.5}
    "Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[:]={200,150,100,50}
    "Pressure curve";
  DuaFanAirHanUnitDX
                   duaFanAirHanUnitDX(
                                    redeclare package MediumAir = MediumAir,
    mAirFloRat=mAirFloRat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
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
    MixingBox_Ti=60,
    Fan_Ti=60,
    minOffTim=300,
    minOnTim=0,
    dT=0.5,
    datCoi=datCoi)                  annotation (Placement(transformation(extent={{-14,26},{14,50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    dpValve_nominal=353,
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
    p(displayUnit="Pa") = 100000,
    X={0.02,1 - 0.02},
    use_X_in=true,
    redeclare package Medium = MediumAir,
    use_C_in=false,
    use_T_in=true)
    annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
  Modelica.Blocks.Sources.RealExpression TZ(y=vol.T) annotation (Placement(transformation(extent={{-106,-50},{-86,-30}})));
  Modelica.Blocks.Sources.RealExpression HeaSetPoi(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
  parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.SingleSpeed.Carrier_Comfort_50ES060
    datCoi(sta={Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800,
        nomVal=Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-17500.95,
          COP_nominal=3.9,
          SHR_nominal=0.78,
          m_flow_nominal=1.2*0.944),
        perCur=Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
          capFunT={1.6380187,-0.0747347,0.0029747,0.0015201,-0.0000519,-0.0004509},
          capFunFF={0.8185792,0.2831771,-0.1017563},
          EIRFunT={-0.2209648,0.1033303,-0.0030061,-0.0070657,0.0006322,-0.0002496},
          EIRFunFF={1.0380778,-0.2013868,0.1633090},
          TConInMin=273.15 + 23.89,
          TConInMax=273.15 + 51.67,
          TEvaInMin=273.15 + 13.89,
          TEvaInMax=273.15 + 22.22,
          ffMin=0.875,
          ffMax=1.125))})
    annotation (Placement(transformation(extent={{22,82},{42,102}})));
equation
  connect(vol.ports[1], senTem.port_b)
    annotation (Line(
      points={{2,-78},{2,-80},{-34,-80}},
      color={0,127,255},
      thickness=1));
  connect(senTem.port_a, duaFanAirHanUnitDX.port_a_Air)
    annotation (Line(
      points={{-54,-80},{-80,-80},{-80,0},{14,0},{14,28.4}},
      color={0,127,255},
      thickness=1));
  connect(pI.y, val.y) annotation (Line(
      points={{-19,-30},{-19,-30},{72,-30},{72,20},{56,20},{56,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(On.y, duaFanAirHanUnitDX.On)
    annotation (Line(
      points={{-77,32},{-48,32},{-48,26},{-15.4,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(pI.On, duaFanAirHanUnitDX.On)
    annotation (Line(
      points={{-42,-24},{-66,-24},{-66,32},{-48,32},{-48,26},{-15.4,26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(realExpression.y, pI.SetPoi)
    annotation (Line(
      points={{-57,-68},{-50,-68},{-50,-30},{-42,-30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.port_b_Air, res.port_a) annotation (Line(
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
  connect(senRelPre.p_rel, duaFanAirHanUnitDX.PreMea)
    annotation (Line(
      points={{54,51},{54,44},{44,44},{44,45.2},{15.4,45.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.ZonTemp[1], senTem.T)
    annotation (Line(
      points={{15.4,30.8},{22,30.8},{22,-46},{-44,-46},{-44,-69}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.DisTemPSetPoi, TSupSetPoi.y)
    annotation (Line(
      points={{-15.4,35.6},{-58,35.6},{-58,52},{-77,52}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PreSetPoi.y, duaFanAirHanUnitDX.PreSetPoi)
    annotation (Line(
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
  connect(souAir.ports[1], duaFanAirHanUnitDX.port_Exh_Air)
    annotation (Line(points={{-76,80.6667},{-46,80.6667},{-46,38},{-14.28,38}}, color={0,127,255}));
  connect(duaFanAirHanUnitDX.port_Fre_Air, souAir.ports[2]) annotation (Line(points={{-14,45.2},{-44,45.2},{-44,78},{-76,78}}, color={0,127,255}));
  connect(x_pTphi.X, souAir.X_in)
    annotation (Line(points={{-85,112},{-74,112},{-74,94},{-108,94},{-108,74},{-98,74}}, color={0,0,127}));
  connect(senRelPre.port_b, souAir.ports[3])
    annotation (Line(points={{44,60},{-16,60},{-16,75.3333},{-76,75.3333}}, color={0,127,255}));
  connect(TZ.y, pI.Mea) annotation (Line(
      points={{-85,-40},{-74,-40},{-74,-38},{-42,-38},{-42,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(souAir.T_in, TOut.y) annotation (Line(points={{-98,82},{-117,82},{-117,112}}, color={0,0,127}));
  connect(HeaSetPoi.y, duaFanAirHanUnitDX.HeaTempSetPoi[1])
    annotation (Line(
      points={{-81,-20},{-30,-20},{-30,47.6},{-15.4,47.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(CoolSetPoi.y, duaFanAirHanUnitDX.CooTempSetPoi[1])
    annotation (Line(
      points={{-81,8},{-38,8},{-38,42.8},{-15.4,42.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.TOut, x_pTphi.T)
    annotation (Line(points={{15.4,34.16},{78,34.16},{78,132},{-114,132},{-114,112},{-108,112}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Cvode"));
end DualFanAirHanUnitDX;
