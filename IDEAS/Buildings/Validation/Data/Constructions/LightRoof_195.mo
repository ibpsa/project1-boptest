within IDEAS.Buildings.Validation.Data.Constructions;
record LightRoof_195 "BESTEST light roof for case 195"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Ceiling,
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.Roofdeck_195(d=0.019),
      IDEAS.Buildings.Validation.Data.Insulation.FiberGlass(d=0.1118),
      IDEAS.Buildings.Validation.Data.Materials.PlasterBoard(d=0.010)});

end LightRoof_195;
