within IDEAS.Buildings.Data.Materials;
record Glass = IDEAS.Buildings.Data.Interfaces.Material (
    k=0.96,
    c=750,
    rho=2500,
    epsLw=IDEAS.Buildings.Data.Constants.epsLw_glass,
    epsSw=IDEAS.Buildings.Data.Constants.epsSw_glass) "Glass" annotation (Documentation(info="<html>
<p>
Thermal properties of glass.
</p>
</html>"));
