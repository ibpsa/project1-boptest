within IDEAS.Buildings.Data.Materials;
record BrickHe = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.10,
    c=840,
    rho=1850,
    epsLw=0.88,
    epsSw=0.55) "Heavy masonry for exterior applications" annotation (
    Documentation(info="<html>
<p>
Thermal properties of heavy bricks for exterior masonry.
</p>
</html>"));
