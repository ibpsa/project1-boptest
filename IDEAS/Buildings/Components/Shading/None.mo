within IDEAS.Buildings.Components.Shading;
model None "No solar shading"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=false);

equation
  connect(angInc, iAngInc) annotation (Line(
      points={{-60,-50},{-16,-50},{-16,-50},{40,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil, HShaDirTil)
    annotation (Line(points={{-60,50},{40,50},{40,50}}, color={0,0,127}));
  connect(HSkyDifTil, HShaSkyDifTil) annotation (Line(points={{-60,30},{-17,30},
          {-17,30},{40,30}}, color={0,0,127}));
  connect(HGroDifTil, HShaGroDifTil) annotation (Line(points={{-60,10},{-14,10},
          {-14,10},{40,10}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
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
</html>", info="<html>
<p>Use this model if you want no solar shading to be computed.</p>
</html>"));
end None;
