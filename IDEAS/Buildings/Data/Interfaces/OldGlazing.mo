within IDEAS.Buildings.Data.Interfaces;
record OldGlazing
  "Glazing type that does not show up in window dropdown"
  extends IDEAS.Buildings.Data.Interfaces.PartialGlazing;
  extends Modelica.Icons.ObsoleteModel;
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
First version.
</li>
</ul>
</html>", info="<html>
<p>
Deprecated glazing types.
</p>
</html>"));
end OldGlazing;
