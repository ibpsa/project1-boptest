within IDEAS.Buildings.Data.Insulation;
record Cellularglass = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.046,
    c=840,
    rho=130) "Cellular glass" annotation (Documentation(info="<html>
<p>
Cellular glass insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
