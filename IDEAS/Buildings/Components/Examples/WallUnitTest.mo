within IDEAS.Buildings.Components.Examples;
model WallUnitTest "Unit test for verifying results for all wall components"
  extends Modelica.Icons.Example;
  BoundaryWall boundaryWall(
    redeclare Data.Constructions.CavityWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    use_T_in=true) "Boundary wall example"
    annotation (Placement(transformation(extent={{-36,60},{-26,80}})));
  InternalWall internalWall(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare Data.Constructions.EpcSolidWall2 constructionType,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Internal wall example"
    annotation (Placement(transformation(extent={{-36,20},{-24,40}})));
  OuterWall outerWall(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare Data.Constructions.CavityWallPartialFill constructionType)
    "Outer wall example"
    annotation (Placement(transformation(extent={{-36,-20},{-26,0}})));
  SlabOnGround slabOnGround(
    inc=IDEAS.Types.Tilt.Floor,
    azi=IDEAS.Types.Azimuth.S,
    A=2,
    redeclare Validation.Data.Constructions.HeavyFloor constructionType)
    "Slab on ground example"
    annotation (Placement(transformation(extent={{-36,-60},{-26,-40}})));
public
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
public
  Modelica.Blocks.Sources.Constant Tconst(k=300)
    "Constant temperature boundary condition"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Interfaces.DummyConnection dummyConnection(isZone=true)
    annotation (Placement(transformation(extent={{20,60},{0,80}})));
  Interfaces.DummyConnection dummyConnection1(isZone=true)
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Interfaces.DummyConnection dummyConnection2(isZone=true)
    annotation (Placement(transformation(extent={{20,-20},{0,0}})));
  Interfaces.DummyConnection dummyConnection3(isZone=true)
    annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  Interfaces.DummyConnection dummyConnection4(isZone=true)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(Tconst.y, boundaryWall.T) annotation (Line(points={{-59,70},{-48,70},
          {-48,72},{-39.8333,72}},
                               color={0,0,127}));
  connect(dummyConnection.zoneBus, boundaryWall.propsBus_a) annotation (Line(
      points={{0,69.8},{-14,69.8},{-14,72},{-26.8333,72}},
      color={255,204,51},
      thickness=0.5));
  connect(dummyConnection1.zoneBus, internalWall.propsBus_a) annotation (Line(
      points={{0,29.8},{-12,29.8},{-12,32},{-25,32}},
      color={255,204,51},
      thickness=0.5));
  connect(dummyConnection2.zoneBus, outerWall.propsBus_a) annotation (Line(
      points={{0,-10.2},{-14,-10.2},{-14,-8},{-26.8333,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(dummyConnection3.zoneBus, slabOnGround.propsBus_a) annotation (Line(
      points={{0,-50.2},{-14,-50.2},{-14,-48},{-26.8333,-48}},
      color={255,204,51},
      thickness=0.5));
  connect(dummyConnection4.zoneBus, internalWall.propsBus_b) annotation (Line(
      points={{-60,29.8},{-48,29.8},{-48,32},{-35,32}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/Examples/WallUnitTest.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example contains an instance of each opaque surface model. 
They are not connected to a zone such that a change in any of 
these models can easily be attributed to a single model in the unit tests. 
For windows see other examples.
</p>
</html>", revisions="<html>
<ul>
<li>
July 19, 2016, by Filip Jorissen:<br/>
Revised implementation that uses <code>DummyConnections</code>.
</li>
<li>
July 19, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WallUnitTest;
