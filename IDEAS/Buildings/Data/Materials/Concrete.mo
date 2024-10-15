within IDEAS.Buildings.Data.Materials;
record Concrete = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.4,
    c=840,
    rho=2100,
    epsLw=0.88,
    epsSw=0.55) "Dense cast concrete, also for finishing" annotation (
    Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
