within IDEAS.Buildings.Components.Examples;
model BeamRadiationOnFloor
  "Model that compares a model with and without floor and its impact on beam radiation"

  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  Validation.Cases.Case900 case900WithFloor
    annotation (Placement(transformation(extent={{-20,42},{0,62}})));
  Validation.Cases.Case900 case900WithoutFloor(building(floor(inc=IDEAS.Types.Tilt.Ceiling,
          constructionType(incLastLay=IDEAS.Types.Tilt.Ceiling))))
    annotation (Placement(transformation(extent={{-20,-38},{0,-18}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
Beam radiation first hits the floor after which the light is redistributed over the other surfaces.
This model is to check what happens if the model contains no floors.
</p>
</html>", revisions="<html>
<ul>
<li>
May 22, 2018 by Filip Jorissen:<br/>
Removed conservation of energy check.
</li>
<li>
September 8, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/BeamRadiationOnFloor.mos"
        "Simulate and plot"));
end BeamRadiationOnFloor;
