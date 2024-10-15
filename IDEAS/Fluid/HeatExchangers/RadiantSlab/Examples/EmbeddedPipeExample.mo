within IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples;
model EmbeddedPipeExample
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;

  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    redeclare
      IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_ValidationEmpa4_6
      RadSlaCha,
    m_flow_nominal=1,
    A_floor=100,
    nParCir=10,
    computeFlowResistance=true,
    m_flowMin=0.2,
    nDiscr=2,
    R_c=0.05,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=273.15 + 30)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15 +
        10)
    annotation (Placement(transformation(extent={{-36,62},{-16,82}})));

  Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=1,
    rising=1000,
    width=1000,
    falling=1000,
    period=5000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=
        embeddedPipe.R_c/embeddedPipe.A_floor*embeddedPipe.nDiscr) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,44})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(R=
        thermalResistor.R) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,44})));
equation
  connect(boundary.ports[1], embeddedPipe.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(trapezoid.y, boundary.m_flow_in) annotation (Line(
      points={{-79,0},{-70,0},{-70,8},{-62,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b, senTem.port_a) annotation (Line(
      points={{10,0},{26,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, bou.ports[1]) annotation (Line(
      points={{46,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, thermalResistor.port_b) annotation (Line(
      points={{-16,72},{0,72},{0,54}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor.port_a, embeddedPipe.heatPortEmb[1]) annotation (Line(
      points={{0,34},{0,9.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor1.port_a, embeddedPipe.heatPortEmb[2]) annotation (
      Line(
      points={{26,34},{26,10.5},{0,10.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResistor1.port_b, fixedTemperature.port) annotation (Line(
      points={{26,54},{26,72},{-16,72}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=10000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/RadiantSlab/Examples/EmbeddedPipeExample.mos"
        "Simulate and plot"));
end EmbeddedPipeExample;
