within IDEAS.Examples.PPD12.Data;
record CommonWall "Ppd12 common wall neighbours"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.BrickMi(d=0.08),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02)});

end CommonWall;
