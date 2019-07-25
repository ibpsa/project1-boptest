within SimpleAir.BaseClasses;
model FanCoilUnit "Four-pipe fan coil unit model"
  package Medium1 = Buildings.Media.Air;
  package Medium2 = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal "Nominal air flowrate";
  parameter Modelica.SIunits.Pressure dpAir_nominal=240 "Nominal supply air pressure";
  parameter Modelica.SIunits.Temperature TSupCoo_nominal=13+273.15 "Nominal cooling supply air temperature";
  parameter Modelica.SIunits.Temperature TSupHea_nominal=40+273.15 "Nominal heating supply air temperature";
  parameter Modelica.SIunits.Temperature TChws=6+273.15 "Chilled water supply temperature";
  parameter Modelica.SIunits.Temperature TChwr_nominal=16+273.15 "Nominal chilled water return temperature";
  parameter Modelica.SIunits.Temperature THtws=40+273.15 "Hot water supply temperature";
  parameter Modelica.SIunits.Temperature THtwr_nominal=30+273.15 "Nominal hot water return temperature";
  parameter Modelica.SIunits.Temperature TZon_nominal=22+273.15 "Nominal zone air temperature";
  parameter Modelica.SIunits.MassFlowRate mCoo_flow_nominal=mAir_flow_nominal*(TZon_nominal-TSupCoo_nominal)/(TChwr_nominal-TChws)*(1000/4200) "Nominal chilled water flowrate";
  parameter Modelica.SIunits.MassFlowRate mHea_flow_nominal=mAir_flow_nominal*(TSupHea_nominal-TZon_nominal)/(THtws-THtwr_nominal)*(1000/4200) "Nominal hot water flowrate";
  parameter Modelica.SIunits.DimensionlessRatio COP = 3 "Assumed COP of chiller supplying chilled water to FCU in [W_thermal/W_electric]";
  parameter Modelica.SIunits.DimensionlessRatio eff = 0.9 "Assumed efficiency of gas boiler supplying hot water to FCU in [W_gas/W_thermal]";
  Modelica.Fluid.Interfaces.FluidPort_a returnAir(redeclare final package
      Medium = Medium1) "Return air" annotation (Placement(transformation(
          extent={{90,-110},{110,-90}}),iconTransformation(extent={{90,-110},{110,
            -90}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(redeclare final package
      Medium = Medium1) "Supply air"
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));
  Buildings.Fluid.Movers.SpeedControlled_y     fan(redeclare package Medium =
        Medium1, per(pressure(V_flow=2*{0,mAir_flow_nominal/1.2}, dp=2*{
            dpAir_nominal,0})))                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-80})));
  Buildings.Fluid.HeatExchangers.WetCoilDiscretized cooCoi(redeclare package
      Medium1 = Medium1, redeclare package Medium2 = Medium2,
    m2_flow_nominal=mAir_flow_nominal,
    m1_flow_nominal=mCoo_flow_nominal,
    dp2_nominal=0,
    UA_nominal=3*mAir_flow_nominal*1000*15/
        Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1=TZon_nominal,
        T_b1=TSupCoo_nominal,
        T_a2=TChws,
        T_b2=TChwr_nominal),
    dp1_nominal=dpAir_nominal/2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,10})));
  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mHea_flow_nominal,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    dp2_nominal=0,
    use_Q_flow_nominal=false,
    eps_nominal=0.9,
    dp1_nominal=dpAir_nominal/2)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-50})));

  Buildings.Fluid.Sources.FixedBoundary sinHea(
    nPorts=1,
    redeclare package Medium = Medium2,
    p=100000) "Sink for heating coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,-60})));
  Buildings.Fluid.Sources.FixedBoundary sinCoo(
    nPorts=1,
    redeclare package Medium = Medium2,
    p=100000)                           "Sink for cooling coil"
                                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,0})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage cooVal(redeclare
      package Medium = Medium2, m_flow_nominal=mCoo_flow_nominal,
    dpValve_nominal(displayUnit="bar") = 200000)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage heaVal(redeclare
      package Medium = Medium2, m_flow_nominal=mHea_flow_nominal,
    dpValve_nominal(displayUnit="bar") = 200000)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Fluid.Sources.FixedBoundary souCoo(
    nPorts=1,
    T=TChws,
    redeclare package Medium = Medium2,
    p=300000) "Source for cooling coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,30})));
  Buildings.Fluid.Sources.FixedBoundary souHea(
    nPorts=1,
    T=THtws,
    redeclare package Medium = Medium2,
    p=300000) "Source for heating coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,-30})));
  Modelica.Blocks.Interfaces.RealInput yCooVal "Cooling coil valve position"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput yHeaVal "Heating coil valve position"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput yFan "Fan speed signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senSupTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senRetTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{60,-110},{40,-90}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senCooSupTem(redeclare package
      Medium = Medium2, m_flow_nominal=mCoo_flow_nominal)
    annotation (Placement(transformation(extent={{70,20},{50,40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senHeaSupTem(redeclare package
      Medium = Medium2, m_flow_nominal=mHea_flow_nominal)
    annotation (Placement(transformation(extent={{70,-40},{50,-20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senHeaRetTem(redeclare package
      Medium = Medium2, m_flow_nominal=mHea_flow_nominal)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senCooRetTem(redeclare package
      Medium = Medium2, m_flow_nominal=mCoo_flow_nominal)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senCooMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{10,10},{-10,30}})));
  Buildings.Fluid.Sensors.MassFlowRate senHeaMasFlo(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Buildings.Fluid.Sensors.MassFlowRate senSupFlo(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Fan electrical power consumption"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput GBoi "Gas consumption of boiler"
    annotation (Placement(transformation(extent={{100,110},{120,130}})));
  Modelica.Blocks.Interfaces.RealOutput PChi
    "Chiller electrical power consumption"
    annotation (Placement(transformation(extent={{100,130},{120,150}})));
  Modelica.Blocks.Sources.RealExpression calPChi(y=senCooMasFlo.m_flow*4200*(
        senCooRetTem.T - senCooSupTem.T)/COP)
    annotation (Placement(transformation(extent={{-10,130},{10,150}})));
  Modelica.Blocks.Sources.RealExpression calGBoi(y=senHeaMasFlo.m_flow*4200*(
        senHeaSupTem.T - senHeaRetTem.T)*eff)
    annotation (Placement(transformation(extent={{-10,110},{10,130}})));
equation
  connect(cooVal.y, yCooVal)
    annotation (Line(points={{30,32},{30,40},{-60,40},{-60,60},{-120,60}},
                                                         color={0,0,127}));
  connect(yHeaVal, heaVal.y)
    annotation (Line(points={{-120,0},{-60,0},{-60,-20},{30,-20},{30,-28}},
                                                       color={0,0,127}));
  connect(fan.y, yFan)
    annotation (Line(points={{-48,-80},{-60,-80},{-60,-60},{-120,-60}},
                                                    color={0,0,127}));
  connect(senSupTem.port_b, supplyAir)
    annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
  connect(returnAir, senRetTem.port_a)
    annotation (Line(points={{100,-100},{60,-100}},
                                                  color={0,127,255}));
  connect(senRetTem.port_b, fan.port_a) annotation (Line(points={{40,-100},{-36,
          -100},{-36,-90}},
                      color={0,127,255}));
  connect(senCooSupTem.port_a, souCoo.ports[1])
    annotation (Line(points={{70,30},{80,30}}, color={0,127,255}));
  connect(senCooSupTem.port_b, cooVal.port_b)
    annotation (Line(points={{50,30},{50,20},{40,20}}, color={0,127,255}));
  connect(souHea.ports[1], senHeaSupTem.port_a)
    annotation (Line(points={{80,-30},{70,-30}}, color={0,127,255}));
  connect(senHeaSupTem.port_b, heaVal.port_b) annotation (Line(points={{50,-30},
          {44,-30},{44,-40},{40,-40}}, color={0,127,255}));
  connect(sinHea.ports[1], senHeaRetTem.port_b)
    annotation (Line(points={{80,-60},{70,-60}}, color={0,127,255}));
  connect(cooCoi.port_b2, senCooRetTem.port_a)
    annotation (Line(points={{-24,0},{50,0}},   color={0,127,255}));
  connect(senCooRetTem.port_b, sinCoo.ports[1])
    annotation (Line(points={{70,0},{80,0}},   color={0,127,255}));
  connect(cooCoi.port_a2, senCooMasFlo.port_b)
    annotation (Line(points={{-24,20},{-10,20}}, color={0,127,255}));
  connect(senCooMasFlo.port_a, cooVal.port_a)
    annotation (Line(points={{10,20},{20,20}}, color={0,127,255}));
  connect(heaVal.port_a, senHeaMasFlo.port_a)
    annotation (Line(points={{20,-40},{10,-40}}, color={0,127,255}));
  connect(cooCoi.port_b1, senSupFlo.port_a)
    annotation (Line(points={{-36,20},{-36,60},{-10,60}}, color={0,127,255}));
  connect(senSupFlo.port_b, senSupTem.port_a)
    annotation (Line(points={{10,60},{40,60}}, color={0,127,255}));
  connect(fan.port_b, heaCoi.port_a1)
    annotation (Line(points={{-36,-70},{-36,-60}}, color={0,127,255}));
  connect(heaCoi.port_b1, cooCoi.port_a1)
    annotation (Line(points={{-36,-40},{-36,0}},  color={0,127,255}));
  connect(heaCoi.port_a2, senHeaMasFlo.port_b)
    annotation (Line(points={{-24,-40},{-10,-40}}, color={0,127,255}));
  connect(heaCoi.port_b2, senHeaRetTem.port_a)
    annotation (Line(points={{-24,-60},{50,-60}}, color={0,127,255}));
  connect(fan.P, PFan)
    annotation (Line(points={{-45,-69},{-45,100},{110,100}}, color={0,0,127}));
  connect(calPChi.y, PChi)
    annotation (Line(points={{11,140},{110,140}}, color={0,0,127}));
  connect(calGBoi.y, GBoi) annotation (Line(points={{11,120},{58,120},{58,120},{
          110,120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
            {100,140}}),                                        graphics={
                                        Text(
        extent={{-150,184},{150,144}},
        textString="%name",
        lineColor={0,0,255}), Rectangle(
          extent={{-100,140},{100,-140}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{100,140}})));
end FanCoilUnit;
