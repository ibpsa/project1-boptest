within MultiZoneOfficeSimpleAir.BaseClasses;
model WriteZoneLoc "Collection of zone local overwrite points for BOPTEST"
  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature,
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity,
    or CO2Concentration";
  Modelica.Blocks.Interfaces.RealInput yDam_in
    "Control signal for terminal box damper"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput yReaHea_in
    "Control signal for terminal box reheat"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yDam(description=
        "Damper position setpoint for zone " + zone, u(
      unit="1",
      min=0,
      max=1)) "Damper position setpoint"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yReaHea(description=
        "Reheat control signal for zone " + zone, u(
      unit="1",
      min=0,
      max=1)) "Reheat control signal"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput yDam_out
    "Control signal for terminal box damper"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yReaHea_out
    "Control signal for terminal box reheat"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(yDam_in,yDam. u) annotation (Line(
      points={{-120,40},{-61,40},{-2,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yReaHea_in,yReaHea. u) annotation (Line(
      points={{-120,-40},{-2,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yDam.y, yDam_out) annotation (Line(
      points={{21,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(yReaHea.y, yReaHea_out) annotation (Line(
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
          extent={{-32,22},{34,-18}},
          lineColor={0,0,0},
          textString="Write
Zone
Loc")}),                         Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end WriteZoneLoc;
