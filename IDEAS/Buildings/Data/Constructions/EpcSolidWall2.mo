within IDEAS.Buildings.Data.Constructions;
record EpcSolidWall2 "EPC: muurtype 2 / wall type 2"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.BrickMe(d=0.15),
      IDEAS.Buildings.Data.Insulation.Rockwool(d=0.1),
      IDEAS.Buildings.Data.Materials.BrickMi(d=0.15)});


  annotation (Documentation(info="<html>
<p>
Implementation of the Belgian EPC 'wall type 2'.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end EpcSolidWall2;
