within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadZone "Collection of zone measurements for BOPTEST"
  IBPSA.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));

  IBPSA.Utilities.IO.SignalExchange.Read yDamAct(
    description="Damper position set point feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Damper position setpoint feedback"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  IBPSA.Utilities.IO.SignalExchange.Read yReaHea(
    description="Reheat control signal set point feedback for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "Reheat control signal feedback"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput yDamAct_in
    "Actual damper position feedback"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput yReaHea_in
    "Actual reheat control signal feedback"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  IBPSA.Utilities.IO.SignalExchange.Read TSup(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  IBPSA.Utilities.IO.SignalExchange.Read PHea(
    description="Electrical power consumption for reheat for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electrical power consumption for reheat"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));

  Modelica.Blocks.Interfaces.RealInput PHea_in
    "Electrical power used for reheat"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{-60,-130},{-40,-110}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{-30,-130},{-10,-110}})));
  IBPSA.Utilities.IO.SignalExchange.Read CO2Zon(
    description="Zone air CO2 measurement for zone " + zone,
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm"),
    zone=zone) "Zone air CO2 concentration measurement"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));

  Modelica.Blocks.Interfaces.RealInput C_In "Mass fraction of CO2"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,120},{-120,120}},
                                                 color={0,0,127}));
  connect(yDamAct_in, yDamAct.u)
    annotation (Line(points={{-120,80},{-2,80}}, color={0,0,127}));
  connect(yReaHea_in, yReaHea.u)
    annotation (Line(points={{-120,40},{-2,40}},
                                               color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,0},{-120,0}},     color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,-40},{-120,-40}}, color={0,0,127}));
  connect(PHea_in, PHea.u)
    annotation (Line(points={{-120,-80},{-2,-80}},   color={0,0,127}));
  connect(conMasVolFra.V,gaiPPM. u)
    annotation (Line(points={{-39,-120},{-32,-120}},
                                                 color={0,0,127}));
  connect(gaiPPM.y, CO2Zon.u)
    annotation (Line(points={{-9,-120},{-2,-120}}, color={0,0,127}));
  connect(conMasVolFra.m, C_In)
    annotation (Line(points={{-61,-120},{-120,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{100,140}}),                                  graphics={
          Rectangle(
          extent={{-100,140},{100,-140}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,176},{52,142}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-140},{100,140}})));
end ReadZone;
