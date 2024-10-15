within IDEAS.Buildings.Validation.Cases;
model Case195
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare IDEAS.Buildings.Validation.BaseClasses.Structure.Bui195 building,
    redeclare IDEAS.Buildings.Validation.BaseClasses.Occupant.None occupant,
    redeclare IDEAS.Buildings.Validation.BaseClasses.HeatingSystem.Bangbang
      heatingSystem(VZones=building.VZones),
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    redeclare IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);

end Case195;
