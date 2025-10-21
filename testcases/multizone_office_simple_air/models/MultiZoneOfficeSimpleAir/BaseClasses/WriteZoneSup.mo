within MultiZoneOfficeSimpleAir.BaseClasses;
model WriteZoneSup
  "Collection of zone supervisory overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput TZonHeaSet_in
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Modelica.Blocks.Interfaces.RealInput TZonCooSet_in
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TZonHeaSet(description=
        "Zone air temperature heating setpoint for zone " + zone, u(
      unit="K",
      min=285.15,
      max=313.15))
    "Zone air temperature heating setpoint"
    annotation (__Buildings(semantic(
     metadataLanguage="Brick 1.3 text/turtle"
     "bldg:<cdl_instance_name> a brick:Zone_Air_Heating_Temperature_Setpoint;
      qudt:hasQuantityKind quantitykind:Temperature;
      qudt:hasUnit qudt:K.
      ")),
          Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TZonCooSet(description=
        "Zone air temperature cooling setpoint for zone " + zone, u(
      unit="K",
      min=285.15,
      max=313.15))
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeaSet_out
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCooSet_out
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(TZonHeaSet_in, TZonHeaSet.u) annotation (Line(
      points={{-120,40},{-62,40},{-2,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonCooSet_in, TZonCooSet.u) annotation (Line(
      points={{-120,-40},{-62,-40},{-2,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonHeaSet.y, TZonHeaSet_out) annotation (Line(
      points={{21,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonCooSet.y, TZonCooSet_out) annotation (Line(
      points={{21,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
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
          textString="%name"),
        Text(
          extent={{-34,22},{32,-18}},
          lineColor={0,0,0},
          textString="Write
Zone
Sup")}),                         Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end WriteZoneSup;
