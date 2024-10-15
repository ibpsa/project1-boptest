within IDEAS.Buildings.Data.Constructions;
record TABS "Classic TABS floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={1},
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={IDEAS.Buildings.Data.Materials.Concrete(d=0.125),
    IDEAS.Buildings.Data.Materials.Concrete(d=0.125),
    IDEAS.Buildings.Data.Insulation.Rockwool(d=0.01),
    IDEAS.Buildings.Data.Materials.Screed(d=0.05),
        IDEAS.Buildings.Data.Materials.Tile(d=0.005)});

annotation (Documentation(info="<html>
<p>
Example implementation of a Thermally Activated Building System.
</p>
</html>", revisions="<html>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
end TABS;
