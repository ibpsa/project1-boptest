within IDEAS.Fluid.HeatPumps.Examples;
model HeatPump_WaterWater
  "General example and tester for a modulating water-to-water heat pump"
  extends Modelica.Icons.Example;
  parameter Real scaling = 2;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  constant SI.MassFlowRate m_flow_nominal=0.3 "Nominal mass flow rate";
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{40,42},{20,62}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine sine(
    offset=273.15 + 50,
    freqHz=1/500,
    amplitude=5,
    startTime=0)
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=8)
    annotation (Placement(transformation(extent={{70,72},{50,52}})));

   IDEAS.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-60,78},{-40,98}})));
  Sources.Boundary_pT bou1(         redeclare package Medium = Medium,
    use_T_in=true,
    p=200000,
    nPorts=8)
    annotation (Placement(transformation(extent={{-88,72},{-68,52}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=4,
    offset=273.15 + 10,
    freqHz=1/300,
    startTime=0)
    annotation (Placement(transformation(extent={{-122,46},{-102,66}})));
  replaceable HP_WaterWater_OnOff heatPump(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    onOff=true,
    use_scaling=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_modulation_security=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                   constrainedby HP_WaterWater_OnOff
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,70})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=scaling*2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{40,-78},{20,-58}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump3(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=scaling*4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-58,-52},{-38,-32}})));
  replaceable HP_WaterWater_OnOff HP_scaling(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_scaling=true,
    onOff=true,
    P_the_nominal=scaling*HP_scaling.heatPumpData.P_the_nominal,
    use_modulation_security=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                   constrainedby HP_WaterWater_OnOff
    "Heat pump using the scaling" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-58})));
  Sensors.TemperatureTwoPort TBrine_out(redeclare package Medium = Medium,
      m_flow_nominal=4200/3600)
    annotation (Placement(transformation(extent={{-40,42},{-60,62}})));
  Sensors.TemperatureTwoPort TBrine_out_scaling(redeclare package Medium =
        Medium, m_flow_nominal=scaling*4200/3600)
    annotation (Placement(transformation(extent={{-40,-82},{-56,-66}})));
  Sensors.TemperatureTwoPort TWater_out(redeclare package Medium = Medium,
      m_flow_nominal=2550/3600)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Sensors.TemperatureTwoPort TWater_out_scaling(redeclare package Medium =
        Medium, m_flow_nominal=scaling*2550/3600)
    annotation (Placement(transformation(extent={{20,-58},{40,-38}})));

  IDEAS.Fluid.Movers.FlowControlled_m_flow pump4(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{38,-22},{18,-2}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump5(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-62,14},{-42,34}})));
  replaceable HP_WaterWater_OnOff HP_onOff_mod(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    onOff=true,
    use_scaling=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_modulation_security=false,
    use_onOffSignal=true,
    use_modulationSignal=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                               constrainedby HP_WaterWater_OnOff
    "Heat pump using the onOff and the modulation" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,6})));
  Sensors.TemperatureTwoPort TBrine_out_onOffMod(redeclare package Medium =
        Medium, m_flow_nominal=4200/3600)
    annotation (Placement(transformation(extent={{-42,-22},{-62,-2}})));
  Sensors.TemperatureTwoPort TWater_out_onOffMod(redeclare package Medium =
        Medium, m_flow_nominal=2550/3600)
    annotation (Placement(transformation(extent={{18,6},{38,26}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=500)
    annotation (Placement(transformation(extent={{-8,22},{-18,32}})));
  Modelica.Blocks.Sources.Pulse const(
    amplitude=0.5,
    period=200,
    offset=0.5)
    annotation (Placement(transformation(extent={{-6,-26},{-18,-14}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump6(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=scaling*2550/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{44,-134},{24,-114}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow pump7(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=scaling*4200/3600,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal = 50000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-54,-108},{-34,-88}})));
  replaceable HP_WaterWater_OnOff HP_modSec(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_onOffSignal=false,
    redeclare
      IDEAS.Fluid.HeatPumps.Data.PerformanceMaps.VitoCal300GBWS301dotA29
      heatPumpData,
    use_scaling=true,
    onOff=true,
    P_the_nominal=scaling*HP_modSec.heatPumpData.P_the_nominal,
    use_modulation_security=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                                   constrainedby
    HP_WaterWater_OnOff
    "Heat pump using the scaling and the modulation security" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-6,-114})));
  Sensors.TemperatureTwoPort TBrine_out_modSec(redeclare package Medium =
        Medium, m_flow_nominal=scaling*4200/3600)
    annotation (Placement(transformation(extent={{-36,-138},{-52,-122}})));
  Sensors.TemperatureTwoPort TWater_out_modSec(redeclare package Medium =
        Medium, m_flow_nominal=scaling*2550/3600)
    annotation (Placement(transformation(extent={{24,-114},{44,-94}})));
equation
  connect(sine.y, bou.T_in) annotation (Line(
      points={{79,60},{78,60},{78,58},{72,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HP_scaling.port_b2, TWater_out_scaling.port_a) annotation (Line(
      points={{-4,-48},{20,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b, HP_scaling.port_a2) annotation (Line(
      points={{20,-68},{-4,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_b, HP_scaling.port_a1) annotation (Line(
      points={{-38,-42},{-28,-42},{-28,-48},{-16,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_scaling.port_a, HP_scaling.port_b1) annotation (Line(
      points={{-40,-74},{-28,-74},{-28,-68},{-16,-68}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_b2, TWater_out.port_a) annotation (Line(
      points={{-4,80},{20,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, heatPump.port_a2) annotation (Line(
      points={{20,52},{6,52},{6,60},{-4,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, bou.ports[1]) annotation (Line(
      points={{40,52},{44,52},{44,58.5},{50,58.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out.port_b, bou.ports[2]) annotation (Line(
      points={{40,80},{50,80},{50,59.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine1.y, bou1.T_in) annotation (Line(
      points={{-101,56},{-94,56},{-94,58},{-90,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump1.port_b, heatPump.port_a1) annotation (Line(
      points={{-40,88},{-28,88},{-28,80},{-16,80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_b1, TBrine_out.port_a) annotation (Line(
      points={{-16,60},{-28,60},{-28,52},{-40,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out.port_b, bou1.ports[1]) annotation (Line(
      points={{-60,52},{-64,52},{-64,58.5},{-68,58.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou1.ports[2]) annotation (Line(
      points={{-60,88},{-68,88},{-68,59.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_onOff_mod.port_b2, TWater_out_onOffMod.port_a) annotation (Line(
      points={{-6,16},{18,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump4.port_b, HP_onOff_mod.port_a2) annotation (Line(
      points={{18,-12},{4,-12},{4,-4},{-6,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump5.port_b, HP_onOff_mod.port_a1) annotation (Line(
      points={{-42,24},{-30,24},{-30,16},{-18,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HP_onOff_mod.port_b1, TBrine_out_onOffMod.port_a) annotation (Line(
      points={{-18,-4},{-30,-4},{-30,-12},{-42,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou1.ports[3], pump5.port_a) annotation (Line(
      points={{-68,60.5},{-66,60.5},{-66,24},{-62,24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou1.ports[4], TBrine_out_onOffMod.port_b) annotation (Line(
      points={{-68,61.5},{-68,-12},{-62,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_onOffMod.port_b, bou.ports[3]) annotation (Line(
      points={{38,16},{46,16},{46,64},{50,64},{50,60.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump4.port_a, bou.ports[4]) annotation (Line(
      points={{38,-12},{50,-12},{50,61.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_a, bou1.ports[5]) annotation (Line(
      points={{-58,-42},{-64,-42},{-64,62.5},{-68,62.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_scaling.port_b, bou1.ports[6]) annotation (Line(
      points={{-56,-74},{-68,-74},{-68,63.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_scaling.port_b, bou.ports[5]) annotation (Line(
      points={{40,-48},{50,-48},{50,62.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_a, bou.ports[6]) annotation (Line(
      points={{40,-68},{50,-68},{50,63.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(booleanPulse.y, HP_onOff_mod.on) annotation (Line(
      points={{-18.5,27},{-34,27},{-34,8},{-22.8,8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const.y, HP_onOff_mod.mod) annotation (Line(
      points={{-18.6,-20},{-28,-20},{-28,-2.8},{-23,-2.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HP_modSec.port_b2, TWater_out_modSec.port_a) annotation (Line(
      points={{0,-104},{24,-104}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump6.port_b, HP_modSec.port_a2) annotation (Line(
      points={{24,-124},{0,-124}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump7.port_b, HP_modSec.port_a1) annotation (Line(
      points={{-34,-98},{-24,-98},{-24,-104},{-12,-104}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_modSec.port_a, HP_modSec.port_b1) annotation (Line(
      points={{-36,-130},{-24,-130},{-24,-124},{-12,-124}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWater_out_modSec.port_b, bou.ports[7]) annotation (Line(
      points={{44,-104},{44,64.5},{50,64.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump6.port_a, bou.ports[8]) annotation (Line(
      points={{44,-124},{50,-124},{50,65.5}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(pump7.port_a, bou1.ports[7]) annotation (Line(
      points={{-54,-98},{-68,-98},{-68,64.5}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBrine_out_modSec.port_b, bou1.ports[8]) annotation (Line(
      points={{-52,-130},{-68,-130},{-68,65.5}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-160},{100,
            100}}),     graphics),
    experiment(StopTime=1000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-120,-160},{100,100}})),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump_WaterWater.mos"
        "Simulate and plot"),    Documentation(info="<html>
<p>This example demonstrates the use of a heat pump.</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end HeatPump_WaterWater;
