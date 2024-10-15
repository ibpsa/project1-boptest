within IDEAS.Buildings.Validation.Data.Constructions;
record HeavyFloor "BESTEST heavy floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Floor,
    final mats={
      IDEAS.Buildings.Validation.Data.Insulation.InsulationFloor(d=1.007),
      IDEAS.Buildings.Validation.Data.Materials.ConcreteSlab(d=0.08)});

end HeavyFloor;
