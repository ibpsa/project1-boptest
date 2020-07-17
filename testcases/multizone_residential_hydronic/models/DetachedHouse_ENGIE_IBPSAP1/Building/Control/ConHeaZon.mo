within DetachedHouse_ENGIE_IBPSAP1.Building.Control;
model ConHeaZon "Controller for zone heating"
  extends ConHea(oveActHea(u(
        min=0,
        max=1,
        unit="1")), oveTsetHea(u(
        min=273.15 + 10,
        max=273.15 + 30,
        unit="K")));
  IBPSA.Utilities.IO.SignalExchange.Read reaTzon(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    description="Zone air temperature",
    zone=zone)
    annotation (Placement(transformation(extent={{-88,0},{-80,8}})));

  parameter String zone="1" "Zone designation, required if KPIs is AirZoneTemperature, 
    RadiativeZoneTemperature, OperativeZoneTemperature, RelativeHumidity, 
    or CO2Concentration";
equation
  connect(reaTzon.u, T) annotation (Line(points={{-88.8,4},{-94,4},{-94,12},{
          -108,12}}, color={0,0,127}));
end ConHeaZon;
