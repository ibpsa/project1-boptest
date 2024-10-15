within IDEAS.Buildings.Components.Examples;
model RectangularZoneEmbedded
  "This model test the implementation of embedded heat port"
  extends RectangularZone(zone(
      bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
      redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External),
      zoneIntWal(
      bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
      redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      hasEmb=true));

  package Medium = IDEAS.Media.Water;
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe       embeddedPipe(
    redeclare package Medium = Medium,
    redeclare IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_ValidationEmpa4_6
      RadSlaCha,
    m_flow_nominal=1,
    nParCir=10,
    computeFlowResistance=true,
    m_flowMin=0.2,
    R_c=0.05,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    A_floor=zoneIntWal.w*zoneIntWal.l,
    nDiscr=1)
    annotation (Placement(transformation(extent={{6,-104},{26,-84}})));
  IDEAS.Fluid.Sources.MassFlowSource_T
                           boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    T=273.15 + 30,
    use_m_flow_in=false,
    m_flow=1)
    annotation (Placement(transformation(extent={{-44,-104},{-24,-84}})));
  IDEAS.Fluid.Sources.Boundary_pT
                      bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{96,-104},{76,-84}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort
                             senTem(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{42,-104},{62,-84}})));
equation


  connect(boundary.ports[1],embeddedPipe. port_a) annotation (Line(
      points={{-24,-94},{6,-94}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b,senTem. port_a) annotation (Line(
      points={{26,-94},{42,-94}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b,bou. ports[1]) annotation (Line(
      points={{62,-94},{76,-94}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.heatPortEmb[1], zoneIntWal.gainEmb[1]) annotation (Line(
        points={{16,-84},{16,-74},{36,-74},{36,-58},{20,-58}}, color={191,0,0}));
  connect(zoneIntWal.proBusFlo, zoneIntWal.proBusCei) annotation (Line(
      points={{0,-52},{0,-70},{-38,-70},{-38,-10},{-0.4,-10},{-0.4,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.proBusFlo, zone.proBusCei) annotation (Line(
      points={{0,28},{0,12},{-32,12},{-32,72},{-0.4,72},{-0.4,52}},
      color={255,204,51},
      thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates how to implement floorheating or CCA in RectangularZoneTemplate.
</p>
</html>", revisions="<html>
<ul>
<li>
August 29, 2018 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/RectangularZoneEmbedded.mos"
        "Simulate and Plot"));
end RectangularZoneEmbedded;
