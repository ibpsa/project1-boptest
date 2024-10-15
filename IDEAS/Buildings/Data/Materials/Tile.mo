within IDEAS.Buildings.Data.Materials;
record Tile = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.4,
    c=840,
    rho=2100,
    epsLw=0.88,
    epsSw=0.55) "Ceramic tile for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of tiles.
</p>
</html>"));
