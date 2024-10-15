within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record ceiling
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.screed(d=0.04),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.insulation(d=0.04),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.concrete(d=0.22),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.plaster(d=0.01),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.insul_underceil(d=0.1)});
end ceiling;
