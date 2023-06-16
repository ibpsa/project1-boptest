within BuildingControlEmulator.Systems;
model FloorDX

  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  parameter Modelica.Units.SI.Pressure PreDroCoiAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Temperature TemEcoHig=273.15 + 15.58
    "the highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemEcoLow=273.15 + 0
    "the lowest temeprature when the economizer is on";
  parameter Real MixingBoxDamMin = 0.3 "the minimum damper postion";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";
  parameter Real HydEff[:] "Hydraulic efficiency";
  parameter Real MotEff[:] "Motor efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure SupPreCur[:] "Supply Fan Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[:] "Return Fan Pressure curve";
  parameter Modelica.Units.SI.Time minOffTim(min=0) = 0 "Minimum off time";
  parameter Modelica.Units.SI.Time minOnTim(min=0) = 0 "Minimum on time";
  parameter Real dT
      "Temperature control deadband";
  parameter Modelica.Units.SI.Pressure PreAirDroMai1
    "Pressure drop 1 across the duct";
  parameter Modelica.Units.SI.Pressure PreAirDroMai2
    "Pressure drop 2 across the main duct";
  parameter Modelica.Units.SI.Pressure PreAirDroMai3
    "Pressure drop 3 across the main duct";
  parameter Modelica.Units.SI.Pressure PreAirDroMai4
    "Pressure drop 4 across the main duct";
  parameter Modelica.Units.SI.Pressure PreAirDroBra1
    "Pressure drop 1 across the duct branch 1";
  parameter Modelica.Units.SI.Pressure PreAirDroBra2
    "Pressure drop 1 across the duct branch 2";
  parameter Modelica.Units.SI.Pressure PreAirDroBra3
    "Pressure drop 1 across the duct branch 3";
  parameter Modelica.Units.SI.Pressure PreAirDroBra4
    "Pressure drop 1 across the duct branch 4";
  parameter Modelica.Units.SI.Pressure PreAirDroBra5
    "Pressure drop 1 across the duct branch 5";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat1
    "mass flow rate for vav 1";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat2
    "mass flow rate for vav 2";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat3
    "mass flow rate for vav 3";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat4
    "mass flow rate for vav 4";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat5
    "mass flow rate for vav 5";
  parameter Modelica.Units.SI.Pressure PreDroAir1
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroAir2
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroAir3
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroAir4
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroAir5
    "Pressure drop in the air side of vav 5";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal1
    "rated heat flow rate for heating of vav 1";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal2
    "rated heat flow rate for heating of vav 2";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal3
    "rated heat flow rate for heating of vav 3";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal4
    "rated heat flow rate for heating of vav 4";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal5
    "rated heat flow rate for heating of vav 5";

  Subsystems.AirHanUnit.BaseClasses.DuaFanAirHanUnitDX
                                                     duaFanAirHanUnitDX(
                                                                      numTemp=5,
    redeclare package MediumAir = MediumAir,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    MixingBox_k=1,
    MixingBox_Ti=60,
    Fan_Ti=60,
    waitTime=900,
    Fan_SpeRat=0.9,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    SupPreCur=SupPreCur,
    RetPreCur=RetPreCur,
    mAirFloRat=mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    mFreAirFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)*0.3,
    Fan_k=0.01,
    minOffTim=minOffTim,
    minOnTim=minOnTim,
    dT=dT,
    datCoi=datCoi)
    annotation (Placement(transformation(extent={{-68,-12},{-40,14}})));
  Subsystems.HydDisturbution.FivZonVAVDX
                                       fivZonVAVDX(
                                                 redeclare package MediumAir = MediumAir,
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
    Q_flow_nominal5=Q_flow_nominal5)
    annotation (Placement(transformation(extent={{18,-48},{72,0}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium
      =                                                                         MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium
      =                                                                         MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=5)
    annotation (Placement(transformation(extent={{-56,-96},{-42,-84}})));
  Modelica.Blocks.Interfaces.BooleanInput OnFan
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-124,-72},{-100,-48}})));
  Modelica.Blocks.Interfaces.BooleanInput OnZon
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-124,-112},{-100,-88}})));
  Modelica.Blocks.Interfaces.RealInput ZonCooTempSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,88},{-100,112}})));
  Modelica.Blocks.Interfaces.RealInput DisTemPSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,48},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput PreSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-122,10},{-100,32}})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-122,-30},{-100,-8}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5]
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-124,-92},{-100,-68}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[5]
    annotation (Placement(transformation(extent={{122,-92},{100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput ZonHeaTempSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-124,68},{-100,92}})));
  parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.SingleSpeed.Carrier_Comfort_50ES060
    datCoi(sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-17500.95,
          COP_nominal=3.9,
          SHR_nominal=0.78,
          m_flow_nominal=1.2*0.944),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
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
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Interfaces.RealInput TOut
    annotation (Placement(transformation(extent={{122,68},{100,90}})));
