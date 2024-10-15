within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
function viewFactorRectRectPar
  "View factor between two equal coaxial parallel rectangular surfaces."
  extends Modelica.Icons.Function;
  input Real A "Area of surface";
  input Real d "Distance between surfaces";
  input Real l "Length of surface";

  output Real vieFac "View factor between surfaces";

protected
  Real x = l/d;
  Real y = A/l/d;

  Real x1 = sqrt(1+x^2);
  Real y1 = sqrt(1+y^2);

algorithm
vieFac := 1/Modelica.Constants.pi/x/y*(log(x1^2*y1^2/(x1^2+y1^2-1)) +
                                       2*x*(y1*atan(x/y1)-atan(x)) +
                                       2*y*(x1*atan(y/x1)-atan(y)));

  annotation (Documentation(info="<html>
<p>source: http://webserver.dmt.upm.es/~isidoro/tc3/Radiation%20View%20factors.pdf</p>
</html>"));
end viewFactorRectRectPar;
