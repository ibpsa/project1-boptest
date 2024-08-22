within MultiZoneOfficeSimpleAir.BaseClasses;
model ReadZone "Collection of zone measurements for BOPTEST"
  Buildings.Utilities.IO.SignalExchange.Read TZon(
    description="Zone air temperature measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    zone=zone) "Zone air temperature measurement"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Zone_Air_Temperature ;
          ref:hasExternalReference bldg:<cdl_instance_name>_Reference ;
          qudt:hasQuantityKind quantitykind:Temperature ;
          qudt:hasUnit qudt:K .
      bldg:<cdl_instance_name>_Reference a ref:BOPTestReference ;
          ref:name literal:<cdl_instance_name>_y ;
          ref:description literal:description ;
          ref:zone literal:zone;
          ref:unit literal:K ;
          ref:isWritable false. ")),
          Placement(transformation(extent={{0,50},{20,70}})));

  Modelica.Blocks.Interfaces.RealInput TZon_in
    "Zone air temperature measurement"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Buildings.Utilities.IO.SignalExchange.Read TSup(
    description="Discharge air temperature to zone measurement for zone " +
        zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Supply_Air_Temperature_Sensor;
          ref:hasExternalReference bldg:<cdl_instance_name>_Reference;
          qudt:hasQuantityKind quantitykind:Temperature;
          qudt:hasUnit qudt:K.
      bldg:<cdl_instance_name>_Reference a ref:BOPTestReference;
          ref:name literal:<cdl_instance_name>_y;
          ref:description literal:description;
          ref:zone literal:zone;
          ref:equipment literal:equipment;
          ref:unit literal:K;
          ref:isWritable false.")),
          Placement(transformation(extent={{0,10},{20,30}})));
  Buildings.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Supply_Air_Flow_Sensor;
          ref:hasExternalReference bldg:<cdl_instance_name>_Reference;
          qudt:hasQuantityKind quantitykind:VolumeFlowRate;
          qudt:hasUnit qudt:M3-PER-SEC.
      bldg:<cdl_instance_name>_Reference a ref:BOPTestReference;
          ref:name literal:<cdl_instance_name>_y;
          ref:description literal:description;
          ref:zone literal:zone;
          ref:equipment literal:equipement;
          ref:unit literal:m3_per_s;
          ref:isWritable false.")),
          Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSup_in
    "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_in
    "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));

  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Buildings.Utilities.IO.SignalExchange.Read CO2Zon(
    description="Zone air CO2 measurement for zone " + zone,
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm"),
    zone=zone) "Zone air CO2 concentration measurement"
    annotation (__Buildings(semantic(
      metadataLanguage="Brick 1.3 text/turtle"
      "bldg:<cdl_instance_name> a brick:Zone_CO2;
          ref:hasExternalReference bldg:<cdl_instance_name>_Reference;    
          qudt:hasUnit qudt:PPM.
      bldg:<cdl_instance_name>_Reference a ref:BOPTestReference;
          ref:name literal:<cdl_instance_name>_y;
          ref:description literal:description;
          ref:zone literal:zone;
          ref:unit literal:ppm;
          ref:isWritable false.")),
          Placement(transformation(extent={{0,-70},{20,-50}})));

  Modelica.Blocks.Interfaces.RealInput C_In "Mass fraction of CO2"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  connect(TZon.u, TZon_in)
    annotation (Line(points={{-2,60},{-120,60}}, color={0,0,127}));
  connect(TSup.u, TSup_in)
    annotation (Line(points={{-2,20},{-120,20}},   color={0,0,127}));
  connect(V_flow.u, V_flow_in)
    annotation (Line(points={{-2,-20},{-120,-20}}, color={0,0,127}));
  connect(conMasVolFra.V,gaiPPM. u)
    annotation (Line(points={{-39,-60},{-32,-60}},
                                                 color={0,0,127}));
  connect(gaiPPM.y, CO2Zon.u)
    annotation (Line(points={{-9,-60},{-2,-60}},   color={0,0,127}));
  connect(conMasVolFra.m, C_In)
    annotation (Line(points={{-61,-60},{-120,-60}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,80}}),                                   graphics={
          Rectangle(
          extent={{-100,80},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,176},{52,142}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-28,24},{38,-16}},
          lineColor={0,0,0},
          textString="Read
Zone")}),                        Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}})));
end ReadZone;
