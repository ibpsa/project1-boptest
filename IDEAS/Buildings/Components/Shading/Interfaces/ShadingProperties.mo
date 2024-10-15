within IDEAS.Buildings.Components.Shading.Interfaces;
record ShadingProperties
  "Default: no shading"
  extends Modelica.Icons.Record;
  parameter Boolean controlled = false
    "if true, shading has a control input"
    annotation(Evaluate=true,
               Dialog(enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Screen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BoxAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingType shaType=
      IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.None
    "Window shading type";

  parameter Modelica.SIunits.Length hWin(min=0, start=0)=0.01 "Window height"
    annotation(Dialog(group="Window properties"));
  parameter Modelica.SIunits.Length wWin(min=0, start=0)=0.01 "Window width"
    annotation(Dialog(group="Window properties"));

  parameter Modelica.SIunits.Length wLeft(min=0, start=0)=0.01
    "Left overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Overhang or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Modelica.SIunits.Length wRight(min=0, start=0)=0.01
    "Right overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Overhang or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Modelica.SIunits.Length ovDep(min=0, start=0)=0.01
    "Overhang depth perpendicular to the wall plane"
    annotation(Dialog(group="Overhang properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Overhang or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Modelica.SIunits.Length ovGap(min=0, start=0)=0.01
    "Distance between window upper edge and overhang lower edge"
    annotation(Dialog(group="Overhang properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Overhang or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));

  parameter Modelica.SIunits.Length hFin(min=0, start=0)=0.01
    "Height of side fin above window"
    annotation(Dialog(group="Side fin properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.SideFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box)));
  parameter Modelica.SIunits.Length finDep(min=0, start=0)=0.01
    "Side fin depth perpendicular to the wall plane"
    annotation(Dialog(group="Side fin properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.SideFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box)));
  parameter Modelica.SIunits.Length finGap(min=0, start=0)=0.01
    "Vertical distance between side fin and window"
    annotation(Dialog(group="Side fin properties",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.SideFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Box)));

  parameter Modelica.SIunits.Length L(min=0, start=0)=0.01
    "Horizontal distance to object"
    annotation(Dialog(group="Building shade",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BuildingShade)));
  parameter Modelica.SIunits.Length dh(min=0, start=0)=0.01
    "Height difference between top of object and top of window"
    annotation(Dialog(group="Building shade",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BuildingShade)));

  parameter Real shaCorr(min=0)=0.24
    "Shortwave transmittance of shortwave radiation"
    annotation(Dialog(group="Screen",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.Screen or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndScreen)));

  parameter Modelica.SIunits.Length s(min=0)=0.1
    "Vertical spacing between fins"
    annotation(Dialog(group="Horizontal fins",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Modelica.SIunits.Length w(min=0)=0.1
    "Fin width"
        annotation(Dialog(group="Horizontal fins",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Modelica.SIunits.Length t(min=0)=0.01
    "Fin thickness"
        annotation(Dialog(group="Horizontal fins",
                      enable= (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));
  parameter Boolean use_betaInput = controlled
    "=true, to use input for fin inclination angle"
        annotation(Dialog(group="Horizontal fins",
                      Evaluate = true,
                      enable= false));
  parameter Modelica.SIunits.Angle beta(min=0) = 0.01
    "Fin inclination angle: 0 for horizontal inclination, see documentation"
    annotation(Dialog(group="Horizontal fins",
                      enable= not controlled and (shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.HorizontalFins or
                               shaType==IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.OverhangAndHorizontalFins)));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
Aug 2 2018, by Iago Cupeiro:<br/>
Corrected initialization bug in assert
</li>
<li>
May 4 2018, by Iago Cupeiro:<br/>
Extended with HorizontalFins and OverhangAndHorizontalFins models.
</li>
</ul>
</html>"));
end ShadingProperties;
