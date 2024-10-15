within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record column
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.concrete(d=0.07)});
end column;
