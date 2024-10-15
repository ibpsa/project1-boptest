within IDEAS.Fluid.Taps.Examples;
model DHW_example
  extends Modelica.Icons.Example;
  BalancedTap_m_flow dHW_RealInput(
    redeclare package Medium = Medium,
    tau=1,
    TDHWSet=318.15)
    annotation (Placement(transformation(extent={{-2,-4},{22,10}})));
  Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    nPorts=2,
    use_T_in=true,
    T=333)
    annotation (Placement(transformation(extent={{-40,-12},{-20,8}})));
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;
  Modelica.Blocks.Sources.Pulse mDHW60C(
    amplitude=0.1,
    width=5,
    period=10000,
    startTime=5000,
    offset=0)       annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Ramp step(
    startTime=86400,
    height=-30,
    duration=50000,
    offset=273.15 + 70)
    annotation (Placement(transformation(extent={{-94,-8},{-74,12}})));
  BalancedTap dHW_ProfileReader(
    redeclare package Medium = Medium,
    VDayAvg=1,
    profileType=2,
    TDHWSet=318.15,
    m_flow_nominal=1,
    table(fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/")
           + "Resources/weatherdata/DHWProfile_2d.txt"))
    annotation (Placement(transformation(extent={{4,-54},{28,-40}})));
  Sources.Boundary_pT bou2(
    redeclare package Medium = Medium,
    nPorts=2,
    use_T_in=false,
    T=333)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,-20})));
equation
  connect(mDHW60C.y, dHW_RealInput.mDHW60C) annotation (Line(
      points={{-19,50},{-14,50},{-14,20},{12.4,20},{12.4,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dHW_RealInput.port_hot, bou.ports[1]) annotation (Line(
      points={{-2,3},{-12,3},{-12,8.88178e-16},{-20,8.88178e-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(step.y, bou.T_in) annotation (Line(
      points={{-73,2},{-42,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[2], dHW_ProfileReader.port_hot) annotation (Line(
      points={{-20,-4},{-8,-4},{-8,-47},{4,-47}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHW_RealInput.port_cold, bou2.ports[1]) annotation (Line(
      points={{22,3},{32,3},{32,-14},{52,-14},{52,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dHW_ProfileReader.port_cold, bou2.ports[2]) annotation (Line(
      points={{28,-47},{40,-47},{40,-18},{52,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=172800, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Taps/Examples/DHW_example.mos"
        "Simulate and plot"));
end DHW_example;
