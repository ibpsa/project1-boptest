within TwoZoneApartmentHydronic.Components.Rooms;
model NightZone "Milan night zone thermal zone istance"
  extends thermalZone;
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
