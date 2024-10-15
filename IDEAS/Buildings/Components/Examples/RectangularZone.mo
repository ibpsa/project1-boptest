within IDEAS.Buildings.Components.Examples;
model RectangularZone
  "Example that compares a zone with internal wall and without internal wall"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Validation.Cases.Case900Template zoneIntWal(
    hasInt=true,
    lInt=zoneIntWal.lA*3,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall18 conTypInt)
    "Zone with internal wall"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zone
    "Zone without internal wall"
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates the impact of having an internal wall
on the thermal dynamics of a single zone.
</p>
</html>", revisions="<html>
<ul>
<li>
August 10, 2018 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/RectangularZone.mos"
        "Simulate and Plot"));
end RectangularZone;
