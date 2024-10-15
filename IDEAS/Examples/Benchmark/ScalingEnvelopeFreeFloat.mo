within IDEAS.Examples.Benchmark;
model ScalingEnvelopeFreeFloat
  extends Modelica.Icons.Example;
  parameter Integer n = 1 "Number of buildings";
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Validation.BaseClasses.Structure.Bui900 bui[n]
    "Case 900 building envelope without HVAC"
    annotation (Placement(transformation(extent={{-20,0},{8,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3.15e+06,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Euler"),
    Documentation(info="<html>
<p>
This model may be used to check how computation time scales with n, 
the number of simulated buildings.
</p>
<p>
In this model each building is in free float, 
which means that the system is not excited by 
HVAC and all models stay synchronised.
</p>
</html>", revisions="<html>
<ul>
<li>
March 10, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ScalingEnvelopeFreeFloat;
