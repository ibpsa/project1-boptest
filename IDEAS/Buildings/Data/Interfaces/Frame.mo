within IDEAS.Buildings.Data.Interfaces;
partial record Frame "Template record for window frames"
  extends Modelica.Icons.MaterialProperty;

  parameter Boolean present=true;
  parameter Modelica.SIunits.ThermalConductance U_value=1.1 "U-value window frame";

  replaceable parameter IDEAS.Buildings.Components.ThermalBridges.None briTyp "Thermal bridge type";
  replaceable parameter IDEAS.Buildings.Data.Interfaces.Material mat(
    k=0.1,
    rho=1000,
    c=1000) "Material type, used for emissivity properties only";
  annotation (Documentation(info="<html>
<p>
This record may be used to define the thermal properties of a window frame. 
The U_value is used to compute the thermal losses of the frame. 
The material type <code>mat</code> is only used for the emissivity values 
and is therefore of lesser importance.
A thermal bridge may optionally be defined as well. 
</p>
</html>", revisions="<html>
<ul>
<li>
December 19, 2016, by Filip Jorissen:<br/>
Added thermal bridge type and material type.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end Frame;
