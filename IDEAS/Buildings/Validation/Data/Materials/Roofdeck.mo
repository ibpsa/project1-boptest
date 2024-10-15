within IDEAS.Buildings.Validation.Data.Materials;
record Roofdeck
  "BESTEST roof deck"
  extends IDEAS.Buildings.Data.Interfaces.Material(
    final k=0.14,
    final c=900,
    final rho=530,
    epsLw=0.9,
    epsSw=0.6);
end Roofdeck;
