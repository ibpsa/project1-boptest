within IDEAS.BoundaryConditions.SolarIrradiation;
model RadSol "Block that computes surface-dependent environment data"
  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real rho=0.2 "Ground reflectance";
  parameter Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  parameter Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  parameter Modelica.SIunits.Angle lat(displayUnit="degree") "latitude";
  parameter Boolean remDefVals = false "Remove default signal values";
  parameter Boolean outputAngles=true "Set to false when linearising only";

  output Buildings.Components.Interfaces.SolBus solBus(outputAngles=
        outputAngles)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  Modelica.Blocks.Interfaces.RealInput angZen "Zenith angle"
    annotation (Placement(transformation(extent={{-124,-60},{-84,-20}})));
  Modelica.Blocks.Interfaces.RealInput solDifHor
    "Diffuse solar irradiation on horizontal surface"
    annotation (Placement(transformation(extent={{-124,40},{-84,80}})));
  Modelica.Blocks.Interfaces.RealInput solGloHor
    "Global solar irradiation on horizontal surface"
    annotation (Placement(transformation(extent={{-124,60},{-84,100}})));
  Modelica.Blocks.Interfaces.RealInput F1 "Circumsolar brightening coefficient"
    annotation (Placement(transformation(extent={{-124,-100},{-84,-60}})));
  Modelica.Blocks.Interfaces.RealInput F2 "Horizon brightening coefficient"
    annotation (Placement(transformation(extent={{-124,-120},{-84,-80}})));
  Modelica.Blocks.Interfaces.RealInput solDirPer
    "Beam solar irradiation on surface perpendicular to beam direction"
    annotation (Placement(transformation(extent={{-124,80},{-84,120}})));
  Modelica.Blocks.Interfaces.RealInput angHou "Hour angle"
    annotation (Placement(transformation(extent={{-124,-40},{-84,0}})));
  Modelica.Blocks.Interfaces.RealInput angDec "Declination angle"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,0})));
  Modelica.Blocks.Interfaces.RealInput solTim "Solar time" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,30})));
  SolarGeometry.BaseClasses.IncidenceAngle incAng(
    lat=lat,
    azi=azi,
    til=inc) "Inclination angle"
    annotation (Placement(transformation(extent={{-40,60},{-20,40}})));
  SolarIrradiation.BaseClasses.DiffusePerez HDifTil(rho=rho, til=inc)
    "Computation of diffuse solar irradiation on tilted surface"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));

  Modelica.Blocks.Interfaces.RealInput winSpe "Wind speed" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-60,120})));
  Modelica.Blocks.Interfaces.RealInput winDir "Wind direction" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-20,120})));
protected
  SolarIrradiation.BaseClasses.DirectTiltedSurface
                        solDirTil
    "Computation of direct solar irradiation on tilted surface"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.ExtConvForcedCoeff
    extConvCoeff(final inc=inc, final azi=azi)
    "Calculate coefficient for forced convection for exterior surface"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Modelica.Blocks.Sources.Constant dummyValAzi(k=0) if not remDefVals
    "angAzi dummy value when not needed"
    annotation (Placement(transformation(extent={{48,-98},{60,-86}})));
  Modelica.Blocks.Sources.Constant dummyValTenv(k=Modelica.Constants.inf) if
                                                     not remDefVals
    "Tenv dummy value when not needed"
    annotation (Placement(transformation(extent={{48,-76},{60,-64}})));


equation
  connect(angZen, solBus.angZen) annotation (Line(points={{-104,-40},{100.1,-40},
          {100.1,0.1}}, color={0,0,127}));
  connect(dummyValAzi.y, solBus.angAzi) annotation (Line(
      points={{60.6,-92},{100.1,-92},{100.1,0.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dummyValTenv.y, solBus.Tenv) annotation (Line(
      points={{60.6,-70},{100.1,-70},{100.1,0.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDirTil.HDirNor, solDirPer) annotation (Line(points={{-2,36},{-8,36},
          {-8,100},{-104,100}}, color={0,0,127}));
  connect(incAng.incAng, solBus.angInc) annotation (Line(points={{-19,50},{
          100.1,50},{100.1,0.1}}, color={0,0,127}));
  connect(incAng.decAng, angDec) annotation (Line(points={{-42.2,44.6},{-62,44.6},
          {-62,0},{-104,0}},       color={0,0,127}));
  connect(incAng.solHouAng, angHou) annotation (Line(points={{-42,54.8},{-60,54.8},
          {-60,46},{-60,-20},{-104,-20}},       color={0,0,127}));
  connect(HDifTil.HGloHor, solGloHor) annotation (Line(points={{-2,-2},{-46,-2},
          {-46,80},{-104,80}}, color={0,0,127}));
  connect(HDifTil.HDifHor, solDifHor) annotation (Line(points={{-2,-5},{-48,-5},
          {-48,60},{-104,60}}, color={0,0,127}));
  connect(HDifTil.briCof2, F2) annotation (Line(points={{-2,-11},{-48,-11},{-48,
          -32},{-48,-100},{-104,-100}}, color={0,0,127}));
  connect(HDifTil.briCof1, F1) annotation (Line(points={{-2,-8},{-50,-8},{-50,
          -80},{-104,-80}}, color={0,0,127}));
  connect(HDifTil.incAng, incAng.incAng) annotation (Line(points={{-2,-17},{-14,
          -17},{-14,50},{-19,50}}, color={0,0,127}));
  connect(HDifTil.zen, angZen) annotation (Line(points={{-2,-14},{-2,-16},{-52,
          -16},{-52,-40},{-104,-40}}, color={0,0,127}));
  connect(HDifTil.HSkyDifTil, solBus.HSkyDifTil) annotation (Line(points={{21,
          -6},{100.1,-6},{100.1,0.1}}, color={0,0,127}));
  connect(HDifTil.HGroDifTil, solBus.HGroDifTil) annotation (Line(points={{21,
          -14},{36,-14},{100.1,-14},{100.1,0.1}}, color={0,0,127}));
  connect(solDirTil.HDirTil, solBus.HDirTil) annotation (Line(points={{21,30},{
          100.1,30},{100.1,0.1}}, color={0,0,127}));
  connect(extConvCoeff.hForcedConExt, solBus.hForcedConExt) annotation (Line(points={{41,70},
          {60,70},{60,0.1},{100.1,0.1}},        color={0,0,127}));
  connect(extConvCoeff.winSpe, winSpe)
    annotation (Line(points={{18,74},{-60,74},{-60,120}}, color={0,0,127}));
  connect(extConvCoeff.winDir, winDir)
    annotation (Line(points={{18,66},{-20,66},{-20,120}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(extent={{-100,-120},{100,
            100}}),                   graphics={
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
November 28, 2019, by Ian Beausoleil-Morrison:<br/>
Add RealInput's for wind speed and wind direction.<br/>
Instantiate extConvForcedCoeff.mo and place resulting coefficient for forced convection on SolBus.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Added input <code>solTim</code> for azimuth computations.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/753\">
#753</a>.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
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
</html>"));
end RadSol;
