within IDEAS.Buildings.Components.RoomType.BaseClasses;
partial record PartialRoomType
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Illuminance Ev
    "Illuminance requirement of the zone";

  annotation (Documentation(revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
This record describes the function of the zone.
</p>
<p>
At this point, this record only contains the illuminance requirements of the zone.
In the future, other functionality may be added.
</p>
</html>"));
end PartialRoomType;
