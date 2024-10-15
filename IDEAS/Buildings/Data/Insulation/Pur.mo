within IDEAS.Buildings.Data.Insulation;
record Pur = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.020,
    c=1470,
    rho=30,
    epsLw=0.8,
    epsSw=0.8) "Polyurethane foam, PUR" annotation (Documentation(info="<html>
<p>
Polyurethane (PUR) insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
