within IDEAS.Examples.PPD12.Data;
record InteriorWall30 "Ppd12 interior wall 30cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.015),
      IDEAS.Buildings.Data.Materials.BrickMi(d=0.27),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});

end InteriorWall30;
