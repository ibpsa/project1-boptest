within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadZone "Collection of zone measurements for BOPTEST"
  IBPSA.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));

  IBPSA.Utilities.IO.SignalExchange.Read yDamAct(
    description="Damper position set point feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Damper position setpoint feedback"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  IBPSA.Utilities.IO.SignalExchange.Read yReaHea(
    description="Reheat control signal set point feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Reheat control signal feedback"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput yDamAct_in
    "Actual damper position feedback"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput yReaHea_in
    "Actual reheat control signal feedback"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  IBPSA.Utilities.IO.SignalExchange.Read TSup(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  IBPSA.Utilities.IO.SignalExchange.Read PHea(
    description="Gas power consumption for reheat for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    y(unit="W")) "Gas power consumption for reheat"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  Modelica.Blocks.Interfaces.RealInput PHea_in "Gas power used for reheat"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,100},{-120,100}},
                                                 color={0,0,127}));
  connect(yDamAct_in, yDamAct.u)
    annotation (Line(points={{-120,60},{-2,60}}, color={0,0,127}));
  connect(yReaHea_in, yReaHea.u)
    annotation (Line(points={{-120,20},{-2,20}},
                                               color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,-20},{-120,-20}}, color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,-60},{-120,-60}}, color={0,0,127}));
  connect(PHea_in, PHea.u)
    annotation (Line(points={{-120,-100},{-2,-100}}, color={0,0,127}));
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
