within IDEAS.Examples.PPD12.Data;
record RoofHor "Ppd12 horizontal roof"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Screed(d=0.01),
      IDEAS.Buildings.Data.Insulation.Glasswool(d=0.05),
      IDEAS.Buildings.Data.Materials.Timber(d=0.02)});

end RoofHor;
