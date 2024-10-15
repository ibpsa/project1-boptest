within IDEAS.Utilities.Diagnostics.Examples;
model GitShaLogger "Example demonstrating the use of git sha logger"
  extends Modelica.Icons.Example;
  IDEAS.Utilities.Diagnostics.GitShaLogger gitShaLogger(libraryNames={"IDEAS"})
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This example generates the file GitShaLogger.gitShaLogger_dependencies.txt in the IDEAS root directory.
</p>
</html>", revisions="<html>
<ul>
<li>
October 24, 2018, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end GitShaLogger;
