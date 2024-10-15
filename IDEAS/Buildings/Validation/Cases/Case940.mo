within IDEAS.Buildings.Validation.Cases;
model Case940
  extends IDEAS.Buildings.Validation.Cases.Case900(
    redeclare replaceable BaseClasses.VentilationSystem.None ventilationSystem,
    redeclare replaceable BaseClasses.HeatingSystem.ThermostatSetback heatingSystem(VZones=
          building.VZones));
end Case940;
