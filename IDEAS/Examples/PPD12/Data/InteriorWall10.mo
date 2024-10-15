within IDEAS.Examples.PPD12.Data;
record InteriorWall10 "Ppd12 interior wall 10cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02),
      IDEAS.Buildings.Data.Materials.BrickMi(d=0.10),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02)});

end InteriorWall10;
