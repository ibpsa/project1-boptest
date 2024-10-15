within IDEAS.Examples.PPD12.Data;
record FloorOnGround "Ppd12 floor on ground"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Tile(d=0.04),
      IDEAS.Buildings.Data.Materials.Timber(d=0.02)});

end FloorOnGround;
