within IDEAS.Buildings.Components.RoomType;
record Office "Office room type"
  extends IDEAS.Buildings.Components.RoomType.BaseClasses.PartialRoomType(
    Ev = 500);
  annotation (Documentation(revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>Record for lighting requirements for office typical work
(writing, typing, reading, data processing...). Based on
standard EN 12464-1, Table 5.26 (5.26.2)</p>
</html>"));
end Office;
