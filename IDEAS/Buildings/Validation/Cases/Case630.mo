within IDEAS.Buildings.Validation.Cases;
model Case630
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare replaceable BaseClasses.Occupant.Gain occupant,
    redeclare replaceable BaseClasses.Structure.Bui630 building,
    redeclare replaceable BaseClasses.VentilationSystem.None ventilationSystem,
    redeclare replaceable BaseClasses.HeatingSystem.Deadband heatingSystem(VZones=building.VZones),
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);
end Case630;
