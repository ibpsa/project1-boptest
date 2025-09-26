within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadZone "Collection of zone measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));

  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{0,-38},{20,-18}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-48},{-100,-8}})));

  Buildings.Utilities.IO.SignalExchange.Read yReheaVal(
    description="Reheat valve position measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Reheat valve position measurement"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));

  Buildings.Utilities.IO.SignalExchange.Read yDam(
    description="Damper position measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Damper position measurement"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));

  Modelica.Blocks.Interfaces.RealInput yReheaVal_in
    "Reheat valve position measurement"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput yDam_in "Damper position measurement"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));

  Buildings.Utilities.IO.SignalExchange.Read V_flowSet(
    description="Airflow setpoint " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"),
    zone=zone) "Minimum airflow setpoint"
    annotation (Placement(transformation(extent={{0,-64},{20,-44}})));

  Modelica.Blocks.Interfaces.RealInput V_flowSet_in "Airflow setpoint"
    annotation (Placement(transformation(extent={{-140,-74},{-100,-34}})));

  Buildings.Utilities.IO.SignalExchange.Read CO2Zon(
    description="Zone air CO2 measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm"),
    zone=zone) "Zone air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));

  Modelica.Blocks.Interfaces.RealInput CO2Zon_in "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,30},{-120,30}}, color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,0},{-120,0}},     color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,-28},{-120,-28}}, color={0,0,127}));
  connect(yReheaVal_in, yReheaVal.u)
    annotation (Line(points={{-120,60},{-2,60}},   color={0,0,127}));
  connect(yDam_in, yDam.u)
    annotation (Line(points={{-120,90},{-2,90}},   color={0,0,127}));
  connect(V_flowSet_in, V_flowSet.u)
    annotation (Line(points={{-120,-54},{-2,-54}}, color={0,0,127}));
  connect(CO2Zon_in, CO2Zon.u)
    annotation (Line(points={{-120,-80},{-2,-80}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}),                                  graphics={
          Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-28,24},{38,-16}},
          lineColor={0,0,0},
          textString="Read
Zone"), Text(
          extent={{-152,152},{148,192}},
          textString="%name",
          textColor={0,0,255})}),Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,120}})));
end ReadZone;
