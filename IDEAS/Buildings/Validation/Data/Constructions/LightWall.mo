within IDEAS.Buildings.Validation.Data.Constructions;
record LightWall "BESTEST light wall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.WoodSiding(d=0.009),
      IDEAS.Buildings.Validation.Data.Insulation.FiberGlass(d=0.066),
      IDEAS.Buildings.Validation.Data.Materials.PlasterBoard(d=0.012)});
end LightWall;
