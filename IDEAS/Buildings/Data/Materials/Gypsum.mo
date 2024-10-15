within IDEAS.Buildings.Data.Materials;
record Gypsum = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.6,
    c=840,
    rho=975,
    epsLw=0.85,
    epsSw=0.65) "Gypsum plaster for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of gypsum.
</p>
</html>"));
