within IDEAS.Buildings.Data.Materials;
record Screed = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.6,
    c=840,
    rho=1100,
    epsLw=0.88,
    epsSw=0.55) "Light cast concrete" annotation (Documentation(info="<html>
<p>
Thermal properties of screed.
</p>
</html>"));
