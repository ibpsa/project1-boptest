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
    annotation (Placement(transformation(extent={{-10,-68},{-30,-48}})));

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
    annotation (Placement(transformation(extent={{18,12},{38,32}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
               MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,12},{110,32}})));
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
    annotation (Placement(transformation(extent={{-2,20},{-20,40}})));
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
        origin={-60,22})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Wat(redeclare package Medium =
                MediumWat)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,130},{30,150}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Wat(redeclare package Medium =
               MediumWat)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,130},{-30,150}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh_Air(redeclare package Medium =
                MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,12},{-92,32}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Fre_Air(redeclare package Medium =
               MediumAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,72},{-90,92}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
                MediumAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-68},{110,-48}})));
  Modelica.Blocks.Interfaces.BooleanInput onFanOcc
    "Fan On signal during occupied period"
    annotation (Placement(transformation(extent={{-120,-88},{-100,-68}})));
  Modelica.Blocks.Interfaces.RealInput disTSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-8},{-100,12}})));
  Modelica.Blocks.Interfaces.RealInput pSet
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-48},{-100,-28}})));
  Modelica.Blocks.Interfaces.RealInput pMea
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-120,106},{-100,126}})));
  Modelica.Blocks.Interfaces.RealInput cooTSet[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,52},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput zonT[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,-28},{-100,-8}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTDisAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{76,16},{88,28}})));
  Modelica.Blocks.Interfaces.RealInput heaTSet[numTemp]
    "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-120,92},{-100,112}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-34,-38},{-14,-18}})));
  Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
    annotation (Placement(transformation(extent={{-120,-68},{-100,-48}})));
  Modelica.Blocks.Interfaces.RealOutput TSupAir(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU supply air temperature"
    annotation (Placement(transformation(extent={{100,52},{120,72}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTMixAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{-44,12},{-24,32}})));
  Modelica.Blocks.Interfaces.RealOutput TMixAir(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Mixing air temperature"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTRetAir(redeclare package
      Medium = MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{94,-66},{78,-50}})));
  Modelica.Blocks.Interfaces.RealOutput TRetAir "AHU return air temperature"
    annotation (Placement(transformation(extent={{100,-42},{120,-22}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSupAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1) annotation (Placement(transformation(extent={{60,16},{72,28}})));
  Modelica.Blocks.Interfaces.RealOutput V_flowSupAir(
    final min=0,
    final unit = "m3/s",
    final quantity = "VolumeFlowRate") "Supply air volume flow rate"
    annotation (Placement(transformation(extent={{100,28},{120,48}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloRetAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1)
    annotation (Placement(transformation(extent={{46,-66},{30,-50}})));
  Modelica.Blocks.Interfaces.RealOutput V_flowRetAir
    "Return air volume flow rate "
    annotation (Placement(transformation(extent={{100,-54},{120,-34}})));
  Modelica.Blocks.Sources.RealExpression yDamOutAirMea(y=mixingBox.mixBox.valFre.y_actual)
    annotation (Placement(transformation(extent={{40,106},{60,126}})));
  Modelica.Blocks.Interfaces.RealOutput yDamOutAir(
    final min=0,
    final max=1,
    final unit="1")
    "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{100,110},{120,130}}),
        iconTransformation(extent={{100,110},{120,130}})));
  Modelica.Blocks.Sources.RealExpression PFanTot(y=supFan.P + retFan.P)
    annotation (Placement(transformation(extent={{-34,-20},{-14,0}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Total fan power"
    annotation (Placement(transformation(extent={{100,-16},{120,4}})));
  Modelica.Blocks.Interfaces.RealOutput TSupCHW(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU supply chilled water temperature"
    annotation (Placement(transformation(extent={{100,92},{120,112}})));
  Modelica.Blocks.Interfaces.RealOutput TRetCHW(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "AHU return chilled water temperature"
    annotation (Placement(transformation(extent={{100,-2},{120,18}})));
  Modelica.Blocks.Sources.RealExpression TSupCHWMea(y=cooCoi.coi.TEntWat.T)
    annotation (Placement(transformation(extent={{72,92},{92,112}})));
  Modelica.Blocks.Sources.RealExpression TRetCHWMea(y=cooCoi.coi.TLeaWat.T)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Sources.RealExpression yCooValMea(y=cooCoi.val.y_actual)
    annotation (Placement(transformation(extent={{70,-28},{90,-8}})));
  Modelica.Blocks.Interfaces.RealOutput yCooVal
    "AHU cooling coil valve position measurement" annotation (Placement(
        transformation(extent={{100,-28},{120,-8}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senVolFloOutAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=mAirFloRat,
    tau=1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-80,50})));
  Modelica.Blocks.Interfaces.RealOutput V_flowOutAir(
    final min=0,
    final unit="m3/s",
    final quantity="VolumeFlowRate") "Outdoor air volume flow rate"
    annotation (Placement(transformation(extent={{100,72},{120,92}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSpeRetFan(
      description="AHU return fan speed control signal", u(
      min=0,
      max=1,
      unit="1"))
    annotation (Placement(transformation(extent={{48,-34},{64,-18}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2RetAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU return air"
    annotation (Placement(transformation(extent={{24,-50},{8,-66}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-84},{36,-72}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-84},{72,-72}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHURetAir
    "AHU return air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-78},{120,-58}}),  iconTransformation(
          extent={{100,-78},{120,-58}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2FreAir(redeclare package
      Medium =         MediumAir,
    allowFlowReversal=false,      m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU fresh air" annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=90,
        origin={-80,72})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra1(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-104},{36,-92}})));
  Modelica.Blocks.Math.Gain gaiPPM1(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-104},{72,-92}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHUFreAir
    "AHU fresh air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-94},{120,-74}}),
        iconTransformation(extent={{100,-94},{120,-74}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra2(each
      MMMea=Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{24,-122},{36,-110}})));
  Modelica.Blocks.Math.Gain gaiPPM2(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{60,-122},{72,-110}})));
  Modelica.Blocks.Interfaces.RealOutput CO2_AHUSupAir
    "AHU supply air CO2 volume fraction PPM" annotation (Placement(
        transformation(extent={{100,-108},{120,-88}}),
        iconTransformation(extent={{100,-128},{120,-108}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort senCO2SupAir(redeclare package
      Medium =         MediumAir, m_flow_nominal=mAirFloRat,
    C_start=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Sensor at AHU supply air" annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={50,22})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHumRetAir(redeclare
      package Medium = MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{52,-66},{68,-50}})));
  Modelica.Blocks.Interfaces.RealOutput phiRetAir(final unit="1", min=0)
    "Relative humidity in return air" annotation (Placement(transformation(
          extent={{100,-112},{120,-92}}),  iconTransformation(extent={{100,-112},
            {120,-92}})));
  Modelica.Blocks.Interfaces.RealOutput phiSupAir(final unit="1", min=0)
    "Relative humidity in supply air" annotation (Placement(transformation(
          extent={{100,-140},{120,-120}}), iconTransformation(extent={{100,-140},
            {120,-120}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHumSupAir(redeclare
      package Medium = MediumAir, m_flow_nominal=mAirFloRat)
    annotation (Placement(transformation(extent={{56,34},{66,44}})));
equation
  connect(cooCoi.port_b_Air, supFan.port_a) annotation (Line(
      points={{-1.82,22},{18,22}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.TMix, disTSet) annotation (Line(points={{-60,10},{-60,2},{
          -110,2}},    color={0,0,127}));
  connect(cooCoi.SetPoi, disTSet) annotation (Line(points={{-0.2,28},{6,28},{6,
          2},{-110,2}},           color={0,0,127}));
  connect(supFan.T, zonT) annotation (Line(points={{16,16},{16,-18},{-110,-18}},
                 color={0,0,127}));
  connect(supFan.pSet, pSet) annotation (Line(points={{16,24},{12,24},{12,-38},
          {-110,-38}},      color={0,0,127}));
  connect(port_Exh_Air, mixingBox.port_Exh) annotation (Line(
      points={{-102,22},{-82,22},{-82,16},{-70,16}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.port_Ret, retFan.port_b) annotation (Line(
      points={{-50,16.2},{-42,16.2},{-42,-58},{-30,-58}},
      color={0,140,72},
      thickness=0.5));
  connect(port_b_Air, senTDisAir.port_b) annotation (Line(
      points={{100,22},{88,22}},
      color={0,127,255},
      thickness=1));
  connect(supFan.heaTSet, heaTSet) annotation (Line(points={{16,32},{12,32},{12,
          102},{-110,102}},       color={0,0,127}));
  connect(supFan.cooTSet, cooTSet) annotation (Line(points={{16,20},{-46,20},{
          -46,62},{-110,62}},      color={0,0,127}));
  connect(booleanExpression.y, cooCoi.On) annotation (Line(points={{-13,-28},{8,
          -28},{8,34},{-0.2,34}},         color={255,0,255}));
  connect(mixingBox.TOut, TOut) annotation (Line(points={{-54,10},{-54,-58},{
          -110,-58}},
                 color={0,0,127}));
  connect(onFanOcc, mixingBox.On) annotation (Line(points={{-110,-78},{-68,-78},
          {-68,10}},  color={255,0,255}));
  connect(onFanOcc, supFan.onFanOcc) annotation (Line(points={{-110,-78},{4,-78},
          {4,28},{16,28}},
                         color={255,0,255}));
  connect(senTDisAir.T, TSupAir) annotation (Line(points={{82,28.6},{82,62},{
          110,62}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTMixAir.port_b, cooCoi.port_a_Air) annotation (Line(
      points={{-24,22},{-20,22}},
      color={0,140,72},
      thickness=0.5));
  connect(mixingBox.port_Sup, senTMixAir.port_a) annotation (Line(
      points={{-49.8,28},{-48,28},{-48,22},{-44,22}},
      color={0,140,72},
      thickness=0.5));
  connect(senTMixAir.T, TMixAir) annotation (Line(points={{-34,33},{-34,50},{
          110,50}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTRetAir.T, TRetAir) annotation (Line(points={{86,-49.2},{86,-32},{
          110,-32}},  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloSupAir.port_b, senTDisAir.port_a)
    annotation (Line(points={{72,22},{76,22}},
                                             color={0,127,255}));
  connect(senVolFloSupAir.V_flow, V_flowSupAir) annotation (Line(points={{66,28.6},
          {66,38},{110,38}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloRetAir.V_flow, V_flowRetAir) annotation (Line(points={{38,
          -49.2},{38,-44},{110,-44}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(yDamOutAirMea.y, yDamOutAir)
    annotation (Line(points={{61,116},{86,116},{86,120},{110,120}},
                                                color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PFanTot.y, PFan) annotation (Line(points={{-13,-10},{-8,-10},{-8,-6},
          {110,-6}},  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cooCoi.port_a_Wat, port_a_Wat) annotation (Line(
      points={{-2,38},{20,38},{20,140}},
      color={0,127,255},
      thickness=1));
  connect(cooCoi.port_b_Wat, port_b_Wat) annotation (Line(
      points={{-20,38},{-40,38},{-40,140}},
      color={0,127,255},
      thickness=1));
  connect(TSupCHWMea.y, TSupCHW)
    annotation (Line(points={{93,102},{110,102}},
                                                color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRetCHWMea.y, TRetCHW)
    annotation (Line(points={{91,0},{96,0},{96,8},{110,8}},
                                                  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(yCooValMea.y, yCooVal)
    annotation (Line(points={{91,-18},{110,-18}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senVolFloOutAir.port_b, mixingBox.port_Fre)
    annotation (Line(points={{-80,42},{-80,28},{-70,28}},
                                                        color={0,127,255}));
  connect(senVolFloOutAir.V_flow, V_flowOutAir) annotation (Line(points={{-71.2,
          50},{80,50},{80,82},{110,82}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.yRet, oveSpeRetFan.u) annotation (Line(points={{39,13.8},{42,
          13.8},{42,-26},{46.4,-26}},           color={0,0,127}));
  connect(oveSpeRetFan.y, retFan.u) annotation (Line(points={{64.8,-26},{70,-26},
          {70,-52},{-9,-52}},          color={0,0,127}));
  connect(senCO2RetAir.C, conMasVolFra.m) annotation (Line(
      points={{16,-66.8},{16,-78},{23.4,-78}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conMasVolFra.V,gaiPPM. u)
    annotation (Line(points={{36.6,-78},{58.8,-78}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gaiPPM.y, CO2_AHURetAir)
    annotation (Line(points={{72.6,-78},{78,-78},{78,-68},{110,-68}},
                                                      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(port_a_Air, senTRetAir.port_a)
    annotation (Line(points={{100,-58},{94,-58}}, color={0,127,255}));
  connect(senVolFloRetAir.port_b, senCO2RetAir.port_a)
    annotation (Line(points={{30,-58},{24,-58}}, color={0,127,255}));
  connect(senCO2RetAir.port_b, retFan.port_a)
    annotation (Line(points={{8,-58},{-10,-58}}, color={0,127,255}));
  connect(port_Fre_Air, senCO2FreAir.port_a) annotation (Line(points={{-100,82},
          {-80,82},{-80,80}},          color={0,127,255}));
  connect(senCO2FreAir.port_b, senVolFloOutAir.port_a)
    annotation (Line(points={{-80,64},{-80,58}}, color={0,127,255}));
  connect(conMasVolFra1.V, gaiPPM1.u)
    annotation (Line(points={{36.6,-98},{58.8,-98}},   color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gaiPPM1.y, CO2_AHUFreAir)
    annotation (Line(points={{72.6,-98},{90,-98},{90,-84},{110,-84}},
                                                      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conMasVolFra2.V, gaiPPM2.u)
    annotation (Line(points={{36.6,-116},{58.8,-116}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gaiPPM2.y, CO2_AHUSupAir)
    annotation (Line(points={{72.6,-116},{94,-116},{94,-98},{110,-98}},
                                                      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2FreAir.C, conMasVolFra1.m) annotation (Line(
      points={{-71.2,72},{-46,72},{-46,-98},{23.4,-98}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(supFan.port_b, senCO2SupAir.port_a)
    annotation (Line(points={{38,22},{44,22}},
                                             color={0,127,255}));
  connect(senCO2SupAir.C, conMasVolFra2.m) annotation (Line(
      points={{50,28.6},{50,46},{-46,46},{-46,-116},{23.4,-116}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senRelHumRetAir.port_b, senTRetAir.port_b)
    annotation (Line(points={{68,-58},{78,-58}}, color={0,127,255}));
  connect(senRelHumRetAir.port_a, senVolFloRetAir.port_a)
    annotation (Line(points={{52,-58},{46,-58}}, color={0,127,255}));
  connect(senRelHumRetAir.phi, phiRetAir) annotation (Line(
      points={{60.08,-49.2},{60.08,-42},{86,-42},{86,-102},{110,-102}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2SupAir.port_b, senRelHumSupAir.port_a)
    annotation (Line(points={{56,22},{56,39}},color={0,127,255}));
  connect(senRelHumSupAir.port_b, senVolFloSupAir.port_a)
    annotation (Line(points={{66,39},{66,22},{60,22}},
                                                     color={0,127,255}));
  connect(senRelHumSupAir.phi, phiSupAir) annotation (Line(
      points={{61.05,44.5},{61.05,56},{82,56},{82,-130},{110,-130}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pMea, supFan.pMea) annotation (Line(points={{-110,116},{10,116},{10,
          12},{16,12}},
                     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{100,140}}),                                  graphics={
        Rectangle(
          extent={{-100,140},{102,-140}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-56},{90,-56}}, color={255,170,170},
          thickness=0.5),
        Line(points={{-80,24},{-80,-56}},color={255,170,170},
          thickness=0.5),
        Line(points={{-92,24},{-80,24}},
                                       color={255,170,170},
          thickness=0.5),
        Line(points={{-90,84},{-60,84}}, color={0,255,255},
          thickness=0.5),
        Line(points={{-60,84},{-60,24}},color={0,255,255},
          thickness=0.5),
        Line(points={{-60,24},{-70,24}},
                                       color={0,255,255},
          thickness=0.5),
        Line(points={{-80,24},{-70,24}},
                                       color={255,170,170}),
        Line(points={{-40,134},{-40,44}},color={0,0,255},
          thickness=1),
        Rectangle(
          extent={{-30,52},{12,14}},
          lineColor={0,255,255},
          lineThickness=0.5,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{20,132},{20,44}},color={0,0,255},
          thickness=1),
        Rectangle(extent={{-100,100},{100,-100}}, pattern=LinePattern.None),
        Line(points={{20,44},{-40,44}}, color={0,0,255},
          thickness=1),
        Line(points={{-60,24},{100,24}},
                                       color={0,255,255},
          thickness=0.5),
        Text(
          extent={{-156,-148},{144,-108}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{100,
            140}}),                                  graphics={
        Text(
          extent={{-150,154},{150,194}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>There are two fans (i.e., one supply fan, and one return fan) in the AHU system. Note that there is no heating coil in the AHU system level.</p>
<p><img src=\"modelica://MultiZoneOfficeComplexAir/../../doc/images/AHUControl.png\" width=\"600\"/></p>
<p>Supply fan speed is controlled by a PI controller to maintain duct static pressure (DSP) at setpoint when the fan is proven ON. Cooling coil valve position is controlled by a PI controller to maintain the AHU supply air temperature at setpoint.</p>
<p>In the mixing box of the AHU, an economizer is implemented to use the outdoor air to meet the cooling load when outdoor conditions are favorable. Outdoor air damper position is controlled by a PI controller to maintain the mixed air temperature at setpoint. It takes the mixed and outdoor air temperature measurements, as well as the mixed air temperature setpoints as inputs. It takes the outdoor air damper position as the output. The return air damper are interlocked with the outdoor air damper while exhausted air damper share the same opening position with the outdoor air damper. On top of that, an economizer control based on the fixed dry-bulb outdoor air temperature-based is adopted. The economizer higher temperature limit is set as 21 degC according to ASHRAE 90.1-2019 for Climate Zone 5A.</p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.VAVSupFan</a> for a description of the supply fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.BaseClasses.WithoutMotor</a> for a description of the return fan model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.Coil.CoolingCoil</a> for a description of the cooling coil model. </p>
<p>See the model <a href=\"modelica://MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl\">MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.MixingBox.MixingBoxWithControl</a> for a description of the mixing box model. </p>
</html>", revisions="<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang:
<p> First implementation.</p>
</ul>
</html>"));
end DuaFanAirHanUnit;
