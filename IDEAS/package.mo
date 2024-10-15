within ;
package IDEAS "Integrated District Energy Assessment Simulation"

extends Modelica.Icons.Package;
import SI = Modelica.SIunits;

annotation (
  uses(Modelica(version="3.2.3")),
  Icon(graphics),
  version="2.2.1",
  versionDate="2021-06-09",
  dateModified = "2021-06-09",
  conversion(
 from(version={"0.2"},
      script="modelica://IDEAS/Resources/Scripts/convertIdeas030to100.mos")),
  Documentation(info="<html>
<p>Licensed by KU Leuven and 3E</p>
<p>Copyright &copy; 2013-2023, KU Leuven and 3E. </p>
<p>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;
For license information, view our <a href=\"https://github.com/open-ideas/IDEAS\">github page</a>.
</p>
</html>"));
end IDEAS;
