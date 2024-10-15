within IDEAS.Experimental.Electric.Photovoltaics.Components;
model PvVoltageToPower

  extends Modelica.Blocks.Interfaces.BlockIcon;

  input Modelica.Electrical.Analog.Interfaces.Pin pin
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
equation
  P = pin.v*pin.i;
  Q = 0;
  annotation (Diagram(graphics), Documentation(revisions="<html>
<ul>
<li>
October 21, 2015 by Filip Jorissen:<br/>
Changed class declaration to model declaration for issue 398.
Also added input modifier to pin to avoid failing check.
</li>
</ul>
</html>"));
end PvVoltageToPower;
