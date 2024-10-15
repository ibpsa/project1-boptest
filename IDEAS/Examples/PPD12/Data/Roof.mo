within IDEAS.Examples.PPD12.Data;
record Roof "Ppd12 roof"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Slate(d=0.006),
      IDEAS.Buildings.Data.Materials.Air(d=0.03),
      IDEAS.Buildings.Data.Insulation.Pur(d=0.12),
      IDEAS.Buildings.Data.Materials.Air(d=0.04),
      IDEAS.Buildings.Data.Insulation.Glasswool(d=0.05),
      IDEAS.Buildings.Data.Materials.Gypsum(d=0.0125)});

end Roof;
