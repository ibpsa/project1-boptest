within IDEAS.Buildings.Components.Examples;
model FacadeShadeExample
  "Example that compares a building with shaded and unshaded facade"
  extends Modelica.Icons.Example;
  Validation.Cases.Case900Template zoneSha(
    hasBuildingShadeA=true,
    hasBuildingShadeB=true,
    hasBuildingShadeC=true,
    LShaC=20,
    dhShaC=7,
    hasBuildingShadeD=true,
    LShaD=20,
    dhShaD=2,
    LShaA=5,
    dhShaA=10,
    LShaB=10,
    dhShaB=5) "Shaded zone"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Validation.Cases.Case900Template zone "Unshaded zone"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates the impact of external shading 
on the building facade for the Case 900 example model.
</p>
</html>", revisions="<html>
<ul>
<li>
June 13, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/576\">#576</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/FacadeShadeExample.mos"
        "Simulate and plot"));
end FacadeShadeExample;
