within IDEAS.Buildings.Data.Insulation;
record Ytong = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.120,
    c=1000,
    rho=450,
    epsLw=0.8,
    epsSw=0.8) "Ytong" annotation (Documentation(info="<html>
<p>
Ytong insulating bricks thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
