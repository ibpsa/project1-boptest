within IDEAS.Buildings.Components.Shading;
model BuildingShade
  "Component for modeling shade cast by distant objects such as buildings and treelines"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
    final controlled=false);

  parameter Modelica.SIunits.Length L(min=0)
    "Distance to object perpendicular to window"
    annotation(Dialog(group="Dimensions (see illustration in documentation)"));
  parameter Modelica.SIunits.Length dh
    "Height difference between top of object and top of window glazing"
    annotation(Dialog(group="Dimensions (see illustration in documentation)"));
  parameter Modelica.SIunits.Length hWin(min=0) = 1
    "Window height: distance between top and bottom of window glazing"
    annotation(Dialog(group="Dimensions (see illustration in documentation)"));
  parameter Real fraSha(min=0,max=1) = 1
    "Fraction of the light that is shaded, e.g. smaller than 1 for shading cast by tree lines.";
  final parameter Real fraSunDifSky(final min=0,final max=1, final unit="1") = 1-vieAngObj/(Modelica.Constants.pi/2)
    "Fraction of window area exposed to diffuse sun light";

  Real fraSunDir(final min=0,final max=1, final unit="1")
    "Fraction of window area exposed to direct sun light";

  // Computation assumes that window base is at ground level.
  // Viewing angle computed from center of glazing.
protected
  parameter Modelica.SIunits.Angle vieAngObj = atan((hWin/2+dh)/L) "Viewing angle of opposite object";
  final parameter Modelica.SIunits.Angle rot = 0
    "Rotation angle of opposite building. Zero when parallel, positive when rotated clockwise"
    annotation(Evaluate=true);
  final parameter Real coeff = 1-fraSha "More efficient implementation";
  final parameter Real hWinInv = 1/hWin "More efficient implementation";
  Real tanZen = tan(min(angZen, Modelica.Constants.pi/2.01));
  Modelica.SIunits.Length L1 "Horizontal distance to object when following vertical plane through sun ray";
  Modelica.SIunits.Length L2 "Distance to object, taking into account sun position";
  Modelica.SIunits.Angle alt = (Modelica.Constants.pi/2) - angZen;
  Modelica.SIunits.Angle verAzi
    "Angle between downward projection of sun's rays and normal to vertical surface";
initial equation
  assert(fraSunDifSky>=0 and fraSunDifSky<=1, "In " + getInstanceName() +
    ": The parameter fraSunDifSky has the value " +String(fraSunDifSky) + " and 
    should be within [0,1]. Please contact the IDEAS developers.");

equation

  verAzi = Modelica.Math.acos(cos(angInc)/cos(alt));
  L1 = max(0,L/cos(verAzi));
  L2 = L1*tan(alt);
  if noEvent(L2<dh) then
    fraSunDir=coeff;
  elseif noEvent(L2<dh+hWin) then
    fraSunDir=coeff + (L2-dh)*fraSha*hWinInv;
  else
    fraSunDir=1;
  end if;

  HShaDirTil=fraSunDir*HDirTil;
  HShaSkyDifTil = fraSunDifSky*HSkyDifTil;
  connect(angInc, iAngInc) annotation (Line(points={{-60,-50},{-14,-50},{-14,-50},
          {40,-50}}, color={0,0,127}));

  connect(HGroDifTil, HShaGroDifTil)
    annotation (Line(points={{-60,10},{40,10},{40,10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}}),
        graphics),
    Documentation(info="<html>
<p>
This model computes the shading cast by a building (or other object) at 
distance <code>L</code> and relative height <code>dh</code> 
on a window (or wall) with height <code>hWin</code>.
For a window this height corresponds to the window glazing height,
excluding the window frame.
Diffuse sky solar radiation is reduced
by computing a simplified view factor of the building,
which blocks the sky view.
Diffuse ground solar radiation is unaffected by this model. 
</p>
<p><img alt=\"illustration\" src=\"modelica://IDEAS/Resources/Images/Buildings/Components/Shading/BuildingShade.png\"/></p>
<h4>Assumption and limitations</h4>
<p>
This model assumes that the obstructing object is very wide (infinite) 
compared to the window/wall
and that it is parallel to the window. 
This model is inaccurate when this is not the case.
</p>
<p>
We assume that the opposite building is shaded or that its reflectivity is zero,
such that it does not reflect solar irradiation towards
the window.
Partial shading, e.g. when modelling treelines, 
can be modelled by changing the value of parameter <code>fraSha</code> accordingly.
</p>
</html>", revisions="<html>
<ul>
<li>
September 22, 2019 by Filip Jorissen:<br/>
Added assert that checks validity of parameter <code>fraSunDifSky</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/843\">
#843</a>.
</li>
<li>
April 10, 2019 by Filip Jorissen:<br/>
Revised computation of <code>fraSunDifSky</code> to avoid
negative shading fractions.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1007\">
#1007</a>.
</li>
<li>
February 21, 2019 by Filip Jorissen:<br/>
Added parameter <code>shaFra</code> for lowering shading
fraction of the model.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/912\">
#912</a>.
</li>
<li>
September 25, 2018 by Filip Jorissen:<br/>
Clarified meaning of <code>hWin</code>
and grouped parameters with reference to documentation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/909\">
#909</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Added computation of diffuse solar shading.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
May 25, 2017, by Filip Jorissen:<br/>
Fixed implementation for non-south oriented windows.
</li>
<li>
December 9, 2016, by Filip Jorissen:<br/>
Fixed implementation for non-circular type building.
</li>
<li>
July 14, 2015, by Filip Jorissen:<br/>
Added documentation.
</li>
<li>
June 12, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end BuildingShade;
