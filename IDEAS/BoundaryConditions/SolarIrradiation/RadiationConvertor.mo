within IDEAS.BoundaryConditions.SolarIrradiation;
model RadiationConvertor
  "Converts east-south-west radiation into different components"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Modelica.SIunits.Angle delta = 0 "Relative shift of south in the direction of west.";
  parameter Real[3] rho = {0.2,0.2,0.2} "Ground reflectivities for east, south, west";
  final parameter Modelica.SIunits.Angle south=IDEAS.Types.Azimuth.S + delta;
  final parameter Modelica.SIunits.Angle east = south + Modelica.SIunits.Conversions.from_deg(270) + delta;
  final parameter Modelica.SIunits.Angle west = south + Modelica.SIunits.Conversions.from_deg(90) + delta;
  final parameter Modelica.SIunits.Angle vertical=IDEAS.Types.Tilt.Wall;
  final parameter Modelica.SIunits.Angle horizontal = Modelica.SIunits.Conversions.from_deg(0);
  parameter Real lon "Longitude";
  Modelica.Blocks.Interfaces.RealInput decAng "Declination angle"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput HEast
    "Total radiation on a plane facing east"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}}),
        iconTransformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput HSouth
    "Total radiation on a plane facing south"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput HWest
    "Total radiation on a plane facing west"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-140,-10},{-100,30}})));
  IDEAS.Utilities.Math.Min Hmin(nin=3, u(each start=0))
    "Minimum radiation on surfaces: everything except direct solar radiation"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Interfaces.RealOutput HDirHor
    "Radiation on horizontal surface" annotation (Placement(transformation(
          extent={{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,
            70}})));
  Modelica.Blocks.Interfaces.RealOutput HDirNor
    "Direct radiation normal to zenith" annotation (Placement(transformation(
          extent={{100,30},{120,50}}), iconTransformation(extent={{100,30},{120,
            50}})));
  Modelica.Blocks.Interfaces.RealOutput HDifHor
    "Diffuse radiation on a horizontal surface" annotation (Placement(
        transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{
            100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealInput solHouAng
    "Solar hour angle"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput solZen
    "Solar zenith angle"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));

   IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle zenAng(final lat=
       lat) "Zenith angle"
    annotation (Placement(transformation(extent={{0,20},{20,0}})));
protected
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incSouth(
    final lat=lat,
    final til=vertical,
    azi=south) "Incidence angle of the south oriented sensor"
    annotation (Placement(transformation(extent={{0,-30},{20,-50}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incWest(
    final lat=lat,
    final til=vertical,
    azi=west) "Incidence angle of the west oriented sensor"
    annotation (Placement(transformation(extent={{0,-54},{20,-74}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incEast(
    final lat=lat,
    final til=vertical,
    azi=east) "Incidence angle of the east oriented sensor"
    annotation (Placement(transformation(extent={{0,-80},{20,-100}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incHor(
    final lat=lat,
    azi=south,
    final til=horizontal) "Incidence angle on horizontal surface"
    annotation (Placement(transformation(extent={{0,-4},{20,-24}})));
  Modelica.Blocks.Sources.RealExpression HDirSouthGuess(y=(HSouth -
        solDifHorGuess.y/2 - rhoGain[2].y/2)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incSouth.incAng),
        0.01)) "Solar radiation measured from south faced surface"
    annotation (Placement(transformation(extent={{-100,0},{-20,22}})));
  Modelica.Blocks.Sources.RealExpression HDirEastGuess(y=(HEast -
        solDifHorGuess.y/2 - rhoGain[1].y/2)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incEast.incAng),
        0.01)) "Solar radiation measured from east faced surface"
    annotation (Placement(transformation(extent={{-100,18},{-20,40}})));
  Modelica.Blocks.Sources.RealExpression HDirWestGuess(y=(HWest -
        solDifHorGuess.y/2 - rhoGain[3].y/2)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incWest.incAng),
        0.01)) "Solar radiation measured from west faced surface"
    annotation (Placement(transformation(extent={{-100,-14},{-20,6}})));
  Modelica.Blocks.Sources.RealExpression HDirHorVal(y=cos(incHor.incAng)*
        HDirNor) "Solar radiation on a horizontal surface"
    annotation (Placement(transformation(extent={{40,50},{80,70}})));
  Modelica.Blocks.Sources.RealExpression HDirMaxGuess(y=
        if zenAng.zen > Modelica.Constants.pi/2 then 0 else
          IDEAS.Utilities.Math.Functions.spliceFunction(
          x=min(incSouth.incAng, incEast.incAng) - incWest.incAng,
          pos=HDirWestGuess.y,
          neg=IDEAS.Utilities.Math.Functions.spliceFunction(
            x=incEast.incAng - incSouth.incAng + 0.25,
            pos=HDirSouthGuess.y,
            neg=HDirEastGuess.y,
            deltax=0.3),
          deltax=0.3))
    "Direct solar radiation measured from direction that faces sun the most"
    annotation (Placement(transformation(extent={{-100,-30},{-20,-10}})));
   Modelica.Blocks.Math.Gain gainDif(k=2) "Inverse of (1+cos90)/2 - see Perez"
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Math.Add add[3](each k2=-0.5)
    "Remove ground reflecting light"
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Math.Gain rhoGain[3](k=rho) "Ground reflectance factors"
    annotation (Placement(transformation(extent={{-60,66},{-80,46}})));
  Modelica.Blocks.Sources.RealExpression HGloHorGuess(y=cos(incHor.incAng)*
        HDirMaxGuess.y + solDifHorGuess.y)
    "Global horizontal radiation without reflectance"
    annotation (Placement(transformation(extent={{0,46},{-46,66}})));
  DiffusePerezPublic HDifTil[3](rho=rhoGain.k, each til=vertical)
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Math.Add HDifTot[3]
    annotation (Placement(transformation(extent={{128,-56},{140,-44}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.SkyClearness skyClearness
    "Computation of sky clearness"
    annotation (Placement(transformation(extent={{42,-62},{58,-78}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.BrighteningCoefficient
    skyBriCoe "Computation of sky brightness coefficients F1 and F2"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Routing.RealPassThrough solDifHorGuess
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Blocks.Sources.RealExpression HDirWest(y=(HWest - HDifTot[3].y)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incWest.incAng),
        0.01)) "Solar radiation measured from west faced surface"
    annotation (Placement(transformation(extent={{40,-14},{80,6}})));
  Modelica.Blocks.Sources.RealExpression HDirSouth(y=(HSouth - HDifTot[2].y)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incSouth.incAng),
        0.01)) "Solar radiation measured from south faced surface"
    annotation (Placement(transformation(extent={{40,0},{80,20}})));
  Modelica.Blocks.Sources.RealExpression HDirEast(y=(HEast - HDifTot[1].y)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incEast.incAng),
        0.01)) "Solar radiation measured from east faced surface"
    annotation (Placement(transformation(extent={{40,16},{80,36}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.SkyBrightness skyBrightness
    "Computation of sky brightness"
    annotation (Placement(transformation(extent={{66,-78},{80,-92}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.RelativeAirMass relativeAirMass
    "Computation of relative air mass"
    annotation (Placement(transformation(extent={{42,-84},{58,-100}})));
  Modelica.Blocks.Sources.RealExpression HDirMax(y=
        if zenAng.zen > Modelica.Constants.pi/2 then 0 else
        IDEAS.Utilities.Math.Functions.spliceFunction(
          x=min(incSouth.incAng, incEast.incAng) - incWest.incAng,
          pos=HDirWest.y,
          neg=IDEAS.Utilities.Math.Functions.spliceFunction(
            x=incEast.incAng - incSouth.incAng + 0.25,
            pos=HDirSouth.y,
            neg=HDirEast.y,
            deltax=0.3),
          deltax=0.3))
    "Direct solar radiation measured from direction that faces sun the most"
    annotation (Placement(transformation(extent={{40,30},{80,50}})));
  Modelica.Blocks.Sources.RealExpression HGloHor(y=HDirHor + HDifHor)
    "Global horizontal radiation without reflectance"
    annotation (Placement(transformation(extent={{40,-52},{80,-32}})));
  IDEAS.Utilities.Math.Min Hmin1(      nin=3, u(each start=0))
    "Minimum radiation on surfaces: everything except direct solar radiation"
    annotation (Placement(transformation(extent={{92,-26},{106,-12}})));
  Modelica.Blocks.Math.Add subGro[3](each k2=-1)
    "Remove ground reflecting light"
    annotation (Placement(transformation(extent={{120,0},{140,20}})));
  Modelica.Blocks.Sources.RealExpression invPerez[3](y=subGro.y ./ (ones(3)*0.5*
        (1 - skyBriCoe.F1) + skyBriCoe.F1*HDifTil.a_pub ./ HDifTil.b_pub + ones(
         3)*skyBriCoe.F2))
                       "Inverse of perez computation"
    annotation (Placement(transformation(extent={{40,-30},{80,-8}})));

  block DiffusePerezPublic
    "Diffuse Perez implementation with more public variables"
    extends IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.DiffusePerez;
    Real a_pub=a "Public copy of protected variable";
    Real b_pub=b "Public copy of protected variable";
    annotation (Documentation(info="<html>
  <p>
  Model to avoid warnings when accessing a and b.
  </p>
  </html>"));
  end DiffusePerezPublic;
equation
  connect(zenAng.solHouAng, solHouAng) annotation (Line(
      points={{-2,14.8},{-8,14.8},{-8,-80},{-120,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zenAng.decAng, decAng) annotation (Line(
      points={{-2,4.6},{-10,4.6},{-10,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incSouth.decAng, decAng) annotation (Line(
      points={{-2.2,-45.4},{-10,-45.4},{-10,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incSouth.solHouAng, solHouAng) annotation (Line(
      points={{-2,-35.2},{-8,-35.2},{-8,-80},{-120,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incWest.decAng, decAng) annotation (Line(
      points={{-2.2,-69.4},{-10,-69.4},{-10,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incWest.solHouAng, solHouAng) annotation (Line(
      points={{-2,-59.2},{-8,-59.2},{-8,-80},{-120,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incEast.decAng, decAng) annotation (Line(
      points={{-2.2,-95.4},{-2.2,-96},{-10,-96},{-10,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incEast.solHouAng, solHouAng) annotation (Line(
      points={{-2,-85.2},{-8,-85.2},{-8,-80},{-120,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incHor.solHouAng, solHouAng) annotation (Line(
      points={{-2,-9.2},{-8,-9.2},{-8,-80},{-120,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incHor.decAng, decAng) annotation (Line(
      points={{-2.2,-19.4},{-10,-19.4},{-10,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirHorVal.y, HDirHor) annotation (Line(
      points={{82,60},{110,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zenAng.zen, solZen) annotation (Line(
      points={{21,10},{30,10},{30,20},{110,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, Hmin.u)
    annotation (Line(points={{-69,80},{-62,80}},            color={0,0,127}));
  connect(add[1].u1, HEast) annotation (Line(points={{-92,86},{-120,86},{-120,90}},
                      color={0,0,127}));
  connect(add[2].u1, HSouth)
    annotation (Line(points={{-92,86},{-120,86},{-120,50}}, color={0,0,127}));
  connect(add[3].u1, HWest)
    annotation (Line(points={{-92,86},{-120,86},{-120,10}},color={0,0,127}));
  connect(Hmin.y, gainDif.u)
    annotation (Line(points={{-39,80},{-32,80}},      color={0,0,127}));
  connect(HGloHorGuess.y, rhoGain[1].u)
    annotation (Line(points={{-48.3,56},{-58,56}}, color={0,0,127}));
  connect(HGloHorGuess.y, rhoGain[2].u)
    annotation (Line(points={{-48.3,56},{-58,56}}, color={0,0,127}));
  connect(HGloHorGuess.y, rhoGain[3].u)
    annotation (Line(points={{-48.3,56},{-58,56}}, color={0,0,127}));
  connect(HDifTil[1].incAng, incEast.incAng) annotation (Line(points={{98,-57},{
          26,-57},{26,-90},{21,-90}}, color={0,0,127}));
  connect(HDifTil[1].zen, incHor.incAng) annotation (Line(points={{98,-54},{28,-54},
          {28,-14},{21,-14}}, color={0,0,127}));
  connect(HDifTil[2].zen, incHor.incAng) annotation (Line(points={{98,-54},{28,-54},
          {28,-14},{21,-14}}, color={0,0,127}));
  connect(HDifTil[3].zen, incHor.incAng) annotation (Line(points={{98,-54},{28,-54},
          {28,-14},{21,-14}}, color={0,0,127}));
  for i in 1:3 loop
    connect(skyBriCoe.F1, HDifTil[i].briCof1) annotation (Line(points={{121,-86},
            {124,-86},{124,-70},{90,-70},{90,-48},{98,-48}},           color={0,
            0,127}));
    connect(skyBriCoe.F2, HDifTil[i].briCof2) annotation (Line(points={{121,-94},
            {126,-94},{126,-68},{92,-68},{92,-51},{98,-51}}, color={0,0,127}));
    connect(HDifTil[i].HGloHor, HGloHor.y) annotation (Line(points={{98,-42},{82,
            -42}},                           color={0,0,127}));
    connect(HDifTil[i].HDifHor, HDifHor) annotation (Line(points={{98,-45},{94,-45},
            {88,-45},{88,-46},{88,-44},{88,80},{110,80}}, color={0,0,127}));

  end for;
  connect(HDifTot.u2, HDifTil.HGroDifTil) annotation (Line(points={{126.8,-53.6},
          {121,-53.6},{121,-54}},              color={0,0,127}));
  connect(HDifTil.HSkyDifTil, HDifTot.u1) annotation (Line(points={{121,-46},{128,
          -46},{128,-46.4},{126.8,-46.4}},
                                     color={0,0,127}));
  connect(skyClearness.zen, zenAng.zen) annotation (Line(points={{40.4,-65.2},{30,
          -65.2},{30,10},{21,10}},
                          color={0,0,127}));
  connect(rhoGain.y, add.u2) annotation (Line(points={{-81,56},{-96,56},{-96,74},
          {-92,74}}, color={0,0,127}));
  connect(solDifHorGuess.u, gainDif.y)
    annotation (Line(points={{-2,80},{-9,80}},         color={0,0,127}));
  connect(skyClearness.HGloHor, HGloHorGuess.y) annotation (Line(points={{40.4,-74.8},
          {32,-74.8},{32,50},{-50,50},{-50,56},{-48.3,56}},
                                                color={0,0,127}));
  connect(skyClearness.HDifHor, solDifHorGuess.y) annotation (Line(points={{40.4,
          -70},{34,-70},{34,80},{21,80}},     color={0,0,127}));
  connect(skyClearness.skyCle, skyBriCoe.skyCle) annotation (Line(points={{58.8,
          -70},{82,-70},{82,-84},{98,-84}},
                                          color={0,0,127}));
  connect(skyBriCoe.zen, skyClearness.zen)
    annotation (Line(points={{98,-96},{30,-96},{30,-65.2},{40.4,-65.2}},
                                                  color={0,0,127}));
  connect(relativeAirMass.relAirMas, skyBrightness.relAirMas) annotation (Line(
        points={{58.8,-92},{62,-92},{62,-87.8},{64.6,-87.8}}, color={0,0,127}));
  connect(skyBrightness.HDifHor, skyClearness.HDifHor) annotation (Line(points={{64.6,
          -82.2},{34,-82.2},{34,-70},{40.4,-70}},             color={0,0,127}));
  connect(subGro[1].u1, HEast) annotation (Line(
      points={{118,16},{118,66},{-6,66},{-6,90},{-120,90}},
      color={0,0,127},
      visible=false));
  connect(subGro[2].u1, HSouth) annotation (Line(
      points={{118,16},{-120,16},{-120,50}},
      color={0,0,127},
      visible=false));
  connect(subGro[3].u1, HWest) annotation (Line(
      points={{118,16},{-120,16},{-120,10}},
      color={0,0,127},
      visible=false));
  connect(HDirMax.y, HDirNor)
    annotation (Line(points={{82,40},{110,40}}, color={0,0,127}));
  connect(incWest.incAng, HDifTil[3].incAng) annotation (Line(points={{21,-64},{
          26,-64},{26,-57},{98,-57}}, color={0,0,127}));
  connect(incSouth.incAng, HDifTil[2].incAng) annotation (Line(points={{21,-40},
          {26,-40},{26,-57},{98,-57}}, color={0,0,127}));
  connect(HDifTil.HGroDifTil, subGro.u2) annotation (Line(points={{121,-54},{124,
          -54},{124,-34},{114,-34},{114,4},{118,4}}, color={0,0,127}));
  connect(Hmin1.u, invPerez.y)
    annotation (Line(points={{90.6,-19},{82,-19}},  color={0,0,127}));
  connect(Hmin1.y, HDifHor) annotation (Line(points={{106.7,-19},{108,-19},{108,
          -18},{110,-18},{110,80},{110,80}}, color={0,0,127}));
  connect(relativeAirMass.zen, skyClearness.zen) annotation (Line(points={{40.4,
          -92},{30,-92},{30,-65.2},{40.4,-65.2}}, color={0,0,127}));
  connect(skyBriCoe.skyBri, skyBrightness.skyBri) annotation (Line(points={{98,-90},
          {80.7,-90},{80.7,-85}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}},
        initialScale=0.1)),               Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
The left part of this block computes the sky brightness using a simplified 
inverse Perez computation, which are then used for a more detailed inverse Perez computation.
For details see section 8.3.1.10 of [1]. For a validation see Figure 8.9 of [1].
</p>
<h4>Assumption and limitations</h4>
<p>
The model assumes that each sensor is placed on a vertical wall and that the 
sensors are rotated multiples of 90 degrees with respect to each other.
</p>
<h4>Typical use and important parameters</h4>
<p>
The parameters <code>rho</code> can be used to set the ground reflectivity 
corresponding to each of the measured solar irradiation inputs.
</p>
<p>
The parameter delta is the shift of the south sensor compared to south in the west rotational direction.
</p>
<p>
Furthermore, the longitude and latitude have to be set.
</p>
<h4>References</h4>
<p>
[1] F. Jorissen. (2018) Toolchain for optimal control and design of energy systems in buildings. PhD thesis, Arenberg Doctoral School, KU Leuven.
</p>
</html>", revisions="<html>
<ul>
<li>
October 10, 2019, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end RadiationConvertor;
