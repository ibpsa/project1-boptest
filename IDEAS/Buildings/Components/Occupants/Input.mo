within IDEAS.Buildings.Components.Occupants;
block Input "Number of occupants equals zone input yOcc"
  extends BaseClasses.PartialOccupants(final useInput=true);

  Modelica.Blocks.Math.Gain gain(k=1) "Optional gain for scaling input"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  assert(not linearise, "Linearising the model when using an occupancy control input. 
    Make sure to add the occupancy control input as an input for the linearisation to work correctly.",
    level=AssertionLevel.warning);
  connect(nOcc, gain.y)
    annotation (Line(points={{120,0},{13,0}}, color={0,0,127}));
  connect(gain.u, yOcc)
    annotation (Line(points={{-10,0},{-120,0}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
March 28, 2019 by Filip Jorissen:<br/>
Revised implementation
for <a href=\"https://github.com/open-ideas/IDEAS/issues/998\">#998</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>", info="<html>
<p>
This block allows defining the occupancy externally, by using the zone model input <code>yOcc</code>.
</p>
</html>"));
end Input;
