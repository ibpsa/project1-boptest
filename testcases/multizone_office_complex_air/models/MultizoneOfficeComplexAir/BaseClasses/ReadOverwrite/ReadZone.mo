within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadZone "Collection of zone measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));

  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{0,2},{20,22}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-8},{-100,32}})));

  Buildings.Utilities.IO.SignalExchange.Read yReheaVal(
    description="Reheat valve position measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Reheat valve position measurement"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));

  Buildings.Utilities.IO.SignalExchange.Read yDam(
    description="Damper position measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Damper position measurement"
    annotation (Placement(transformation(extent={{0,120},{20,140}})));

  Modelica.Blocks.Interfaces.RealInput yReheaVal_in
    "Reheat valve position measurement"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput yDam_in "Damper position measurement"
    annotation (Placement(transformation(extent={{-140,110},{-100,150}})));
  Buildings.Utilities.IO.SignalExchange.Read TRoo_Coo_set(
    description="Zone temperature cooling setpoint for zone" + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    zone=zone) "Zone temperature cooling setpoint"
    annotation (Placement(transformation(extent={{0,-84},{20,-64}})));

  Buildings.Utilities.IO.SignalExchange.Read TRoo_Hea_set(
    description="Zone temperature heating setpoint for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    zone=zone) "Zone temperature heating setpoint"
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));

  Modelica.Blocks.Interfaces.RealInput TRoo_Coo_set_in
    "Zone temperature cooling setpoint"
    annotation (Placement(transformation(extent={{-140,-94},{-100,-54}})));
  Modelica.Blocks.Interfaces.RealInput TRoo_Hea_set_in
    "Zone temperature heating setpoint"
    annotation (Placement(transformation(extent={{-140,-62},{-100,-22}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow_set(
    description="Airflow setpoint" + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s"),
    zone=zone) "Minimum airflow setpoint"
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));

  Modelica.Blocks.Interfaces.RealInput Vflow_set_in "Airflow setpoint"
    annotation (Placement(transformation(extent={{-140,-34},{-100,6}})));

  Buildings.Utilities.IO.SignalExchange.Read yHea(
    description="Heating PID signal measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Heating PID signal measurement"
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));

  Buildings.Utilities.IO.SignalExchange.Read yCoo(
    description="Cooling PID signal measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1"),
    zone=zone) "Cooling PID signal measurement"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  Modelica.Blocks.Interfaces.RealInput yHea_in "Heating PID signal measurement"
    annotation (Placement(transformation(extent={{-140,-150},{-100,-110}})));
  Modelica.Blocks.Interfaces.RealInput yCoo_in "Cooling PID signal measurement"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2Zon(
    description="Zone air CO2 measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,

    y(unit="ppm"),
    zone=zone) "Zone air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-170},{20,-150}})));
  Modelica.Blocks.Interfaces.RealInput CO2Zon_in "Volume fraction of CO2 (PPM)"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,70},{-120,70}}, color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,40},{-120,40}},   color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,12},{-120,12}},   color={0,0,127}));
  connect(yReheaVal_in, yReheaVal.u)
    annotation (Line(points={{-120,100},{-2,100}}, color={0,0,127}));
  connect(yDam_in, yDam.u)
    annotation (Line(points={{-120,130},{-2,130}}, color={0,0,127}));
  connect(TRoo_Coo_set_in, TRoo_Coo_set.u)
    annotation (Line(points={{-120,-74},{-2,-74}},   color={0,0,127}));
  connect(TRoo_Hea_set_in, TRoo_Hea_set.u)
    annotation (Line(points={{-120,-42},{-2,-42}},   color={0,0,127}));
  connect(Vflow_set_in, V_flow_set.u)
    annotation (Line(points={{-120,-14},{-2,-14}},   color={0,0,127}));
  connect(yHea_in,yHea. u)
    annotation (Line(points={{-120,-130},{-2,-130}},
                                                 color={0,0,127}));
  connect(yCoo_in,yCoo. u)
    annotation (Line(points={{-120,-100},{-2,-100}},
                                                   color={0,0,127}));
  connect(CO2Zon_in, CO2Zon.u)
    annotation (Line(points={{-120,-160},{-2,-160}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{100,140}}),                                  graphics={
          Rectangle(
          extent={{-100,140},{100,-180}},
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
            false, extent={{-100,-180},{100,140}})));
end ReadZone;
