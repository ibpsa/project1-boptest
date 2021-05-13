within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,230},{20,250}})));
  Buildings.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,200},{20,220}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"))  "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,170},{20,190}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_sup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,140},{20,160}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_out(
    description="Outside air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"))  "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,220},{-100,260}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,190},{-100,230}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,160},{-100,200}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_sup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,130},{-100,170}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_ret_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_out_in
    "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Buildings.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="Pa"))  "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Utilities.IO.SignalExchange.Read yOA(
    description="Outside air damper position set point feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Outside air damper position setpoint feedback"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Utilities.IO.SignalExchange.Read yRelAct(
    description="Relief air damper position set point feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Relief air damper position set point feedback"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Buildings.Utilities.IO.SignalExchange.Read yRetAct(
    description="Return air damper position set point feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Return air damper position setpoint feedback"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Buildings.Utilities.IO.SignalExchange.Read yFanAct(
    description="Supply fan speed set point feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Supply fan speed setpoint feedback"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  Modelica.Blocks.Interfaces.RealInput yOA_in
    "Actual outside air damper position feedback"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput yExh_in
    "Actual exhaust air damper position feedback"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput yRet_in
    "Actual recirculation air damper position feedback"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput yFan_in
    "Actual supply fan speed feedback"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Utilities.IO.SignalExchange.Read yHeaAct(
    description="Heating coil control signal feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Heating coil control signal feedback"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

  Modelica.Blocks.Interfaces.RealInput yHea_in
    "Actual heating coil signal feedback"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealInput yCoo_in
    "Actual cooling coil signal feedback"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
  Buildings.Utilities.IO.SignalExchange.Read yCooAct(
    description="Cooling coil control signal feedback for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Cooling coil control signal feedback"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));

  Buildings.Utilities.IO.SignalExchange.Read PFanSup(
    description="Electrical power measurement of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{0,-160},{20,-140}})));

  Modelica.Blocks.Interfaces.RealInput PFanSup_in
    "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{-140,-170},{-100,-130}})));
  Buildings.Utilities.IO.SignalExchange.Read PCoo(
    description="Electrical power measurement of cooling for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power of cooling"
    annotation (Placement(transformation(extent={{0,-190},{20,-170}})));

  Modelica.Blocks.Interfaces.RealInput PCoo_in "Electrical power of cooling"
    annotation (Placement(transformation(extent={{-140,-200},{-100,-160}})));
  Buildings.Utilities.IO.SignalExchange.Read PHea(
    description="Electrical power consumption for heating coil for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power consumption for heating coil"
    annotation (Placement(transformation(extent={{0,-220},{20,-200}})));

  Modelica.Blocks.Interfaces.RealInput PHea_in
    "Electrical power used for heating coil"
    annotation (Placement(transformation(extent={{-140,-230},{-100,-190}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,240},{-120,240}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,210},{-2,210}}, color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,180},{-2,180}}, color={0,0,127}));
  connect(V_flow_sup_in, V_flow_sup.u)
    annotation (Line(points={{-120,150},{-2,150}},
                                                 color={0,0,127}));
  connect(V_flow_ret_in, V_flow_ret.u)
    annotation (Line(points={{-120,120},{-2,120}},
                                                 color={0,0,127}));
  connect(V_flow_out_in, V_flow_out.u)
    annotation (Line(points={{-120,90},{-2,90}}, color={0,0,127}));
  connect(dp_sup.u, dp_in)
    annotation (Line(points={{-2,60},{-120,60}},
                                               color={0,0,127}));
  connect(yOA_in, yOA.u) annotation (Line(
      points={{-120,30},{-61,30},{-2,30}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yExh_in, yRelAct.u) annotation (Line(
      points={{-120,0},{-62,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yRet_in, yRetAct.u) annotation (Line(
      points={{-120,-30},{-2,-30}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yFan_in, yFanAct.u) annotation (Line(
      points={{-120,-60},{-62,-60},{-2,-60}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yHea_in, yHeaAct.u) annotation (Line(
      points={{-120,-90},{-62,-90},{-2,-90}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yCoo_in, yCooAct.u) annotation (Line(
      points={{-120,-120},{-62,-120},{-2,-120}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PFanSup_in, PFanSup.u) annotation (Line(
      points={{-120,-150},{-62,-150},{-2,-150}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PCoo_in, PCoo.u) annotation (Line(
      points={{-120,-180},{-62,-180},{-2,-180}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(PHea_in, PHea.u)
    annotation (Line(points={{-120,-210},{-2,-210}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-240},
            {100,240}}),       graphics={Rectangle(
          extent={{-100,240},{100,-242}},
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
            false, extent={{-100,-240},{100,240}})));
end ReadAhu;
