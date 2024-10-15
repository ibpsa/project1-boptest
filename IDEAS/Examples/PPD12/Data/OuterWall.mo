within IDEAS.Examples.PPD12.Data;
record OuterWall "Ppd12 outer wall 30cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.BrickMe(d=0.27),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.02)});

end OuterWall;
