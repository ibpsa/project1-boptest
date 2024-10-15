within IDEAS.Buildings.Data.Constructions;
record InsulatedFloorHeating "Floor heating example with heat injection between PUR and screed"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={2},
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={IDEAS.Buildings.Data.Materials.Concrete(d=0.10),
    IDEAS.Buildings.Data.Insulation.Pur(d=0.07),
    IDEAS.Buildings.Data.Materials.Screed(d=0.05),
    IDEAS.Buildings.Data.Materials.Tile(d=0.01)});

annotation (Documentation(info="<html>
<p>
Example implementation of a floor heating construction record.
</p>
</html>", revisions="<html>
<ul>
<li>
June 8, 2018, by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end InsulatedFloorHeating;
