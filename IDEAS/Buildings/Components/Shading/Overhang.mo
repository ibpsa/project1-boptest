within IDEAS.Buildings.Components.Shading;
model Overhang "Roof overhangs"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=false);

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
  final parameter Real fraSunDifSky(final min=0,final max=1, final unit="1") = 1-vieAngOverhang/(0.5*Modelica.Constants.pi)
    "Fraction of window area exposed to diffuse sun light";

  Real fraSunDir(final min=0,final max=1, final unit="1")
    "Fraction of window area exposed to direct sun light";
protected
  final parameter Modelica.SIunits.Area AWin= hWin*wWin "Window area";
  parameter Modelica.SIunits.Length tmpH[4](fixed=false)
    "Height rectangular sections used for superposition";
  final parameter Modelica.SIunits.Angle vieAngOverhang = atan(dep/(gap+hWin/2)) "Viewing angle of overhang";

  Modelica.SIunits.Length w
    "Either wL or wR, depending on the sun relative to the wall azimuth";
  Modelica.SIunits.Length tmpW[4]
    "Width of rectangular sections used for superpositions";
  Modelica.SIunits.Length del_L = wWin/100
    "Fraction of window dimension over which min-max functions are smoothened";
  Modelica.SIunits.Length x1
    "Horizontal distance between window side edge and shadow corner";
  Modelica.SIunits.Length x2[4]
    "Horizontal distance between window side edge and point where shadow line and window lower edge intersects";
  Modelica.SIunits.Length y1
    "Vertical distance between overhang and shadow lower edge";
  Modelica.SIunits.Length y2[4]
    "Window height (vertical distance corresponding to x2)";
  Real shdwTrnglRtio "ratio of y1 and x1";
  Modelica.SIunits.Area area[4]
    "Shaded areas of the sections used in superposition";
  Modelica.SIunits.Area shdArea "Shaded area calculated from equations";
  Modelica.SIunits.Area crShdArea "Final value for shaded area";
  Modelica.SIunits.Area crShdArea1
    "Corrected for the sun behind the surface/wall";
  Modelica.SIunits.Area crShdArea2 "Corrected for the sun below horizon";

  Modelica.SIunits.Angle alt = (Modelica.Constants.pi/2) - angZen;
  Modelica.SIunits.Angle verAzi
    "Angle between projection of sun's rays and normal to vertical surface";

initial equation

    assert(dep > 0, "The depth of the overhang must be larger than zero.");

initial algorithm

  for i in 1:4 loop
    tmpH[i] := gap + mod((i - 1), 2)*hWin;
  end for;

equation

  verAzi = Modelica.Math.acos(cos(angInc)/cos(alt));

  w = Modelica.Media.Air.MoistAir.Utilities.spliceFunction(pos=wLeft, neg=wRight, x=angAzi-azi, deltax=0.005);
  tmpW = {w+wWin,w,w,w+wWin};
  y1*Modelica.Math.cos(verAzi) = dep*Modelica.Math.tan(alt);
  x1 = dep*Modelica.Math.tan(verAzi);
  shdwTrnglRtio*x1 = y1;

  for i in 1:4 loop
    y2[i] = tmpH[i];
    x2[i]*y1 = x1*tmpH[i];
    area[i] = IDEAS.Utilities.Math.Functions.smoothMin(x1=y1,x2=y2[i],deltaX=del_L)*tmpW[i]
      -(IDEAS.Utilities.Math.Functions.smoothMin(y1,tmpH[i],del_L)*IDEAS.Utilities.Math.Functions.smoothMin(x1=x2[i],x2=y1,deltaX=del_L)/2)
      + IDEAS.Utilities.Math.Functions.smoothMax(x1=shdwTrnglRtio*(IDEAS.Utilities.Math.Functions.smoothMin(x1=x1,x2=x2[i],deltaX=del_L) - tmpW[i]),x2=0,deltaX=del_L)*IDEAS.Utilities.Math.Functions.smoothMax(x1=(IDEAS.Utilities.Math.Functions.smoothMin(x1=x1,x2=x2[i],deltaX=del_L) - tmpW[i]),x2=0,deltaX=del_L)/2;
  end for;
  shdArea = area[4] + area[3] - area[2] - area[1];
  // correction case: Sun not in front of the wall
  crShdArea1 = Modelica.Media.Air.MoistAir.Utilities.spliceFunction(pos=shdArea,neg=AWin,x=(Modelica.Constants.pi/2)-verAzi,deltax=0.01);
  // correction case: Sun not above horizon
  crShdArea2 = Modelica.Media.Air.MoistAir.Utilities.spliceFunction(pos=shdArea,neg=AWin,x=alt,deltax=0.01);
  crShdArea=IDEAS.Utilities.Math.Functions.smoothMax(x1=crShdArea1,x2=crShdArea2,deltaX=0.01);
  fraSunDir = IDEAS.Utilities.Math.Functions.smoothMin( x1=IDEAS.Utilities.Math.Functions.smoothMax(x1=1-crShdArea/AWin,x2=0,deltaX=0.01),x2=1.0,deltaX=0.01);

  HShaDirTil = fraSunDir*HDirTil;
  HShaSkyDifTil=fraSunDifSky*HSkyDifTil;

  connect(angInc, iAngInc) annotation (Line(
      points={{-60,-50},{-14,-50},{-14,-50},{40,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HGroDifTil, HShaGroDifTil) annotation (Line(points={{-60,10},{-14,10},
          {-14,10},{40,10}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Shading model of an overhang above a window where
hWin is the window height,
wWin is the window width,
gap is the vertical distance between the window upper edge and the overhang,
dep is the horizontal distance between the window glazing and the overhang
and wLeft and wRight are respectively the horizontal overhang widths.
</p>
<p><img alt=\"illustration\" src=\"modelica://IDEAS/Resources/Images/Buildings/Components/Shading/Overhang.png\"/></p>
</html>", revisions="<html>
<ul>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Added computation of diffuse solar shading.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end Overhang;
