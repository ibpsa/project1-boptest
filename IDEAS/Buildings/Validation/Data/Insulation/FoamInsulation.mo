within IDEAS.Buildings.Validation.Data.Insulation;
record FoamInsulation =
  IDEAS.Buildings.Data.Interfaces.Insulation (
    final k=0.040,
    final c=1400,
    final rho=10,
    epsLw=0.9,
    epsSw=0.6) "BESTEST foam insulation";
