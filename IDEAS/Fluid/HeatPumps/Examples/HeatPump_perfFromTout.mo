within IDEAS.Fluid.HeatPumps.Examples;
model HeatPump_perfFromTout
  "Validation of performance when recomputing from outlet temperature"
  extends Modelica.Icons.Example;
  parameter Real scaling = 2;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  constant SI.MassFlowRate m_flow_nominal=0.3 "Nominal mass flow rate";
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    startTime=0,
    freqHz=1/5000,
    offset=273.15 + 40)
    annotation (Placement(transformation(extent={{110,-40},{90,-20}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=8)
    annotation (Placement(transformation(extent={{80,-20},{60,-40}})));

   IDEAS.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Sources.Boundary_pT bou1(         redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=8)
    annotation (Placement(transformation(extent={{-100,-20},{-80,-40}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=4,
    offset=273.15 + 10,
    startTime=0,
    freqHz=1/3000)
    annotation (Placement(transformation(extent={{-132,-40},{-112,-20}})));
  HP_WaterWater_OnOff HP_nom(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    onOff=true,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    perfFromTout=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump with nominal mass flow rate" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,70})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = Medium,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=2550/3600)
    annotation (Placement(transformation(extent={{40,-160},{20,-140}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump3(
    redeclare package Medium = Medium,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=mod.k*4200/3600)
    annotation (Placement(transformation(extent={{-60,-130},{-40,-110}})));
  HP_WaterWater_OnOff HP_recomp(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    onOff=true,
    perfFromTout=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump with non-nominal mass flow rate and perfFromTout=true"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-134})));
  Sensors.TemperatureTwoPort TBrine_out_nom(
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    tau=0) annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  Sensors.TemperatureTwoPort TBrine_out_recomp(
    redeclare package Medium = Medium,
    tau=0,
    m_flow_nominal=4200/3600)
    annotation (Placement(transformation(extent={{-40,-160},{-60,-140}})));
  Sensors.TemperatureTwoPort TWater_out_nom(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    tau=0) annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Sensors.TemperatureTwoPort TWater_out_recomp(
    redeclare package Medium = Medium,
    tau=0,
    m_flow_nominal=2550/3600)
    annotation (Placement(transformation(extent={{20,-130},{40,-110}})));

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump4(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{38,-90},{18,-70}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump5(
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  HP_WaterWater_OnOff HP_nom_recomp(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    onOff=true,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_onOffSignal=false,
    perfFromTout=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump with nominal mass flow rate and perfFromTout=true" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-66})));
  Sensors.TemperatureTwoPort TBrine_out_nom_recomp(
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    tau=0) annotation (Placement(transformation(extent={{-40,-90},{-60,-70}})));
  Sensors.TemperatureTwoPort TWater_out_nom_recomp(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    tau=0) annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump6(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
   IDEAS.Fluid.Movers.FlowControlled_m_flow pump7(
    redeclare package Medium = Medium,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=mod.k*4200/3600)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  HP_WaterWater_OnOff HP(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    onOff=true,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    perfFromTout=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump with non-nominal mass flow rate" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,0})));
  Sensors.TemperatureTwoPort TBrine_out_nom1(
    redeclare package Medium = Medium,
    m_flow_nominal=4200/3600,
    tau=0) annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
  Sensors.TemperatureTwoPort TWater_out(
    redeclare package Medium = Medium,
    m_flow_nominal=2550/3600,
    tau=0) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Sources.Constant mod(k=0.8)
    "Mass flow rate modulation factor"
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
equation
  connect(sine.y, bou.T_in) annotation (Line(
      points={{89,-30},{88,-30},{88,-34},{82,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HP_recomp.port_b2, TWater_out_recomp.port_a) annotation (Line(
      points={{-4,-124},{-4,-120},{20,-120}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b, HP_recomp.port_a2) annotation (Line(
      points={{20,-150},{-4,-150},{-4,-144}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_b, HP_recomp.port_a1) annotation (Line(
      points={{-40,-120},{-16,-120},{-16,-124}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_recomp.port_a, HP_recomp.port_b1) annotation (Line(
      points={{-40,-150},{-16,-150},{-16,-144}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_nom.port_b2, TWater_out_nom.port_a) annotation (Line(
      points={{-4,80},{-4,90},{20,90}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, HP_nom.port_a2) annotation (Line(
      points={{20,50},{-4,50},{-4,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, bou.ports[1]) annotation (Line(
      points={{40,50},{60,50},{60,-33.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_nom.port_b, bou.ports[2]) annotation (Line(
      points={{40,90},{60,90},{60,-32.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine1.y, bou1.T_in) annotation (Line(
      points={{-111,-30},{-106,-30},{-106,-34},{-102,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump1.port_b, HP_nom.port_a1) annotation (Line(
      points={{-40,90},{-16,90},{-16,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_nom.port_b1, TBrine_out_nom.port_a) annotation (Line(
      points={{-16,60},{-16,50},{-40,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_nom.port_b, bou1.ports[1]) annotation (Line(
      points={{-60,50},{-80,50},{-80,-33.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou1.ports[2]) annotation (Line(
      points={{-60,90},{-80,90},{-80,-32.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_nom_recomp.port_b2, TWater_out_nom_recomp.port_a) annotation (Line(
      points={{-4,-56},{-4,-50},{20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump4.port_b, HP_nom_recomp.port_a2) annotation (Line(
      points={{18,-80},{-4,-80},{-4,-76}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump5.port_b, HP_nom_recomp.port_a1) annotation (Line(
      points={{-40,-50},{-16,-50},{-16,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_nom_recomp.port_b1, TBrine_out_nom_recomp.port_a) annotation (Line(
      points={{-16,-76},{-16,-80},{-40,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou1.ports[3], pump5.port_a) annotation (Line(
      points={{-80,-31.5},{-80,-50},{-60,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou1.ports[4], TBrine_out_nom_recomp.port_b) annotation (Line(
      points={{-80,-30.5},{-80,-80},{-60,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_nom_recomp.port_b, bou.ports[3]) annotation (Line(
      points={{40,-50},{60,-50},{60,-31.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump4.port_a, bou.ports[4]) annotation (Line(
      points={{38,-80},{60,-80},{60,-30.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_a, bou1.ports[5]) annotation (Line(
      points={{-60,-120},{-80,-120},{-80,-29.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_recomp.port_b, bou1.ports[6]) annotation (Line(
      points={{-60,-150},{-80,-150},{-80,-28.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_recomp.port_b, bou.ports[5]) annotation (Line(
      points={{40,-120},{60,-120},{60,-29.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_a, bou.ports[6]) annotation (Line(
      points={{40,-150},{60,-150},{60,-28.5}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(HP.port_b2, TWater_out.port_a) annotation (Line(
      points={{-4,10},{-4,20},{20,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump6.port_b, HP.port_a2) annotation (Line(
      points={{20,-20},{-4,-20},{-4,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump7.port_b, HP.port_a1) annotation (Line(
      points={{-40,20},{-16,20},{-16,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP.port_b1, TBrine_out_nom1.port_a) annotation (Line(
      points={{-16,-10},{-16,-20},{-40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump7.port_a, bou1.ports[7]) annotation (Line(points={{-60,20},{-64,
          20},{-80,20},{-80,-27.5}}, color={0,127,255}));
  connect(TBrine_out_nom1.port_b, bou1.ports[8]) annotation (Line(points={{-60,
          -20},{-80,-20},{-80,-26.5}}, color={0,127,255}));
  connect(pump6.port_a, bou.ports[7]) annotation (Line(points={{40,-20},{60,-20},
          {60,-27.5}}, color={0,127,255}));
  connect(TWater_out.port_b, bou.ports[8])
    annotation (Line(points={{40,20},{60,20},{60,-26.5}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-160},{100,
            100}})),
    experiment(StopTime=10000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-120,-160},{100,100}})),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump_perfFromTout.mos"
        "Simulate and plot"),    Documentation(info="<html>
<p>
This example demonstrates the difference in results when using the parameter perfFromTout.
</p>
</html>", revisions="<html>
<ul>
<li>
July 27, 2016 by Filip Jorissen:<br/> 
First implementation.
</li>
</ul>
</html>"));
end HeatPump_perfFromTout;
