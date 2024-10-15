within IDEAS.Buildings.Components.LightingControl;
block OccupancyBased
  "Lighting control from zone when nOcc > 0"
  extends IDEAS.Buildings.Components.LightingControl.BaseClasses.PartialLightingControl(
    final useOccInput=true);

  Modelica.Blocks.Logical.GreaterThreshold      greEquThr(threshold=0)
    "Greater or equal than threshold"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=1, realFalse=0)
    "Boolean to real conversion"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(booToRea.y, ctrl)
    annotation (Line(points={{21,0},{120,0}}, color={0,0,127}));
  connect(booToRea.u, greEquThr.y)
    annotation (Line(points={{-2,0},{-19,0}}, color={255,0,255}));
  connect(greEquThr.u, nOcc) annotation (Line(points={{-42,0},{-60,0},{-60,20},{
          -120,20}}, color={0,0,127}));
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
This block enables the lighting when the number 
of occupants in the zone exceeds zero.
</p>
</html>"));
end OccupancyBased;
