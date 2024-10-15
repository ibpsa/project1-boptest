within IDEAS.BoundaryConditions.SolarIrradiation;
model ShadedRadSol "Block that computes surface-dependent environment data"
  extends IDEAS.BoundaryConditions.SolarIrradiation.RadSol(
    final remDefVals = true);

  Modelica.Blocks.Interfaces.RealInput TskyPow4
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,120})));
  Modelica.Blocks.Interfaces.RealInput TePow4
    annotation (Placement(transformation(extent={{-18,-18},{18,18}},
        rotation=270,
        origin={60,118})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.SolarAzimuth solAzi(lat=lat) "Solar azimuth angle"
    annotation (Placement(transformation(extent={{36,-18},{56,-38}})));
  Modelica.Blocks.Math.Add relAzi(k2=-1)
    "Azimuth angle relative to surface azimuth"
    annotation (Placement(transformation(extent={{68,-52},{88,-32}})));
  Modelica.Blocks.Sources.Constant surfAzi(k=azi) "Surface azimuth angle"
    annotation (Placement(transformation(extent={{-20,-54},{-8,-42}})));


protected
  final parameter Real Fssky=(1 + cos(inc))/2
    "radiant-interchange configuration factor between surface and sky";
  final parameter Real beta = cos(inc/2)
    "Additional factor for taking into account the line of sight through the atmosphere";
  final parameter Real coeffSky = Fssky*beta
    "Dummy parameter for speeding up computations";
  final parameter Real coeffEnv = 1-Fssky*beta
    "Dummy parameter for speeding up computations";

  Modelica.Blocks.Sources.RealExpression TenvExpr(
    y=(coeffSky*TskyPow4 + coeffEnv*TePow4)^0.25)
    "Environment temperature"
    annotation (Placement(transformation(extent={{0,70},{60,90}})));


equation
  connect(TenvExpr.y, solBus.Tenv) annotation (Line(
      points={{63,80},{100.1,80},{100.1,0.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDirTil.incAng, incAng.incAng) annotation (Line(points={{-2,24},{
          -14,24},{-14,50},{-19,50}}, color={0,0,127}));
  connect(solAzi.zen, angZen) annotation (Line(points={{34,-34},{34,-40},{-104,
          -40}},       color={0,0,127}));
  connect(surfAzi.y, relAzi.u2)
    annotation (Line(points={{-7.4,-48},{66,-48}}, color={0,0,127}));
  connect(relAzi.u1, solAzi.solAzi) annotation (Line(points={{66,-36},{60,-36},
          {60,-28},{57,-28}},color={0,0,127}));
  connect(solAzi.solTim, solTim) annotation (Line(points={{34,-22},{-64,-22},{
          -64,30},{-104,30}},
                          color={0,0,127}));
  connect(relAzi.y, solBus.angAzi) annotation (Line(points={{89,-42},{100.1,-42},
          {100.1,0.1}}, color={0,0,127}));
  connect(solAzi.decAng, angDec) annotation (Line(points={{34,-28},{-62,-28},{
          -62,0},{-104,0}},
                        color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                      graphics={
        Polygon(
          points={{-90,-80},{-40,-40},{40,-40},{90,-80},{-90,-80}},
          lineColor={95,95,95},
          smooth=Smooth.None),
        Polygon(
          points={{16,-46},{22,-72},{-72,-4},{-18,-22},{16,-46}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Ellipse(
          extent={{88,84},{40,38}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Revised azimuth angle computation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/753\">
#753</a>.
</li>
<li>
January 20, 2017 by Filip Jorissen:<br/>
Changed computation of Tenv.
See issue 
<a href=https://github.com/open-ideas/IDEAS/issues/623>#623</a>.
</li>
<li>
September 22, 2016 by Filip Jorissen:<br/>
Reworked implementation such that we use Annex 60 baseclasses.
</li>
<li>
March 25, 2016 by Filip Jorissen:<br/>
Reworked radSol implementation to use RealInputs instead of weaBus.
This simplifies translation and interpretation.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>", info="<html>
<p>
Model of equivalent radiative temperature is according to page 73 in
</p>
<p>
Walton, G. N. 1983. Thermal Analysis Research Program Reference Manual. NBSSIR 83-2655. National Bureau of Standards
</p>
</html>"));
end ShadedRadSol;
