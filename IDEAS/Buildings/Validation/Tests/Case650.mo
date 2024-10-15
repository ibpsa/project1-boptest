within IDEAS.Buildings.Validation.Tests;
model Case650 "Case 650"

  extends Modelica.Icons.Example;

  /*

Simulation of all so far modeled BESTEST cases in a single simulation.

*/

  // BESTEST 600 Series

  replaceable Cases.Case650 Case650 constrainedby Interfaces.BesTestCase
    annotation (Placement(transformation(extent={{44,44},{56,56}})));

  // BESTEST 900 Series

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
            100,100}}), graphics={Text(
          extent={{-78,68},{-40,60}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 600 Series")}),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/Case650.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Revised implementation using dedicated SimInfoManger for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
</ul>
</html>"));
end Case650;
