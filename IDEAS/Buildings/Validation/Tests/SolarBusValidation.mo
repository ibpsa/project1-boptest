within IDEAS.Buildings.Validation.Tests;
model SolarBusValidation
  "This model compares two identical models where one model uses the solar bus and the other does not"
  extends Modelica.Icons.Example;
  Cases.Case900 Case900SolBus
    annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
  Cases.Case900 Case900NoSolBus(building(
      roof(radSolData(solDataInBus=false)),
      wall(radSolData(each solDataInBus=false)),
      win(radSolData(each solDataInBus=false))))
    annotation (Placement(transformation(extent={{-56,-16},{-44,-4}})));
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-76,82},{-66,92}})));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<p>This model is a verification for the solar bus implementation. Two identical models (BesTest Case 900) are simulated where one of the instances uses the solar bus implementation and the other explicitly calculates the inputs based on the azimuth and inclination angles. Both results should be identical within solver precision.</p>
</html>", revisions="<html>
<ul>
<li>
February 25, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=1000000,
      __Dymola_NumberOfIntervals=1000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end SolarBusValidation;
