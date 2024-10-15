within IDEAS.Buildings.Data.Insulation;
record Xps = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.024,
    c=1470,
    rho=40,
    epsLw=0.8,
    epsSw=0.8) "Extruded polystrene, XPS" annotation (Documentation(info="<html>
<p>
Extruded polystyrene (XPS) insulation thermal properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
