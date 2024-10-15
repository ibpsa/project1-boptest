within IDEAS.Examples.Tutorial;
model Example1 "First example model containing one zone"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air "Air medium";

  parameter Modelica.SIunits.Length l = 8 "Zone length";
  parameter Modelica.SIunits.Length w = 4 "Zone width";
  parameter Modelica.SIunits.Length h = 2.7 "Zone height";


  //SimInfoManager must be 'inner' at the top level
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Medium,
    nSurf=7,
    V=l*h*w)
    "Zone model" annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.W,
    A=l*h)
    "Outer wall model"
    annotation (Placement(transformation(extent={{-56,0},{-44,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.E,
    A=l*h)
    "Outer wall model"
    annotation (Placement(transformation(extent={{36,0},{24,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall2(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.N,
    A=w*h)
    "Outer wall model"
     annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={-10,52})));
  IDEAS.Buildings.Components.OuterWall outerWall3(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=w*h - window.A)
    "Outer wall model"
     annotation (Placement(transformation(
        extent={{-6,-10},{6,10}},
        rotation=90,
        origin={-10,-30})));
  IDEAS.Buildings.Components.Window window(
    inc=IDEAS.Types.Tilt.Wall,
    A=3*1.4,
    azi=IDEAS.Types.Azimuth.S,
    redeclare TwinHouses.BaseClasses.Data.Materials.Glazing glazing)
    "Window model" annotation (Placement(transformation(extent={{-6,-10},{6,10}},

        rotation=90,
        origin={-36,-30})));
  Buildings.Components.InternalWall floor(
    redeclare Buildings.Validation.Data.Constructions.HeavyFloor
      constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=IDEAS.Types.Azimuth.S,
    A=l*w)
    "Floor modelled using internal wall with both the ceiling and roof side connected to the zone"
    annotation (Placement(transformation(
        extent={{-6,-10},{6,10}},
        rotation=90,
        origin={70,10})));
equation
  connect(outerWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-45,12},{-38.5,12},{-38.5,15.7143},{-20,15.7143}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[2], outerWall2.propsBus_a) annotation (Line(
      points={{-20,15.1429},{-22,15.1429},{-22,47},{-12,47}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[3], outerWall1.propsBus_a) annotation (Line(
      points={{-20,14.5714},{-20,28},{25,28},{25,12}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall3.propsBus_a, zone.propsBus[4]) annotation (Line(
      points={{-12,-25},{-12,-6},{-20,-6},{-20,14}},
      color={255,204,51},
      thickness=0.5));
  connect(window.propsBus_a, zone.propsBus[5]) annotation (Line(
      points={{-38,-25},{-38,14},{-20,14},{-20,13.4286}},
      color={255,204,51},
      thickness=0.5));
  connect(floor.propsBus_a, zone.propsBus[6]) annotation (Line(
      points={{68,15},{68,28},{-20,28},{-20,12.8571}},
      color={255,204,51},
      thickness=0.5));
  connect(floor.propsBus_b, zone.propsBus[7]) annotation (Line(
      points={{68,5},{68,-6},{-20,-6},{-20,12.2857}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example1.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This first example file instantiates a simple building model.
</p>
</html>", revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"));
end Example1;
