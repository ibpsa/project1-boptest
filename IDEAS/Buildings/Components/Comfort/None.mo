within IDEAS.Buildings.Components.Comfort;
model None "No comfort is computed"
  extends BaseClasses.PartialComfort;
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
Use this if you do not need to know the thermal comfort of the occupants.
</p>
</html>"));
end None;
