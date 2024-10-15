within IDEAS.Buildings.Validation.Data.Materials;
record ConcreteSlab
  "BESTEST concrete slab"
  extends IDEAS.Buildings.Data.Interfaces.Material(
    final k=1.130,
    final c=1000,
    final rho=1400,
    epsLw=0.9,
    epsSw=0.6);
end ConcreteSlab;
