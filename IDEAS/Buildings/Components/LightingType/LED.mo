within IDEAS.Buildings.Components.LightingType;
record LED "Properties for generic LED lighting"
  extends Modelica.Icons.Record;
  extends IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLighting(
      K = 150,
      radFra = 0.35);

  annotation (Documentation(revisions="<html>
<ul>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
Record for lighting properties of LED lighting. 
Based on <a href=\"https://en.wikipedia.org/wiki/Luminous_efficacy\">
https://en.wikipedia.org/wiki/Luminous_efficacy</a>.
</p>
</html>"));

end LED;
