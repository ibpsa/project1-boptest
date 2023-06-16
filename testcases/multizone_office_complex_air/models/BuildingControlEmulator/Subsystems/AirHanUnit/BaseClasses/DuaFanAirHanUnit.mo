within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses;
model DuaFanAirHanUnit

  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat = Modelica.Media.Interfaces.PartialMedium "Medium for the water";
  parameter Real UA "Rated heat exchange coefficients";
  parameter Modelica.Units.SI.MassFlowRate mAirFloRat "mass flow rate for air";
  parameter Modelica.Units.SI.MassFlowRate mWatFloRat
    "mass flow rate for water";
  parameter Modelica.Units.SI.Pressure PreDroCoiAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroMixingBoxAir
    "Pressure drop in the air side";
  parameter Modelica.Units.SI.Pressure PreDroWat
    "Pressure drop in the water side";
  parameter Real Coi_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Coi_Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Efficiency eps(max=1) = 1
    "Heat exchanger effectiveness";

  parameter Modelica.Units.SI.MassFlowRate mFreAirFloRat
    "mass flow rate for fresh air";
  parameter Modelica.Units.SI.Temperature TemEcoHig
    "the highest temeprature when the economizer is on";
  parameter Modelica.Units.SI.Temperature TemEcoLow
    "the lowest temeprature when the economizer is on";
  parameter Real MixingBoxDamMin "the minimum damper postion";
  parameter Real MixingBox_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time MixingBox_Ti(min=Modelica.Constants.small)=
       0.5 "Time constant of Integrator block";

  parameter Real Fan_k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Fan_Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time waitTime(min=0) = 0
    "Wait time before transition fires";
  parameter Real Fan_SpeRat
      "Speed ratio";
  parameter Integer numTemp(min=1) = 1
      "The size of the temeprature vector";
  parameter Real HydEff[:] "Hydraulic efficiency";
  parameter Real MotEff[:] "Motor efficiency";
  parameter Modelica.Units.SI.VolumeFlowRate VolFloCur[:]
    "Volume flow rate curve";
  parameter Modelica.Units.SI.Pressure SupPreCur[:] "Supply Fan Pressure curve";
  parameter Modelica.Units.SI.Pressure RetPreCur[:] "Return Fan Pressure curve";



  Devices.FlowMover.BaseClasses.WithoutMotor retFan(redeclare package Medium = MediumAir,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    TimCon=1,
    PreCur=RetPreCur)                               annotation (Placement(transformation(extent={{-10,-90},{-30,-70}})));

  Devices.FlowMover.VAVSupplyFan supFan(redeclare package Medium = MediumAir,
    TimCon=1,
    k=Fan_k,
    Ti=Fan_Ti,
    waitTime=waitTime,
    SpeRat=Fan_SpeRat,
    numTemp=numTemp,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    PreCur=SupPreCur)                   annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Devices.AirSide.Coil.CooCoil
                       cooCoil(redeclare package MediumAir = MediumAir, redeclare
      package MediumWat =                                                                             MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroAir=PreDroCoiAir,
    PreDroWat=PreDroWat,
    k=Coi_k,
    Ti=Coi_Ti,
    UA=UA*1.2*eps)
    annotation (Placement(transformation(extent={{-2,-2},{-20,18}})));
  Devices.AirSide.MixingBox.MixingBox
                              mixingBox(mTotAirFloRat=mAirFloRat, redeclare
      package Medium =                                                                       MediumAir,
    PreDro=PreDroMixingBoxAir,
    mFreAirFloRat=mFreAirFloRat,
    TemHig=TemEcoHig,
    TemLow=TemEcoLow,
    DamMin=MixingBoxDamMin,
    k=MixingBox_k,
    Ti=MixingBox_Ti)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium = MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium = MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium = MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium = MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
  Modelica.Blocks.Interfaces.RealInput DisTemPSetPoi "Connector of setpoint input signal" annotation (Placement(transformation(extent={{-120,
            -30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput PreSetPoi
    "Connector of setpoint input signal"                                              annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput PreMea "Connector of measurement input signal" annotation (Placement(transformation(extent={{120,50},{100,70}})));
  Modelica.Blocks.Interfaces.RealInput CooTempSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput ZonTemp[numTemp] "Connector of setpoint input signal" annotation (Placement(transformation(extent={{120,-70},{100,-50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemDisAir(redeclare package
      Medium =
        MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=100000)
    annotation (Placement(transformation(extent={{42,66},{62,86}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{60,40},{40,60}})));
  Modelica.Blocks.Interfaces.RealInput HeaTempSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Sources.BooleanExpression
                                         booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-34,-58},{-14,-38}})));
  Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
equation
  connect(cooCoil.port_a_Air, mixingBox.port_Sup) annotation (Line(
      points={{-20,0},{-49.8,0},{-49.8,6}},
      color={0,127,255},
      thickness=1));
  connect(cooCoil.port_b_Air, supFan.port_a) annotation (Line(
      points={{-1.82,0},{28,0}},
      color={0,127,255},
      thickness=1));
  connect(cooCoil.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-2,16},{-2,16},{20,16},{20,100}},
      color={0,127,255},
      thickness=1));
  connect(cooCoil.port_b_Wat, port_b_Wat) annotation (Line(
      points={{-20,16},{-20,16},{-40,16},{-40,100}},
      color={0,127,255},
      thickness=1));
  connect(mixingBox.port_Fre, port_Fre_Air) annotation (Line(
      points={{-70,6},{-70,60},{-100,60}},
      color={0,127,255},
      thickness=1));
  connect(retFan.port_a, port_a_Air) annotation (Line(
      points={{-10,-80},{46,-80},{100,-80}},
      color={0,127,255},
      thickness=1));
  connect(supFan.yRet, retFan.u) annotation (Line(
      points={{49,-8.2},{60,-8.2},{60,-74},{-9,-74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mixingBox.SetPoi, DisTemPSetPoi) annotation (Line(
      points={{-60,-12},{-60,-20},{-110,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCoil.SetPoi, DisTemPSetPoi) annotation (Line(
      points={{-0.2,6},{6,6},{6,-20},{-110,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.Temp, ZonTemp) annotation (Line(
      points={{26,-6},{16,-6},{16,-60},{110,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.PreSetPoi, PreSetPoi) annotation (Line(
      points={{26,2},{12,2},{12,-60},{-110,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_Exh_Air, mixingBox.port_Exh) annotation (Line(
      points={{-102,0},{-80,0},{-80,-6},{-70,-6}},
      color={0,127,255},
      thickness=1));
  connect(mixingBox.port_Ret, retFan.port_b) annotation (Line(
      points={{-50,-5.8},{-40,-5.8},{-40,-80},{-30,-80}},
      color={0,127,255},
      thickness=1));
  connect(port_b_Air, senTemDisAir.port_b) annotation (Line(
      points={{100,0},{92,0}},
      color={0,127,255},
      thickness=1));
  connect(senTemDisAir.port_a, supFan.port_b) annotation (Line(
      points={{72,0},{48,0}},
      color={0,127,255},
      thickness=1));
  connect(PreMea, add.u1) annotation (Line(
      points={{110,60},{86,60},{86,56},{62,56}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression.y, add.u2) annotation (Line(
      points={{63,76},{80,76},{80,44},{62,44}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(add.y, supFan.PreMea) annotation (Line(
      points={{39,50},{32,50},{32,-30},{20,-30},{20,-10},{26,-10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.HeaTempSetPoi, HeaTempSetPoi) annotation (Line(
      points={{26,10},{12,10},{12,80},{-110,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.CooTempSetPoi, CooTempSetPoi) annotation (Line(
      points={{26,-2},{-46,-2},{-46,40},{-110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanExpression.y, cooCoil.On) annotation (Line(points={{-13,-48},{
          8,-48},{8,12},{-0.2,12}}, color={255,0,255}));
  connect(mixingBox.Tout, TOut) annotation (Line(
      points={{-54,-12},{-54,-80},{-110,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(On, mixingBox.On) annotation (Line(points={{-110,-100},{-68,-100},{
          -68,-12}}, color={255,0,255}));
  connect(On, supFan.On) annotation (Line(points={{-110,-100},{16,-100},{16,6},
          {26,6}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{90,-80}}, color={255,170,170},
          thickness=0.5),
        Line(points={{-80,0},{-80,-80}}, color={255,170,170},
          thickness=0.5),
        Line(points={{-92,0},{-80,0}}, color={255,170,170},
          thickness=0.5),
        Line(points={{-90,60},{-60,60}}, color={0,255,255},
          thickness=0.5),
        Line(points={{-60,60},{-60,0}}, color={0,255,255},
          thickness=0.5),
        Line(points={{-60,0},{-70,0}}, color={0,255,255},
          thickness=0.5),
        Line(points={{-80,0},{-70,0}}, color={255,170,170}),
        Line(points={{-40,90},{-40,20}}, color={0,0,255},
          thickness=1),
        Rectangle(
          extent={{-30,28},{12,-10}},
          lineColor={0,255,255},
          lineThickness=0.5,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{20,90},{20,20}}, color={0,0,255},
          thickness=1),
        Rectangle(extent={{-100,100},{100,-100}}, pattern=LinePattern.None),
        Line(points={{20,20},{-40,20}}, color={0,0,255},
          thickness=1),
        Line(points={{-60,0},{100,0}}, color={0,255,255},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DuaFanAirHanUnit;
