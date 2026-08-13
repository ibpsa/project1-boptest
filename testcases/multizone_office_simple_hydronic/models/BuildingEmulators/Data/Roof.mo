within BuildingEmulators.Data;
record Roof "Horizontal roof"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Data.Materials.Screed(d=0.02),
      IDEAS.Buildings.Data.Insulation.Glasswool(d=0.10),
      IDEAS.Buildings.Data.Materials.Plywood(d=0.02)});

end Roof;
