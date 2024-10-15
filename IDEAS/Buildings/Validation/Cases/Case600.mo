within IDEAS.Buildings.Validation.Cases;
model Case600
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.Structure.Bui600 building,
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.Occupant.Gain occupant,
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.HeatingSystem.Deadband
      heatingSystem(VZones=building.VZones),
    redeclare replaceable IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);

end Case600;
