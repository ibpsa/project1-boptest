within IDEAS.Examples.PPD12.Data;
record GlassWall "PPD12 glazed doors"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Glass(d=0.005)});

end GlassWall;
