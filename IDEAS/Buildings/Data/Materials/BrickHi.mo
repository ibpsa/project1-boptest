within IDEAS.Buildings.Data.Materials;
record BrickHi = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.90,
    c=840,
    rho=1850,
    epsLw=0.88,
    epsSw=0.55) "Heavy masonry for interior applications" annotation (
    Documentation(info="<html>
<p>
Thermal properties of heavy bricks for interior masonry.
</p>
</html>"));
