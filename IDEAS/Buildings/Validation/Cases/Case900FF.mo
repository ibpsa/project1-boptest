within IDEAS.Buildings.Validation.Cases;
model Case900FF
  extends IDEAS.Buildings.Validation.Cases.Case900(
    redeclare replaceable BaseClasses.HeatingSystem.None heatingSystem,
    redeclare replaceable BaseClasses.VentilationSystem.None ventilationSystem);
end Case900FF;
