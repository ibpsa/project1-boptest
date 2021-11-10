within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,190},{20,210}})));
  Buildings.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,160},{20,180}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,130},{20,150}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_sup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_out(
    description="Outside air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,180},{-100,220}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,150},{-100,190}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,120},{-100,160}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_sup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,90},{-100,130}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_ret_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_out_in
    "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Buildings.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa"))  "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanSup(
    description="Electrical power measurement of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));

  Modelica.Blocks.Interfaces.RealInput PFanSup_in
    "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));

  Buildings.Utilities.IO.SignalExchange.Read PPumCoo(
    description="Electrical power measurement of cooling coil pump for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of cooling coil pump"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));

  Modelica.Blocks.Interfaces.RealInput PPumCoo_in
    "Electrical power of cooling coil pump"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Read PPumHea(
    description="Electrical power measurement of heating coil pump for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of heating coil pump"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

  Modelica.Blocks.Interfaces.RealInput PPumHea_in
    "Electrical power of heating coil pump"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooCoiSup(
    description="Cooling coil supply water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));
  Modelica.Blocks.Interfaces.RealInput TCooCoiSup_in
    "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput TCooCoiRet_in
    "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{-140,-150},{-100,-110}})));
  Modelica.Blocks.Interfaces.RealInput THeaCoiSup_in
    "Heating coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}})));
  Modelica.Blocks.Interfaces.RealInput THeaCoiRet_in
    "Heating coil water return temperature measurement"
    annotation (Placement(transformation(extent={{-140,-210},{-100,-170}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooCoiRet(
    description="Cooling coil return water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));
  Buildings.Utilities.IO.SignalExchange.Read THeaCoiSup(
    description="Heating coil supply water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Heating coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{0,-170},{20,-150}})));
  Buildings.Utilities.IO.SignalExchange.Read THeaCoiRet(
    description="Heating coil return water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Heating coil water return temperature measurement"
    annotation (Placement(transformation(extent={{0,-200},{20,-180}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,200},{-120,200}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,170},{-2,170}}, color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,140},{-2,140}}, color={0,0,127}));
  connect(V_flow_sup_in, V_flow_sup.u)
    annotation (Line(points={{-120,110},{-2,110}},
                                                 color={0,0,127}));
  connect(V_flow_ret_in, V_flow_ret.u)
    annotation (Line(points={{-120,80},{-2,80}}, color={0,0,127}));
  connect(V_flow_out_in, V_flow_out.u)
    annotation (Line(points={{-120,50},{-2,50}}, color={0,0,127}));
  connect(dp_sup.u, dp_in)
    annotation (Line(points={{-2,20},{-120,20}},
                                               color={0,0,127}));
  connect(PFanSup_in, PFanSup.u) annotation (Line(
      points={{-120,-10},{-62,-10},{-2,-10}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PPumCoo_in, PPumCoo.u) annotation (Line(
      points={{-120,-40},{-62,-40},{-2,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PPumHea_in, PPumHea.u) annotation (Line(
      points={{-120,-70},{-62,-70},{-2,-70}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(THeaCoiRet_in, THeaCoiRet.u)
    annotation (Line(points={{-120,-190},{-2,-190}}, color={0,0,127}));
  connect(THeaCoiSup_in, THeaCoiSup.u)
    annotation (Line(points={{-120,-160},{-2,-160}}, color={0,0,127}));
  connect(TCooCoiRet_in, TCooCoiRet.u)
    annotation (Line(points={{-120,-130},{-2,-130}}, color={0,0,127}));
  connect(TCooCoiSup_in, TCooCoiSup.u) annotation (Line(points={{-120,-100},{
          -62,-100},{-62,-100},{-2,-100}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -200},{100,200}}), graphics={Rectangle(
          extent={{-100,200},{100,-200}},
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
            false, extent={{-100,-200},{100,200}})));
end ReadAhu;
