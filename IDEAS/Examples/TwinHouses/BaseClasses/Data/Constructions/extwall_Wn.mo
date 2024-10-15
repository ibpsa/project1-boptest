within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record extwall_Wn
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.ext_plaster(d=0.01),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.ins_mw(d=0.08),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.formerext_plast(d=0.03),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.honeycomb_brick(d=0.3),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.int_plaster(d=0.1)});
end extwall_Wn;
