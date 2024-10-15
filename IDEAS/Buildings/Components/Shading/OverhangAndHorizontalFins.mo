within IDEAS.Buildings.Components.Shading;
model OverhangAndHorizontalFins "Roof overhang and horizontal fins"

  parameter Modelica.SIunits.Length hWin(min=0) "Window height"
    annotation(Dialog(group="Window properties"));
  parameter Modelica.SIunits.Length wWin(min=0) "Window width"
    annotation(Dialog(group="Window properties"));

  parameter Modelica.SIunits.Length wLeft(min=0)
    "Left overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length wRight(min=0)
    "Right overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length dep(min=0)
    "Overhang depth perpendicular to the wall plane"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length gap(min=0)
    "Distance between window upper edge and overhang lower edge"
    annotation(Dialog(group="Overhang properties"));

  parameter Modelica.SIunits.Length s(min=0)
    "Vertical spacing between fins"
    annotation(Dialog(group="Horizontal fin properties"));
  parameter Modelica.SIunits.Length w(min=0)
    "Fin width"
    annotation(Dialog(group="Horizontal fin properties"));
  parameter Modelica.SIunits.Length t(min=0)
    "Fin thickness"
    annotation(Dialog(group="Horizontal fin properties"));
  parameter Boolean use_betaInput = false
    "=true, to use input for fin inclination angle"
    annotation(Evaluate=true,Dialog(group="Horizontal fin properties"));
  parameter Modelica.SIunits.Angle beta(min=0)=0
    "Fin inclination angle: 0 for horizontal inclination, see documentation"
    annotation(Dialog(enable=not use_betaInput,group="Horizontal fin properties"));



  extends IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading(
      redeclare HorizontalFins stateShading1(
        azi=azi,
      s=s,
      w=w,
      t=t,
      use_betaInput=use_betaInput,
      beta=beta),
      redeclare IDEAS.Buildings.Components.Shading.Overhang stateShading2(
        azi=azi,
        hWin=hWin,
        wWin=wWin,
        wLeft=wLeft,
        wRight=wRight,
        dep=dep,
        gap=gap));

initial equation

    assert(dep > 0, "The depth of the overhang must be larger than zero, if this is not the case: just use Shading.Screen.");

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Documentation(info="<html>
<p>
Shading model for a combination of overhang and horizontal fins.
</p>
</html>", revisions="<html>
<ul>
<li>
March 23 2018, by Filip Jorissenr:<br/>
First implementation.
</li>
</ul>
</html>"));
end OverhangAndHorizontalFins;
