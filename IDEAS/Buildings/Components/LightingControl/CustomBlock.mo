within IDEAS.Buildings.Components.LightingControl;
block CustomBlock
  "Lighting control defined by a replaceable block"
  extends IDEAS.Buildings.Components.LightingControl.BaseClasses.PartialLightingControl(
    final useCtrInput=false,
    final useOccInput=false);

  replaceable Modelica.Blocks.Sources.Constant singleOutput(k=0)
    constrainedby Modelica.Blocks.Interfaces.SO
    "Custom block profile" annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  assert(not linearise, "Lighting control can not be defined using the CustomBlock when the model is linearized. Change the lighting control type.");
  connect(singleOutput.y, ctrl)
    annotation (Line(points={{11,0},{120,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block can be used to define a custom profile. 
Any block that extends 
<code>Modelica.Blocks.Interfaces.SO</code>
can be inserted in this placeholder. 
The output value <code>y</code> of the block 
is then used as lighting control signal.
</p>
</html>", revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>"));
end CustomBlock;
