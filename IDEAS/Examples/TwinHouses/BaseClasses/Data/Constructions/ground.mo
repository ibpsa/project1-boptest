within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record ground
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay=IDEAS.Types.Tilt.Floor,
    final mats={
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.concrete2(d=0.22),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.levelling(d=0.029),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.pur_damm(d=0.03),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.composite(d=0.033),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.screed(d=0.065)});
end ground;
