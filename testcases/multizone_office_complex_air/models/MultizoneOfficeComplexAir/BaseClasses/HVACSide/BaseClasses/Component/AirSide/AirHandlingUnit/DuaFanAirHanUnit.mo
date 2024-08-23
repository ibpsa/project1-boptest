within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.AirHandlingUnit;
model DuaFanAirHanUnit "AHU with supply/return fans and cooling coil."

  replaceable package MediumAir =
      Modelica.Media.Interfaces.PartialMedium "Medium for the air";
  replaceable package MediumWat =
      Modelica.Media.Interfaces.PartialMedium "Medium for the water";
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

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor
    retFan(
    redeclare package Medium = MediumAir,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    TimCon=1,
    PreCur=RetPreCur,
    varSpeFloMov(use_inputFilter=true))
    annotation (Placement(transformation(extent={{-10,-90},{-30,-70}})));

  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan
    supFan(
    redeclare package Medium = MediumAir,
    TimCon=1,
    k=Fan_k,
    Ti=Fan_Ti,
    waitTime=waitTime,
    SpeRat=Fan_SpeRat,
    numTemp=numTemp,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    PreCur=SupPreCur,
    withoutMotor(varSpeFloMov(use_inputFilter=true)))
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
               MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil
    cooCoi(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumWat,
    mAirFloRat=mAirFloRat,
    mWatFloRat=mWatFloRat,
    PreDroAir=PreDroCoiAir,
    PreDroWat=PreDroWat,
    k=Coi_k,
    Ti=Coi_Ti,
    UA=UA*1.2*eps)
    annotation (Placement(transformation(extent={{-2,-2},{-20,18}})));
  MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl
    mixingBox(
    mTotAirFloRat=mAirFloRat,
    redeclare package Medium = MediumAir,
    PreDro=PreDroMixingBoxAir,
    mFreAirFloRat=mFreAirFloRat,
    TemHig=TemEcoHig,
    TemLow=TemEcoLow,
    DamMin=MixingBoxDamMin,
    k=MixingBox_k,
    Ti=MixingBox_Ti) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
                MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
               MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium =
                MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium =
               MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
                MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput onFanOcc
    "Fan On signal during occupied period"
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
  Modelica.Blocks.Interfaces.RealInput disTSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput pSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput pMea
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-120,84},{-100,104}})));
  Modelica.Blocks.Interfaces.RealInput cooTSet[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput zonT[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTDisAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{76,-6},{88,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=100000)
    annotation (Placement(transformation(extent={{40,66},{60,86}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{50,40},{30,60}})));
  Modelica.Blocks.Interfaces.RealInput heaTSet[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-34,-60},{-14,-40}})));
  Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput TSupAir(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU supply air temperature"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTMixAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Modelica.Blocks.Interfaces.RealOutput TMixAir(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Mixing air temperature"
    annotation (Placement(transformation(extent={{100,18},{120,38}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTRetAir(redeclare package
      Medium = MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{86,-88},{70,-72}})));
  Modelica.Blocks.Interfaces.RealOutput TRetAir "AHU return air temperature"
    annotation (Placement(transformation(extent={{100,-64},{120,-44}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSupAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1) annotation (Placement(transformation(extent={{60,-6},{72,6}})));
  Modelica.Blocks.Interfaces.RealOutput V_flowSupAir(
    final min=0,
    final unit = "m3/s",
    final quantity = "VolumeFlowRate") "Supply air volume flow rate"
    annotation (Placement(transformation(extent={{100,6},{120,26}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloRetAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1)
    annotation (Placement(transformation(extent={{54,-88},{38,-72}})));
  Modelica.Blocks.Interfaces.RealOutput V_flowRetAir
    "Return air volume flow rate "
    annotation (Placement(transformation(extent={{100,-76},{120,-56}})));
  Modelica.Blocks.Sources.RealExpression yDamOutAirMea(y=mixingBox.mixBox.valFre.y)
    annotation (Placement(transformation(extent={{40,84},{60,104}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOutAir(
    final min=0,
    final max=1,
    final unit="1")
    "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{100,84},{120,104}})));
  Modelica.Blocks.Sources.RealExpression PFanTot(y=supFan.P + retFan.P)
    annotation (Placement(transformation(extent={{-34,-42},{-14,-22}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Total fan power"
    annotation (Placement(transformation(extent={{100,-38},{120,-18}})));
  Modelica.Blocks.Interfaces.RealOutput TSupCHW(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU supply chilled water temperature"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput TRetCHW(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU return chilled water temperature"
    annotation (Placement(transformation(extent={{100,-24},{120,-4}})));
  Modelica.Blocks.Sources.RealExpression TSupCHWMea(y=cooCoi.coi.TEntWat.T)
    annotation (Placement(transformation(extent={{72,70},{92,90}})));
  Modelica.Blocks.Sources.RealExpression TRetCHWMea(y=cooCoi.coi.TLeaWat.T)
    annotation (Placement(transformation(extent={{70,-32},{90,-12}})));
  Modelica.Blocks.Sources.RealExpression yCooValMea(y=cooCoi.val.y)
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Modelica.Blocks.Interfaces.RealOutput yCooVal
    "AHU cooling coil valve position measurement" annotation (Placement(
        transformation(extent={{100,-50},{120,-30}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOutAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-80,28})));
  Modelica.Blocks.Interfaces.RealOutput V_flowOutAir(
    final min=0,
    final unit="m3/s",
    final quantity="VolumeFlowRate") "Outdoor air volume flow rate"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeRetFan(
      description="AHU return fan speed control signal", u(
      min=0,
      max=1,
      unit="1"))
    annotation (Placement(transformation(extent={{48,-56},{64,-40}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2RetAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU return air"
    annotation (Placement(transformation(extent={{24,-72},{8,-88}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-106},{36,-94}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-106},{72,-94}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHURetAir
    "AHU return air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-110},{120,-90}}), iconTransformation(
          extent={{100,-110},{120,-90}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2FreAir(redeclare package
      Medium =         MediumAir,
    allowFlowReversal=false,      m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU fresh air" annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=90,
        origin={-80,50})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra1(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-126},{36,-114}})));
  Modelica.Blocks.Math.Gain gaiPPM1(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-126},{72,-114}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHUFreAir
    "AHU fresh air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-130},{120,-110}}),
        iconTransformation(extent={{100,-120},{120,-100}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra2(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-144},{36,-132}})));
  Modelica.Blocks.Math.Gain gaiPPM2(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-144},{72,-132}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHUSupAir
    "AHU supply air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-148},{120,-128}}),
        iconTransformation(extent={{100,-132},{120,-112}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2SupAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU supply air" annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={50,0})));
equation
  connect(cooCoi.port_b_Air, supFan.port_a) annotation (Line(
      points={{-1.82,0},{18,0}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.TMix, disTSet) annotation (Line(points={{-60,-12},{-60,-20},
          {-110,-20}}, color={0,0,127}));
  connect(cooCoi.SetPoi, disTSet) annotation (Line(points={{-0.2,6},{6,
          6},{6,-20},{-110,-20}}, color={0,0,127}));
  connect(supFan.T, zonT) annotation (Line(points={{16,-6},{16,-40},{-110,
          -40}}, color={0,0,127}));
  connect(supFan.pSet, pSet) annotation (Line(points={{16,2},{12,2},{12,
          -60},{-110,-60}}, color={0,0,127}));
  connect(port_Exh_Air, mixingBox.port_Exh) annotation (Line(
      points={{-102,0},{-82,0},{-82,-6},{-70,-6}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.port_Ret, retFan.port_b) annotation (Line(
      points={{-50,-5.8},{-42,-5.8},{-42,-80},{-30,-80}},
      color={0,140,72},
      thickness=0.5));
  connect(port_b_Air, senTDisAir.port_b) annotation (Line(
      points={{100,0},{88,0}},
      color={0,127,255},
      thickness=1));
  connect(pMea, add.u1) annotation (Line(points={{-110,94},{-20,94},{-20,
          68},{60,68},{60,56},{52,56}}, color={0,0,127}));
  connect(realExpression.y, add.u2) annotation (Line(
      points={{61,76},{68,76},{68,44},{52,44}},
      color={0,0,127}));
  connect(add.y, supFan.pMea) annotation (Line(points={{29,50},{10,50},
          {10,-10},{16,-10}}, color={0,0,127}));
  connect(supFan.heaTSet, heaTSet) annotation (Line(points={{16,10},{12,
          10},{12,80},{-110,80}}, color={0,0,127}));
  connect(supFan.cooTSet, cooTSet) annotation (Line(points={{16,-2},{-46,
          -2},{-46,40},{-110,40}}, color={0,0,127}));
  connect(booleanExpression.y, cooCoi.On) annotation (Line(points={{-13,-50},
          {8,-50},{8,12},{-0.2,12}},      color={255,0,255}));
  connect(mixingBox.TOut, TOut) annotation (Line(points={{-54,-12},{-54,-80},{-110,
          -80}}, color={0,0,127}));
  connect(onFanOcc, mixingBox.On) annotation (Line(points={{-110,-100},{-68,-100},
          {-68,-12}}, color={255,0,255}));
  connect(onFanOcc, supFan.onFanOcc) annotation (Line(points={{-110,-100},{4,-100},
          {4,6},{16,6}}, color={255,0,255}));
  connect(senTDisAir.T, TSupAir) annotation (Line(points={{82,6.6},{82,40},
          {110,40}},     color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTMixAir.port_b, cooCoi.port_a_Air) annotation (Line(
      points={{-24,0},{-20,0}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.port_Sup, senTMixAir.port_a) annotation (Line(
      points={{-49.8,6},{-48,6},{-48,0},{-44,0}},
      color={0,140,72},
      thickness=0.5));
  connect(senTMixAir.T, TMixAir) annotation (Line(points={{-34,11},{-34,
          28},{110,28}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTRetAir.T, TRetAir) annotation (Line(points={{78,-71.2},{78,
          -54},{110,-54}},
                      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloSupAir.port_b, senTDisAir.port_a)
    annotation (Line(points={{72,0},{76,0}}, color={0,127,255}));
  connect(senVolFloSupAir.V_flow, V_flowSupAir) annotation (Line(points={{66,6.6},
          {66,16},{110,16}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloRetAir.V_flow, V_flowRetAir) annotation (Line(points={{46,
          -71.2},{46,-66},{110,-66}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(yDamOutAirMea.y, yDamOutAir)
    annotation (Line(points={{61,94},{110,94}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PFanTot.y, PFan) annotation (Line(points={{-13,-32},{-8,-32},{
          -8,-28},{110,-28}},
                      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCoi.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-2,16},{20,16},{20,100}},
      color={0,127,255},
      thickness=1));
  connect(cooCoi.port_b_Wat, port_b_Wat) annotation (Line(
      points={{-20,16},{-40,16},{-40,100}},
      color={0,127,255},
      thickness=1));
  connect(TSupCHWMea.y, TSupCHW)
    annotation (Line(points={{93,80},{110,80}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRetCHWMea.y, TRetCHW)
    annotation (Line(points={{91,-22},{96,-22},{96,-14},{110,-14}},
                                                  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(yCooValMea.y, yCooVal)
    annotation (Line(points={{91,-40},{110,-40}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloOutAir.port_b, mixingBox.port_Fre)
    annotation (Line(points={{-80,20},{-80,6},{-70,6}}, color={0,127,255}));
  connect(senVolFloOutAir.V_flow, V_flowOutAir) annotation (Line(points={{-71.2,
          28},{80,28},{80,60},{110,60}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.yRet, oveSpeRetFan.u) annotation (Line(points={{39,
          -8.2},{42,-8.2},{42,-48},{46.4,-48}}, color={0,0,127}));
  connect(oveSpeRetFan.y, retFan.u) annotation (Line(points={{64.8,-48},{
          70,-48},{70,-74},{-9,-74}},  color={0,0,127}));
  connect(senCO2RetAir.C, conMasVolFra.m) annotation (Line(
      points={{16,-88.8},{16,-100},{23.4,-100}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conMasVolFra.V,gaiPPM. u)
    annotation (Line(points={{36.6,-100},{58.8,-100}}, color={0,0,127}));
  connect(gaiPPM.y, CO2_AHURetAir)
    annotation (Line(points={{72.6,-100},{110,-100}}, color={0,0,127}));
  connect(port_a_Air, senTRetAir.port_a)
    annotation (Line(points={{100,-80},{86,-80}}, color={0,127,255}));
  connect(senTRetAir.port_b, senVolFloRetAir.port_a)
    annotation (Line(points={{70,-80},{54,-80}}, color={0,127,255}));
  connect(senVolFloRetAir.port_b, senCO2RetAir.port_a)
    annotation (Line(points={{38,-80},{24,-80}}, color={0,127,255}));
  connect(senCO2RetAir.port_b, retFan.port_a)
    annotation (Line(points={{8,-80},{-10,-80}}, color={0,127,255}));
  connect(port_Fre_Air, senCO2FreAir.port_a) annotation (Line(points={{
          -100,60},{-80,60},{-80,58}}, color={0,127,255}));
  connect(senCO2FreAir.port_b, senVolFloOutAir.port_a)
    annotation (Line(points={{-80,42},{-80,36}}, color={0,127,255}));
  connect(conMasVolFra1.V, gaiPPM1.u)
    annotation (Line(points={{36.6,-120},{58.8,-120}}, color={0,0,127}));
  connect(gaiPPM1.y, CO2_AHUFreAir)
    annotation (Line(points={{72.6,-120},{110,-120}}, color={0,0,127}));
  connect(conMasVolFra2.V, gaiPPM2.u)
    annotation (Line(points={{36.6,-138},{58.8,-138}}, color={0,0,127}));
  connect(gaiPPM2.y, CO2_AHUSupAir)
    annotation (Line(points={{72.6,-138},{110,-138}}, color={0,0,127}));
  connect(senCO2FreAir.C, conMasVolFra1.m) annotation (Line(
      points={{-71.2,50},{-46,50},{-46,-120},{23.4,-120}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.port_b, senCO2SupAir.port_a)
    annotation (Line(points={{38,0},{44,0}}, color={0,127,255}));
  connect(senCO2SupAir.port_b, senVolFloSupAir.port_a)
    annotation (Line(points={{56,0},{60,0}}, color={0,127,255}));
  connect(senCO2SupAir.C, conMasVolFra2.m) annotation (Line(
      points={{50,6.6},{50,24},{-46,24},{-46,-138},{23.4,-138}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-120},{100,100}}),                             graphics={
        Rectangle(
          extent={{-100,100},{100,-120}},
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
          thickness=0.5),
        Text(
          extent={{-156,-148},{144,-108}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{
            100,100}}),                              graphics={
        Text(
          extent={{-146,300},{154,340}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>There are two fans (i.e., one supply fan, and one return fan) in the AHU system. Only a cooling coil is installed in the AHU.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/AHUControl.png\"/></p>
<p>Supply fan speed is controlled by a PI controller to maintain duct static pressure (DSP) at setpoint when the fan is proven ON. 
Cooling coil valve position is controlled by a PI controller to maintain the AHU supply air temperature at setpoint.</p>
<p>In the mixing box of the AHU, an economizer is implemented to use the outdoor air to meet the cooling load when outdoor conditions are favorable. 
Outdoor air damper position is controlled by a PI controller to maintain the mixed air temperature at setpoint. It takes the mixed and outdoor air temperature measurements, as well as the mixed air temperature setpoints as inputs. It takes the outdoor air damper position as the output. The return air damper are interlocked with the outdoor air damper while exhausted air damper share the same opening position with the outdoor air damper. On top of that, an economizer control based on the fixed dry-bulb outdoor air temperature-based is adopted. The economizer higher temperature limit is set as 21 degC according to ASHRAE 90.1-2019 for Climate Zone 5A.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan</a> for a description of the supply fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor</a> for a description of the return fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil</a> for a description of the cooling coil model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl\">
MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl</a> for a description of the mixing box model. </p>
</html>", revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
end DuaFanAirHanUnit;
