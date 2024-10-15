within IDEAS.Buildings.Data.Materials;
record BrickLe = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.41,
    c=840,
    rho=850,
    epsLw=0.88,
    epsSw=0.55) "Light masonry for exterior applications" annotation (
    Documentation(info="<html>
<p>
Thermal properties of light bricks for exterior masonry.
</p>
</html>"));
