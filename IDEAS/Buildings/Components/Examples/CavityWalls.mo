within IDEAS.Buildings.Components.Examples;
model CavityWalls
  "Check of air cavity models in glazing and partially filled cavity walls"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));


  IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=2)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    redeclare parameter
      IDEAS.Buildings.Data.Constructions.CavityWallPartialFill constructionType,
    A=10) "Vertical wall with partially filled cavity"
    annotation (Placement(transformation(extent={{-56,-20},{-46,0}})));

  IDEAS.Buildings.Components.Window win(
    A=1,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    redeclare Data.Glazing.Ins2Ar glazing) "Window"
    annotation (Placement(transformation(extent={{-56,-60},{-46,-40}})));
equation
  connect(outerWall.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-46.8333,-8},{20,-8},{20,-16},{20,-57}},
      color={255,204,51},
      thickness=0.5));
  connect(win.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-46.8333,-48},{-46.8333,-48},{20,-48},{20,-55}},
      color={255,204,51},
      thickness=0.5));
  connect(zone1.port_a, bou.ports[1])
    annotation (Line(points={{32,-50},{32,90},{-40,90}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/CavityWalls.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
February 10, 2016, by Filip Jorissen:<br/>
Improved documentation and implementation.
</li>
<li>
February 16, 2016, by Glenn Reynders:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Model for unit testing the cavity wall correlation implementation.
</p>
</html>"),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end CavityWalls;
