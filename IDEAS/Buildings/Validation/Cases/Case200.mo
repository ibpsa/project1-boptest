within IDEAS.Buildings.Validation.Cases;
model Case200

  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.Structure.Bui200 building,
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.Occupant.None occupant,
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.HeatingSystem.Bangbang
      heatingSystem(VZones=building.VZones),
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);

end Case200;
