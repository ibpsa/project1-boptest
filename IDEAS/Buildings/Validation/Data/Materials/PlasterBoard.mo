within IDEAS.Buildings.Validation.Data.Materials;
record PlasterBoard
  "BESTEST plasterboard"
  extends IDEAS.Buildings.Data.Interfaces.Material(
    final k=0.160,
    final c=840,
    final rho=950,
    epsLw=0.9,
    epsSw=0.6);
end PlasterBoard;
