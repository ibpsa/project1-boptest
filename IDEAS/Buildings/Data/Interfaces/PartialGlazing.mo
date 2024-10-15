within IDEAS.Buildings.Data.Interfaces;
record PartialGlazing "Template used for deprecated glazing types"
  extends Modelica.Icons.MaterialProperty;

  parameter Integer nLay(min=1)
    "Number of layers of the glazing, including gaps";
  parameter IDEAS.Buildings.Data.Interfaces.Material[nLay] mats
    "Array of materials, ordered from outside to inside. Add coatings to glass by setting epsLw_a for inward facing sides of the glass, epsLw_b for outward.";
  parameter Real[:, nLay + 1] SwAbs
    "Absorbed solar radiation for each layer as function of angle of incidence";
  parameter Real[:, 2] SwTrans
    "Transmitted solar radiation as function of angle of incidence";
  parameter Real[nLay] SwAbsDif
    "Absorbed solar radiation for each layer as function of angle of incidence";
  parameter Real SwTransDif
    "Transmitted solar radiation as function of angle of incidence";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_value "Design U-value. (Only used for calculation Qdesign)";
  parameter Real g_value
    "Design g-value. (Not used in calculation, only informative)";
  parameter Boolean checkLowPerformanceGlazing = true
    "Throw error when the glazing does not have a coating in the cavity";
  annotation (Documentation(info="<html>
<p>
Extend this glazing partial if you do not want the glazing type to show up in the window dropdown.
</p>
</html>", revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
First version.
</li>
</ul>
</html>"));
end PartialGlazing;
