within IDEAS.Buildings.Components.Occupants;
block Fixed "Fixed number of occupants"
  extends BaseClasses.PartialOccupants(final useInput=false);
  outer BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter Real nOccFix(min=0)=0
    "Fixed number of occupants";
  Modelica.Blocks.Sources.Constant constOcc(final k=nOccFix)
    "Constant block for number of occupants"
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
  Modelica.Blocks.Math.Product product "For LIDEAS"
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));
protected
  Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles)
    annotation (Placement(transformation(extent={{-74,82},{-54,102}})));
equation
  connect(sim.weaBus, weaBus) annotation (Line(
      points={{-81,93},{-74,93},{-74,92},{-64,92}},
      color={255,204,51},
      thickness=0.5));
  connect(product.u1, constOcc.y)
    annotation (Line(points={{38,-6},{11,-6}},color={0,0,127}));
  connect(product.y, nOcc)
    annotation (Line(points={{61,0},{120,0}}, color={0,0,127}));
  connect(product.u2, weaBus.dummy) annotation (Line(points={{38,6},{24,6},{24,
          92.05},{-63.95,92.05}},
                           color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 21, 2018 by Damien Picard: <br/> 
Multiplied the occupant number with the dummy variable to 
avoid the suppression of it while linearizing in LIDEAS.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/812\">#812</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"));
end Fixed;
