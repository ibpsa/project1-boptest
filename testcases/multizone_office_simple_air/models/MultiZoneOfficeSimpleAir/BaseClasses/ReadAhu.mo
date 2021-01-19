within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadAhu "Collection of AHU measurements for BOPTEST"
  IBPSA.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="K")) "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{0,170},{20,190}})));
  IBPSA.Utilities.IO.SignalExchange.Read TMix(
    description="Mixed air temperature measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="K")) "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{0,140},{20,160}})));
  IBPSA.Utilities.IO.SignalExchange.Read TRet(
    description="Return air temperature measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="K")) "Return air temperature measurement"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow_sup(
    description="Supply air flowrate measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="m^3/s")) "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow_ret(
    description="Return air flowrate measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="m^3/s")) "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow_out(
    description="Outside air flowrate measurement",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="m^3/s")) "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature measurement"
    annotation (Placement(transformation(extent={{-140,160},{-100,200}})));
  Modelica.Blocks.Interfaces.RealInput TMix_in
    "Mixed air temperature measurement"
    annotation (Placement(transformation(extent={{-140,130},{-100,170}})));
  Modelica.Blocks.Interfaces.RealInput TRet_in
    "Return air temperature measurement"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_sup_in
    "Supply air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_ret_in
    "Return air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_out_in
    "Outside air flowrate measurement"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput dp_in "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  IBPSA.Utilities.IO.SignalExchange.Read dp_sup(
    description="Discharge pressure of supply fan",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="Pa")) "Discharge pressure of supply fan"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read yOA(
    description="Actual outside air damper position feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual outside air damper position feedback"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IBPSA.Utilities.IO.SignalExchange.Read yExh(
    description="Actual exhaust air damper position feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual exhaust air damper position feedback"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  IBPSA.Utilities.IO.SignalExchange.Read yRet(
    description="Actual return air damper position feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual return air damper position feedback"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  IBPSA.Utilities.IO.SignalExchange.Read yFan(
    description="Actual supply fan speed feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual supply fan speed feedback"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  Modelica.Blocks.Interfaces.RealInput yOA_in
    "Actual outside air damper position feedback"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput yExh_in
    "Actual exhaust air damper position feedback"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput yRet_in
    "Actual recirculation air damper position feedback"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealInput yFan_in
    "Actual supply fan speed feedback"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
  IBPSA.Utilities.IO.SignalExchange.Read yHea(
    description="Actual heating coil signal feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual heating coil signal feedback"
    annotation (Placement(transformation(extent={{0,-160},{20,-140}})));
  Modelica.Blocks.Interfaces.RealInput yHea_in
    "Actual heating coil signal feedback"
    annotation (Placement(transformation(extent={{-140,-170},{-100,-130}})));
  Modelica.Blocks.Interfaces.RealInput yCoo_in
    "Actual cooling coil signal feedback"
    annotation (Placement(transformation(extent={{-140,-200},{-100,-160}})));
  IBPSA.Utilities.IO.SignalExchange.Read yCoo(
    description="Actual cooling coil signal feedback",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Actual cooling coil signal feedback"
    annotation (Placement(transformation(extent={{0,-190},{20,-170}})));
equation
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,180},{-120,180}}, color={0,0,127}));
  connect(TMix_in, TMix.u)
    annotation (Line(points={{-120,150},{-2,150}}, color={0,0,127}));
  connect(TRet_in, TRet.u)
    annotation (Line(points={{-120,120},{-2,120}}, color={0,0,127}));
  connect(V_flow_sup_in, V_flow_sup.u)
    annotation (Line(points={{-120,90},{-2,90}}, color={0,0,127}));
  connect(V_flow_ret_in, V_flow_ret.u)
    annotation (Line(points={{-120,60},{-2,60}}, color={0,0,127}));
  connect(V_flow_out_in, V_flow_out.u)
    annotation (Line(points={{-120,30},{-2,30}}, color={0,0,127}));
  connect(dp_sup.u, dp_in)
    annotation (Line(points={{-2,0},{-120,0}}, color={0,0,127}));
  connect(yOA_in, yOA.u) annotation (Line(
      points={{-120,-30},{-61,-30},{-2,-30}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yExh_in, yExh.u) annotation (Line(
      points={{-120,-60},{-62,-60},{-2,-60}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yRet_in, yRet.u) annotation (Line(
      points={{-120,-90},{-2,-90}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yFan_in, yFan.u) annotation (Line(
      points={{-120,-120},{-62,-120},{-2,-120}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yHea_in, yHea.u) annotation (Line(
      points={{-120,-150},{-62,-150},{-2,-150}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yCoo_in, yCoo.u) annotation (Line(
      points={{-120,-180},{-62,-180},{-62,-180},{-2,-180}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -200},{100,200}}), graphics={Rectangle(
          extent={{-100,180},{100,-180}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-54,214},{54,180}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-200},{100,200}})));
end ReadAhu;
