within IDEAS.Fluid.HeatPumps.Examples;
model HeatPump_WaterWaterTSet
  "Test of a heat pump using a temperature setpoint"
  extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  constant SI.MassFlowRate m_flow_nominal=0.3 "Nominal mass flow rate";

  Modelica.Blocks.Sources.Constant const(k=273.15 + 35)
    annotation (Placement(transformation(extent={{8,24},{-10,42}})));
  Modelica.Blocks.Sources.Step     const1(
    height=-0.5,
    offset=1,
    startTime=500)
    annotation (Placement(transformation(extent={{6,-46},{-10,-30}})));
  IDEAS.Fluid.HeatPumps.HP_WaterWater_TSet heatPump(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    onOff=true,
    use_scaling=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_modulation_security=false,
    deltaT_security=5,
    use_modulationSignal=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-2,0})));

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-52,8},{-32,28}})));
  Sensors.TemperatureTwoPort TBrine_out(redeclare package Medium = Medium,
      m_flow_nominal=4200/3600)
    annotation (Placement(transformation(extent={{-32,-28},{-52,-8}})));

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{48,-28},{28,-8}})));
  Sensors.TemperatureTwoPort TWater_out(redeclare package Medium = Medium,
      m_flow_nominal=2550/3600)
    annotation (Placement(transformation(extent={{28,0},{48,20}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=2)
    annotation (Placement(transformation(extent={{78,2},{58,-18}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/500,
    amplitude=5,
    offset=273.15 + 20,
    startTime=0)
    annotation (Placement(transformation(extent={{108,-20},{88,0}})));
  Sources.Boundary_pT bou1(         redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,2},{-60,-18}})));
  Modelica.Blocks.Sources.Constant
                               sine1(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-114,-24},{-94,-4}})));
equation
  connect(const.y, heatPump.TSet) annotation (Line(
      points={{-10.9,33},{-26,33},{-26,5},{-12,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, heatPump.mod) annotation (Line(
      points={{-10.8,-38},{-13,-38},{-13,-8.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPump.port_b1, TBrine_out.port_a) annotation (Line(
      points={{-8,-10},{-20,-10},{-20,-18},{-32,-18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_b, heatPump.port_a1) annotation (Line(
      points={{-32,18},{-20,18},{-20,10},{-8,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_b2, TWater_out.port_a) annotation (Line(
      points={{4,10},{28,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, heatPump.port_a2) annotation (Line(
      points={{28,-18},{14,-18},{14,-10},{4,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine1.y,bou1. T_in) annotation (Line(
      points={{-93,-14},{-86,-14},{-86,-12},{-82,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y,bou. T_in) annotation (Line(
      points={{87,-10},{86,-10},{86,-12},{80,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TWater_out.port_b, bou.ports[1]) annotation (Line(
      points={{48,10},{48,2},{58,2},{58,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, bou.ports[2]) annotation (Line(
      points={{48,-18},{54,-18},{54,-6},{58,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou1.ports[1]) annotation (Line(
      points={{-52,18},{-60,18},{-60,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out.port_b, bou1.ports[2]) annotation (Line(
      points={{-52,-18},{-56,-18},{-56,-16},{-60,-16},{-60,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}}), graphics),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump_WaterWaterTSet.mos"
        "Simulate and plot"),  Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>", info="<html>
<p>This model demonstrates the use of a heat pump with a temperature set point.</p>
</html>"),
    experiment(StopTime=1000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-120,-100},{120,100}})));
end HeatPump_WaterWaterTSet;
