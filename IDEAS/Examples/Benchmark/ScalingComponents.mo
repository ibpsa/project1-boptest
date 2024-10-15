within IDEAS.Examples.Benchmark;
model ScalingComponents
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air "Medium model";
  parameter Integer n(min=3) = 3 "Number of sides of the polygon";
  parameter Modelica.SIunits.Length a = 3 "Polygon apothem";
  parameter Modelica.SIunits.Length l = 2*a*tan(Modelica.Constants.pi/n)
    "Polygon side length";
  parameter Modelica.SIunits.Area A = l*gF.hZone "Surface area corresponding to one polygon side";
  parameter Modelica.SIunits.Area Afloor = a*n*l/2 "Floor and ceiling surface areas";

  Buildings.Components.Zone gF(
    V=Afloor*gF.hZone,
    redeclare package Medium = Medium,
    hZone=2.7,
    nSurf=3 + n)
                annotation (Placement(transformation(extent={{40,0},{80,40}})));
  Buildings.Components.OuterWall[n] wall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall constructionType,
    each inc=IDEAS.Types.Tilt.Wall,
    each A=A,
    azi={2*i*Modelica.Constants.pi/n for i in 1:n})                    annotation (Placement(transformation(
        extent={{-5.5,-9.49999},{5.5,9.49999}},
        rotation=90,
        origin={-51.5,-16.5})));
  Buildings.Components.BoundaryWall       floor(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightFloor constructionType,
    final A=Afloor,
    inc=IDEAS.Types.Tilt.Floor,
    final azi=IDEAS.Types.Azimuth.S)    annotation (Placement(transformation(
        extent={{-5.5,-9.5},{5.5,9.5}},
        rotation=90,
        origin={-21.5,-16.5})));
  Buildings.Components.OuterWall roof(
    redeclare final parameter IDEAS.Buildings.Validation.Data.Constructions.LightRoof constructionType,
    final A=Afloor-win.A,
    final inc=IDEAS.Types.Tilt.Ceiling,
    final azi=IDEAS.Types.Azimuth.S) annotation (Placement(transformation(
        extent={{-5.5,-9.5},{5.5,9.5}},
        rotation=90,
        origin={-81.5,-16.5})));
  Buildings.Components.Window win(
    final A=6,
    redeclare final parameter IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    azi=IDEAS.Types.Azimuth.S,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    frac=0,
    final inc=IDEAS.Types.Tilt.Ceiling)
    annotation (Placement(transformation(
        extent={{-5.5,-9.49999},{5.5,9.49997}},
        rotation=90,
        origin={8.5,-16.5})));
equation
  connect(roof.propsBus_a, gF.propsBus[1]) annotation (Line(
      points={{-83.4,-11.9167},{-83.4,28},{40,28}},
      color={255,204,51},
      thickness=0.5));
  connect(floor.propsBus_a, gF.propsBus[2]) annotation (Line(
      points={{-23.4,-11.9167},{-23.4,28},{40,28}},
      color={255,204,51},
      thickness=0.5));
  connect(win.propsBus_a, gF.propsBus[3]) annotation (Line(
      points={{6.60001,-11.9167},{6.60001,28},{40,28}},
      color={255,204,51},
      thickness=0.5));
  for i in 1:n loop
    connect(wall[i].propsBus_a, gF.propsBus[3+i]) annotation (Line(
      points={{-53.4,-11.9167},{-53.4,28},{40,28}},
      color={255,204,51},
      thickness=0.5));
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3.15e+07),
    Documentation(revisions="<html>
<ul>
<li>
March 10, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model may be used to check how computation time scales with n, 
the number of components in a zone.
</p>
<p>
In this model the zone floor area has the shape of a polygon with n sides.
Each side has a wall, there is a single window in the roof.
For rising numbers of n, the computation time can be compared.
</p>
</html>"));
end ScalingComponents;
