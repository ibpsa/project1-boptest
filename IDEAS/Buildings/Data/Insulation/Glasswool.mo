within IDEAS.Buildings.Data.Insulation;
record Glasswool = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.040,
    c=840,
    rho=80) "Glasswool" annotation (Documentation(info="<html>
<p>
Glass wool insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
