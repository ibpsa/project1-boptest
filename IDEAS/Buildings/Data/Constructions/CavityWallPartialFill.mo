within IDEAS.Buildings.Data.Constructions;
record CavityWallPartialFill
  "Cavity wall with partially-filled cavity"
 extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Wall,
    mats={
      IDEAS.Buildings.Data.Materials.BrickHe(d=0.08),
      IDEAS.Buildings.Data.Materials.Air(d=0.03),
      IDEAS.Buildings.Data.Insulation.Rockwool(d=0.1),
      IDEAS.Buildings.Data.Materials.BrickLe(d=0.14),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});


  annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall with a partially filled cavity.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end CavityWallPartialFill;
