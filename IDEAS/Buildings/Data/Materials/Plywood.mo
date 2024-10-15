within IDEAS.Buildings.Data.Materials;
record Plywood = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.9,
    c=840,
    rho=1950,
    epsLw=0.86,
    epsSw=0.44) "Ply wood finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of plywood.
</p>
</html>"));
