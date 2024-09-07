within FRP.RTUVAV.Component;
model readAHU
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-6,210},{14,230}})));
  Buildings.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="K")) "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-6,176},{14,196}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_sup(
    description="Supply air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="m3/s"))  "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-6,144},{14,164}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="m3/s"))  "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-6,110},{14,130}})));
  Buildings.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,

    y(unit="Pa"))  "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-6,78},{14,98}})));
  Buildings.Utilities.IO.SignalExchange.Read PFanSup(
    description="Electrical power measurement of supply fan for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,

    y(unit="W")) "Electrical power of supply fan"
    annotation (Placement(transformation(extent={{-6,22},{14,42}})));
  Buildings.Utilities.IO.SignalExchange.Read PDXCool(
    description="Electrical power measurement of DX cooling coil for AHU",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,

    y(unit="W")) "Electrical power of Dx cooling coil"
    annotation (Placement(transformation(extent={{-6,-18},{14,2}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-138,200},{-98,240}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-138,166},{-98,206}})));
  Modelica.Blocks.Interfaces.RealInput VflowSup_in
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,134},{-100,174}})));
  Modelica.Blocks.Interfaces.RealInput VflowRet_in
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput dP_in "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,68},{-100,108}})));
  Modelica.Blocks.Interfaces.RealInput pFan_in "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,12},{-100,52}})));
  Modelica.Blocks.Interfaces.RealInput pDX_in "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-28},{-100,12}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-8,220},{-118,220}}, color={0,0,127}));
  connect(TRet.u, TRet_in)
    annotation (Line(points={{-8,186},{-118,186}}, color={0,0,127}));
  connect(V_flow_sup.u, VflowSup_in)
    annotation (Line(points={{-8,154},{-120,154}}, color={0,0,127}));
  connect(V_flow_ret.u, VflowRet_in)
    annotation (Line(points={{-8,120},{-120,120}}, color={0,0,127}));
  connect(dp_sup.u, dP_in)
    annotation (Line(points={{-8,88},{-120,88}}, color={0,0,127}));
  connect(PFanSup.u, pFan_in)
    annotation (Line(points={{-8,32},{-120,32}}, color={0,0,127}));
  connect(PDXCool.u, pDX_in)
    annotation (Line(points={{-8,-8},{-120,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -60},{100,240}}), graphics={Rectangle(
          extent={{-100,248},{104,-60}},
          lineColor={0,0,127},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid), Text(
          extent={{-78,138},{82,40}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textString="ReadAHU")}), Diagram(coordinateSystem(preserveAspectRatio
          =false, extent={{-100,-40},{100,240}})));
end readAHU;
