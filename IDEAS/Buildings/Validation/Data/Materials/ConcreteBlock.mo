within IDEAS.Buildings.Validation.Data.Materials;
record ConcreteBlock
  "BESTEST concrete blocks"
  extends IDEAS.Buildings.Data.Interfaces.Material(
    final k=0.51,
    final c=1000,
    final rho=1400,
    epsLw=0.9,
    epsSw=0.6);
end ConcreteBlock;
