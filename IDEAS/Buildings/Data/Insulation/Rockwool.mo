within IDEAS.Buildings.Data.Insulation;
record Rockwool = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.036,
    c=840,
    rho=110,
    epsLw=0.8,
    epsSw=0.8) "Rockwool" annotation (Documentation(info="<html>
<p>
Rockwool insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
