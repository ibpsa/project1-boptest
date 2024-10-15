within IDEAS.Buildings.Data.Interfaces;
record Material "Template record for properties of building materials"

  extends IDEAS.Buildings.Data.Interfaces.BasicMaterial;

  parameter Modelica.SIunits.Length d=0 "Layer thickness";
  parameter Modelica.SIunits.Emissivity epsLw=0.85 "Longwave emisivity";
  parameter Modelica.SIunits.Emissivity epsSw=0.85 "Shortwave emissivity";
  parameter Boolean gas=false "Boolean whether the material is a gas"
    annotation(Evaluate=true);
  parameter Boolean glass=false "Boolean whether the material is made of glass"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.KinematicViscosity mhu = 0
    "Viscosity, i.e. if the material is a fluid";

  parameter Modelica.SIunits.Emissivity epsLw_a = epsLw
    "Longwave emisivity for surface a if different";
  parameter Modelica.SIunits.Emissivity epsLw_b = epsLw
    "Longwave emisivity for surface a if different";

  parameter Modelica.SIunits.Emissivity epsSw_a = epsSw
    "Shortwave emisivity for surface a if different";
  parameter Modelica.SIunits.Emissivity epsSw_b = epsSw
    "Shortwave emisivity for surface a if different";

  final parameter Modelica.SIunits.ThermalInsulance R=d/k;

  final parameter Modelica.SIunits.ThermalDiffusivity alpha=k/(c*rho)
    "Thermal diffusivity";
  final parameter Integer nStaRef=3
    "Number of states of a reference case, ie. 20 cm dense concrete";
  final parameter Real piRef=224
    "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete";
  final parameter Real piLay=d/sqrt(alpha)
    "d/sqrt(mat.alpha) of the depicted layer";
  final parameter Integer nSta(min=2) = max(2, integer(ceil(nStaRef*piLay/piRef)))
    "Actual number of state variables in material";

  annotation (Documentation(info="<html>
<p>
This record may be used to define material properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end Material;
