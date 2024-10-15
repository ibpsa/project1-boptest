within IDEAS.Examples.PPD12.Data;
record Floor "Ppd12 floor with suspended gypsum ceiling"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Floor,
    final mats={
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.0125),
      IDEAS.Buildings.Data.Materials.Air(d=0.075),
      IDEAS.Buildings.Data.Insulation.Glasswool(d=0.05),
      IDEAS.Buildings.Data.Materials.Air(d=0.15),
      IDEAS.Buildings.Data.Materials.Timber(d=0.022)});

end Floor;
