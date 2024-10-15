within IDEAS.Buildings.Data.Materials;
record Ground = IDEAS.Buildings.Data.Interfaces.Material (
    k=2.0,
    c=1250,
    rho=1600,
    epsLw=0.88,
    epsSw=0.68) annotation (Documentation(info="<html>
<p>
Thermal properties of ground/soil.
</p>
</html>"));
