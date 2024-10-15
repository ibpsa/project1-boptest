within IDEAS.Buildings.Components.Occupants.BaseClasses;
partial block PartialOccupants "Partial for defining the number of occupants"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean useInput= false
    "=true to use external input";
  parameter Boolean linearise
    "For linearisation checks";
  parameter Modelica.SIunits.Area A
    "Zone surface area";
  Modelica.Blocks.Interfaces.RealOutput nOcc "Number of occupants"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.RealInput yOcc if   useInput
    "Input for number of occupants"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
March 28, 2019 by Filip Jorissen:<br/>
Added parameter <code>A</code> 
for <a href=\"https://github.com/open-ideas/IDEAS/issues/998\">#998</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"));
end PartialOccupants;
