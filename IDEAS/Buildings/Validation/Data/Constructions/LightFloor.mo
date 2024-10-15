within IDEAS.Buildings.Validation.Data.Constructions;
record LightFloor "BESTEST light floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Floor,
    mats={
      IDEAS.Buildings.Validation.Data.Insulation.InsulationFloor(d=1.003),
      IDEAS.Buildings.Validation.Data.Materials.TimberFlooring(d=0.025)});

  annotation (Documentation(revisions="<html>
<ul>
<li>
July 19, 2016, Filip Jorissen:<br/>
Corrected wrong value in implementation.
</li>
</ul>
</html>"));
end LightFloor;
