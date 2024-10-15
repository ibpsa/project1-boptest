within IDEAS.Buildings.Components.Shading;
model Screen "Controllable exterior screen"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=true);

  parameter Real shaCorr=0.24 "Shortwave transmittance of shortwave radiation";

protected
  Modelica.Blocks.Nonlinear.Limiter limiter(
    uMax=1,
    uMin=0,
    limitsAtInit=true);

equation
  HShaDirTil = HDirTil*(1 - limiter.y);
  HShaSkyDifTil = HSkyDifTil*(1 - limiter.y) + HSkyDifTil*limiter.y*shaCorr + HDirTil*limiter.y*shaCorr;
  HShaGroDifTil = HGroDifTil*(1 - limiter.y) + HGroDifTil*limiter.y*shaCorr;

  connect(limiter.u, Ctrl);
  connect(angInc, iAngInc) annotation (Line(points={{-60,-50},{-14,-50},{-14,
          -50},{40,-50}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}})),
    Documentation(info="<html>
<p>
Shading model of a controllable screen. 
The transmitted direct solar irradiance varies linearly between [0, 1] with the control input. 
A fraction <code>shaCorr</code> is converted into diffuse light that enters the building.
</p>
</html>", revisions="<html>
<ul>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end Screen;
