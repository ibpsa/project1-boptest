within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature measurement"
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
    y(unit="m3/s")) "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
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
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Buildings.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa"))  "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanTot(
    description=
        "Total electrical power measurement of supply and return fans for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply and return fans"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));

  Modelica.Blocks.Interfaces.RealInput PFanTot_in
    "Total electrical power of supply and return fans"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));

  Buildings.Utilities.IO.SignalExchange.Read TCooCoiSup(
    description="Cooling coil supply water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));

  Modelica.Blocks.Interfaces.RealInput TCooCoiSup_in
    "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput TCooCoiRet_in
    "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooCoiRet(
    description="Cooling coil return water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

  Buildings.Utilities.IO.SignalExchange.Read yCooVal(
    description="AHU cooling coil valve position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1"))
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  Modelica.Blocks.Interfaces.RealInput yCooVal_in
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Utilities.IO.SignalExchange.Read TSup_set(
    description="Supply air temperature setpoint measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature setpoint measurement"
    annotation (Placement(transformation(extent={{0,214},{20,234}})));

  Modelica.Blocks.Interfaces.RealInput TSup_set_in
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-140,204},{-100,244}}),
        iconTransformation(extent={{-140,204},{-100,244}})));
  Buildings.Utilities.IO.SignalExchange.Read occ(
    description="Occupancy status (1 occupied, 0 unoccupied)",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1")) "Occupancy status (1 occupied, 0 unoccupied)"
    annotation (Placement(transformation(extent={{0,244},{20,264}})));
  Buildings.Utilities.IO.SignalExchange.Read yOA(
    description="AHU cooling coil valve position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{2,42},{22,62}})));

  Modelica.Blocks.Interfaces.RealInput yOA_in
    "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{-140,32},{-100,72}}),
        iconTransformation(extent={{-140,32},{-100,72}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_OA(
    description="Supply outdoor airflow rate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply outdoor airflow rate measurement"
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));

  Modelica.Blocks.Interfaces.RealInput V_flow_OA_in
    "Supply outdoor airflow rate measurement"
    annotation (Placement(transformation(extent={{-140,-150},{-100,-110}}),
        iconTransformation(extent={{-140,-150},{-100,-110}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-50,244},{-30,264}})));
  Modelica.Blocks.Interfaces.BooleanInput occ_in "Occupancy status"
    annotation (Placement(transformation(extent={{-140,234},{-100,274}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUSup(
    description="Supply air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,

    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-170},{20,-150}})));
  Modelica.Blocks.Interfaces.RealInput CO2_AHUSup_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUFre(
    description="Fresh air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,

    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-200},{20,-180}})));
  Modelica.Blocks.Interfaces.RealInput CO2_AHUFre_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-210},{-100,-170}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHURet(
    description="Return air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,

    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-230},{20,-210}})));
  Modelica.Blocks.Interfaces.RealInput CO2_AHURet_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-240},{-100,-200}})));
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
  connect(dp_sup.u, dp_in)
    annotation (Line(points={{-2,20},{-120,20}},
                                               color={0,0,127}));
  connect(PFanTot_in,PFanTot. u) annotation (Line(
      points={{-120,-10},{-62,-10},{-2,-10}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TCooCoiRet_in, TCooCoiRet.u)
    annotation (Line(points={{-120,-70},{-2,-70}},   color={0,0,127}));
  connect(TCooCoiSup_in, TCooCoiSup.u) annotation (Line(points={{-120,-40},{-2,
          -40}},                           color={0,0,127}));
  connect(yCooVal_in, yCooVal.u)
    annotation (Line(points={{-120,-100},{-2,-100}}, color={0,0,127}));
  connect(TSup_set.u, TSup_set_in)
    annotation (Line(points={{-2,224},{-120,224}}, color={0,0,127}));
  connect(yOA_in, yOA.u)
    annotation (Line(points={{-120,52},{0,52}}, color={0,0,127}));
  connect(V_flow_OA_in, V_flow_OA.u)
    annotation (Line(points={{-120,-130},{-2,-130}},color={0,0,127}));
  connect(booleanToReal.y, occ.u)
    annotation (Line(points={{-29,254},{-2,254}}, color={0,0,127}));
  connect(booleanToReal.u, occ_in)
    annotation (Line(points={{-52,254},{-120,254}}, color={255,0,255}));
  connect(CO2_AHUSup_in, CO2_AHUSup.u)
    annotation (Line(points={{-120,-160},{-2,-160}}, color={0,0,127}));
  connect(CO2_AHUFre_in, CO2_AHUFre.u)
    annotation (Line(points={{-120,-190},{-2,-190}}, color={0,0,127}));
  connect(CO2_AHURet_in, CO2_AHURet.u)
    annotation (Line(points={{-120,-220},{-2,-220}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -240},{100,280}}), graphics={Rectangle(
          extent={{-102,282},{100,-246}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-32,74},{34,34}},
          lineColor={0,0,0},
          textString="Read
AHU"),  Text(
          extent={{-156,290},{144,330}},
          textString="%name",
          textColor={0,0,255})}),Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-240},{100,280}})));
end ReadAhu;
