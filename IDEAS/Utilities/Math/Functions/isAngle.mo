within IDEAS.Utilities.Math.Functions;
function isAngle
  "Return true if angles are mathematically equivalent up to a certain precision"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Angle ang1;
  input Modelica.SIunits.Angle ang2;
  input Real precision = 0.01;

  output Boolean result;

algorithm
  result :=abs(mod(ang1, 2*Modelica.Constants.pi) - mod(ang2, 2*Modelica.Constants.pi)) < precision;
  annotation(Inline=true, Documentation(revisions="<html>
<ul>
<li>
August 9, 2018, by Filip Jorissen:<br/>
Revised implementation to be more intuitive.
</li>
</ul>
</html>"));
end isAngle;
