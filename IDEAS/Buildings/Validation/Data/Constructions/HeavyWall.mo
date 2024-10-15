within IDEAS.Buildings.Validation.Data.Constructions;
record HeavyWall "BESTEST heavy wall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.WoodSiding(d=0.009),
      IDEAS.Buildings.Validation.Data.Insulation.FoamInsulation(d=0.0615),
      IDEAS.Buildings.Validation.Data.Materials.ConcreteBlock(d=0.10)});

end HeavyWall;
