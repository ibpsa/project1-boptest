within IDEAS.Utilities.Diagnostics;
model GitShaLogger
  "Model that stores the git sha of library dependencies"
  extends Modelica.Blocks.Icons.Block;
  // libraryNames is constant since otherwise dymola does not resolve the function loadResource()
  constant String[:] libraryNames= {"IDEAS"}
    "Library names, printed in result file";
  parameter String[:] libraryPaths=
    {Modelica.Utilities.Files.loadResource("modelica://"+libraryName+"/") for libraryName in libraryNames}
    "Library paths, used to fetch sha's";
  parameter String shaResultPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/") + getInstanceName() + "_dependencies.txt"
    "Path where the sha's will be stored";
  parameter Boolean verbose=true
    "=true, to print sha's to simulation output";

protected
  function tagCommit
    extends Modelica.Icons.Function;
    input String fileName "Name of this model";
    input String[:] libraryNames "Names of libraries";
    input String[:] libraryPaths "Paths of libraries";
    input Boolean verbose "Verbose output";
    external"C" tagCommit(fileName, libraryNames, libraryPaths, size(libraryNames,1),verbose)
      annotation (
        Include="#include \"tagcommit.c\"",
        IncludeDirectory="modelica://IDEAS/Resources/C-Sources");
  end tagCommit;
initial equation
  assert(size(libraryNames,1)==size(libraryPaths,1),
    "The size of libraryNames should be the same as the size of libraryPaths.");
  tagCommit(shaResultPath, libraryNames, libraryPaths, verbose);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-100,96},{-12,38}},
          lineColor={28,108,200},
          textString="Git"), Text(
          extent={{-90,-38},{34,-96}},
          lineColor={28,108,200},
          textString="Library logger")}),                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This model collects the git sha's of the libraries in <code>libraryNames</code> and stores these 
sha's in the path <code>shaResultPath</code>.
The library paths are automatically fetch from <code>libraryNames</code> through the definition
of parameter <code>libraryPaths</code>. 
Note that <code>libraryNames</code> is a constant and hence does not show up in the parameter window.
Its values can be defined using the Modelica text view.
</p>
</html>", revisions="<html>
<ul>
<li>
October 23, 2018, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end GitShaLogger;
