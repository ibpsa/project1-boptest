within IDEAS.Buildings.Data.Materials;
record Timber = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.11,
    c=1880,
    rho=550,
    epsLw=0.86,
    epsSw=0.44) "Timber finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of timber.
</p>
</html>"));
