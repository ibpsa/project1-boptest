within BuildingEmulators.Data;
record InteriorWall7 "Interior wall 7cm"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.015),
      IDEAS.Buildings.Data.Materials.BrickHollow(d=0.07),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});

end InteriorWall7;
