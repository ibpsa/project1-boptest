within MultiZoneResidentialHydronic.Building.Control;
model ConHeaZon "Controller for zone heating"
  extends ConHea(oveTSetHea(   u(
        min=273.15 + 10,
        max=273.15 + 30,
        unit="K")),
                 oveActHea(u(
        min=0,
        max=1,
        unit="1")));
  IBPSA.Utilities.IO.SignalExchange.Read reaTZon(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    y(unit="K"),
    description="Air temperature of zone " + zone,
    zone=zone)
    annotation (Placement(transformation(extent={{-88,0},{-80,8}})));

equation
  connect(reaTZon.u, T) annotation (Line(points={{-88.8,4},{-94,4},{-94,12},{
          -108,12}}, color={0,0,127}));
end ConHeaZon;
