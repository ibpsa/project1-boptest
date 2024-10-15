within IDEAS.Buildings.Data.Materials;
record Slate =IDEAS.Buildings.Data.Interfaces.Material (
    k=2.01,
    c=760,
    rho=2700,
    epsLw=0.97,
    epsSw=0.9) "Natural slate for roof tiles" annotation (Documentation(
      revisions="", info="<html>
<p>
Thermal properties of slate.
</p>
</html>"));
