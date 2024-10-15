within IDEAS.Buildings.Validation.Cases;
model Case600FF
  extends IDEAS.Buildings.Validation.Cases.Case600(
    redeclare replaceable BaseClasses.HeatingSystem.None heatingSystem,
    redeclare replaceable BaseClasses.VentilationSystem.None ventilationSystem);
end Case600FF;
