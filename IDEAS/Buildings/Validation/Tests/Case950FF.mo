within IDEAS.Buildings.Validation.Tests;
model Case950FF "Case 950FF"

  extends Modelica.Icons.Example;

  /*

Simulation of all so far modeled BESTEST cases in a single simulation.

*/

  // BESTEST 600 Series

  // BESTEST 900 Series

  replaceable Cases.Case950FF Case950FF constrainedby Interfaces.BesTestCase
    annotation (Placement(transformation(extent={{64,4},{76,16}})));

  inner BaseClasses.SimInfoManagerBestest sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (
    experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={         Text(
          extent={{-78,28},{-40,20}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 900 Series")}),
    Documentation(revisions="<html>
<ul>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Revised implementation using dedicated SimInfoManger for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
</ul>
</html>"));
end Case950FF;
