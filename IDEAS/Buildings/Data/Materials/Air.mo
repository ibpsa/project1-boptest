within IDEAS.Buildings.Data.Materials;
record Air = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.0241,
    c=1008,
    rho=1.23,
    epsSw=0,
    epsLw=0,
    gas=true,
    mhu=18.3*10e-6) "Air" annotation (Documentation(info="<html>
<p>
Constant air thermal properties.
</p>
</html>"));
