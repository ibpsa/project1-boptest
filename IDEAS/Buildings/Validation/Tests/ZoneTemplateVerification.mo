within IDEAS.Buildings.Validation.Tests;
model ZoneTemplateVerification
  "Model for checking result difference between template and non-template version of case 900"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

  IDEAS.Buildings.Validation.BaseClasses.Structure.Bui900 bui900
    annotation (Placement(transformation(extent={{-24,40},{6,60}})));
  IDEAS.Buildings.Validation.Cases.Case900Template case900Template
    "Template implementation of case 900"
    annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This model compares Bestest case 900 with an implementation of the same model using the ZoneTemplate model.
</p>
</html>", revisions="<html>
<ul>
<li>
March 26, 2018 by Filip Jorissen:<br/>
Using preconfigured template
</li>
<li>
November 14, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/ZoneTemplateVerification.mos"
        "Simulate and plot"));
end ZoneTemplateVerification;
