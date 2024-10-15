within IDEAS.Utilities.Cryptographics.BaseClasses;
function sha "Rewritten sha-code returning a unique number for each file."
  extends Modelica.Icons.Function;
  input String argv;
  output String sha1;

external"C" sha1 = hash(argv);
  annotation (Include="#include <simpleHash.c>", IncludeDirectory="modelica://IDEAS/Resources/C-Sources",
    Documentation(revisions="<html>
<ul>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Revised sha implementation to avoid buffer overflow in borefield.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/755\">
#755</a>.
</li>
</ul>
</html>"));
end sha;
