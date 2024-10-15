within IDEAS.Buildings.Components.LightingType;
record None "No lighting installed in the zone"
  extends Modelica.Icons.Record;
  extends IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLighting(
      K = Modelica.Constants.inf,
      radFra = 0);                   //infinite to force 0 lighting gains in the lighting model

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
Model in case no lighting heat gains should be modelled.
</p>
</html>"));

end None;
