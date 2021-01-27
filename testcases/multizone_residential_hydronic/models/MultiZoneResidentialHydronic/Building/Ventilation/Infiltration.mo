within MultiZoneResidentialHydronic.Building.Ventilation;
model Infiltration "Infiltration source for ventilation"
  extends BaseClass(ports_b(redeclare package Medium = MediumA));
  Buildings.Fluid.Sources.MassFlowSource_T infSou(
    m_flow=1,
    use_m_flow_in=true,
    use_X_in=false,
    use_C_in=false,
    use_T_in=true,
    redeclare package Medium = MediumA,
    T=293.15,
    nPorts=1) "Infiltration source"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Constant infCnt(k=m_flow_vent)
    "Infiltration constant for mass flow rate"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(weaBus.TDryBul, infSou.T_in) annotation (Line(
      points={{-100,0},{-20,0},{-20,14},{-2,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(infCnt.y, infSou.m_flow_in) annotation (Line(points={{-39,30},{-8,30},
          {-8,18},{-2,18}}, color={0,0,127}));
  connect(infSou.ports[1:1], ports_b) annotation (Line(points={{20,10},{54,10},{54,
          0},{90,0}}, color={0,127,255}));

end Infiltration;
