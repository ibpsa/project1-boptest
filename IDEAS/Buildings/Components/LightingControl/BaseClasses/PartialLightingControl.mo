within IDEAS.Buildings.Components.LightingControl.BaseClasses;
partial block PartialLightingControl
  "Partial for defining the lighting control"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean useCtrInput= false
    "=true to use external control input";
  parameter Boolean useOccInput= false
    "=true to use occupancy input";
  parameter Boolean linearise
    "For linearisation checks";
  Modelica.Blocks.Interfaces.RealOutput ctrl "Lighting control signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealInput ligCtr if useCtrInput
    "External lighting control input"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput nOcc if   useOccInput
    "Number of occupants"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
Partial for defining the lighting control.
</p>
</html>"));
end PartialLightingControl;
