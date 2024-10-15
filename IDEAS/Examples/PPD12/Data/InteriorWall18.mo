within IDEAS.Examples.PPD12.Data;
record InteriorWall18 "Ppd12 interior wall 18 cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01),
      IDEAS.Buildings.Data.Materials.BrickMi(d=0.18),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.01)});

end InteriorWall18;
