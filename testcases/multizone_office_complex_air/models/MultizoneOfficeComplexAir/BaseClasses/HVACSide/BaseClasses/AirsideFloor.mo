within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses;
model AirsideFloor "Thermal zones and corresponding air side HVAC systems"

  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  //replaceable package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";

  replaceable package MediumHeaWat =
      Modelica.Media.Interfaces.PartialMedium "Medium for the heating water";

  replaceable package MediumCooWat =
      Modelica.Media.Interfaces.PartialMedium  "Medium for the cooling water";

  parameter Modelica.Units.SI.Pressure PreDroCoiAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroCooWat
    "Pressure drop in the water side";

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

  parameter Modelica.Units.SI.Pressure PreWatDroMai1
    "Pressure drop 1 across the pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai2
    "Pressure drop 2 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai3
    "Pressure drop 3 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroMai4
    "Pressure drop 4 across the main pipe";

  parameter Modelica.Units.SI.Pressure PreWatDroBra1
    "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.Units.SI.Pressure PreWatDroBra2
    "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.Units.SI.Pressure PreWatDroBra3
    "Pressure drop 1 across the pipe branch 3";

  parameter Modelica.Units.SI.Pressure PreWatDroBra4
    "Pressure drop 1 across the pipe branch 4";

  parameter Modelica.Units.SI.Pressure PreWatDroBra5
    "Pressure drop 1 across the pipe branch 5";

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

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat1
    "mass flow rate for vav 1";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat2
    "mass flow rate for vav 2";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat3
    "mass flow rate for vav 3";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat4
    "mass flow rate for vav 4";

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat5
    "mass flow rate for vav 5";

  parameter Modelica.Units.SI.Pressure PreDroAir1
    "Pressure drop in the air side of vav 1";
  parameter Modelica.Units.SI.Pressure PreDroWat1
    "Pressure drop in the water side of vav 1";
  parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir2
    "Pressure drop in the air side of vav 2";
  parameter Modelica.Units.SI.Pressure PreDroWat2
    "Pressure drop in the water side of vav 2";
  parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";

  parameter Modelica.Units.SI.Pressure PreDroAir3
    "Pressure drop in the air side of vav 3";
  parameter Modelica.Units.SI.Pressure PreDroWat3
    "Pressure drop in the water side of vav 3";
  parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.Units.SI.Pressure PreDroAir4
    "Pressure drop in the air side of vav 4";
  parameter Modelica.Units.SI.Pressure PreDroWat4
    "Pressure drop in the water side of vav 4";
  parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 4";

  parameter Modelica.Units.SI.Pressure PreDroAir5
    "Pressure drop in the air side of vav 5";
  parameter Modelica.Units.SI.Pressure PreDroWat5
    "Pressure drop in the water side of vav 5";
  parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 5";

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit
    duaFanAirHanUni(
    numTemp=5,
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumCooWat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    MixingBox_k=1,
    MixingBox_Ti=60,
    Fan_Ti=60,
    waitTime=waitTime,
    Fan_SpeRat=0.9,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    SupPreCur=SupPreCur,
    RetPreCur=RetPreCur,
    mAirFloRat=mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 +
        mAirFloRat5,
    PreDroWat=PreDroCooWat,
    Coi_k=1,
    Coi_Ti=60,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    mWatFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 +
        mAirFloRat5)*(30 - 12.88)/4.2/6,
    mFreAirFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 +
        mAirFloRat5)*0.3,
    UA=-(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)*(
        1000*17)/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        273.15 + 6,
        273.15 + 12,
        273.15 + 30,
        273.15 + 12.88),
    Fan_k=0.01)
    annotation (Placement(transformation(extent={{-78,14},{-50,-12}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV
    fivZonVAV(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumHeaWat,
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
    annotation (Placement(transformation(extent={{30,-18},{66,-46}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_CooWat(redeclare package Medium
      = MediumCooWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-64,-110},{-44,-90}}),
        iconTransformation(extent={{-64,-110},{-44,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_CooWat(redeclare package Medium
      = MediumCooWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}}),
        iconTransformation(extent={{-40,-110},{-20,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_HeaWat(redeclare package Medium
      = MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_HeaWat(redeclare package Medium
      = MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{46,-110},{66,-90}}),
        iconTransformation(extent={{46,-110},{66,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium
      =                                                                         MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-174,-50},{-154,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium
      =                                                                         MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,30},{-150,50}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=5)
    annotation (Placement(transformation(extent={{-140,-96},{-126,-84}})));
  Modelica.Blocks.Interfaces.BooleanInput OnFan
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-180,-60},{-160,-40}}),
        iconTransformation(extent={{-180,-60},{-160,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput OnZon
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}}),
        iconTransformation(extent={{-180,-100},{-160,-80}})));
  Modelica.Blocks.Interfaces.RealInput zonCooTSet[5]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-180,90},{-160,110}}), iconTransformation(
          extent={{-180,90},{-160,110}})));
  Modelica.Blocks.Interfaces.RealInput disTSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-180,50},{-160,70}}), iconTransformation(
          extent={{-180,50},{-160,70}})));
  Modelica.Blocks.Interfaces.RealInput pSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-180,0},{-160,20}}), iconTransformation(
          extent={{-180,0},{-160,20}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[5]
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={16,-110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={16,-110})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{160,-10},{180,10}}),
        iconTransformation(extent={{160,-10},{180,10}})));
  Modelica.Blocks.Interfaces.RealInput zonHeaTSet[5]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-180,70},{-160,90}}), iconTransformation(
          extent={{-180,70},{-160,90}})));
  Modelica.Blocks.Interfaces.RealInput TOut
    "Connector of setpoint input signal" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-14,-110}),          iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-14,-110})));
  ReadOverwrite.ReadAhu reaAhu
    annotation (Placement(transformation(extent={{28,2},{48,66}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TSupAirSet(description=
        "Supply air temperature setpoint for AHU", u(
      unit="K",
      min=285.15,
      max=313.15)) "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-140,54},{-128,66}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite dpSet(description=
        "Supply duct pressure setpoint for AHU", u(
      unit="Pa",
      min=50,
      max=410)) "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{-140,4},{-128,16}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonCor(zone="cor")
    annotation (Placement(transformation(extent={{100,114},{120,142}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonSou(zone="sou")
    annotation (Placement(transformation(extent={{100,50},{120,78}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonEas(zone="eas")
    annotation (Placement(transformation(extent={{100,-14},{120,14}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonNor(zone="nor")
    annotation (Placement(transformation(extent={{140,82},{160,110}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonWes(zone="wes")
    annotation (Placement(transformation(extent={{140,20},{160,48}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.Control.ZonCon
    zonVAVCon[5](
    each MinFlowRateSetPoi=0.3,
    each HeatingFlowRateSetPoi=0.5,
    heaCon(Ti=60, yMin=0.01),
    cooCon(k=11, Ti=60))
    "Zone terminal VAV controller (airflow rate, reheat valve)l "
    annotation (Placement(transformation(extent={{-14,118},{6,138}})));
  ReadOverwrite.WriteZoneSup oveZonCor(zone="cor")
    annotation (Placement(transformation(extent={{-120,178},{-100,198}})));
  ReadOverwrite.WriteZoneSup oveZonSou(zone="sou")
    annotation (Placement(transformation(extent={{-120,150},{-100,170}})));
  ReadOverwrite.WriteZoneSup oveZonEas(zone="eas")
    annotation (Placement(transformation(extent={{-120,122},{-100,142}})));
  ReadOverwrite.WriteZoneSup oveZonNor(zone="nor")
    annotation (Placement(transformation(extent={{-120,98},{-100,118}})));
  ReadOverwrite.WriteZoneSup oveZonWes(zone="wes")
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractSignal TZonHeaSet(nin=5,
      nout=5)
    annotation (Placement(transformation(extent={{-70,166},{-50,186}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractSignal TZonCooSet(nin=5,
      nout=5)
    annotation (Placement(transformation(extent={{-72,68},{-52,88}})));

equation
  connect(fivZonVAV.port_a_Air, duaFanAirHanUni.port_b_Air) annotation (
      Line(
      points={{30,-37.6},{-10,-37.6},{-10,-22},{-20,-22},{-20,1},{-50,1}},
      color={0,140,72},
      thickness=0.5));
  connect(fivZonVAV.port_b_Air, duaFanAirHanUni.port_a_Air) annotation (
      Line(
      points={{30,-23.6},{16,-23.6},{16,-4},{-50,-4},{-50,11.4}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUni.port_b_Wat, port_b_CooWat) annotation (Line(
      points={{-69.6,-12},{-70,-12},{-70,-66},{-54,-66},{-54,-100}},
      color={0,127,255},
      thickness=1));
  connect(duaFanAirHanUni.port_a_Wat, port_a_CooWat) annotation (Line(
      points={{-61.2,-12},{-62,-12},{-62,-30},{-30,-30},{-30,-100}},
      color={0,127,255},
      thickness=1));
  connect(fivZonVAV.port_a_Wat, port_a_HeaWat) annotation (Line(
      points={{40.8,-46},{40,-46},{40,-100}},
      color={255,0,0},
      thickness=1));
  connect(fivZonVAV.port_b_Wat, port_b_HeaWat) annotation (Line(
      points={{55.2,-46},{56,-46},{56,-100}},
      color={255,0,0},
      thickness=1));
  connect(duaFanAirHanUni.port_Exh_Air, port_Exh_Air) annotation (Line(
      points={{-78.28,1},{-114,1},{-114,-40},{-164,-40}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUni.port_Fre_Air, port_Fre_Air) annotation (Line(
      points={{-78,-6.8},{-114,-6.8},{-114,40},{-160,40}},
      color={0,140,72},
      thickness=0.5));
  connect(booleanReplicator.y, fivZonVAV.On) annotation (Line(
      points={{-125.3,-90},{0,-90},{0,-30.32},{28.2,-30.32}},
      color={255,0,255}));
  connect(fivZonVAV.p, duaFanAirHanUni.pMea) annotation (Line(points={{67.8,
          -19.4},{70,-19.4},{70,-16},{-88,-16},{-88,-11.22},{-79.4,-11.22}},
        color={0,0,127}));
  connect(fivZonVAV.TZon, duaFanAirHanUni.zonT) annotation (Line(points={{
          67.8,-40.4},{84,-40.4},{84,-64},{-104,-64},{-104,6.2},{-79.4,6.2}},
        color={0,0,127}));

  connect(OnFan, duaFanAirHanUni.On) annotation (Line(points={{-170,-50},{-108,
          -50},{-108,14},{-79.4,14}}, color={255,0,255}));
  connect(booleanReplicator.u, OnZon) annotation (Line(
      points={{-141.4,-90},{-170,-90}},
      color={255,0,255}));
  connect(fivZonVAV.Q_flow, Q_flow) annotation (Line(
      points={{28.2,-20.8},{2,-20.8},{2,-70},{16,-70},{16,-110}},
      color={0,0,127}));
  connect(fivZonVAV.TZon, TZon) annotation (Line(
      points={{67.8,-40.4},{146,-40.4},{146,0},{170,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a_CooWat, port_a_CooWat) annotation (Line(points={{-30,-100},
          {-30,-100}},     color={0,127,255}));
  connect(duaFanAirHanUni.TOut, TOut) annotation (Line(points={{-79.4,11.4},
          {-112,11.4},{-112,-74},{-14,-74},{-14,-110}}, color={0,0,127}));

  connect(OnFan, reaAhu.occ_in) annotation (Line(points={{-170,-50},{-112,-50},
          {-112,62},{26,62},{26,62.3826}}, color={255,0,255}));
  connect(duaFanAirHanUni.TSupAir, reaAhu.TSup_in) annotation (Line(
      points={{-48.6,-4.2},{-34,-4.2},{-34,54.8696},{26,54.8696}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TMixAir, reaAhu.TMix_in) annotation (Line(
      points={{-48.6,-2.64},{-48.6,-4},{-32,-4},{-32,50.6957},{26,50.6957}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetAir, reaAhu.TRet_in) annotation (Line(
      points={{-48.6,8.02},{-28,8.02},{-28,46.5217},{26,46.5217}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowSupAir, reaAhu.V_flow_sup_in) annotation (
      Line(
      points={{-48.6,-1.08},{-26,-1.08},{-26,42.3478},{26,42.3478}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.V_flowRetAir, reaAhu.V_flow_ret_in) annotation (
      Line(
      points={{-48.6,9.58},{-30,9.58},{-30,38.1739},{26,38.1739}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.yDamOutAir, reaAhu.yOA_in) annotation (Line(
      points={{-48.6,-11.22},{-24,-11.22},{-24,34.2783},{26,34.2783}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.pMea, reaAhu.dp_in) annotation (Line(
      points={{-79.4,-11.22},{-22,-11.22},{-22,29.8261},{26,29.8261}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.PFan, reaAhu.PFanTot_in) annotation (Line(
      points={{-48.6,4.64},{-20,4.64},{-20,25.6522},{26,25.6522}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TSupCHW, reaAhu.TCooCoiSup_in) annotation (Line(
      points={{-48.6,-9.4},{-18,-9.4},{-18,21.4783},{26,21.4783}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetCHW, reaAhu.TCooCoiRet_in) annotation (Line(
      points={{-48.6,2.82},{-16,2.82},{-16,17.3043},{26,17.3043}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(reaAhu.yCooVal_in, duaFanAirHanUni.yCooVal) annotation (Line(
      points={{26,13.1304},{-14,13.1304},{-14,6.2},{-48.6,6.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowOutAir, reaAhu.V_flow_OA_in) annotation (
      Line(
      points={{-48.6,-6.8},{-48.6,-4},{-12,-4},{-12,10},{26,10},{26,8.95652}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(TSupAirSet.y, reaAhu.TSup_set_in) annotation (Line(
      points={{-127.4,60},{26,60},{26,58.2087}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(disTSet, TSupAirSet.u)
    annotation (Line(points={{-170,60},{-141.2,60}}, color={0,0,127}));
  connect(TSupAirSet.y, duaFanAirHanUni.disTSet) annotation (Line(points={{
          -127.4,60},{-110,60},{-110,3.6},{-79.4,3.6}}, color={0,0,127}));
  connect(pSet, dpSet.u)
    annotation (Line(points={{-170,10},{-141.2,10}}, color={0,0,127}));
  connect(dpSet.y, duaFanAirHanUni.pSet) annotation (Line(points={{-127.4,
          10},{-110,10},{-110,8.8},{-79.4,8.8}}, color={0,0,127}));
  connect(fivZonVAV.yDam[1], reaZonCor.yDam_in) annotation (Line(
      points={{67.8,-35.64},{88,-35.64},{88,141},{98,141}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[2], reaZonSou.yDam_in) annotation (Line(
      points={{67.8,-35.92},{88,-35.92},{88,77},{98,77}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[3], reaZonEas.yDam_in) annotation (Line(
      points={{67.8,-36.2},{88,-36.2},{88,13},{98,13}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[4], reaZonNor.yDam_in) annotation (Line(
      points={{67.8,-36.48},{128,-36.48},{128,109},{138,109}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[5], reaZonWes.yDam_in) annotation (Line(
      points={{67.8,-36.76},{128,-36.76},{128,47},{138,47}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[1], reaZonCor.yReheaVal_in) annotation (Line(
      points={{67.8,-31.44},{92,-31.44},{92,138},{98,138}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[2], reaZonSou.yReheaVal_in) annotation (Line(
      points={{67.8,-31.72},{92,-31.72},{92,74},{98,74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[3], reaZonEas.yReheaVal_in) annotation (Line(
      points={{67.8,-32},{92,-32},{92,10},{98,10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[4], reaZonNor.yReheaVal_in) annotation (Line(
      points={{67.8,-32.28},{130,-32.28},{130,106},{138,106}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[5], reaZonWes.yReheaVal_in) annotation (Line(
      points={{67.8,-32.56},{130,-32.56},{130,44},{138,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[1], reaZonCor.TZon_in) annotation (Line(
      points={{67.8,-39.84},{84,-39.84},{84,135},{98,135}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[2], reaZonSou.TZon_in) annotation (Line(
      points={{67.8,-40.12},{84,-40.12},{84,71},{98,71}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[3], reaZonEas.TZon_in) annotation (Line(
      points={{67.8,-40.4},{84,-40.4},{84,7},{98,7}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[4], reaZonNor.TZon_in) annotation (Line(
      points={{67.8,-40.68},{126,-40.68},{126,103},{138,103}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[5], reaZonWes.TZon_in) annotation (Line(
      points={{67.8,-40.96},{126,-40.96},{126,41},{138,41}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[1], reaZonCor.TSup_in) annotation (Line(points={{67.8,-44.04},
          {94,-44.04},{94,132},{98,132}},              color={0,0,127}));
  connect(fivZonVAV.TSup[2], reaZonSou.TSup_in) annotation (Line(points={{67.8,-44.32},
          {94,-44.32},{94,68},{98,68}},              color={0,0,127}));
  connect(fivZonVAV.TSup[3], reaZonEas.TSup_in) annotation (Line(points={{
          67.8,-44.6},{94,-44.6},{94,4},{98,4}}, color={0,0,127}));
  connect(fivZonVAV.TSup[4], reaZonNor.TSup_in) annotation (Line(
      points={{67.8,-44.88},{132,-44.88},{132,100},{138,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[5], reaZonWes.TSup_in) annotation (Line(
      points={{67.8,-45.16},{134,-45.16},{134,38},{138,38}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[1], reaZonCor.V_flow_in) annotation (Line(
      points={{67.8,-23.04},{82,-23.04},{82,129.2},{98,129.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[2], reaZonSou.V_flow_in) annotation (Line(
      points={{67.8,-23.32},{82,-23.32},{82,65.2},{98,65.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[3], reaZonEas.V_flow_in) annotation (Line(
      points={{67.8,-23.6},{82,-23.6},{82,1.2},{98,1.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[4], reaZonNor.V_flow_in) annotation (Line(
      points={{67.8,-23.88},{124,-23.88},{124,97.2},{138,97.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[5], reaZonWes.V_flow_in) annotation (Line(
      points={{67.8,-24.16},{124,-24.16},{124,35.2},{138,35.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[1], reaZonCor.Vflow_set_in) annotation (Line(
      points={{67.8,-27.24},{80,-27.24},{80,126.6},{98,126.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[2], reaZonSou.Vflow_set_in) annotation (Line(
      points={{67.8,-27.52},{80,-27.52},{80,62.6},{98,62.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[3], reaZonEas.Vflow_set_in) annotation (Line(
      points={{67.8,-27.8},{80,-27.8},{80,-1.4},{98,-1.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[4], reaZonNor.Vflow_set_in) annotation (Line(
      points={{67.8,-28.08},{122,-28.08},{122,94.6},{138,94.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[5], reaZonWes.Vflow_set_in) annotation (Line(
      points={{67.8,-28.36},{124,-28.36},{124,32.6},{138,32.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(zonVAVCon.yValPos, fivZonVAV.yVal) annotation (Line(points={{7,122},
          {6,122},{6,-40.4},{28.2,-40.4}},      color={0,0,127}));
  connect(zonVAVCon.yAirFlowSet, fivZonVAV.airFloRatSet) annotation (Line(
        points={{7,126},{8,126},{8,-44.04},{28.2,-44.04}}, color={0,0,127}));
  connect(zonVAVCon.yHea, fivZonVAV.yHea) annotation (Line(points={{7,132},
          {8,132},{8,-32.84},{28.2,-32.84}}, color={0,0,127}));
  connect(zonVAVCon.yCoo, fivZonVAV.yCoo) annotation (Line(points={{7,136},
          {10,136},{10,-35.64},{28.2,-35.64}}, color={0,0,127}));
  connect(zonVAVCon.T, fivZonVAV.TZon) annotation (Line(points={{-16,128},{
          -26,128},{-26,98},{88,98},{88,-40.4},{67.8,-40.4}}, color={0,0,
          127}));
  connect(zonHeaTSet[1], oveZonCor.TZonHeaSet_in) annotation (Line(points={{-170,76},
          {-150,76},{-150,192},{-122,192}},           color={0,0,127}));
  connect(zonHeaTSet[2], oveZonSou.TZonHeaSet_in) annotation (Line(points={{-170,78},
          {-150,78},{-150,164},{-122,164}},           color={0,0,127}));
  connect(zonHeaTSet[3], oveZonEas.TZonHeaSet_in) annotation (Line(points={
          {-170,80},{-150,80},{-150,136},{-122,136}}, color={0,0,127}));
  connect(zonHeaTSet[4], oveZonNor.TZonHeaSet_in) annotation (Line(points={{-170,82},
          {-150,82},{-150,112},{-122,112}},           color={0,0,127}));
  connect(zonHeaTSet[5], oveZonWes.TZonHeaSet_in) annotation (Line(points={{-170,84},
          {-150,84},{-150,84},{-122,84}},           color={0,0,127}));
  connect(zonCooTSet[1], oveZonCor.TZonCooSet_in) annotation (Line(points={{-170,96},
          {-154,96},{-154,184},{-122,184}},           color={0,0,127}));
  connect(zonCooTSet[2], oveZonSou.TZonCooSet_in) annotation (Line(points={{-170,98},
          {-154,98},{-154,156},{-122,156}},           color={0,0,127}));
  connect(zonCooTSet[3], oveZonEas.TZonCooSet_in) annotation (Line(points={
          {-170,100},{-154,100},{-154,128},{-122,128}}, color={0,0,127}));
  connect(zonCooTSet[4], oveZonNor.TZonCooSet_in)
    annotation (Line(points={{-170,102},{-146,102},{-146,104},{-122,104}},
                                                     color={0,0,127}));
  connect(zonCooTSet[5], oveZonWes.TZonCooSet_in) annotation (Line(points={{-170,
          104},{-150,104},{-150,76},{-122,76}},       color={0,0,127}));
  connect(oveZonCor.TZonHeaSet_out, TZonHeaSet.u[1]) annotation (Line(
        points={{-99,192},{-76,192},{-76,175.2},{-72,175.2}}, color={0,0,
          127}));
  connect(oveZonSou.TZonHeaSet_out, TZonHeaSet.u[2]) annotation (Line(
        points={{-99,164},{-76,164},{-76,175.6},{-72,175.6}}, color={0,0,
          127}));
  connect(oveZonEas.TZonHeaSet_out, TZonHeaSet.u[3]) annotation (Line(
        points={{-99,136},{-76,136},{-76,176},{-72,176}}, color={0,0,127}));
  connect(oveZonNor.TZonHeaSet_out, TZonHeaSet.u[4]) annotation (Line(
        points={{-99,112},{-76,112},{-76,176.4},{-72,176.4}}, color={0,0,
          127}));
  connect(oveZonWes.TZonHeaSet_out, TZonHeaSet.u[5]) annotation (Line(
        points={{-99,84},{-76,84},{-76,176},{-72,176},{-72,176.8}}, color={
          0,0,127}));
  connect(TZonHeaSet.y, zonVAVCon.THeaSet) annotation (Line(points={{-48,
          176},{-24,176},{-24,122},{-16,122}}, color={0,0,127}));
  connect(oveZonCor.TZonCooSet_out, TZonCooSet.u[1]) annotation (Line(
        points={{-99,184},{-80,184},{-80,77.2},{-74,77.2}}, color={0,0,127}));
  connect(oveZonSou.TZonCooSet_out, TZonCooSet.u[2]) annotation (Line(
        points={{-99,156},{-80,156},{-80,77.6},{-74,77.6}}, color={0,0,127}));
  connect(oveZonEas.TZonCooSet_out, TZonCooSet.u[3]) annotation (Line(
        points={{-99,128},{-80,128},{-80,78},{-74,78}}, color={0,0,127}));
  connect(oveZonNor.TZonCooSet_out, TZonCooSet.u[4]) annotation (Line(
        points={{-99,104},{-80,104},{-80,78.4},{-74,78.4}}, color={0,0,127}));
  connect(oveZonWes.TZonCooSet_out, TZonCooSet.u[5]) annotation (Line(
        points={{-99,76},{-80,76},{-80,78.8},{-74,78.8}}, color={0,0,127}));
  connect(TZonCooSet.y, zonVAVCon.TCooSet) annotation (Line(points={{-50,78},
          {-28,78},{-28,134},{-16,134}}, color={0,0,127}));
  connect(TZonCooSet.y, duaFanAirHanUni.cooTSet) annotation (Line(points={{
          -50,78},{-50,58},{-110,58},{-110,-4.2},{-79.4,-4.2}}, color={0,0,
          127}));
  connect(TZonHeaSet.y, duaFanAirHanUni.heaTSet) annotation (Line(points={{
          -48,176},{-48,60},{-106,60},{-106,-9.4},{-79.4,-9.4}}, color={0,0,
          127}));
  connect(TZonHeaSet.y[1], reaZonCor.TRoo_Hea_set_in) annotation (Line(
        points={{-48,175.2},{76,175.2},{76,123.8},{98,123.8}}, color={0,0,
          127}));
  connect(TZonHeaSet.y[2], reaZonSou.TRoo_Hea_set_in) annotation (Line(
        points={{-48,175.6},{76,175.6},{76,59.8},{98,59.8}}, color={0,0,127}));
  connect(TZonHeaSet.y[3], reaZonEas.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176},{76,176},{76,-4.2},{98,-4.2}}, color={0,0,127}));
  connect(TZonHeaSet.y[4], reaZonNor.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176.4},{76,176.4},{76,91.8},{138,91.8}}, color={0,0,
          127}));
  connect(TZonHeaSet.y[5], reaZonWes.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176.8},{78,176.8},{78,29.8},{138,29.8}}, color={0,0,
          127}));
  connect(TZonCooSet.y[1], reaZonCor.TRoo_Coo_set_in) annotation (Line(
        points={{-50,77.2},{70,77.2},{70,120.6},{98,120.6}}, color={0,0,127}));
  connect(TZonCooSet.y[2], reaZonSou.TRoo_Coo_set_in) annotation (Line(
        points={{-50,77.6},{70,77.6},{70,56.6},{98,56.6}}, color={0,0,127}));
  connect(TZonCooSet.y[3], reaZonEas.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78},{70,78},{70,-7.4},{98,-7.4}}, color={0,0,127}));
  connect(TZonCooSet.y[4], reaZonNor.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78.4},{70,78.4},{70,88.6},{138,88.6}}, color={0,0,127}));
  connect(TZonCooSet.y[5], reaZonWes.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78.8},{70,78.8},{70,26.6},{138,26.6}}, color={0,0,127}));
  connect(zonVAVCon[1].yCoo, reaZonCor.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,118},{98,118}},      color={0,0,127}));
  connect(zonVAVCon[2].yCoo, reaZonSou.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,54},{98,54}},      color={0,0,127}));
  connect(zonVAVCon[3].yCoo, reaZonEas.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,-10},{98,-10}},      color={0,0,127}));
  connect(zonVAVCon[4].yCoo, reaZonNor.yCoo_in) annotation (Line(points={{7,136},
          {70,136},{70,86},{138,86}},      color={0,0,127}));
  connect(zonVAVCon[5].yCoo, reaZonWes.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,24},{138,24}},      color={0,0,127}));
  connect(zonVAVCon[1].yHea, reaZonCor.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,115},{98,115}},      color={0,0,127}));
  connect(zonVAVCon[2].yHea, reaZonSou.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,51},{98,51}},      color={0,0,127}));
  connect(zonVAVCon[3].yHea, reaZonEas.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,-13},{98,-13}},      color={0,0,127}));
  connect(zonVAVCon[4].yHea, reaZonNor.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,83},{138,83}},      color={0,0,127}));
  connect(zonVAVCon[5].yHea, reaZonWes.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,21},{138,21}},      color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,140}}),                                  graphics={
        Rectangle(
          extent={{-160,140},{160,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-80,90},{80,-50}}, lineColor={0,0,127}),
        Rectangle(extent={{-40,50},{40,-10}}, lineColor={0,0,127}),
        Line(points={{-80,90},{-40,50}}, color={0,0,127}),
        Line(points={{80,90},{40,50}}, color={0,0,127}),
        Line(points={{-80,-50},{-40,-10}}, color={0,0,127}),
        Line(points={{40,-10},{80,-50}}, color={0,0,127}),
        Text(
          extent={{-154,142},{146,182}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{
            160,200}})),
    Documentation(info="<html>
<p>This is the floor model with the airside HVAC system. The represented floor has five zones, with four perimeter zones and one core zone. Each perimeter zone has a window-to-wall ratio of about 0.38. The height of each zone is 2.74 m and the areas are as follows:</p>
<ul>
<li>North and South: 313.42 m<sup>2</sup></li>
<li>East and West: 201.98 m<sup>2</sup></li>
<li>Core: 2532.32 m<sup>2</sup></li>
</ul>
<p>The geometry of the floor is shown as the following figure:</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/Zones.png\"/></p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit </a>for a description of the AHU.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV</a> for a description of the five-zone models with VAV terminals.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.Controls.ZonCon\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal.Controls.ZonCon</a> for a description of the zone terminal VAV controller. </p>
</html>", revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
end AirsideFloor;
