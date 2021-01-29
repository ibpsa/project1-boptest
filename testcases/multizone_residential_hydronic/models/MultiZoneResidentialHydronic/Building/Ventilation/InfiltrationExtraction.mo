within MultiZoneResidentialHydronic.Building.Ventilation;
model InfiltrationExtraction
  "Infiltration source or extraction sink for ventilation. Infiltration when mass flow rate is set positive, extraction otherwise."
  extends BaseClass;
  Buildings.Fluid.Sources.MassFlowSource_T infSouExtSin(
    m_flow=1,
    use_m_flow_in=true,
    use_X_in=false,
    use_C_in=false,
    use_T_in=true,
    redeclare package Medium = MediumA,
    T=293.15,
    nPorts=1) "Infiltration source or extraction sink"
    annotation (Placement(transformation(extent={{0,-14},{20,6}})));
equation
  connect(weaBus.TDryBul, infSouExtSin.T_in) annotation (Line(
      points={{-100,0},{-2,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(venPort, ports_b[2])
    annotation (Line(points={{60,-20},{90,-20}}, color={0,127,255}));
  connect(infSouExtSin.ports[1], venPort) annotation (Line(points={{20,-4},{40,
          -4},{40,-20},{60,-20}}, color={0,127,255}));
  connect(m_flow, infSouExtSin.m_flow_in) annotation (Line(points={{-120,30},{
          -40,30},{-40,4},{-2,4}}, color={0,0,127}));
end InfiltrationExtraction;
