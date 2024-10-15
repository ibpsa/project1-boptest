within IDEAS.Buildings.Validation.Data.Insulation;
record FiberGlass =
  IDEAS.Buildings.Data.Interfaces.Insulation (
    final k=0.040,
    final c=840,
    final rho=12,
    epsLw=0.9,
    epsSw=0.6) "BESTEST fiberglass insulation";
