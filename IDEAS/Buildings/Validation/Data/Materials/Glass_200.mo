within IDEAS.Buildings.Validation.Data.Materials;
record Glass_200
  "BESTEST glass"
  extends IDEAS.Buildings.Data.Interfaces.Material(
    k=0.96,
    c=750,
    rho=2500,
    epsLw=0.1,
    epsSw=0.1);

end Glass_200;
