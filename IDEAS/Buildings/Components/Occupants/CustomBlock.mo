within IDEAS.Buildings.Components.Occupants;
block CustomBlock
  "Occupancy defined by a replaceable block"
  extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);
  replaceable Modelica.Blocks.Sources.Constant singleOutput(k=0)
  constrainedby Modelica.Blocks.Interfaces.SO
  "Custom block profile"
    annotation (choicesAllMatching=true,Placement(transformation(extent={{-10,-10},
            {10,10}})));

  outer BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
    assert(not linearise, "Number of occupant can not be defined using the CustomBlock when the model is linearized. Change the occupancy type.");

  connect(singleOutput.y, nOcc)
    annotation (Line(points={{11,0},{58,0},{58,0},{120,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block can be used to define a custom profile. 
Any block that extends 
<code>Modelica.Blocks.Interfaces.SO</code>
can be inserted in this placeholder. 
The output value <code>y</code> of the block 
is then used as the number of occupants.
</p>
</html>", revisions="<html>
<ul>
<li>
August 21, 2018 by Damien Picard: <br/> 
Add assert such that this model is not used to linearize model with LIDEAS.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/812\">#812</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"));
end CustomBlock;
