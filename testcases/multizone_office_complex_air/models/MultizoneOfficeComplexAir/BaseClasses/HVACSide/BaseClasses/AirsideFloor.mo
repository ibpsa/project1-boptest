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

  // Initialization
  parameter MediumAir.AbsolutePressure p_start = MediumAir.p_default
    "Start value of zone air pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumAir.Temperature T_start=MediumAir.T_default
    "Start value of zone air temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter MediumAir.MassFraction X_start[MediumAir.nX](
       quantity=MediumAir.substanceNames) = MediumAir.X_default
    "Start value of zone air mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter MediumAir.ExtraProperty C_start[MediumAir.nC](
       quantity=MediumAir.extraPropertiesNames)=fill(0, MediumAir.nC)
    "Start value of zone air trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter MediumAir.ExtraProperty C_nominal[MediumAir.nC](
       quantity=MediumAir.extraPropertiesNames) = fill(1E-2, MediumAir.nC)
    "Nominal value of zone air trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  parameter Modelica.Units.SI.MassFlowRate m_flow_lea[4]={0.206*1.2,0.137*1.2,0.206*1.2,0.137*1.2} "Air infiltration mass flow rates to four exterior zones";

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
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    m_flow_lea=m_flow_lea,
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
  Modelica.Fluid.Interfaces.FluidPort_b port_b_CooWat(redeclare package Medium =
        MediumCooWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
        iconTransformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_CooWat(redeclare package Medium =
        MediumCooWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}}),
        iconTransformation(extent={{-40,-110},{-20,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_HeaWat(redeclare package Medium =
        MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_HeaWat(redeclare package Medium =
        MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{60,-110},{80,-90}}),
        iconTransformation(extent={{60,-110},{80,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-174,-50},{-154,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,30},{-150,50}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=5)
    annotation (Placement(transformation(extent={{-140,-96},{-126,-84}})));
  Modelica.Blocks.Interfaces.BooleanInput OnFan
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-180,-70},{-160,-50}}),
        iconTransformation(extent={{-180,-70},{-160,-50}})));
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
    heaCon(Ti=60, yMin=0.),
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

  Modelica.Blocks.Interfaces.RealInput nPeo[5] "Number of occupant" annotation (
     Placement(transformation(extent={{-180,-28},{-160,-8}}),
        iconTransformation(extent={{-180,-20},{-160,0}})));
  Modelica.Icons.SignalBus weaBus
    annotation (Placement(transformation(extent={{-8,-108},{8,-92}}),
        iconTransformation(extent={{-8,-108},{8,-92}})));
