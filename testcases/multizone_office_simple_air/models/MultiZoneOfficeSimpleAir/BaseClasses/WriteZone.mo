within MultiZoneOfficeSimpleAir.BaseClasses;
model WriteZone "Collection of zone overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput TZonHeaSet_in
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Modelica.Blocks.Interfaces.RealInput TZonCooSet_in
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput uDam_in
    "Control signal for terminal box damper"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput uReaHea_in
    "Control signal for terminal box reheat"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite TZonHeaSet(description=
        "Zone air temperature heating setpoint for zone " + zone, u(
      unit="K",
      min=285.15,
      max=313.15))
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite TZonCooSet(description=
        "Zone air temperature cooling setpoint for zone " + zone, u(
      unit="K",
      min=285.15,
      max=313.15))
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uDam(description=
        "Damper position setpoint for zone " + zone, u(
      unit="1",
      min=0,
      max=1)) "Damper position setpoint"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uReaHea(description=
        "Reheat control signal for zone " + zone, u(
      unit="1",
      min=0,
      max=1)) "Reheat control signal"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneHeaSet_out
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput TZoneCooSet_out
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yDam
    "Control signal for terminal box damper"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yReaHea
    "Control signal for terminal box reheat"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(TZonHeaSet_in, TZonHeaSet.u) annotation (Line(
      points={{-120,80},{-62,80},{-2,80}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonCooSet_in, TZonCooSet.u) annotation (Line(
      points={{-120,40},{-62,40},{-2,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uDam_in, uDam.u) annotation (Line(
      points={{-120,0},{-61,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uReaHea_in, uReaHea.u) annotation (Line(
      points={{-120,-40},{-2,-40},{-2,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonHeaSet.y, TZoneHeaSet_out) annotation (Line(
      points={{21,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TZonCooSet.y, TZoneCooSet_out) annotation (Line(
      points={{21,40},{110,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uDam.y, yDam) annotation (Line(
      points={{21,0},{110,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uReaHea.y, yReaHea) annotation (Line(
      points={{21,-40},{110,-40},{110,-40}},
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end WriteZone;
