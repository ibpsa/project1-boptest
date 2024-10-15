within IDEAS.Examples.PPD12.Data;
record FloorAttic "Ppd12 attic floor with suspended gypsum ceiling"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Ceiling,
    final mats={
    IDEAS.Buildings.Data.Materials.Timber(d=0.022),
    IDEAS.Buildings.Data.Materials.Air(d=0.15),
    IDEAS.Buildings.Data.Materials.Gypsum(d=0.0125)});

end FloorAttic;