equation
  connect(fivZonVAV.port_a_Air, duaFanAirHanUni.port_b_Air) annotation (
      Line(
      points={{30,-38.3636},{-20,-38.3636},{-20,-0.181818},{-50,-0.181818}},
      color={0,140,72},
      thickness=0.5));
  connect(fivZonVAV.port_b_Air, duaFanAirHanUni.port_a_Air) annotation (
      Line(
      points={{30,-25.6364},{16,-25.6364},{16,12},{-50,12},{-50,9.27273}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUni.port_b_Wat, port_b_CooWat) annotation (Line(
      points={{-69.6,-12},{-70,-12},{-70,-66},{-60,-66},{-60,-100}},
      color={0,127,255},
      thickness=1));
  connect(duaFanAirHanUni.port_a_Wat, port_a_CooWat) annotation (Line(
      points={{-61.2,-12},{-62,-12},{-62,-30},{-30,-30},{-30,-100}},
      color={0,127,255},
      thickness=1));
  connect(fivZonVAV.port_a_Wat, port_a_HeaWat) annotation (Line(
      points={{37.2,-46},{40,-46},{40,-100}},
      color={255,0,0},
      thickness=1));
  connect(fivZonVAV.port_b_Wat, port_b_HeaWat) annotation (Line(
      points={{46.8,-46},{70,-46},{70,-100}},
      color={255,0,0},
      thickness=1));
  connect(duaFanAirHanUni.port_Exh_Air, port_Exh_Air) annotation (Line(
      points={{-78.28,-0.181818},{-114,-0.181818},{-114,-40},{-164,-40}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUni.port_Fre_Air, port_Fre_Air) annotation (Line(
      points={{-78,-7.27273},{-114,-7.27273},{-114,40},{-160,40}},
      color={0,140,72},
      thickness=0.5));
  connect(booleanReplicator.y, fivZonVAV.On) annotation (Line(
      points={{-125.3,-90},{4,-90},{4,-31.7455},{28.8,-31.7455}},
      color={255,0,255}));
  connect(fivZonVAV.p, duaFanAirHanUni.pMea) annotation (Line(points={{55.2,
          -21.8182},{70,-21.8182},{70,-16},{-88,-16},{-88,-11.2909},{-79.4,
          -11.2909}},
        color={0,0,127}));
  connect(fivZonVAV.TZon, duaFanAirHanUni.zonT) annotation (Line(points={{55.2,
          -38.3636},{84,-38.3636},{84,-64},{-104,-64},{-104,4.54545},{-79.4,
          4.54545}},
        color={0,0,127}));

  connect(OnFan, duaFanAirHanUni.On) annotation (Line(points={{-170,-60},{-108,
          -60},{-108,11.6364},{-79.4,11.6364}},
                                      color={255,0,255}));
  connect(booleanReplicator.u, OnZon) annotation (Line(
      points={{-141.4,-90},{-170,-90}},
      color={255,0,255}));
  connect(fivZonVAV.Q_flow, Q_flow) annotation (Line(
      points={{28.8,-23.8545},{2,-23.8545},{2,-70},{16,-70},{16,-110}},
      color={0,0,127}));
  connect(fivZonVAV.TZon, TZon) annotation (Line(
      points={{55.2,-38.3636},{146,-38.3636},{146,0},{170,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a_CooWat, port_a_CooWat) annotation (Line(points={{-30,-100},
          {-30,-100}},     color={0,127,255}));

  connect(OnFan, reaAhu.occ_in) annotation (Line(points={{-170,-60},{-112,-60},
          {-112,62},{26,62},{26,62.8}},    color={255,0,255}));
  connect(duaFanAirHanUni.TSupAir, reaAhu.TSup_in) annotation (Line(
      points={{-48.6,-4.90909},{-34,-4.90909},{-34,56.1538},{26,56.1538}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TMixAir, reaAhu.TMix_in) annotation (Line(
      points={{-48.6,-3.49091},{-48.6,-4},{-32,-4},{-32,52.4615},{26,52.4615}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetAir, reaAhu.TRet_in) annotation (Line(
      points={{-48.6,6.2},{-28,6.2},{-28,48.7692},{26,48.7692}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowSupAir, reaAhu.V_flow_sup_in) annotation (
      Line(
      points={{-48.6,-2.07273},{-26,-2.07273},{-26,45.0769},{26,45.0769}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.V_flowRetAir, reaAhu.V_flow_ret_in) annotation (
      Line(
      points={{-48.6,7.61818},{-30,7.61818},{-30,41.3846},{26,41.3846}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.yDamOutAir, reaAhu.yOA_in) annotation (Line(
      points={{-48.6,-11.2909},{-24,-11.2909},{-24,37.9385},{26,37.9385}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.pMea, reaAhu.dp_in) annotation (Line(
      points={{-79.4,-11.2909},{-22,-11.2909},{-22,34},{26,34}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.PFan, reaAhu.PFanTot_in) annotation (Line(
      points={{-48.6,3.12727},{-20,3.12727},{-20,30.3077},{26,30.3077}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TSupCHW, reaAhu.TCooCoiSup_in) annotation (Line(
      points={{-48.6,-9.63636},{-18,-9.63636},{-18,26.6154},{26,26.6154}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetCHW, reaAhu.TCooCoiRet_in) annotation (Line(
      points={{-48.6,1.47273},{-16,1.47273},{-16,22.9231},{26,22.9231}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(reaAhu.yCooVal_in, duaFanAirHanUni.yCooVal) annotation (Line(
      points={{26,19.2308},{-14,19.2308},{-14,4.54545},{-48.6,4.54545}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowOutAir, reaAhu.V_flow_OA_in) annotation (
      Line(
      points={{-48.6,-7.27273},{-48.6,-6},{-12,-6},{-12,16},{26,16},{26,15.5385}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(TSupAirSet.y, reaAhu.TSup_set_in) annotation (Line(
      points={{-127.4,60},{26,60},{26,59.1077}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(disTSet, TSupAirSet.u)
    annotation (Line(points={{-170,60},{-141.2,60}}, color={0,0,127}));
  connect(TSupAirSet.y, duaFanAirHanUni.disTSet) annotation (Line(points={{-127.4,
          60},{-110,60},{-110,2.18182},{-79.4,2.18182}},color={0,0,127}));
  connect(pSet, dpSet.u)
    annotation (Line(points={{-170,10},{-141.2,10}}, color={0,0,127}));
  connect(dpSet.y, duaFanAirHanUni.pSet) annotation (Line(points={{-127.4,10},{
          -110,10},{-110,6.90909},{-79.4,6.90909}},
                                                 color={0,0,127}));
  connect(fivZonVAV.yDam[1], reaZonCor.yDam_in) annotation (Line(
      points={{55.2,-34.5455},{88,-34.5455},{88,141.125},{98,141.125}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[2], reaZonSou.yDam_in) annotation (Line(
      points={{55.2,-34.8},{88,-34.8},{88,77.125},{98,77.125}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[3], reaZonEas.yDam_in) annotation (Line(
      points={{55.2,-35.0545},{88,-35.0545},{88,13.125},{98,13.125}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[4], reaZonNor.yDam_in) annotation (Line(
      points={{55.2,-35.3091},{128,-35.3091},{128,109.125},{138,109.125}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[5], reaZonWes.yDam_in) annotation (Line(
      points={{55.2,-35.5636},{128,-35.5636},{128,47.125},{138,47.125}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[1], reaZonCor.yReheaVal_in) annotation (Line(
      points={{55.2,-31.4909},{92,-31.4909},{92,138.5},{98,138.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[2], reaZonSou.yReheaVal_in) annotation (Line(
      points={{55.2,-31.7455},{92,-31.7455},{92,74.5},{98,74.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[3], reaZonEas.yReheaVal_in) annotation (Line(
      points={{55.2,-32},{92,-32},{92,10.5},{98,10.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[4], reaZonNor.yReheaVal_in) annotation (Line(
      points={{55.2,-32.2545},{130,-32.2545},{130,106.5},{138,106.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[5], reaZonWes.yReheaVal_in) annotation (Line(
      points={{55.2,-32.5091},{130,-32.5091},{130,44.5},{138,44.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[1], reaZonCor.TZon_in) annotation (Line(
      points={{55.2,-37.8545},{84,-37.8545},{84,135.875},{98,135.875}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[2], reaZonSou.TZon_in) annotation (Line(
      points={{55.2,-38.1091},{84,-38.1091},{84,71.875},{98,71.875}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[3], reaZonEas.TZon_in) annotation (Line(
      points={{55.2,-38.3636},{84,-38.3636},{84,7.875},{98,7.875}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[4], reaZonNor.TZon_in) annotation (Line(
      points={{55.2,-38.6182},{126,-38.6182},{126,103.875},{138,103.875}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[5], reaZonWes.TZon_in) annotation (Line(
      points={{55.2,-38.8727},{126,-38.8727},{126,41.875},{138,41.875}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[1], reaZonCor.TSup_in) annotation (Line(points={{55.2,
          -41.1636},{94,-41.1636},{94,133.25},{98,133.25}},
                                                       color={0,0,127}));
  connect(fivZonVAV.TSup[2], reaZonSou.TSup_in) annotation (Line(points={{55.2,
          -41.4182},{94,-41.4182},{94,69.25},{98,69.25}},
                                                     color={0,0,127}));
  connect(fivZonVAV.TSup[3], reaZonEas.TSup_in) annotation (Line(points={{55.2,
          -41.6727},{94,-41.6727},{94,5.25},{98,5.25}},
                                                 color={0,0,127}));
  connect(fivZonVAV.TSup[4], reaZonNor.TSup_in) annotation (Line(
      points={{55.2,-41.9273},{132,-41.9273},{132,101.25},{138,101.25}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[5], reaZonWes.TSup_in) annotation (Line(
      points={{55.2,-42.1818},{134,-42.1818},{134,39.25},{138,39.25}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[1], reaZonCor.V_flow_in) annotation (Line(
      points={{55.2,-24.8727},{82,-24.8727},{82,130.8},{98,130.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[2], reaZonSou.V_flow_in) annotation (Line(
      points={{55.2,-25.1273},{82,-25.1273},{82,66.8},{98,66.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[3], reaZonEas.V_flow_in) annotation (Line(
      points={{55.2,-25.3818},{82,-25.3818},{82,2.8},{98,2.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[4], reaZonNor.V_flow_in) annotation (Line(
      points={{55.2,-25.6364},{124,-25.6364},{124,98.8},{138,98.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[5], reaZonWes.V_flow_in) annotation (Line(
      points={{55.2,-25.8909},{124,-25.8909},{124,36.8},{138,36.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[1], reaZonCor.Vflow_set_in) annotation (Line(
      points={{55.2,-28.1818},{80,-28.1818},{80,128.525},{98,128.525}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[2], reaZonSou.Vflow_set_in) annotation (Line(
      points={{55.2,-28.4364},{80,-28.4364},{80,64.525},{98,64.525}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[3], reaZonEas.Vflow_set_in) annotation (Line(
      points={{55.2,-28.6909},{80,-28.6909},{80,0.525},{98,0.525}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[4], reaZonNor.Vflow_set_in) annotation (Line(
      points={{55.2,-28.9455},{122,-28.9455},{122,96.525},{138,96.525}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[5], reaZonWes.Vflow_set_in) annotation (Line(
      points={{55.2,-29.2},{124,-29.2},{124,34.525},{138,34.525}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(zonVAVCon.yValPos, fivZonVAV.yVal) annotation (Line(points={{7,122},{
          6,122},{6,-40.9091},{28.8,-40.9091}}, color={0,0,127}));
  connect(zonVAVCon.yAirFlowSet, fivZonVAV.airFloRatSet) annotation (Line(
        points={{7,126},{8,126},{8,-44.2182},{28.8,-44.2182}},
                                                           color={0,0,127}));
  connect(zonVAVCon.yHea, fivZonVAV.yHea) annotation (Line(points={{7,132},{8,
          132},{8,-34.0364},{28.8,-34.0364}},color={0,0,127}));
  connect(zonVAVCon.yCoo, fivZonVAV.yCoo) annotation (Line(points={{7,136},{10,
          136},{10,-36.5818},{28.8,-36.5818}}, color={0,0,127}));
  connect(zonVAVCon.T, fivZonVAV.TZon) annotation (Line(points={{-16,128},{-26,
          128},{-26,98},{88,98},{88,-38.3636},{55.2,-38.3636}},
                                                              color={0,0,
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
  connect(TZonCooSet.y, duaFanAirHanUni.cooTSet) annotation (Line(points={{-50,78},
          {-50,58},{-110,58},{-110,-4.90909},{-79.4,-4.90909}}, color={0,0,
          127}));
  connect(TZonHeaSet.y, duaFanAirHanUni.heaTSet) annotation (Line(points={{-48,176},
          {-48,60},{-106,60},{-106,-9.63636},{-79.4,-9.63636}},  color={0,0,
          127}));
  connect(TZonHeaSet.y[1], reaZonCor.TRoo_Hea_set_in) annotation (Line(
        points={{-48,175.2},{76,175.2},{76,126.075},{98,126.075}},
                                                               color={0,0,
          127}));
  connect(TZonHeaSet.y[2], reaZonSou.TRoo_Hea_set_in) annotation (Line(
        points={{-48,175.6},{76,175.6},{76,62.075},{98,62.075}},
                                                             color={0,0,127}));
  connect(TZonHeaSet.y[3], reaZonEas.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176},{76,176},{76,-1.925},{98,-1.925}},
                                                         color={0,0,127}));
  connect(TZonHeaSet.y[4], reaZonNor.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176.4},{76,176.4},{76,94.075},{138,94.075}},
                                                              color={0,0,
          127}));
  connect(TZonHeaSet.y[5], reaZonWes.TRoo_Hea_set_in) annotation (Line(
        points={{-48,176.8},{78,176.8},{78,32.075},{138,32.075}},
                                                              color={0,0,
          127}));
  connect(TZonCooSet.y[1], reaZonCor.TRoo_Coo_set_in) annotation (Line(
        points={{-50,77.2},{70,77.2},{70,123.275},{98,123.275}},
                                                             color={0,0,127}));
  connect(TZonCooSet.y[2], reaZonSou.TRoo_Coo_set_in) annotation (Line(
        points={{-50,77.6},{70,77.6},{70,59.275},{98,59.275}},
                                                           color={0,0,127}));
  connect(TZonCooSet.y[3], reaZonEas.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78},{70,78},{70,-4.725},{98,-4.725}},
                                                       color={0,0,127}));
  connect(TZonCooSet.y[4], reaZonNor.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78.4},{70,78.4},{70,91.275},{138,91.275}},
                                                            color={0,0,127}));
  connect(TZonCooSet.y[5], reaZonWes.TRoo_Coo_set_in) annotation (Line(
        points={{-50,78.8},{70,78.8},{70,29.275},{138,29.275}},
                                                            color={0,0,127}));
  connect(zonVAVCon[1].yCoo, reaZonCor.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,121},{98,121}},      color={0,0,127}));
  connect(zonVAVCon[2].yCoo, reaZonSou.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,57},{98,57}},      color={0,0,127}));
  connect(zonVAVCon[3].yCoo, reaZonEas.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,-7},{98,-7}},        color={0,0,127}));
  connect(zonVAVCon[4].yCoo, reaZonNor.yCoo_in) annotation (Line(points={{7,136},
          {70,136},{70,89},{138,89}},      color={0,0,127}));
  connect(zonVAVCon[5].yCoo, reaZonWes.yCoo_in) annotation (Line(points={{7,136},
          {68,136},{68,27},{138,27}},      color={0,0,127}));
  connect(zonVAVCon[1].yHea, reaZonCor.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,118.375},{98,118.375}},
                                            color={0,0,127}));
  connect(zonVAVCon[2].yHea, reaZonSou.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,54.375},{98,54.375}},
                                          color={0,0,127}));
  connect(zonVAVCon[3].yHea, reaZonEas.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,-9.625},{98,-9.625}},color={0,0,127}));
  connect(zonVAVCon[4].yHea, reaZonNor.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,86.375},{138,86.375}},
                                           color={0,0,127}));
  connect(zonVAVCon[5].yHea, reaZonWes.yHea_in) annotation (Line(points={{7,132},
          {66,132},{66,24.375},{138,24.375}},
                                           color={0,0,127}));
  connect(nPeo, fivZonVAV.nPeo)
    annotation (Line(points={{-170,-18},{-70,-18},{-70,-21.0545},{28.8,-21.0545}},
                                                     color={0,0,127}));
  connect(fivZonVAV.CO2Zon[1], reaZonCor.CO2Zon_in) annotation (Line(
      points={{55.2,-44.2182},{90,-44.2182},{90,115.75},{98,115.75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[2], reaZonSou.CO2Zon_in) annotation (Line(
      points={{55.2,-44.4727},{78,-44.4727},{78,-44},{90,-44},{90,52},{98,52},{
          98,51.75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[3], reaZonEas.CO2Zon_in) annotation (Line(
      points={{55.2,-44.7273},{90,-44.7273},{90,-12},{98,-12},{98,-12.25}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[4], reaZonNor.CO2Zon_in) annotation (Line(
      points={{55.2,-44.9818},{134,-44.9818},{134,83.75},{138,83.75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[5], reaZonWes.CO2Zon_in) annotation (Line(
      points={{55.2,-45.2364},{134,-45.2364},{134,22},{138,22},{138,21.75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHUSupAir, reaAhu.CO2_AHUSup_in) annotation (Line(
      points={{-48.6,14.2364},{22,14.2364},{22,11.8462},{26,11.8462}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHUFreAir, reaAhu.CO2_AHUFre_in) annotation (Line(
      points={{-48.6,12.8182},{20,12.8182},{20,8.15385},{26,8.15385}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHURetAir, reaAhu.CO2_AHURet_in) annotation (Line(
      points={{-48.6,11.6364},{18,11.6364},{18,4.46154},{26,4.46154}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(weaBus, fivZonVAV.weaBus) annotation (Line(
      points={{0,-100},{0,-18},{42,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, duaFanAirHanUni.TOut) annotation (Line(
      points={{0,-100},{0,-60},{-100,-60},{-100,9.27273},{-79.4,9.27273}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
