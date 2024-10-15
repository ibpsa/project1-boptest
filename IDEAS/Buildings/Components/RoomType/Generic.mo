within IDEAS.Buildings.Components.RoomType;
record Generic "Generic room type"
  extends IDEAS.Buildings.Components.RoomType.BaseClasses.PartialRoomType(
    Ev = 300);
  annotation (Documentation(revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>Record for lighting requirements for a generic zone.
Based on standard EN 12464-1, Table 5.31 (5.31.1)</p>
</html>"));
end Generic;
