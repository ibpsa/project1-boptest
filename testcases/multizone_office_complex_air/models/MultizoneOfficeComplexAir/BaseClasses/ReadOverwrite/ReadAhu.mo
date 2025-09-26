within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,230},{20,250}})));
  Buildings.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,200},{20,220}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,170},{20,190}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flowSup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,140},{20,160}})));

  Buildings.Utilities.IO.SignalExchange.Read V_flowRet(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));

  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,220},{-100,260}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,190},{-100,230}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,160},{-100,200}})));
  Modelica.Blocks.Interfaces.RealInput V_flowSup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,130},{-100,170}})));
  Modelica.Blocks.Interfaces.RealInput V_flowRet_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,48},{-100,88}})));
  Buildings.Utilities.IO.SignalExchange.Read dp(
    description="Static pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa")) "Static pressure of supply fan"
    annotation (Placement(transformation(extent={{0,58},{20,78}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanRet(
    description="Electrical power measurement of return fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of return fan"
    annotation (Placement(transformation(extent={{0,2},{20,22}})));

  Modelica.Blocks.Interfaces.RealInput PFanRet_in "Return fan electrical power"
    annotation (Placement(transformation(extent={{-140,-8},{-100,32}})));

  Buildings.Utilities.IO.SignalExchange.Read TCooCoiSup(
    description="Cooling coil supply water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{0,-48},{20,-28}})));

  Modelica.Blocks.Interfaces.RealInput TCooCoiSup_in
    "Cooling coil water supply temperature measurement"
    annotation (Placement(transformation(extent={{-140,-58},{-100,-18}})));
  Modelica.Blocks.Interfaces.RealInput TCooCoiRet_in
    "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{-140,-88},{-100,-48}})));
  Buildings.Utilities.IO.SignalExchange.Read TCooCoiRet(
    description="Cooling coil return water temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Cooling coil water return temperature measurement"
    annotation (Placement(transformation(extent={{0,-78},{20,-58}})));

  Buildings.Utilities.IO.SignalExchange.Read yCooVal(
    description="AHU cooling coil valve position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1"))
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{0,-108},{20,-88}})));

  Modelica.Blocks.Interfaces.RealInput yCooVal_in
    "AHU cooling coil valve position measurement"
    annotation (Placement(transformation(extent={{-140,-118},{-100,-78}}),
        iconTransformation(extent={{-140,-118},{-100,-78}})));

  Buildings.Utilities.IO.SignalExchange.Read occ(
    description="Occupancy status (1 occupied, 0 unoccupied)",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None, y(unit="1")) "Occupancy status (1 occupied, 0 unoccupied)"
    annotation (Placement(transformation(extent={{0,260},{20,280}})));
  Buildings.Utilities.IO.SignalExchange.Read yOA(
    description="AHU OA damper position measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{0,84},{20,104}})));

  Modelica.Blocks.Interfaces.RealInput yOA_in
    "AHU OA damper position measurement"
    annotation (Placement(transformation(extent={{-140,74},{-100,114}}),
        iconTransformation(extent={{-140,74},{-100,114}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flowOA(
    description="Supply outdoor airflow rate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply outdoor airflow rate measurement"
    annotation (Placement(transformation(extent={{0,-138},{20,-118}})));

  Modelica.Blocks.Interfaces.RealInput V_flowOA_in
    "Supply outdoor airflow rate measurement" annotation (Placement(
        transformation(extent={{-140,-148},{-100,-108}}),iconTransformation(
          extent={{-140,-148},{-100,-108}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-50,260},{-30,280}})));
  Modelica.Blocks.Interfaces.BooleanInput occ_in "Occupancy status"
    annotation (Placement(transformation(extent={{-140,250},{-100,290}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUSup(
    description="Supply air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-168},{20,-148}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHUSup_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-178},{-100,-138}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHUFre(
    description="Fresh air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-198},{20,-178}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHUFre_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-208},{-100,-168}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2_AHURet(
    description="Return air CO2 measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm")) "Return air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-228},{20,-208}})));

  Modelica.Blocks.Interfaces.RealInput CO2_AHURet_in
    "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-238},{-100,-198}})));
  Buildings.Utilities.IO.SignalExchange.Read phiAHUSup(
    description="Supply air relative humidity for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Supply air relative humidity"
    annotation (Placement(transformation(extent={{0,-258},{20,-238}})));
  Buildings.Utilities.IO.SignalExchange.Read phiAHURet(
    description="Return air relative humidity for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Return air relative humidity"
    annotation (Placement(transformation(extent={{0,-290},{20,-270}})));
  Modelica.Blocks.Interfaces.RealInput phiAHUSup_in
    "Supply air relative humidity measurement"
    annotation (Placement(transformation(extent={{-140,-268},{-100,-228}})));
  Modelica.Blocks.Interfaces.RealInput phiAHURet_in
    "Return air relative humidity measurement"
    annotation (Placement(transformation(extent={{-140,-300},{-100,-260}})));
  Buildings.Utilities.IO.SignalExchange.Read PFanSup(
    description="Electrical power measurement of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Interfaces.RealInput PFanSup_in "Supply fan electrical power"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Buildings.Utilities.IO.SignalExchange.Read PFreCoi(
    description=
        "Electrical power measurement of freeze protection coil for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of freeze coil"
    annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
  Modelica.Blocks.Interfaces.RealInput PFreCoi_in
    "Freeze coil electrical power"
    annotation (Placement(transformation(extent={{-140,-32},{-100,8}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,240},{-120,240}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,210},{-2,210}}, color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,180},{-2,180}}, color={0,0,127}));
  connect(V_flowSup_in, V_flowSup.u)
    annotation (Line(points={{-120,150},{-2,150}}, color={0,0,127}));
  connect(V_flowRet_in, V_flowRet.u)
    annotation (Line(points={{-120,120},{-2,120}}, color={0,0,127}));
  connect(dp.u, dp_in)
    annotation (Line(points={{-2,68},{-120,68}}, color={0,0,127}));
  connect(PFanRet_in,PFanRet. u) annotation (Line(
      points={{-120,12},{-62,12},{-2,12}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TCooCoiRet_in, TCooCoiRet.u)
    annotation (Line(points={{-120,-68},{-2,-68}},   color={0,0,127}));
  connect(TCooCoiSup_in, TCooCoiSup.u) annotation (Line(points={{-120,-38},{-2,
          -38}},                           color={0,0,127}));
  connect(yCooVal_in, yCooVal.u)
    annotation (Line(points={{-120,-98},{-2,-98}},   color={0,0,127}));
  connect(yOA_in, yOA.u)
    annotation (Line(points={{-120,94},{-2,94}},color={0,0,127}));
  connect(V_flowOA_in, V_flowOA.u)
    annotation (Line(points={{-120,-128},{-2,-128}}, color={0,0,127}));
  connect(booleanToReal.y, occ.u)
    annotation (Line(points={{-29,270},{-2,270}}, color={0,0,127}));
  connect(booleanToReal.u, occ_in)
    annotation (Line(points={{-52,270},{-120,270}}, color={255,0,255}));
  connect(CO2_AHUSup_in, CO2_AHUSup.u)
    annotation (Line(points={{-120,-158},{-2,-158}}, color={0,0,127}));
  connect(CO2_AHUFre_in, CO2_AHUFre.u)
    annotation (Line(points={{-120,-188},{-2,-188}}, color={0,0,127}));
  connect(CO2_AHURet_in, CO2_AHURet.u)
    annotation (Line(points={{-120,-218},{-2,-218}}, color={0,0,127}));
  connect(phiAHUSup.u, phiAHUSup_in)
    annotation (Line(points={{-2,-248},{-120,-248}}, color={0,0,127}));
  connect(phiAHURet.u, phiAHURet_in)
    annotation (Line(points={{-2,-280},{-120,-280}}, color={0,0,127}));
  connect(PFanSup_in, PFanSup.u) annotation (Line(
      points={{-120,40},{-62,40},{-2,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PFreCoi_in, PFreCoi.u)
    annotation (Line(points={{-120,-12},{-2,-12}}, color={0,0,127}));
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
