within IDEAS.Buildings.Components.OccupancyType;
record OfficeWork
  "Properties for typical office work."
  extends IDEAS.Buildings.Components.OccupancyType.BaseClasses.PartialOccupancyType(
    QlatPp=45,
    QsenPp=73,
    radFra=0.6,
    ICl=0.7);
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
See documentation in IDEAS.Buildings.Components.OccupancyType.PartialOccupancyType.
This model is based on Fanger and Ashrae Fundamentals (2009).
</p>
<h4>References</h4>
<ul>
<li>
ASHRAE Handbook, Fundamentals.
 American Society of Heating, Refrigerating and Air-Conditioning Engineers,
Chapter 18, Internal Heat Gains; pages 18.4; Atlanta, USA, 2009.
</li>
</ul>
</html>"));
end OfficeWork;
