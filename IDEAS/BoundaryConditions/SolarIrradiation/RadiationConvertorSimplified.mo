within IDEAS.BoundaryConditions.SolarIrradiation;
model RadiationConvertorSimplified
  "Converts east-south-west radiation into diffuse and direct component, without complex algebraic loop"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Angle lat "Latitude";

  parameter Real lon "Longitude";
  parameter Real[3] rho = {0.3, 0.3, 0.3} "Ground reflectance for east, south, west";

  Modelica.Blocks.Interfaces.RealInput HEast
    "Total solar irradiation on a plane facing east"
    annotation (Placement(transformation(extent={{-124,60},{-84,100}})));
  Modelica.Blocks.Interfaces.RealInput HSouth
    "Total solar irradiation on a plane facing south"
    annotation (Placement(transformation(extent={{-124,20},{-84,60}})));
  Modelica.Blocks.Interfaces.RealInput HWest
    "Total solar irradiation on a plane facing west"
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
  IDEAS.Utilities.Math.Min Hmin(nin=3, u(each start=0))
    "Minimum radiation on surfaces: everything except direct solar radiation"
    annotation (Placement(transformation(extent={{0,90},{20,70}})));
  Modelica.Blocks.Interfaces.RealOutput HDirHor
    "Direct solar irradation on a horizontal surface"
    annotation (Placement(transformation(extent={{98,40},{118,60}})));
  Modelica.Blocks.Interfaces.RealOutput HDirNor
    "Direct solar irradiation on a plane normal to the sun rays"
    annotation (Placement(transformation(extent={{98,10},{118,30}})));
  Modelica.Blocks.Interfaces.RealOutput HDifHor
    "Diffuse solar irradiation on a horizontal surface"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Interfaces.RealInput decAng "Declination angle"
    annotation (Placement(transformation(extent={{-124,-60},{-84,-20}})));
  Modelica.Blocks.Interfaces.RealInput solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{-124,-86},{-84,-46}})));

