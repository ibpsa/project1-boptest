within IDEAS.Buildings.Components.LightingType;
record Fluorescent "Properties for generic fluorescent lighting"
  extends Modelica.Icons.Record;
  extends IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLighting(
      K = 80,
      radFra = 0.65);

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
Record for lighting properties of fluorescent lighting. 
Based on <a href=\"https://en.wikipedia.org/wiki/Luminous_efficacy\">
https://en.wikipedia.org/wiki/Luminous_efficacy</a>.
</p>
</html>"));

end Fluorescent;
