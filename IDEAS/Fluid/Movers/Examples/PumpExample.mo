within IDEAS.Fluid.Movers.Examples;
model PumpExample "Example of how a pump can be used"
  import IDEAS;
  extends Modelica.Icons.Example;

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=100,
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);

  Modelica.Blocks.Sources.Sine sine(freqHz=0.001)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  IDEAS.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=5500)
    annotation (Placement(transformation(extent={{-50,34},{-36,48}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-30,36},{-20,46}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={0,26})));
equation
  connect(bou.ports[1], pump.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, senMasFlo.port_a) annotation (Line(
      points={{10,0},{26,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo.port_b, bou1.ports[1]) annotation (Line(
      points={{46,0},{62,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(booleanPulse.y, booleanToReal.u) annotation (Line(points={{-35.3,41},{
          -35.3,41},{-31,41}}, color={255,0,255}));
  connect(product.y, pump.m_flow_in)
    annotation (Line(points={{0,19.4},{0,12},{0,12}},    color={0,0,127}));
  connect(booleanToReal.y, product.u2) annotation (Line(points={{-19.5,41},{-3.6,
          41},{-3.6,33.2}}, color={0,0,127}));
  connect(sine.y, product.u1) annotation (Line(points={{-19,70},{-6,70},{3.6,70},
          {3.6,33.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput);
end PumpExample;
