within IDEAS.Buildings.Data.Materials;
record BrickLi = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.27,
    c=840,
    rho=850,
    epsLw=0.88,
    epsSw=0.55) "Light masonry for interior applications" annotation (
    Documentation(info="<html>
<p>
Thermal properties of light bricks for interior masonry.
</p>
</html>"));
