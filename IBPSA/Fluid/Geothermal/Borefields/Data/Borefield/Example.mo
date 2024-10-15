within IBPSA.Fluid.Geothermal.Borefields.Data.Borefield;
record Example
  "Example definition of a borefield data record"
  extends
    IBPSA.Fluid.Geothermal.Borefields.Data.Borefield.Template(
      filDat=IBPSA.Fluid.Geothermal.Borefields.Data.Filling.Bentonite(),
      soiDat=IBPSA.Fluid.Geothermal.Borefields.Data.Soil.SandStone(),
      conDat=IBPSA.Fluid.Geothermal.Borefields.Data.Configuration.Example());
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="borFieDat",
Documentation(
info="<html>
<p>This record presents an example on how to define borefield records
using the template in
<a href=\"modelica://IBPSA.Fluid.Geothermal.Borefields.Data.Borefield.Template\">
IBPSA.Fluid.Geothermal.Borefields.Data.Borefield.Template</a>.</p>
</html>",
revisions="<html>
<ul>
<li>
July 15, 2018, by Michael Wetter:<br/>
Revised implementation, added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code>.
</li>
<li>
June 28, 2018, by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end Example;
