within IDEAS.Buildings.Examples;
model ZoneExample
  "Example model demonstrating how zones may be connected to surfaces"
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Length l = 4 "Room length";
  parameter Modelica.SIunits.Length w = 4 "Room width";
  parameter Modelica.SIunits.Length h = 2.7 "Room height";
  inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort)
                                              "Data reader"
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    nSurf=3,
    V=l*w*h,
    redeclare Components.InterzonalAirFlow.AirTight interzonalAirFlow)
          "First zone"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IDEAS.Buildings.Components.InternalWall internalWall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    azi=0,
    inc=IDEAS.Types.Tilt.Wall,
    A=l*w)                 "Internal wall model" annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={-8,0})));

  IDEAS.Buildings.Components.Window window(
    redeclare Data.Glazing.Ins2Ar2020 glazing
      "Insulating double glazing (6/16/6 AR Planitherm one) with clear glass",
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.N,
    A=2)                       "Window model"
    annotation (Placement(transformation(extent={{-56,40},{-44,60}})));
  IDEAS.Buildings.Components.SlabOnGround slabOnGround(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    A=l*w,
    PWall=2*(l + w))
           "Floor model"
    annotation (Placement(transformation(extent={{-56,-40},{-44,-20}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    azi=IDEAS.Types.Azimuth.N,
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    A=(l + w)*2*h)         "Outer wall model"
    annotation (Placement(transformation(extent={{-56,-60},{-44,-40}})));
  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    nSurf=4,
    V=l*w*h,
    redeclare Components.InterzonalAirFlow.AirTight interzonalAirFlow)
          "Second zone"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=(l + w)*2*h - window.A)  "Outer wall model"
    annotation (Placement(transformation(extent={{-56,20},{-44,40}})));
  IDEAS.Buildings.Components.OuterWall Roof(
    azi=0,
    A=10,
    redeclare Validation.Data.Constructions.LightRoof constructionType,
    incOpt=3)                     "Roof model"
    annotation (Placement(transformation(extent={{-56,60},{-44,80}})));
equation
  connect(internalWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-10,-5},{-10,-24.6667},{0,-24.6667}},
      color={255,204,51},
      thickness=0.5));
  connect(slabOnGround.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{-45,-28},{-22,-28},{-22,-26},{0,-26}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{-45,-48},{-20,-48},{-20,-27.3333},{0,-27.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(Roof.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-45,72},{-45,72},{-12,72},{-12,35.5},{0,35.5}},
      color={255,204,51},
      thickness=0.5));
  connect(window.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-45,52},{-45,52},{-14,52},{-14,34.5},{0,34.5}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall1.propsBus_a, zone1.propsBus[3]) annotation (Line(
      points={{-45,32},{-14,32},{-14,33.5},{0,33.5}},
      color={255,204,51},
      thickness=0.5));
  connect(internalWall.propsBus_b, zone1.propsBus[4]) annotation (Line(
      points={{-10,5},{-12,5},{-12,32.5},{0,32.5}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/ZoneExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
January 2, 2017 by Filip Jorissen:<br/>
Revised implementation.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up code and implementation.
</li>
<li>
By Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ZoneExample;
