within BuildingEmulators.Data;
record ConcreteInternalFloor
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Wall,
    mats={IDEAS.Buildings.Data.Materials.Tile(d=0.01),
    IDEAS.Buildings.Data.Materials.Concrete(d=0.25),
    IDEAS.Buildings.Data.Materials.Tile(d=0.01)});
end ConcreteInternalFloor;