equation
  connect(fivZonVAVDX.port_a_Air, duaFanAirHanUnitDX.port_b_Air) annotation (
      Line(
      points={{18,-14.4},{-10,-14.4},{-10,-22},{-20,-22},{-20,1},{-40,1}},
      color={0,127,255},
      thickness=0.5));
  connect(fivZonVAVDX.port_b_Air, duaFanAirHanUnitDX.port_a_Air) annotation (
      Line(
      points={{18,-38.4},{-20,-38.4},{-20,-68},{-40,-68},{-40,-9.4}},
      color={0,127,255},
      thickness=0.5));
  connect(duaFanAirHanUnitDX.port_Exh_Air, port_Exh_Air) annotation (Line(
      points={{-68.28,1},{-76,1},{-76,0},{-80,0},{-80,-40},{-100,-40}},
      color={0,127,255},
      thickness=0.5));
  connect(duaFanAirHanUnitDX.port_Fre_Air, port_Fre_Air) annotation (Line(
      points={{-68,8.8},{-74,8.8},{-74,8},{-80,8},{-80,40},{-100,40}},
      color={0,127,255},
      thickness=0.5));
  connect(booleanReplicator.y, fivZonVAVDX.On) annotation (Line(
      points={{-41.3,-90},{-41.3,-92},{0,-92},{0,-24},{15.3,-24}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.pre, duaFanAirHanUnitDX.PreMea) annotation (Line(
      points={{74.7,-33.6},{92,-33.6},{92,8.8},{-38.6,8.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.TZon, duaFanAirHanUnitDX.ZonTemp) annotation (Line(
      points={{74.7,-14.4},{78,-14.4},{78,-16},{82,-16},{82,-62},{-30,-62},{-30,
          -6.8},{-38.6,-6.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(OnFan, duaFanAirHanUnitDX.On) annotation (Line(
      points={{-112,-60},{-74,-60},{-74,-12},{-69.4,-12}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanReplicator.u, OnZon) annotation (Line(
      points={{-57.4,-90},{-72,-90},{-72,-100},{-112,-100}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.DisTemPSetPoi, DisTemPSetPoi) annotation (Line(
      points={{-69.4,-1.6},{-94,-1.6},{-94,60},{-112,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.PreSetPoi, PreSetPoi) annotation (Line(
      points={{-69.4,-6.8},{-98,-6.8},{-98,21},{-111,21}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.AirFlowRatSetPoi, AirFlowRatSetPoi) annotation (Line(
      points={{15.3,0},{-2,0},{-2,-19},{-111,-19}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.yVal, yVal) annotation (Line(
      points={{15.3,-9.6},{-6,-9.6},{-6,-80},{-112,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.Q_flow, Q_flow) annotation (Line(
      points={{15.3,-43.2},{10,-43.2},{10,-81},{111,-81}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAVDX.TZon, TZon) annotation (Line(
      points={{74.7,-14.4},{96,-14.4},{96,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.CooTempSetPoi, ZonCooTempSetPoi) annotation (Line(
      points={{-69.4,6.2},{-78,6.2},{-78,100},{-112,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ZonHeaTempSetPoi, duaFanAirHanUnitDX.HeaTempSetPoi) annotation (Line(
      points={{-112,80},{-74,80},{-74,11.4},{-69.4,11.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnitDX.TOut, TOut) annotation (Line(
      points={{-38.6,-3.16},{-8,-3.16},{-8,60},{80,60},{80,79},{111,79}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,60},{80,-80}}, lineColor={0,0,127}),
        Rectangle(extent={{-40,20},{40,-40}}, lineColor={0,0,127}),
        Line(points={{-80,60},{-40,20}}, color={0,0,127}),
        Line(points={{80,60},{40,20}}, color={0,0,127}),
        Line(points={{-80,-80},{-40,-40}}, color={0,0,127}),
        Line(points={{40,-40},{80,-80}}, color={0,0,127})}),     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FloorDX;
