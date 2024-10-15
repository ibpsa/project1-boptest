within IDEAS.Buildings.Examples;
model ComfortExample "Example model with and without occupant model"
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  IDEAS.Buildings.Validation.Cases.Case900 case900_default
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.Buildings.Validation.Cases.Case900 case900_comfort(
    building(gF(redeclare Components.OccupancyType.OfficeWork occTyp,
          redeclare Components.Comfort.Fanger comfort)))
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model demonstrating the use of the comfort evaluation model.</p>
</html>", revisions="<html>
<ul>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/ComfortExample.mos"
        "Simulate and plot"),
    experiment(
      StopTime=8640000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ComfortExample;
