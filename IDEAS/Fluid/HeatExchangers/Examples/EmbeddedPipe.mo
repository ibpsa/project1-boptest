within IDEAS.Fluid.HeatExchangers.Examples;
model EmbeddedPipe "Testing the floorheating according to Koschenz, par. 4.5.1"

  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature prescribedTemperature(
      T=293.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,90})));

  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,50})));
  BaseClasses.NakedTabs nakedTabs(radSlaCha=radSlaCha_ValidationEmpa,
    C1(each T(fixed=true)),
    C2(each T(fixed=true)))
    annotation (Placement(transformation(extent={{50,16},{70,36}})));
  RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    m_flow_nominal=12*24/3600,
    m_flowMin=0.1,
    A_floor=1,
    computeFlowResistance=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  BaseClasses.RadSlaCha_ValidationEmpa radSlaCha_ValidationEmpa
    annotation (Placement(transformation(extent={{-90,-96},{-70,-76}})));
  Modelica.Blocks.Sources.RealExpression convTabs(y=11)
    "\"convection coefficient for the tabs\""
    annotation (Placement(transformation(extent={{-22,40},{-2,60}})));

  Sources.Boundary_ph bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{140,-10},{120,10}})));
  Sensors.TemperatureTwoPort TSen_emb_sup(redeclare package Medium = Medium,
      m_flow_nominal=12*24/3600,
    tau=0)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Sensors.TemperatureTwoPort TSen_emb_ret(redeclare package Medium = Medium,
      m_flow_nominal=12*24/3600,
    tau=0)                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,0})));
  Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 35)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-12*24/3600,
    offset=12*24/3600,
    duration=9e3)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation

  connect(convection.fluid, prescribedTemperature.port) annotation (Line(
      points={{30,60},{30,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convection.solid, nakedTabs.port_a) annotation (Line(
      points={{30,40},{30,36},{60,36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nakedTabs.port_b, convection.solid) annotation (Line(
      points={{60,16.2},{60,14},{74,14},{74,40},{30,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convTabs.y, convection.Gc) annotation (Line(
      points={{-1,50},{20,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSen_emb_sup.port_b, embeddedPipe.port_a) annotation (Line(
      points={{20,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b, TSen_emb_ret.port_a) annotation (Line(
      points={{60,0},{80,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSen_emb_ret.port_b, bou.ports[1]) annotation (Line(
      points={{100,0},{120,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.heatPortEmb[1], nakedTabs.portCore) annotation (Line(
      points={{50,10},{50,26}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(boundary.ports[1], TSen_emb_sup.port_a)
    annotation (Line(points={{-20,0},{8,0},{0,0}}, color={0,127,255}));
  connect(ramp.y, boundary.m_flow_in) annotation (Line(points={{-79,0},{-60,0},
          {-60,8},{-42,8}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}})),
    experiment(StopTime=10000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{140,100}})),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/Examples/EmbeddedPipe.mos"
        "Simulate and plot"));
end EmbeddedPipe;
