within IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples;
model EmbeddedPipeNDiscr
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  Real QFlows[3]=-{sum(embeddedPipe.heatPortEmb.Q_flow),sum(embeddedPipe1.heatPortEmb.Q_flow),
      sum(embeddedPipe2.heatPortEmb.Q_flow)};

  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    redeclare
      IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_ValidationEmpa4_6
      RadSlaCha,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nDiscr=1,
    A_floor=ceiling.A,
    nParCir=1,
    m_flow_nominal=ceiling.A*0.006)
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30)
    annotation (Placement(transformation(extent={{-60,42},{-40,62}})));

  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{80,42},{60,62}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=embeddedPipe.m_flow_nominal,
    width=5000,
    period=25000,
    rising=2000,
    falling=2000)
    annotation (Placement(transformation(extent={{-100,42},{-80,62}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,42},{46,62}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zone(bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  IDEAS.Buildings.Components.InternalWall ceiling(
    azi=IDEAS.Types.Azimuth.S,
    redeclare IDEAS.Buildings.Data.Constructions.TABS constructionType,
    A=zone.w*zone.l,
    inc=IDEAS.Types.Tilt.Floor) annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,92})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe1(
    redeclare package Medium = Medium,
    redeclare BaseClasses.FH_ValidationEmpa4_6 RadSlaCha,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=embeddedPipe.m_flow_nominal,
    A_floor=embeddedPipe.A_floor,
    nParCir=embeddedPipe.nParCir,
    nDiscr=4)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Sources.MassFlowSource_T boundary1(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Sources.Boundary_pT bou1(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Sensors.TemperatureTwoPort senTem1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zone1(
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Buildings.Components.InternalWall ceiling1(
    azi=IDEAS.Types.Azimuth.S,
    redeclare Buildings.Data.Constructions.TABS constructionType,
    A=zone.w*zone.l,
    inc=IDEAS.Types.Tilt.Floor) annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,10})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe2(
    redeclare package Medium = Medium,
    redeclare BaseClasses.FH_ValidationEmpa4_6 RadSlaCha,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=embeddedPipe.m_flow_nominal,
    A_floor=embeddedPipe.A_floor,
    nParCir=embeddedPipe.nParCir,
    nDiscr=embeddedPipe1.nDiscr)
    annotation (Placement(transformation(extent={{-10,-122},{10,-102}})));
  IDEAS.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-122},{-40,-102}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-122},{60,-102}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,-122},{46,-102}})));
  IDEAS.Buildings.Validation.Cases.Case900Template zone2(
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    nSurfExt=(embeddedPipe1.nDiscr - 1)*2)
    annotation (Placement(transformation(extent={{-10,-82},{10,-62}})));
  IDEAS.Buildings.Components.InternalWall ceiling2[embeddedPipe1.nDiscr](
    redeclare each Buildings.Data.Constructions.TABS constructionType,
    each inc=IDEAS.Types.Tilt.Floor,
    each azi=IDEAS.Types.Azimuth.S,
    each A=zone.w*zone.l/embeddedPipe1.nDiscr) annotation (Placement(
        transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,-72})));
