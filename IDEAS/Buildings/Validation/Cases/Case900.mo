within IDEAS.Buildings.Validation.Cases;
model Case900
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare replaceable BaseClasses.Structure.Bui900 building,
    redeclare replaceable BaseClasses.Occupant.Gain occupant,
    redeclare replaceable BaseClasses.HeatingSystem.Deadband heatingSystem(VZones=
          building.VZones),
    redeclare replaceable BaseClasses.VentilationSystem.None ventilationSystem,
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);
end Case900;