protected
  final parameter Modelica.SIunits.Angle south = IDEAS.Types.Azimuth.S;
  final parameter Modelica.SIunits.Angle east = south + Modelica.SIunits.Conversions.from_deg(270);
  final parameter Modelica.SIunits.Angle west = south + Modelica.SIunits.Conversions.from_deg(90);
  final parameter Modelica.SIunits.Angle vertical = IDEAS.Types.Tilt.Wall;
  final parameter Modelica.SIunits.Angle horizontal = Modelica.SIunits.Conversions.from_deg(0);
  Modelica.Blocks.Sources.RealExpression HDirSouth(y=(HSouth - HDifHor/2 -
        rhoGai[2].y/2)*IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(
        incSouth.incAng), 0.01))
    "Direct solar irradiation computed on south surface"
    annotation (Placement(transformation(extent={{-80,-6},{0,16}})));
  Modelica.Blocks.Sources.RealExpression HDirEast(y=(HEast - HDifHor/2 - rhoGai[
        1].y/2)*IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incEast.incAng),
        0.01)) "Direct solar irradiation computed on east surface"
    annotation (Placement(transformation(extent={{-80,14},{0,34}})));
  Modelica.Blocks.Sources.RealExpression HDirWest(y=(HWest - HDifHor/2 - rhoGai[
        3].y/2)*IDEAS.Utilities.Math.Functions.inverseXRegularized(cos(incWest.incAng),
        0.01)) "Direct solar irradiation computed on west surface"
    annotation (Placement(transformation(extent={{-80,-26},{0,-4}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incHor(
    final lat=lat,
    azi=south,
    final til=horizontal) "Incidence angle on horizontal surface"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Sources.RealExpression HDirHorVal(y=cos(incHor.incAng)*
        HDirMax.y) "Solar radiation on a horizontal surface"
    annotation (Placement(transformation(extent={{0,30},{60,50}})));
  Modelica.Blocks.Sources.RealExpression HDirMax(
    y=IDEAS.Utilities.Math.Functions.spliceFunction(
           x=min(incSouth.incAng, incEast.incAng)-incWest.incAng,
           pos= HDirWest.y,
           neg=IDEAS.Utilities.Math.Functions.spliceFunction(x=incEast.incAng - incSouth.incAng,
             pos= HDirSouth.y,
             neg= HDirEast.y,
             deltax=0.3),
           deltax=0.3))
    "Direct solar radiation measured from direction that faces sun the most"
    annotation (Placement(transformation(extent={{14,8},{84,30}})));
  Modelica.Blocks.Math.Gain gainDif(k=2) "Inverse of (1+cos90)/2 - see Perez"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Math.Add add[3](each k2=-0.5)
    "Remove diffuse ground reflection"
    annotation (Placement(transformation(extent={{-48,70},{-28,90}})));
  Modelica.Blocks.Math.Gain rhoGai[3](k=rho)
    "Ground reflectance factor to compute shortwave radiation from the ground"
    annotation (Placement(transformation(extent={{-20,42},{-40,62}})));
  Modelica.Blocks.Sources.RealExpression HGloHor(y=cos(incHor.incAng)*HDirMax.y +
        HDifHor) "Global horizontal radiation without reflectance"
    annotation (Placement(transformation(extent={{60,42},{0,62}})));

  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incSouth(final lat=
       lat, final til=vertical,
    azi=south) "Incidence angle of the south oriented sensor"
    annotation (Placement(transformation(extent={{40,-46},{60,-26}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incWest(
    final lat=lat,
    final til=vertical,
    azi=west) "Incidence angle of the west oriented sensor"
    annotation (Placement(transformation(extent={{40,-72},{60,-52}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incEast(
    final lat=lat,
    final til=vertical,
    azi=east) "Incidence angle of the east oriented sensor"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));

equation
  connect(HDirHorVal.y, HDirHor) annotation (Line(
      points={{63,40},{86,40},{86,50},{108,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirMax.y, HDirNor) annotation (Line(
      points={{87.5,19},{87.5,19.5},{108,19.5},{108,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gainDif.y, HDifHor)
    annotation (Line(points={{81,80},{108,80}}, color={0,0,127}));
  connect(rhoGai.y, add.u2) annotation (Line(points={{-41,52},{-52,52},{-52,74},
          {-50,74}}, color={0,0,127}));
  connect(add[1].u1, HEast)
    annotation (Line(points={{-50,86},{-104,86},{-104,80}}, color={0,0,127}));
  connect(add[2].u1, HSouth)
    annotation (Line(points={{-50,86},{-104,86},{-104,40}}, color={0,0,127}));
  connect(add[3].u1, HWest)
    annotation (Line(points={{-50,86},{-104,86},{-104,0}}, color={0,0,127}));
  connect(HGloHor.y, rhoGai[1].u)
    annotation (Line(points={{-3,52},{-18,52}},   color={0,0,127}));
  connect(HGloHor.y, rhoGai[2].u)
    annotation (Line(points={{-3,52},{-3,52},{-18,52}},   color={0,0,127}));
  connect(HGloHor.y, rhoGai[3].u)
    annotation (Line(points={{-3,52},{-3,52},{-18,52}},     color={0,0,127}));
  connect(solHouAng, incEast.solHouAng) annotation (Line(points={{-104,-66},{20,
          -66},{20,-94.8},{38,-94.8}},   color={0,0,127}));
  connect(solHouAng, incWest.solHouAng) annotation (Line(points={{-104,-66},{20,
          -66},{20,-66.8},{38,-66.8}}, color={0,0,127}));
  connect(solHouAng, incSouth.solHouAng) annotation (Line(points={{-104,-66},{20,
          -66},{20,-40.8},{38,-40.8}}, color={0,0,127}));
  connect(solHouAng, incHor.solHouAng) annotation (Line(points={{-104,-66},{-42,
          -66},{20,-66},{20,-14.8},{38,-14.8}}, color={0,0,127}));
  connect(decAng, incEast.decAng) annotation (Line(points={{-104,-40},{24,-40},{
          24,-84.6},{37.8,-84.6}}, color={0,0,127}));
  connect(decAng, incWest.decAng) annotation (Line(points={{-104,-40},{24,-40},{
          24,-56.6},{37.8,-56.6}}, color={0,0,127}));
  connect(decAng, incSouth.decAng) annotation (Line(points={{-104,-40},{-40,-40},
          {24,-40},{24,-30.6},{37.8,-30.6}}, color={0,0,127}));
  connect(decAng, incHor.decAng) annotation (Line(points={{-104,-40},{-76,-40},{
          24,-40},{24,-4.6},{37.8,-4.6}},   color={0,0,127}));
  connect(Hmin.y, gainDif.u)
    annotation (Line(points={{21,80},{50,80},{58,80}}, color={0,0,127}));
  connect(add.y, Hmin.u)
    annotation (Line(points={{-27,80},{-2,80}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>
This block computes the main solar irradiation components using 
solar irradiation measurements from the east, south and west oriented sensors.
</p>
<p>
This model is an approximation. 
A more accurate implementation, which inverts the Perez model, can be found in 
<a href=modelica://IDEAS.Examples.TwinHouses.BaseClasses.RadiationConvertorPerez>
IDEAS.Examples.TwinHouses.BaseClasses.RadiationConvertorPerez</a>. 
However the algebraic loop in this model does not always have a solution.
</p>
</html>", revisions="<html>
<ul>
<li>
January 17, 2017, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end RadiationConvertorSimplified;