equation
  connect(boundary.ports[1], embeddedPipe.port_a) annotation (Line(
      points={{-40,52},{-10,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b, senTem.port_a) annotation (Line(
      points={{10,52},{26,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, bou.ports[1]) annotation (Line(
      points={{46,52},{60,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.heatPortEmb, ceiling.port_emb)
    annotation (Line(points={{0,62},{0,70},{40,70},{40,92}}, color={191,0,0}));
  connect(ceiling.propsBus_b, zone.proBusCei[1]) annotation (Line(
      points={{28,97},{28,106},{-0.2,106},{-0.2,96}},
      color={255,204,51},
      thickness=0.5));
  connect(ceiling.propsBus_a, zone.proBusFlo[1]) annotation (Line(
      points={{28,87},{28,76},{0,76},{0,84}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary1.ports[1], embeddedPipe1.port_a) annotation (Line(
      points={{-40,-30},{-10,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe1.port_b, senTem1.port_a) annotation (Line(
      points={{10,-30},{26,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, bou1.ports[1]) annotation (Line(
      points={{46,-30},{60,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ceiling1.propsBus_b, zone1.proBusCei[1]) annotation (Line(
      points={{28,15},{28,24},{-0.2,24},{-0.2,16}},
      color={255,204,51},
      thickness=0.5));
  connect(ceiling1.propsBus_a, zone1.proBusFlo[1]) annotation (Line(
      points={{28,5},{28,-6},{0,-6},{0,4}},
      color={255,204,51},
      thickness=0.5));
  for i in 1:embeddedPipe1.nDiscr loop
    connect(embeddedPipe1.heatPortEmb[i], ceiling1.port_emb[1]) annotation (
        Line(points={{0,-20},{0,-12},{40,-12},{40,10}}, color={191,0,0}));
  end for;
  connect(senTem2.port_b, bou2.ports[1]) annotation (Line(
      points={{46,-112},{60,-112}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe2.heatPortEmb[1:embeddedPipe1.nDiscr], ceiling2[1:
    embeddedPipe1.nDiscr].port_emb[1]) annotation (Line(points={{0,-102},{0,-90},
          {40,-90},{40,-72}}, color={191,0,0}));
  connect(ceiling2[1].propsBus_b, zone2.proBusCei[1]) annotation (Line(
      points={{28,-67},{28,-50},{-0.2,-50},{-0.2,-66}},
      color={255,204,51},
      thickness=0.5));
  connect(ceiling2[1].propsBus_a, zone2.proBusFlo[1]) annotation (Line(
      points={{28,-77},{28,-86},{0,-86},{0,-78}},
      color={255,204,51},
      thickness=0.5));
  for i in 2:embeddedPipe1.nDiscr loop
    connect(ceiling2[i].propsBus_b, zone2.proBusExt[(i - 2)*2 + 1]) annotation (
       Line(
        points={{28,-67},{28,-50},{-12,-50},{-12,-62}},
        color={255,204,51},
        thickness=0.5));

    connect(ceiling2[i].propsBus_a, zone2.proBusExt[(i - 2)*2 + 2]) annotation (
       Line(
        points={{28,-77},{28,-86},{-12,-86},{-12,-62}},
        color={255,204,51},
        thickness=0.5));

  end for;

  connect(boundary1.m_flow_in, trapezoid.y) annotation (Line(points={{-62,-22},{
          -68,-22},{-68,52},{-79,52}}, color={0,0,127}));
  connect(trapezoid.y, boundary.m_flow_in) annotation (Line(points={{-79,52},{-68,
          52},{-68,60},{-62,60}}, color={0,0,127}));
  connect(boundary2.m_flow_in, trapezoid.y) annotation (Line(points={{-62,-104},
          {-68,-104},{-68,52},{-79,52}}, color={0,0,127}));
  connect(embeddedPipe2.port_a, boundary2.ports[1])
    annotation (Line(points={{-10,-112},{-40,-112}}, color={0,127,255}));
  connect(embeddedPipe2.port_b, senTem2.port_a)
    annotation (Line(points={{10,-112},{26,-112}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{100,
            120}}), graphics={
        Text(
          extent={{88,56},{130,46}},
          lineColor={28,108,200},
          textString="1 CCA, 1 pipe"),
        Text(
          extent={{88,-24},{130,-34}},
          lineColor={28,108,200},
          textString="1 CCA, n pipes"),
        Text(
          extent={{90,-106},{132,-116}},
          lineColor={28,108,200},
          textString="n CCA, n pipes")}),
    experiment(
      StopTime=100000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/RadiantSlab/Examples/EmbeddedPipeNDiscr.mos"
        "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-140},{100,120}})),
    Documentation(revisions="<html>
<ul>
<li>
August 14, 2018 by Filip Jorissen:<br/>
First implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/862\">#862</a>.
</li>
</ul>
</html>"));
end EmbeddedPipeNDiscr;
