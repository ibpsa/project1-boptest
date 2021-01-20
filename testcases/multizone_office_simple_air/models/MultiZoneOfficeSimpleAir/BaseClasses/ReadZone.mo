within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadZone "Collection of zone measurements for BOPTEST"
  IBPSA.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(units="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));

  IBPSA.Utilities.IO.SignalExchange.Read yDamAct(
    description="Damper position setpoint feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Damper position setpoint feedback"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  IBPSA.Utilities.IO.SignalExchange.Read yReaHea(
    description="Reheat control signal feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="1")) "Reheat control signal feedback"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput yDamAct_in
    "Actual damper position feedback"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput yReaHea_in
    "Actual reheat control signal feedback"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  IBPSA.Utilities.IO.SignalExchange.Read TSup(
    description="Supply air temperature to zone measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow(
    description="Supply air flowrate to zone measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(units="m^3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,80},{-120,80}}, color={0,0,127}));
  connect(yDamAct_in, yDamAct.u)
    annotation (Line(points={{-120,40},{-2,40}}, color={0,0,127}));
  connect(yReaHea_in, yReaHea.u)
    annotation (Line(points={{-120,0},{-2,0}}, color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,-40},{-120,-40}}, color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,-80},{-120,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,134},{52,100}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end ReadZone;
