within IDEAS.Buildings.Validation.Cases;
model Case650
  extends IDEAS.Buildings.Validation.Cases.Case600(
    redeclare replaceable BaseClasses.HeatingSystem.Deadband_650 heatingSystem(VZones=
          building.VZones),
    redeclare replaceable BaseClasses.VentilationSystem.NightVentilation ventilationSystem);

end Case650;
