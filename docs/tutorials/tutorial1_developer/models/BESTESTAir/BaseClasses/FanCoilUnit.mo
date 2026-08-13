within BESTESTAir.BaseClasses;
model FanCoilUnit "Four-pipe fan coil unit model"
  package Medium1 = Buildings.Media.Air;
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal=0.65 "Nominal air flowrate";
  parameter Modelica.SIunits.Pressure dpAir_nominal=500 "Nominal supply air pressure";
  parameter Modelica.SIunits.Power QCooCap=5000 "Cooling coil capacity";
  parameter Modelica.SIunits.Power QHeaCap=5000 "Heating coil capacity";
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
        Medium1, per(
      pressure(V_flow={0,mAir_flow_nominal/1.2}, dp={dpAir_nominal,0}),
      use_powerCharacteristic=true,
      power(V_flow={0,mAir_flow_nominal/1.2}, P={0,800*mAir_flow_nominal/1.2})))
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-80})));

  Modelica.Blocks.Interfaces.RealInput TSupSet
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput yFan "Fan speed signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senSupTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senRetTem(redeclare package Medium =
        Medium1, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{60,-110},{40,-90}})));
  Buildings.Fluid.Sensors.MassFlowRate senSupFlo(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Fan electrical power consumption"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput PHea "Heating power"
    annotation (Placement(transformation(extent={{100,110},{120,130}})));
  Modelica.Blocks.Interfaces.RealOutput PCoo "Cooling power"
    annotation (Placement(transformation(extent={{100,130},{120,150}})));
  Buildings.Fluid.HeatExchangers.Heater_T heaCoi(
    m_flow_nominal=mAir_flow_nominal,
    redeclare package Medium = Medium1,
    dp_nominal=dpAir_nominal,
    QMax_flow=QHeaCap)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-30})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T cooCoi(
    m_flow_nominal=mAir_flow_nominal,
    redeclare package Medium = Medium1,
    dp_nominal=0,
    QMin_flow=-QCooCap)         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  Modelica.Blocks.Math.Gain powHea(k=eff)
    annotation (Placement(transformation(extent={{-8,110},{12,130}})));
  Modelica.Blocks.Math.Gain powCoo(k=-1/COP)
    annotation (Placement(transformation(extent={{-8,130},{12,150}})));
equation
  connect(fan.y, yFan)
    annotation (Line(points={{-42,-80},{-60,-80},{-60,-60},{-120,-60}},
                                                    color={0,0,127}));
  connect(senSupTem.port_b, supplyAir)
    annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
  connect(returnAir, senRetTem.port_a)
    annotation (Line(points={{100,-100},{60,-100}},
                                                  color={0,127,255}));
  connect(senRetTem.port_b, fan.port_a) annotation (Line(points={{40,-100},{-30,
          -100},{-30,-90}},
                      color={0,127,255}));
  connect(senSupFlo.port_b, senSupTem.port_a)
    annotation (Line(points={{30,60},{40,60}}, color={0,127,255}));
  connect(fan.P, PFan)
    annotation (Line(points={{-39,-69},{-39,-66},{-40,-66},{-40,-62},{-52,-62},{
          -52,100},{110,100}},                               color={0,0,127}));
  connect(fan.port_b, heaCoi.port_a)
    annotation (Line(points={{-30,-70},{-30,-40}}, color={0,127,255}));
  connect(heaCoi.port_b, cooCoi.port_a)
    annotation (Line(points={{-30,-20},{-30,20}}, color={0,127,255}));
  connect(cooCoi.port_b, senSupFlo.port_a)
    annotation (Line(points={{-30,40},{-30,60},{10,60}}, color={0,127,255}));
  connect(powCoo.y,PCoo)  annotation (Line(points={{13,140},{58,140},{58,140},{110,
          140}}, color={0,0,127}));
  connect(powHea.y,PHea)  annotation (Line(points={{13,120},{59.5,120},{59.5,120},
          {110,120}}, color={0,0,127}));
  connect(powCoo.u, cooCoi.Q_flow)
    annotation (Line(points={{-10,140},{-38,140},{-38,41}}, color={0,0,127}));
  connect(heaCoi.Q_flow, powHea.u) annotation (Line(points={{-38,-19},{-38,-8},{
          -46,-8},{-46,120},{-10,120}}, color={0,0,127}));
  connect(TSupSet, cooCoi.TSet) annotation (Line(points={{-120,60},{-80,60},{-80,
          8},{-38,8},{-38,18}}, color={0,0,127}));
  connect(TSupSet, heaCoi.TSet) annotation (Line(points={{-120,60},{-80,60},{-80,
          -50},{-38,-50},{-38,-42}}, color={0,0,127}));
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
