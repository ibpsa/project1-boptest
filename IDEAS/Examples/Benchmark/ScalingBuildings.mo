within IDEAS.Examples.Benchmark;
model ScalingBuildings
  extends Modelica.Icons.Example;
  parameter Integer n = 1 "Number of buildings";
  inner BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  constant Modelica.SIunits.Angle angleOffsets[n]= {2*i*Modelica.Constants.pi/n for i in 1:n};
  IDEAS.Buildings.Validation.Cases.Case900 case900[n](building(aO=angleOffsets))
    "Case 900 building with HVAC"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3.15e+06,
      __Dymola_fixedstepsize=30,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This model may be used to check how computation time scales with n, 
the number of simulated buildings.
</p>
<p>
In this model each building is has a different orientation
and each building has a heating system.
Therefore the buildings are excited by the HVAC at different times,
due to which more steps are required to solve the problem.
</p>
</html>", revisions="<html>
<ul>
<li>
March 10, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ScalingBuildings;
