within IDEAS.Buildings.Components.Shading;
model BoxAndScreen "Box and screen shading"


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
  parameter Modelica.SIunits.Length ovDep(min=0)
    "Overhang depth perpendicular to the wall plane"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length ovGap(min=0)
    "Distance between window upper edge and overhang lower edge"
    annotation(Dialog(group="Overhang properties"));

  parameter Modelica.SIunits.Length hFin(min=0)
    "Height of side fin above window"
    annotation(Dialog(group="Side fin properties"));
  parameter Modelica.SIunits.Length finDep(min=0)
    "Side fin depth perpendicular to the wall plane"
    annotation(Dialog(group="Side fin properties"));
  parameter Modelica.SIunits.Length finGap(min=0)
    "Vertical distance between side fin and window"
    annotation(Dialog(group="Side fin properties"));

  parameter Real shaCorr=0.24 "Shortwave transmittance of shortwave radiation";

  extends IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(
        azi=azi,
        shaCorr=shaCorr),
      redeclare IDEAS.Buildings.Components.Shading.Box stateShading2(
        azi=azi,
        hWin=hWin,
        wWin=wWin,
        wLeft=wLeft,
        wRight=wRight,
        ovDep=ovDep,
        ovGap=ovGap,
        hFin=hFin,
        finDep=finDep,
        finGap=finGap));

initial equation

    assert(ovDep > 0, "The depth of the overhang must be larger than zero, if this is not the case: just use Shading.Screen.");
    assert(finDep > 0, "The depth of the side fins must be larger than zero, if this is not the case: just use Shading.OverhangAndScreen.");

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Documentation(info="<html>
<p>This model describes the transient behaviour of solar irradiance on a window below a non-fixed horizontal or vertical overhang combined with a controllable screen.</p>
</html>", revisions="<html>
<ul>
<li>
July 2015, by Filip Jorissenr:<br/>
Now extending from IDEAS.Buildings.Components.Interfaces.DoubleShading.
</li>
<li>
December 2014, by Filip Jorissenr:<br/>
First implementation.
</li>
</ul>
</html>"));
end BoxAndScreen;
