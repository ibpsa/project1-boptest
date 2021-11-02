within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  Buildings.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_sup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_out(
    description="Outside air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_sup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_ret_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_out_in
    "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa"))  "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanSup(
    description="Electrical power measurement of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

  Modelica.Blocks.Interfaces.RealInput PFanSup_in
    "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));

equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,120},{-120,120}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,90},{-2,90}},   color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,60},{-2,60}},   color={0,0,127}));
  connect(V_flow_sup_in, V_flow_sup.u)
    annotation (Line(points={{-120,30},{-2,30}}, color={0,0,127}));
  connect(V_flow_ret_in, V_flow_ret.u)
    annotation (Line(points={{-120,0},{-2,0}},   color={0,0,127}));
  connect(V_flow_out_in, V_flow_out.u)
    annotation (Line(points={{-120,-30},{-2,-30}},
                                                 color={0,0,127}));
  connect(dp_sup.u, dp_in)
    annotation (Line(points={{-2,-60},{-120,-60}},
                                               color={0,0,127}));
  connect(PFanSup_in, PFanSup.u) annotation (Line(
      points={{-120,-90},{-62,-90},{-2,-90}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,140}}), graphics={Rectangle(
          extent={{-100,140},{100,-120}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,274},{52,240}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-32,24},{34,-16}},
          lineColor={0,0,0},
          textString="Read
AHU")}),                         Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-120},{100,140}})));
end ReadAhu;
