within IDEAS.Buildings.Data.Insulation;
record Eps = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.036,
    c=1470,
    rho=26,
    epsLw=0.8,
    epsSw=0.8) "Expanded polystrenem, EPS" annotation (Documentation(info="<html>
<p>
Expaned polystyrene (EPS) insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
