within TwoZoneApartmentHydronic.Components.Rooms;
model NightZone "Milan night zone thermal zone istance"
  extends thermalZone;
  Buildings.Utilities.IO.SignalExchange.Read reaTRooOpe(
    description="Zone operative temperature",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature,
    y(unit="K"),
    zone=zonName) "Read room air temperature"
    annotation (Placement(transformation(extent={{106,36},{118,48}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooRadSen
    "Room radiative temperature"
    annotation (Placement(transformation(extent={{72,40},{82,50}})));
  Modelica.Blocks.Math.Add add(k1=+0.5, k2=+0.5)
    annotation (Placement(transformation(extent={{88,36},{100,48}})));
equation
  connect(roo.heaPorRad, TRooRadSen.port) annotation (Line(points={{48.25,18.15},
          {62,18.15},{62,32},{68,32},{68,45},{72,45}}, color={191,0,0}));
  connect(reaTRooOpe.u, add.y)
    annotation (Line(points={{104.8,42},{100.6,42}}, color={0,0,127}));
  connect(TRooAirSen.T, add.u2) annotation (Line(points={{76.5,23},{78,23},{78,
          38.4},{86.8,38.4}}, color={0,0,127}));
  connect(TRooRadSen.T, add.u1) annotation (Line(points={{82.5,45},{82.5,45.6},
          {86.8,45.6}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
end NightZone;
