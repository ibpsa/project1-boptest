within IDEAS.Buildings.Data.Constructions;
record FloorOnGround "Floor on ground for floor heating system"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={3},
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={
      IDEAS.Buildings.Data.Materials.Concrete(d=0.20),
      IDEAS.Buildings.Data.Insulation.Rockwool(d=0.1),
      IDEAS.Buildings.Data.Materials.Screed(d=0.08),
      IDEAS.Buildings.Data.Materials.Concrete(d=0.015)});


  annotation (Documentation(revisions="<html>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end FloorOnGround;
