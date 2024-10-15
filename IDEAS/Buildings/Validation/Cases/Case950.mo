within IDEAS.Buildings.Validation.Cases;
model Case950
  extends IDEAS.Buildings.Validation.Interfaces.BesTestCase(
    redeclare replaceable BaseClasses.Structure.Bui900 building,
    redeclare replaceable BaseClasses.Occupant.Gain occupant,
    redeclare replaceable BaseClasses.VentilationSystem.NightVentilation ventilationSystem,
    redeclare replaceable BaseClasses.HeatingSystem.Deadband_650 heatingSystem(VZones=
          building.VZones),
    redeclare replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
      inHomeGrid);

end Case950;
