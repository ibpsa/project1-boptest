within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui610 "BESTEST Building model case 610"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui600(
     win(redeclare replaceable IDEAS.Buildings.Components.Shading.Overhang shaType(
      each hWin=2.0,
      each wWin=3.0,
      each dep=1.0,
      each gap=0.35,
      wLeft={0.5,4.5},
      wRight = {4.5,0.5})))  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}}),       graphics));
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 19, 2016, Filip Jorissen:<br/>
Changed implementation such that it extends case 600.
</li>
</ul>
</html>"));
end Bui610;
