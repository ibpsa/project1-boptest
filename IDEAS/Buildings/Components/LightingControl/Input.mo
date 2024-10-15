within IDEAS.Buildings.Components.LightingControl;
block Input "Lighting control defined using zone input lightCtrl"
  extends IDEAS.Buildings.Components.LightingControl.BaseClasses.PartialLightingControl(
    final useCtrInput=true);

equation
  assert(not linearise, "Linearising the model when using a lighting control input. 
    Make sure to add the lighting control input as an input for the linearisation to work correctly.",
    level=AssertionLevel.warning);
  connect(ctrl, ligCtr) annotation (Line(points={{120,0},{0,0},{0,-20},{-120,-20}},
        color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
This block propagates the control input to the zone level.
</p>
</html>"));
end Input;
