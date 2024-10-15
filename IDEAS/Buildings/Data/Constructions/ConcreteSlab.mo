within IDEAS.Buildings.Data.Constructions;
record ConcreteSlab "Simple concrete floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    locGain={1},
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={IDEAS.Buildings.Data.Materials.Concrete(d=0.125),
    IDEAS.Buildings.Data.Materials.Concrete(d=0.125)});

annotation (Documentation(info="<html>
<p>
Example implementation of a Thermally Activated Building System.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
March 7, 2017 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end ConcreteSlab;
