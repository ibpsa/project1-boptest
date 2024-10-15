within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
function viewFactorRectRectPerp
  "View factor between two adjacent, perpendicular rectangular surfaces with one common dimension."
  extends Modelica.Icons.Function;

  input Real W1 "Width of surface 1";
  input Real W2 "Width of surface 2";
  input Real lCommon "Common surface edge length";

  output Real vieFac "View factor between surfaces";

protected
  Real h = W1/lCommon;
  Real w = W2/lCommon;

  Real a = (1+h^2)*(1+w^2)/(1+w^2 + h^2);
  Real b = w^2*(1+h^2+w^2)/(1+w^2)/(h^2+w^2);
  Real c = h^2*(1+h^2+w^2)/(1+h^2)/(h^2+w^2);

  Real subExp = sqrt(h*h+w*w);

algorithm
  vieFac :=1/w/Modelica.Constants.pi*(h*atan(1/h)+w*atan(1/w) - subExp*atan(1/subExp) + 1/4*log(a*b^(w^2)*c^(h^2)));

end viewFactorRectRectPerp;
