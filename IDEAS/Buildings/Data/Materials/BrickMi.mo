within IDEAS.Buildings.Data.Materials;
record BrickMi = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.54,
    c=840,
    rho=1400,
    epsLw=0.88,
    epsSw=0.55) "Medium masonry for interior applications " annotation (
    Documentation(info="<html>
<p>
Thermal properties of medium bricks for interior masonry.
</p>
</html>"));
