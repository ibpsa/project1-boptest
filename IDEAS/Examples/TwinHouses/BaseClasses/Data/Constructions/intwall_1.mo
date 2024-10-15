within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record intwall_1
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.int_plaster2(d=0.01),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.honeycomb_bricki(d=0.24),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.int_plaster2(d=0.01)});
end intwall_1;
