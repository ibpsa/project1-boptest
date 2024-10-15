within IDEAS.Buildings.Data.Materials;
record BrickMe = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.75,
    c=840,
    rho=1400,
    epsLw=0.88,
    epsSw=0.55) "Medium masonry for exterior applications " annotation (
    Documentation(info="<html>
<p>
Thermal properties of medium bricks for exterior masonry.
</p>
</html>"));
