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
  Modelica.Blocks.Sources.Constant infCnt(k=m_flow_vent)
    "Infiltration constant for mass flow rate"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(weaBus.TDryBul, infSouExtSin.T_in) annotation (Line(
      points={{-100,0},{-2,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(infCnt.y, infSouExtSin.m_flow_in) annotation (Line(points={{-39,30},{
          -8,30},{-8,4},{-2,4}}, color={0,0,127}));

  connect(venPort, ports_b[2])
    annotation (Line(points={{60,-20},{90,-20}}, color={0,127,255}));
  connect(infSouExtSin.ports[1], venPort) annotation (Line(points={{20,-4},{40,
          -4},{40,-20},{60,-20}}, color={0,127,255}));
  annotation (Documentation(info="<html>
Models either air infiltration or air extraction in a building zone.
The air flow direction is determined by the sign of the <code>m_flow_vent</code>
parameter: a negative sign indicates air flowing out of the room,
and a positive sign indicates air flowing into the room.
</html>"));
end InfiltrationExtraction;
