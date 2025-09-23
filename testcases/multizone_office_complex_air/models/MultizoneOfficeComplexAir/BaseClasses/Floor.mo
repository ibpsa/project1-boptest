within MultizoneOfficeComplexAir.BaseClasses;
model Floor "Thermal zones and corresponding air side HVAC systems"

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

  parameter Modelica.Units.SI.MassFlowRate mWatFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 +
        mAirFloRat5)*(30 - 12.88)/4.2/6
    "mass flow rate for cooling coil chilled water";

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

  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit
    duaFanAirHanUni(
    mWatFloRat=mWatFloRat,
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
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV
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
    eps5=eps5,
    floorMultiplier=floorMultiplier,
    zoneName=zoneName)
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
  Modelica.Blocks.Interfaces.BooleanInput onFanOcc
    "Fan On signal during occupied period" annotation (Placement(transformation(
          extent={{-180,-70},{-160,-50}}), iconTransformation(extent={{-180,-70},
            {-160,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput onZon
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
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{160,-10},{180,10}}),
        iconTransformation(extent={{160,-10},{180,10}})));
  Modelica.Blocks.Interfaces.RealInput zonHeaTSet[5]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-180,70},{-160,90}}), iconTransformation(
          extent={{-180,70},{-160,90}})));
  ReadOverwrite.ReadAhu reaAHU
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
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonCor(zone=
        "cor")
    annotation (Placement(transformation(extent={{100,114},{120,142}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonSou(zone=
        "sou")
    annotation (Placement(transformation(extent={{100,50},{120,78}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonEas(zone=
        "eas")
    annotation (Placement(transformation(extent={{100,-14},{120,14}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonNor(zone=
        "nor")
    annotation (Placement(transformation(extent={{140,82},{160,110}})));
   MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite.ReadZone reaZonWes(zone=
        "wes")
    annotation (Placement(transformation(extent={{140,20},{160,48}})));
  MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.Control.ZonCon
    zonVAVCon[5](
    each MinFlowRateSetPoi=0.3,
    each HeatingFlowRateSetPoi=0.3,
    heaCon(Ti=60, yMin=0.001),
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

  parameter String zoneName[5]
    "Name of the thermal zones as specified in the EnergyPlus input";
  parameter Integer floorMultiplier=1
    "Floor multiplier to scale HVAC airflow for the single floor that is modeled in EnergyPlus";
equation
  connect(fivZonVAV.port_a_Air, duaFanAirHanUni.port_b_Air) annotation (
      Line(
      points={{30,-37.6},{-20,-37.6},{-20,-1.04286},{-50,-1.04286}},
      color={0,140,72},
      thickness=0.5));
  connect(fivZonVAV.port_b_Air, duaFanAirHanUni.port_a_Air) annotation (
      Line(
      points={{30,-23.6},{16,-23.6},{16,12},{-50,12},{-50,6.38571}},
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
      points={{40.8,-46},{40,-46},{40,-100}},
      color={255,0,0},
      thickness=1));
  connect(fivZonVAV.port_b_Wat, port_b_HeaWat) annotation (Line(
      points={{55.2,-46},{70,-46},{70,-100}},
      color={255,0,0},
      thickness=1));
  connect(duaFanAirHanUni.port_Exh_Air, port_Exh_Air) annotation (Line(
      points={{-78.28,-1.04286},{-114,-1.04286},{-114,-40},{-164,-40}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUni.port_Fre_Air, port_Fre_Air) annotation (Line(
      points={{-78,-6.61429},{-114,-6.61429},{-114,40},{-160,40}},
      color={0,140,72},
      thickness=0.5));
  connect(booleanReplicator.y,fivZonVAV.on)  annotation (Line(
      points={{-125.3,-90},{4,-90},{4,-30.32},{28.2,-30.32}},
      color={255,0,255}));
  connect(fivZonVAV.ducStaPre, duaFanAirHanUni.pMea) annotation (Line(points={{67.8,
          -19.4},{70,-19.4},{70,-16},{-88,-16},{-88,-9.77143},{-79.4,-9.77143}},
                      color={0,0,127}));
  connect(fivZonVAV.TZon, duaFanAirHanUni.zonT) annotation (Line(points={{67.8,
          -37.6},{84,-37.6},{84,-64},{-104,-64},{-104,2.67143},{-79.4,2.67143}},
        color={0,0,127}));

  connect(onFanOcc, duaFanAirHanUni.onFanOcc) annotation (Line(points={{-170,
          -60},{-108,-60},{-108,8.24286},{-79.4,8.24286}}, color={255,0,255}));
  connect(booleanReplicator.u,onZon)  annotation (Line(
      points={{-141.4,-90},{-170,-90}},
      color={255,0,255}));
  connect(fivZonVAV.TZon, TZon) annotation (Line(
      points={{67.8,-37.6},{146,-37.6},{146,0},{170,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a_CooWat, port_a_CooWat) annotation (Line(points={{-30,-100},{
          -30,-100}},      color={0,127,255}));

  connect(onFanOcc,reaAHU. occ_in) annotation (Line(points={{-170,-60},{-112,
          -60},{-112,62},{26,62},{26,63.0286}},
                                        color={255,0,255}));
  connect(duaFanAirHanUni.TSupAir,reaAHU. TSup_in) annotation (Line(
      points={{-48.6,-4.75714},{-34,-4.75714},{-34,59.1429},{26,59.1429}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TMixAir,reaAHU. TMix_in) annotation (Line(
      points={{-48.6,-3.64286},{-48.6,-4},{-32,-4},{-32,55.7143},{26,55.7143}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetAir,reaAHU. TRet_in) annotation (Line(
      points={{-48.6,3.97143},{-28,3.97143},{-28,52.2857},{26,52.2857}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowSupAir, reaAHU.V_flowSup_in) annotation (Line(
      points={{-48.6,-2.52857},{-26,-2.52857},{-26,48.8571},{26,48.8571}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.V_flowRetAir, reaAHU.V_flowRet_in) annotation (Line(
      points={{-48.6,5.08571},{-30,5.08571},{-30,45.4286},{26,45.4286}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.yDamOutAir,reaAHU. yOA_in) annotation (Line(
      points={{-48.6,-10.1429},{-24,-10.1429},{-24,42.2286},{26,42.2286}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.pMea, reaAHU.dp_in) annotation (Line(
      points={{-79.4,-9.77143},{-22,-9.77143},{-22,38.5714},{26,38.5714}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.PFan,reaAHU. PFanTot_in) annotation (Line(
      points={{-48.6,1.55714},{-20,1.55714},{-20,35.1429},{26,35.1429}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TSupCHW,reaAHU. TCooCoiSup_in) annotation (Line(
      points={{-48.6,-8.47143},{-18,-8.47143},{-18,31.7143},{26,31.7143}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.TRetCHW,reaAHU. TCooCoiRet_in) annotation (Line(
      points={{-48.6,0.257143},{-16,0.257143},{-16,28.2857},{26,28.2857}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(reaAHU.yCooVal_in, duaFanAirHanUni.yCooVal) annotation (Line(
      points={{26,24.8571},{-14,24.8571},{-14,2.67143},{-48.6,2.67143}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(duaFanAirHanUni.V_flowOutAir, reaAHU.V_flowOA_in) annotation (Line(
      points={{-48.6,-6.61429},{-48.6,-6},{-12,-6},{-12,16},{26,16},{26,21.4286}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(disTSet, TSupAirSet.u)
    annotation (Line(points={{-170,60},{-141.2,60}}, color={0,0,127}));
  connect(TSupAirSet.y, duaFanAirHanUni.disTSet) annotation (Line(points={{-127.4,
          60},{-110,60},{-110,0.814286},{-79.4,0.814286}},
                                                        color={0,0,127}));
  connect(pSet, dpSet.u)
    annotation (Line(points={{-170,10},{-141.2,10}}, color={0,0,127}));
  connect(dpSet.y, duaFanAirHanUni.pSet) annotation (Line(points={{-127.4,10},{
          -110,10},{-110,4.52857},{-79.4,4.52857}},
                                                 color={0,0,127}));
  connect(fivZonVAV.yDam[1], reaZonCor.yDam_in) annotation (Line(
      points={{67.8,-33.4},{88,-33.4},{88,138.182},{98,138.182}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[2], reaZonSou.yDam_in) annotation (Line(
      points={{67.8,-33.68},{88,-33.68},{88,74.1818},{98,74.1818}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[3], reaZonEas.yDam_in) annotation (Line(
      points={{67.8,-33.96},{88,-33.96},{88,10.1818},{98,10.1818}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[4], reaZonNor.yDam_in) annotation (Line(
      points={{67.8,-34.24},{128,-34.24},{128,106.182},{138,106.182}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yDam[5], reaZonWes.yDam_in) annotation (Line(
      points={{67.8,-34.52},{128,-34.52},{128,44.1818},{138,44.1818}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[1], reaZonCor.yReheaVal_in) annotation (Line(
      points={{67.8,-30.04},{92,-30.04},{92,134.364},{98,134.364}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[2], reaZonSou.yReheaVal_in) annotation (Line(
      points={{67.8,-30.32},{92,-30.32},{92,70.3636},{98,70.3636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[3], reaZonEas.yReheaVal_in) annotation (Line(
      points={{67.8,-30.6},{92,-30.6},{92,6.36364},{98,6.36364}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[4], reaZonNor.yReheaVal_in) annotation (Line(
      points={{67.8,-30.88},{130,-30.88},{130,102.364},{138,102.364}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yReaHea[5], reaZonWes.yReheaVal_in) annotation (Line(
      points={{67.8,-31.16},{130,-31.16},{130,40.3636},{138,40.3636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[1], reaZonCor.TZon_in) annotation (Line(
      points={{67.8,-37.04},{84,-37.04},{84,130.545},{98,130.545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[2], reaZonSou.TZon_in) annotation (Line(
      points={{67.8,-37.32},{84,-37.32},{84,66.5455},{98,66.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[3], reaZonEas.TZon_in) annotation (Line(
      points={{67.8,-37.6},{84,-37.6},{84,2.54545},{98,2.54545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[4], reaZonNor.TZon_in) annotation (Line(
      points={{67.8,-37.88},{126,-37.88},{126,98.5455},{138,98.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon[5], reaZonWes.TZon_in) annotation (Line(
      points={{67.8,-38.16},{126,-38.16},{126,36.5455},{138,36.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[1], reaZonCor.TSup_in) annotation (Line(points={{67.8,
          -40.68},{94,-40.68},{94,126.727},{98,126.727}},
                                                       color={0,0,127}));
  connect(fivZonVAV.TSup[2], reaZonSou.TSup_in) annotation (Line(points={{67.8,
          -40.96},{94,-40.96},{94,62.7273},{98,62.7273}},
                                                     color={0,0,127}));
  connect(fivZonVAV.TSup[3], reaZonEas.TSup_in) annotation (Line(points={{67.8,
          -41.24},{94,-41.24},{94,-1.27273},{98,-1.27273}},
                                                 color={0,0,127}));
  connect(fivZonVAV.TSup[4], reaZonNor.TSup_in) annotation (Line(
      points={{67.8,-41.52},{132,-41.52},{132,94.7273},{138,94.7273}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TSup[5], reaZonWes.TSup_in) annotation (Line(
      points={{67.8,-41.8},{134,-41.8},{134,32.7273},{138,32.7273}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[1], reaZonCor.V_flow_in) annotation (Line(
      points={{67.8,-22.76},{82,-22.76},{82,123.164},{98,123.164}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[2], reaZonSou.V_flow_in) annotation (Line(
      points={{67.8,-23.04},{82,-23.04},{82,59.1636},{98,59.1636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[3], reaZonEas.V_flow_in) annotation (Line(
      points={{67.8,-23.32},{82,-23.32},{82,-4.83636},{98,-4.83636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[4], reaZonNor.V_flow_in) annotation (Line(
      points={{67.8,-23.6},{124,-23.6},{124,91.1636},{138,91.1636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow[5], reaZonWes.V_flow_in) annotation (Line(
      points={{67.8,-23.88},{124,-23.88},{124,29.1636},{138,29.1636}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[1], reaZonCor.V_flowSet_in) annotation (Line(
      points={{67.8,-26.4},{80,-26.4},{80,119.855},{98,119.855}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[2], reaZonSou.V_flowSet_in) annotation (Line(
      points={{67.8,-26.68},{80,-26.68},{80,55.8545},{98,55.8545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[3], reaZonEas.V_flowSet_in) annotation (Line(
      points={{67.8,-26.96},{80,-26.96},{80,-8.14545},{98,-8.14545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[4], reaZonNor.V_flowSet_in) annotation (Line(
      points={{67.8,-27.24},{122,-27.24},{122,87.8545},{138,87.8545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Vflow_set[5], reaZonWes.V_flowSet_in) annotation (Line(
      points={{67.8,-27.52},{124,-27.52},{124,25.8545},{138,25.8545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(zonVAVCon.yValPos, fivZonVAV.yVal) annotation (Line(points={{7,122},{
          10,122},{10,-42},{28,-42},{28,-40.4},{28.2,-40.4}},
                                                color={0,0,127}));
  connect(zonVAVCon.yAirFlowSet, fivZonVAV.airFloRatSet) annotation (Line(
        points={{7,134},{14,134},{14,-44.04},{28.2,-44.04}},
                                                           color={0,0,127}));
  connect(zonVAVCon.T, fivZonVAV.TZon) annotation (Line(points={{-16,128},{-26,
          128},{-26,100},{72,100},{72,-37.6},{67.8,-37.6}},   color={0,0,
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
          {-50,58},{-110,58},{-110,-4.75714},{-79.4,-4.75714}}, color={0,0,
          127}));
  connect(TZonHeaSet.y, duaFanAirHanUni.heaTSet) annotation (Line(points={{-48,176},
          {-48,60},{-106,60},{-106,-8.47143},{-79.4,-8.47143}},  color={0,0,
          127}));
  connect(nPeo, fivZonVAV.nPeo)
    annotation (Line(points={{-170,-18},{-70,-18},{-70,-18.56},{28.2,-18.56}},
                                                     color={0,0,127}));
  connect(fivZonVAV.CO2Zon[1], reaZonCor.CO2Zon_in) annotation (Line(
      points={{67.8,-44.04},{90,-44.04},{90,116.545},{98,116.545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[2], reaZonSou.CO2Zon_in) annotation (Line(
      points={{67.8,-44.32},{78,-44.32},{78,-44},{90,-44},{90,52},{98,52},{98,
          52.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[3], reaZonEas.CO2Zon_in) annotation (Line(
      points={{67.8,-44.6},{90,-44.6},{90,-12},{98,-12},{98,-11.4545}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[4], reaZonNor.CO2Zon_in) annotation (Line(
      points={{67.8,-44.88},{134,-44.88},{134,84.5455},{138,84.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.CO2Zon[5], reaZonWes.CO2Zon_in) annotation (Line(
      points={{67.8,-45.16},{134,-45.16},{134,22},{138,22},{138,22.5455}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHUSupAir,reaAHU. CO2_AHUSup_in) annotation (Line(
      points={{-48.6,11.9571},{22,11.9571},{22,18},{26,18}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHUFreAir,reaAHU. CO2_AHUFre_in) annotation (Line(
      points={{-48.6,8.8},{20,8.8},{20,14.5714},{26,14.5714}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.CO2_AHURetAir,reaAHU. CO2_AHURet_in) annotation (Line(
      points={{-48.6,7.31429},{18,7.31429},{18,11.1429},{26,11.1429}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(weaBus, fivZonVAV.weaBus) annotation (Line(
      points={{0,-100},{0,-18},{47.64,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, duaFanAirHanUni.TOut) annotation (Line(
      points={{0,-100},{0,-60},{-100,-60},{-100,6.38571},{-79.4,6.38571}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(duaFanAirHanUni.phiSupAir,reaAHU. phiAHUSup_in) annotation (Line(
      points={{-48.6,13.0714},{18,13.0714},{18,7.71429},{26,7.71429}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUni.phiRetAir,reaAHU. phiAHURet_in) annotation (Line(
      points={{-48.6,10.4714},{16,10.4714},{16,4.05714},{26,4.05714}},
      color={0,0,127},
      pattern=LinePattern.Dash));
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
<p>This is the floor model with the thermal zones and airside HVAC system. The represented floor has five zones, with four perimeter zones and one core zone. Each perimeter zone has a window-to-wall ratio of about 0.38. The height of each zone is 2.74 m and the areas are as follows:</p>
<ul>
<li>North and South: 313.42 m<sup>2</sup></li>
<li>East and West: 201.98 m<sup>2</sup></li>
<li>Core: 2532.32 m<sup>2</sup></li>
</ul>
<p>The geometry of the floor is shown as the following figure:</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/Zones.png\" width=\"400\"/></p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit\">
MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.AirHandlingUnit.DuaFanAirHanUnit </a>for a description of the AHU.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV\">
MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.FiveZoneVAV</a> for a description of the five-zone models with VAV terminals.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.Control.ZonCon\">
MultizoneOfficeComplexAir.BaseClasses.Component.AirSide.ZoneTerminal.Control.ZonCon</a> for a description of the zone terminal VAV controller. </p>
</html>", revisions="<html>
<ul>
<li>August 17, 2023, by Xing Lu, Sen Huang: </li>
<p>First implementation.</p>
</ul>
</html>"));
end Floor;
