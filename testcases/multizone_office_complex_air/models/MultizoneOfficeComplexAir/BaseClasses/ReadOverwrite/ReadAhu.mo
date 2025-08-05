within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,210},{20,230}})));
  Buildings.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,180},{20,200}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,150},{20,170}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flowSup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,120},{20,140}})));

  Buildings.Utilities.IO.SignalExchange.Read V_flowRet(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));

  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,200},{-100,240}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,170},{-100,210}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,140},{-100,180}})));
  Modelica.Blocks.Interfaces.RealInput V_flowSup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,110},{-100,150}})));
  Modelica.Blocks.Interfaces.RealInput V_flowRet_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Buildings.Utilities.IO.SignalExchange.Read dp(
    description="Static pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa")) "Static pressure of supply fan"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanTot(
    description=
        "Total electrical power measurement of supply and return fans for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply and return fans"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));

  Modelica.Blocks.Interfaces.RealInput PFanTot_in
    "Total electrical power of supply and return fans"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}})));

  Buildings.Utilities.IO.SignalExchange.Read TCooCoiSup(
    description="Cooling coil supply water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));

  Modelica.Blocks.Interfaces.RealInput TCooCoiSup_in
    "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput TCooCoiRet_in
    "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooCoiRet(
    description="Cooling coil return water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));

  Buildings.Utilities.IO.SignalExchange.Read yCooVal(
    description="AHU cooling coil valve position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1"))
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));

  Modelica.Blocks.Interfaces.RealInput yCooVal_in
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Utilities.IO.SignalExchange.Read occ(
    description="Occupancy status (1 occupied, 0 unoccupied)",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1")) "Occupancy status (1 occupied, 0 unoccupied)"
    annotation (Placement(transformation(extent={{0,244},{20,264}})));
  Buildings.Utilities.IO.SignalExchange.Read yOA(
    description="AHU OA damper position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{0,62},{20,82}})));

  Modelica.Blocks.Interfaces.RealInput yOA_in
    "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{-140,52},{-100,92}}),
        iconTransformation(extent={{-140,52},{-100,92}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flowOA(
    description="Supply outdoor airflow rate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply outdoor airflow rate measurement"
    annotation (Placement(transformation(extent={{0,-120},{20,-100}})));

  Modelica.Blocks.Interfaces.RealInput V_flowOA_in
    "Supply outdoor airflow rate measurement" annotation (Placement(
        transformation(extent={{-140,-130},{-100,-90}}), iconTransformation(
          extent={{-140,-130},{-100,-90}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-50,244},{-30,264}})));
  Modelica.Blocks.Interfaces.BooleanInput occ_in "Occupancy status"
    annotation (Placement(transformation(extent={{-140,234},{-100,274}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUSup(
    description="Supply air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-150},{20,-130}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHUSup_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-160},{-100,-120}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUFre(
    description="Fresh air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-180},{20,-160}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHUFre_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-190},{-100,-150}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHURet(
    description="Return air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Return air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-210},{20,-190}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHURet_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-220},{-100,-180}})));
  Buildings.Utilities.IO.SignalExchange.Read phiAHUSup(
    description="Supply air relative humidity for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Supply air relative humidity"
    annotation (Placement(transformation(extent={{0,-240},{20,-220}})));
  Buildings.Utilities.IO.SignalExchange.Read phiAHURet(
    description="Return air relative humidity for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Return air relative humidity"
    annotation (Placement(transformation(extent={{0,-272},{20,-252}})));
  Modelica.Blocks.Interfaces.RealInput phiAHUSup_in
    "Supply air relative humidity measurement"
    annotation (Placement(transformation(extent={{-140,-250},{-100,-210}})));
  Modelica.Blocks.Interfaces.RealInput phiAHURet_in
    "Return air relative humidity measurement"
    annotation (Placement(transformation(extent={{-140,-282},{-100,-242}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,220},{-120,220}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,190},{-2,190}}, color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,160},{-2,160}}, color={0,0,127}));
  connect(V_flowSup_in, V_flowSup.u)
    annotation (Line(points={{-120,130},{-2,130}}, color={0,0,127}));
  connect(V_flowRet_in, V_flowRet.u)
    annotation (Line(points={{-120,100},{-2,100}}, color={0,0,127}));
  connect(dp.u, dp_in)
    annotation (Line(points={{-2,40},{-120,40}}, color={0,0,127}));
  connect(PFanTot_in,PFanTot. u) annotation (Line(
      points={{-120,10},{-62,10},{-2,10}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TCooCoiRet_in, TCooCoiRet.u)
    annotation (Line(points={{-120,-50},{-2,-50}},   color={0,0,127}));
  connect(TCooCoiSup_in, TCooCoiSup.u) annotation (Line(points={{-120,-20},{-2,
          -20}},                           color={0,0,127}));
  connect(yCooVal_in, yCooVal.u)
    annotation (Line(points={{-120,-80},{-2,-80}},   color={0,0,127}));
  connect(yOA_in, yOA.u)
    annotation (Line(points={{-120,72},{-2,72}},color={0,0,127}));
  connect(V_flowOA_in, V_flowOA.u)
    annotation (Line(points={{-120,-110},{-2,-110}}, color={0,0,127}));
  connect(booleanToReal.y, occ.u)
    annotation (Line(points={{-29,254},{-2,254}}, color={0,0,127}));
  connect(booleanToReal.u, occ_in)
    annotation (Line(points={{-52,254},{-120,254}}, color={255,0,255}));
  connect(CO2_AHUSup_in, CO2_AHUSup.u)
    annotation (Line(points={{-120,-140},{-2,-140}}, color={0,0,127}));
  connect(CO2_AHUFre_in, CO2_AHUFre.u)
    annotation (Line(points={{-120,-170},{-2,-170}}, color={0,0,127}));
  connect(CO2_AHURet_in, CO2_AHURet.u)
    annotation (Line(points={{-120,-200},{-2,-200}}, color={0,0,127}));
  connect(phiAHUSup.u, phiAHUSup_in)
    annotation (Line(points={{-2,-230},{-120,-230}}, color={0,0,127}));
  connect(phiAHURet.u, phiAHURet_in)
    annotation (Line(points={{-2,-262},{-120,-262}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -280},{100,280}}), graphics={Rectangle(
          extent={{-98,278},{100,-280}},
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
            false, extent={{-100,-280},{100,280}})));
end ReadAhu;
