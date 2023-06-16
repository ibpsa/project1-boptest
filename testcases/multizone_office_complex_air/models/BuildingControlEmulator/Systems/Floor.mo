within BuildingControlEmulator.Systems;
model Floor

  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";

  replaceable package MediumHeaWat = Modelica.Media.Interfaces.PartialMedium "Medium for the heating water";

  replaceable package MediumCooWat = Modelica.Media.Interfaces.PartialMedium "Medium for the cooling water";

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

  Subsystems.AirHanUnit.BaseClasses.DuaFanAirHanUnit duaFanAirHanUnit(numTemp=5,
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumCooWat,
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
    PreDroWat=PreDroCooWat,
    Coi_k=1,
    Coi_Ti=60,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    mWatFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)*(30 - 12.88)/4.2/6,
    mFreAirFloRat=(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)*0.3,
    UA=-(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)*(
        1000*17)/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        273.15 + 6,
        273.15 + 12,
        273.15 + 30,
        273.15 + 12.88),
    Fan_k=0.01)
    annotation (Placement(transformation(extent={{-68,14},{-40,-12}})));
  Subsystems.HydDisturbution.FivZonVAV fivZonVAV(
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
    eps5=eps5) annotation (Placement(transformation(extent={{18,-2},{72,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_CooWat(redeclare package Medium =
        MediumCooWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_CooWat(redeclare package Medium =
        MediumCooWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-46,-110},{-26,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_HeaWat(redeclare package Medium =
        MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{24,-110},{44,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_HeaWat(redeclare package Medium =
        MediumHeaWat)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{46,-110},{66,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=5)
    annotation (Placement(transformation(extent={{-56,-96},{-42,-84}})));
  Modelica.Blocks.Interfaces.BooleanInput OnFan
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput OnZon
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-120,-100},{-100,-80}}),
        iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput ZonCooTempSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}}),
        iconTransformation(extent={{-120,90},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput DisTemPSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput PreSetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,0},{-100,20}}),
        iconTransformation(extent={{-120,0},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}}),
        iconTransformation(extent={{-120,-20},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5]
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}}),
        iconTransformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[5]
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={10,-110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={10,-110})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput ZonHeaTempSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput TOut
    "Connector of setpoint input signal" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-16,-110}),          iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-110})));
equation
  connect(fivZonVAV.port_a_Air, duaFanAirHanUnit.port_b_Air) annotation (Line(
      points={{18,-35.6},{-10,-35.6},{-10,-22},{-20,-22},{-20,1},{-40,1}},
      color={0,140,72},
      thickness=0.5));
  connect(fivZonVAV.port_b_Air, duaFanAirHanUnit.port_a_Air) annotation (Line(
      points={{18,-11.6},{-20,-11.6},{-20,-68},{-40,-68},{-40,11.4}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUnit.port_b_Wat, port_b_CooWat) annotation (Line(
      points={{-59.6,-12},{-60,-12},{-60,-100}},
      color={0,127,255},
      thickness=1));
  connect(duaFanAirHanUnit.port_a_Wat, port_a_CooWat) annotation (Line(
      points={{-51.2,-12},{-36,-12},{-36,-100}},
      color={0,127,255},
      thickness=1));
  connect(fivZonVAV.port_a_Wat, port_a_HeaWat) annotation (Line(
      points={{34.2,-50},{34,-50},{34,-100}},
      color={255,0,0},
      thickness=1));
  connect(fivZonVAV.port_b_Wat, port_b_HeaWat) annotation (Line(
      points={{55.8,-50},{56,-50},{56,-100}},
      color={255,0,0},
      thickness=1));
  connect(duaFanAirHanUnit.port_Exh_Air, port_Exh_Air) annotation (Line(
      points={{-68.28,1},{-80,1},{-80,-40},{-100,-40}},
      color={0,140,72},
      thickness=0.5));
  connect(duaFanAirHanUnit.port_Fre_Air, port_Fre_Air) annotation (Line(
      points={{-68,-6.8},{-80,-6.8},{-80,40},{-100,40}},
      color={0,140,72},
      thickness=0.5));
  connect(booleanReplicator.y, fivZonVAV.On) annotation (Line(
      points={{-41.3,-90},{-41.3,-92},{0,-92},{0,-26},{15.3,-26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.pre, duaFanAirHanUnit.PreMea) annotation (Line(
      points={{74.7,-16.4},{92,-16.4},{92,-6.8},{-38.6,-6.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon, duaFanAirHanUnit.ZonTemp) annotation (Line(
      points={{74.7,-35.6},{78,-35.6},{78,-16},{82,-16},{82,-62},{-30,-62},{-30,
          8.8},{-38.6,8.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(OnFan, duaFanAirHanUnit.On) annotation (Line(
      points={{-110,-50},{-74,-50},{-74,14},{-69.4,14}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanReplicator.u, OnZon) annotation (Line(
      points={{-57.4,-90},{-72,-90},{-72,-90},{-110,-90}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.DisTemPSetPoi, DisTemPSetPoi) annotation (Line(
      points={{-69.4,3.6},{-94,3.6},{-94,60},{-110,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.PreSetPoi, PreSetPoi) annotation (Line(
      points={{-69.4,8.8},{-98,8.8},{-98,10},{-110,10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.AirFlowRatSetPoi, AirFlowRatSetPoi) annotation (Line(
      points={{15.3,-50},{-2,-50},{-2,-10},{-110,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.yVal, yVal) annotation (Line(
      points={{15.3,-40.4},{-6,-40.4},{-6,-70},{-110,-70}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.Q_flow, Q_flow) annotation (Line(
      points={{15.3,-6.8},{10,-6.8},{10,-110}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fivZonVAV.TZon, TZon) annotation (Line(
      points={{74.7,-35.6},{96,-35.6},{96,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a_CooWat, port_a_CooWat) annotation (Line(points={{-36,-100},{
          -36,-100}},      color={0,127,255}));
  connect(duaFanAirHanUnit.CooTempSetPoi, ZonCooTempSetPoi) annotation (Line(
      points={{-69.4,-4.2},{-78,-4.2},{-78,100},{-110,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ZonHeaTempSetPoi, duaFanAirHanUnit.HeaTempSetPoi) annotation (Line(
      points={{-110,80},{-74,80},{-74,-9.4},{-69.4,-9.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(duaFanAirHanUnit.TOut, TOut) annotation (Line(
      points={{-69.4,11.4},{-78,11.4},{-78,-74},{-16,-74},{-16,-110}},
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
        Line(points={{40,-40},{80,-80}}, color={0,0,127}),
        Text(
          extent={{-154,114},{146,154}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Floor;
