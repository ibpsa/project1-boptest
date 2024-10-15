within IDEAS.Buildings.Data.Materials;
record Argon = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.0162,
    c=519,
    rho=1.70,
    epsSw=0,
    epsLw=0,
    gas=true,
    mhu=22.9*10e-6) "Argon gass" annotation (Documentation(info="<html>
<p>
Constant argon thermal properties.
</p>
</html>"));
