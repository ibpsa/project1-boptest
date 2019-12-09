within BESTESTAir.BaseClasses;
model FanCoilUnit "Four-pipe fan coil unit model"
  package Medium1 = Buildings.Media.Air;
  package Medium2 = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal=0.55 "Nominal air flowrate" annotation (Dialog(group="Air"));
  parameter Modelica.SIunits.DimensionlessRatio minSpe=0.2 "Minimum fan speed" annotation (Dialog(group="Air"));
  parameter Modelica.SIunits.Power QCooCap=3666 "Cooling coil capacity" annotation (Dialog(group="Coils"));
  parameter Modelica.SIunits.Power QHeaCap=7000 "Heating coil capacity" annotation (Dialog(group="Coils"));
  parameter Modelica.SIunits.DimensionlessRatio COP = 3 "Assumed COP of chiller supplying chilled water to FCU in [W_thermal/W_electric]" annotation (Dialog(group="Plant"));
  parameter Modelica.SIunits.DimensionlessRatio eff = 0.9 "Assumed efficiency of gas boiler supplying hot water to FCU in [W_gas/W_thermal]" annotation (Dialog(group="Plant"));
  final parameter Modelica.SIunits.Pressure dpAir_nominal=185 "Nominal supply air pressure";
  final parameter Modelica.SIunits.MassFlowRate mCoo_flow_nominal=QCooCap/(4200*5) "Nominal chilled water flowrate";
  final parameter Modelica.SIunits.MassFlowRate mHea_flow_nominal=QHeaCap/(4200*20) "Nominal heating water flowrate";
  final parameter Modelica.SIunits.Pressure dpCoo_nominal=((mCoo_flow_nominal/1000)*3600/(0.865*1))^2*1e5 "Nominal chilled water pressure drop";
  final parameter Modelica.SIunits.Pressure dpHea_nominal=((mHea_flow_nominal/1000)*3600/(0.865*1))^2*1e5 "Nominal heating water pressure drop";
  Modelica.Fluid.Interfaces.FluidPort_a returnAir(redeclare final package
      Medium = Medium1) "Return air" annotation (Placement(transformation(
          extent={{130,-170},{150,-150}}),
                                        iconTransformation(extent={{130,-170},{
            150,-150}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(redeclare final package
      Medium = Medium1) "Supply air"
    annotation (Placement(transformation(extent={{130,90},{150,110}}),
        iconTransformation(extent={{130,90},{150,110}})));
  Buildings.Fluid.Movers.SpeedControlled_y     fan(redeclare package Medium =
        Medium1, per(
      pressure(V_flow={0,mAir_flow_nominal/1.2}, dp={dpAir_nominal,0}),
      use_powerCharacteristic=true,
      power(V_flow={0,mAir_flow_nominal/1.2}, P={0,dpAir_nominal/0.7/0.7*
            mAir_flow_nominal/1.2})))              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-120})));

  Modelica.Blocks.Interfaces.RealInput uCooVal
    "Control signal for cooling valve"
    annotation (Placement(transformation(extent={{-180,80},{-140,120}})));
  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed signal"
    annotation (Placement(transformation(extent={{-180,-120},{-140,-80}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senSupTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senRetTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{110,-170},{90,-150}})));
  Buildings.Fluid.Sensors.MassFlowRate senSupFlo(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Fan electrical power consumption"
    annotation (Placement(transformation(extent={{140,130},{160,150}})));
  Modelica.Blocks.Interfaces.RealOutput PHea "Heating power"
    annotation (Placement(transformation(extent={{140,150},{160,170}})));
  Modelica.Blocks.Interfaces.RealOutput PCoo "Cooling power"
    annotation (Placement(transformation(extent={{140,170},{160,190}})));
  Modelica.Blocks.Math.Gain powHea(k=eff)
    annotation (Placement(transformation(extent={{-8,150},{12,170}})));
  Modelica.Blocks.Math.Gain powCoo(k=1/COP)
    annotation (Placement(transformation(extent={{-8,170},{12,190}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTSup(description=
        "Supply air temperature", y(unit="K")) "Read supply air temperature"
    annotation (Placement(transformation(extent={{110,110},{130,130}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTRet(y(unit="K"), description=
        "Return air temperature") "Read return air temperature"
    annotation (Placement(transformation(extent={{110,-150},{130,-130}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaFloSup(y(unit="kg/s"), description=
        "Supply air mass flow rate") "Read supply air flowrate"
    annotation (Placement(transformation(extent={{40,110},{60,130}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaFanSpeSet(y(unit="1"), description=
        "Supply fan speed setpoint") "Read supply fan speed setpoint"
    annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage cooVal(
    redeclare package Medium = Medium2,
    m_flow_nominal=mCoo_flow_nominal,
    dpValve_nominal(displayUnit="bar") = dpCoo_nominal)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senCooSupTem(redeclare package
      Medium = Medium2, m_flow_nominal=mCoo_flow_nominal)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senCooRetTem(redeclare package
      Medium = Medium2, m_flow_nominal=mCoo_flow_nominal)
    annotation (Placement(transformation(extent={{78,-28},{98,-8}})));
  Buildings.Fluid.Sensors.MassFlowRate senCooMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage heaVal(
    redeclare package Medium = Medium2,
    m_flow_nominal=mHea_flow_nominal,
    dpValve_nominal(displayUnit="bar") = dpHea_nominal)
    annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senHeaSupTem(redeclare package
      Medium = Medium2, m_flow_nominal=mHea_flow_nominal)
    annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senHeaRetTem(redeclare package
      Medium = Medium2, m_flow_nominal=mHea_flow_nominal)
    annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  Buildings.Fluid.Sensors.MassFlowRate senHeaMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
  Buildings.Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = Medium2,
    p=101325 + dpCoo_nominal,
    T=280.35,                                nPorts=1)
    "Source for chilled water"
    annotation (Placement(transformation(extent={{140,20},{120,40}})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(redeclare package Medium = Medium2,
    p(displayUnit="Pa") = 101325,
    nPorts=1)                                          "Sink for chilled water"
    annotation (Placement(transformation(extent={{140,-28},{120,-8}})));
  Buildings.Fluid.Sources.Boundary_pT sinHea(redeclare package Medium = Medium2,
    p(displayUnit="Pa") = 101325,            nPorts=1) "Sink for heating water"
    annotation (Placement(transformation(extent={{140,-120},{120,-100}})));
  Buildings.Fluid.Sources.Boundary_pT souHea(
    redeclare package Medium = Medium2,
    p=101325 + dpHea_nominal,
    T=333.15,                                nPorts=1)
    "Source for heating water"
    annotation (Placement(transformation(extent={{140,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput uHeaVal
    "Control signal for heating valve"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness cooCoi(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mCoo_flow_nominal,
    dp1_nominal=dpAir_nominal/2,
    dp2_nominal=0) "Cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness heaCoi(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mHea_flow_nominal,
    dp1_nominal=dpAir_nominal/2,
    dp2_nominal=0) "Heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-80})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaVal(y(unit="1"), description="Heating valve control signal")
    "Read heating valve control signal"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaCooVal(y(unit="1"), description="Cooling valve control signal")
    "Read cooling valve control signal"
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Modelica.Blocks.Sources.RealExpression powCooThe(y=senCooMasFlo.m_flow*(
        inStream(cooCoi.port_b2.h_outflow) - inStream(cooCoi.port_a2.h_outflow)))
                                                   "Cooling thermal power"
    annotation (Placement(transformation(extent={{-60,170},{-40,190}})));
  Modelica.Blocks.Sources.RealExpression powHeaThe(y=-senHeaMasFlo.m_flow*(
        inStream(heaCoi.port_b2.h_outflow) - inStream(heaCoi.port_a2.h_outflow)))
                                                   "Heating thermal power"
    annotation (Placement(transformation(extent={{-60,150},{-40,170}})));
  Modelica.Blocks.Interfaces.BooleanInput uFanSta "Status of fan"
    annotation (Placement(transformation(extent={{-180,-180},{-140,-140}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveFan(description="Fan speed control signal",
      u(
      min=0,
      max=1,
      unit="1")) "Overwrite for fan speed control signal"
    annotation (Placement(transformation(extent={{-120,-110},{-100,-90}})));
  FanControl fanControl(minSpe=minSpe)
    annotation (Placement(transformation(extent={{-70,-130},{-50,-110}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveCooVal(description="Cooling valve control signal",
      u(
      min=0,
      max=1,
      unit="1")) "Overwrite for cooling valve control signal"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveHeaVal(description="Heating valve control signal",
      u(
      min=0,
      max=1,
      unit="1")) "Overwrite for heating valve control signal"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-134,-166},{-122,-154}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-92,-136},{-80,-124}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveFanSta(description="Fan status control signal",
      u(
      min=0,
      max=1,
      unit="1")) "Overwrite for fan status control signal"
    annotation (Placement(transformation(extent={{-120,-140},{-100,-120}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaFloCoo(y(unit="kg/s"), description=
        "Cooling coil water flow rate") "Read cooling coil water flow rate"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaFloHea(y(unit="kg/s"), description=
        "Heating coil water flow rate")
    "Read heating coil supply water flow rate"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTHeaLea(description=
        "Heating coil water leaving temperature", y(unit="K"))
    "Read heating coil water leaving temperature"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTCooLea(description=
        "Cooling coil water leaving temperature", y(unit="K"))
    "Read cooling coil water leaving temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaPCoo(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Cooling electrical power consumption")
    "Read power for cooling"
    annotation (Placement(transformation(extent={{70,170},{90,190}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPHea(
    y(unit="W"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heating thermal power consumption") "Read power for heating"
    annotation (Placement(transformation(extent={{70,150},{90,170}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    description="Supply fan electrical power consumption",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Read power for supply fan"
    annotation (Placement(transformation(extent={{70,130},{90,150}})));
equation
  connect(senSupTem.port_b, supplyAir)
    annotation (Line(points={{110,100},{140,100}},
                                                color={0,127,255}));
  connect(returnAir, senRetTem.port_a)
    annotation (Line(points={{140,-160},{110,-160}},
                                                  color={0,127,255}));
  connect(senRetTem.port_b, fan.port_a) annotation (Line(points={{90,-160},{
          -6.66134e-16,-160},{-6.66134e-16,-130}},
                      color={0,127,255}));
  connect(senSupFlo.port_b, senSupTem.port_a)
    annotation (Line(points={{40,100},{90,100}},
                                               color={0,127,255}));
  connect(senSupTem.T, reaTSup.u)
    annotation (Line(points={{100,111},{100,120},{108,120}},
                                                       color={0,0,127}));
  connect(senRetTem.T, reaTRet.u)
    annotation (Line(points={{100,-149},{100,-140},{108,-140}},
                                                          color={0,0,127}));
  connect(senSupFlo.m_flow, reaFloSup.u)
    annotation (Line(points={{30,111},{30,120},{38,120}},
                                                       color={0,0,127}));
  connect(senCooSupTem.port_b,cooVal. port_b)
    annotation (Line(points={{80,30},{80,20},{70,20}}, color={0,127,255}));
  connect(senCooMasFlo.port_a,cooVal. port_a)
    annotation (Line(points={{40,20},{50,20}}, color={0,127,255}));
  connect(senHeaSupTem.port_b,heaVal. port_b) annotation (Line(points={{80,-60},
          {80,-70},{70,-70}},          color={0,127,255}));
  connect(heaVal.port_a,senHeaMasFlo. port_a)
    annotation (Line(points={{50,-70},{40,-70}}, color={0,127,255}));
  connect(senCooSupTem.port_a,souCoo. ports[1])
    annotation (Line(points={{100,30},{120,30}},
                                               color={0,127,255}));
  connect(souHea.ports[1], senHeaSupTem.port_a)
    annotation (Line(points={{120,-60},{100,-60}},
                                                 color={0,127,255}));
  connect(sinHea.ports[1], senHeaRetTem.port_b)
    annotation (Line(points={{120,-110},{100,-110}},
                                                 color={0,127,255}));
  connect(senCooMasFlo.port_b, cooCoi.port_a2)
    annotation (Line(points={{20,20},{6,20}}, color={0,127,255}));
  connect(senCooRetTem.port_a, cooCoi.port_b2)
    annotation (Line(points={{78,-18},{78,0},{6,0}}, color={0,127,255}));
  connect(heaCoi.port_a2, senHeaMasFlo.port_b)
    annotation (Line(points={{6,-70},{20,-70}},    color={0,127,255}));
  connect(heaCoi.port_b2, senHeaRetTem.port_a)
    annotation (Line(points={{6,-90},{80,-90},{80,-110}},
                                                  color={0,127,255}));
  connect(senSupFlo.port_a, cooCoi.port_b1)
    annotation (Line(points={{20,100},{-6,100},{-6,20}}, color={0,127,255}));
  connect(cooCoi.port_a1, heaCoi.port_b1)
    annotation (Line(points={{-6,0},{-6,-70}}, color={0,127,255}));
  connect(fan.port_b, heaCoi.port_a1) annotation (Line(points={{4.44089e-16,
          -110},{4.44089e-16,-90},{-6,-90}},
                                color={0,127,255}));
  connect(reaCooVal.y, cooVal.y) annotation (Line(points={{-59,100},{-40,100},{
          -40,36},{60,36},{60,32}},
                                color={0,0,127}));
  connect(powCooThe.y, powCoo.u)
    annotation (Line(points={{-39,180},{-10,180}}, color={0,0,127}));
  connect(powHeaThe.y, powHea.u)
    annotation (Line(points={{-39,160},{-10,160}}, color={0,0,127}));
  connect(senCooRetTem.port_b, sinCoo.ports[1])
    annotation (Line(points={{98,-18},{120,-18}},
                                             color={0,127,255}));
  connect(uFan, oveFan.u)
    annotation (Line(points={{-160,-100},{-122,-100}},
                                                     color={0,0,127}));
  connect(reaFanSpeSet.y, fan.y)
    annotation (Line(points={{-19,-120},{-12,-120}},
                                                   color={0,0,127}));
  connect(oveFan.y, fanControl.uFan) annotation (Line(points={{-99,-100},{-90,
          -100},{-90,-116},{-72,-116}},
                                color={0,0,127}));
  connect(fanControl.yFan, reaFanSpeSet.u)
    annotation (Line(points={{-49,-120},{-42,-120}},
                                                   color={0,0,127}));
  connect(reaHeaVal.y, heaVal.y) annotation (Line(points={{-59,0},{-40,0},{-40,
          -54},{60,-54},{60,-58}},
                              color={0,0,127}));
  connect(uCooVal, oveCooVal.u)
    annotation (Line(points={{-160,100},{-122,100}},
                                                   color={0,0,127}));
  connect(oveCooVal.y, reaCooVal.u)
    annotation (Line(points={{-99,100},{-82,100}},
                                                 color={0,0,127}));
  connect(oveHeaVal.y, reaHeaVal.u)
    annotation (Line(points={{-99,0},{-82,0}}, color={0,0,127}));
  connect(oveHeaVal.u, uHeaVal)
    annotation (Line(points={{-122,0},{-160,0}}, color={0,0,127}));
  connect(uFanSta, booleanToReal.u)
    annotation (Line(points={{-160,-160},{-135.2,-160}}, color={255,0,255}));
  connect(realToBoolean.y, fanControl.uFanSta) annotation (Line(points={{-79.4,
          -130},{-72,-130},{-72,-122}},
                                color={255,0,255}));
  connect(oveFanSta.y, realToBoolean.u)
    annotation (Line(points={{-99,-130},{-93.2,-130}},
                                                     color={0,0,127}));
  connect(booleanToReal.y, oveFanSta.u) annotation (Line(points={{-121.4,-160},
          {-110,-160},{-110,-146},{-130,-146},{-130,-130},{-122,-130}},
                                                                     color={0,0,
          127}));
  connect(reaFloCoo.u, senCooMasFlo.m_flow)
    annotation (Line(points={{38,50},{30,50},{30,31}}, color={0,0,127}));
  connect(reaFloHea.u, senHeaMasFlo.m_flow)
    annotation (Line(points={{38,-40},{30,-40},{30,-59}}, color={0,0,127}));
  connect(reaTCooLea.u, senCooRetTem.T)
    annotation (Line(points={{98,0},{88,0},{88,-7}}, color={0,0,127}));
  connect(reaTHeaLea.u, senHeaRetTem.T)
    annotation (Line(points={{98,-90},{90,-90},{90,-99}}, color={0,0,127}));
  connect(powCoo.y, reaPCoo.u)
    annotation (Line(points={{13,180},{68,180}}, color={0,0,127}));
  connect(reaPCoo.y, PCoo)
    annotation (Line(points={{91,180},{150,180}}, color={0,0,127}));
  connect(powHea.y, reaPHea.u)
    annotation (Line(points={{13,160},{68,160}}, color={0,0,127}));
  connect(reaPHea.y, PHea)
    annotation (Line(points={{91,160},{150,160}}, color={0,0,127}));
  connect(fan.P, reaPFan.u) annotation (Line(points={{-9,-109},{-9,-68},{-10,
          -68},{-10,-64},{-16,-64},{-16,140},{68,140}}, color={0,0,127}));
  connect(reaPFan.y, PFan)
    annotation (Line(points={{91,140},{150,140}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -180},{140,180}}),                                  graphics={
                                        Text(
        extent={{-150,184},{150,144}},
        textString="%name",
        lineColor={0,0,255}), Rectangle(
          extent={{-140,180},{140,-180}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-150,238},{150,198}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{140,
            180}})),
    experiment(
      StartTime=20736000,
      StopTime=21600000,
      Interval=599.999616,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end FanCoilUnit;
