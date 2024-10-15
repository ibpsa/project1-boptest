within IDEAS.Fluid.Actuators.Valves.Simplified.Examples;
model ThreeWayValveMotor
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);

  IDEAS.Fluid.Movers.FlowControlled_m_flow pumpFlow1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    tau=30,
    use_inputFilter=false,
    dp_nominal = 0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-72,0})));
  Modelica.Blocks.Sources.Constant flow_pump(k=1)
        annotation (Placement(transformation(extent={{-98,60},{-78,80}})));
  Modelica.Blocks.Sources.Sine     ctrl(freqHz=0.1,
    amplitude=0.5,
    offset=0.5)
        annotation (Placement(transformation(extent={{-32,58},{-12,78}})));
  Sources.Boundary_pT sink(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{-58,-70},{-78,-50}})));
  Sources.Boundary_pT hot(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=333.15) annotation (Placement(transformation(extent={{78,-10},{58,10}})));
  IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor threeWayValveMotor(
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
                                       annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Sources.Boundary_pT cold(
    redeclare package Medium = Medium,
    nPorts=1,
    p=100000,
    T=283.15) annotation (Placement(transformation(extent={{80,-70},{60,-50}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-24,-10},{-44,10}})));
equation
  connect(sink.ports[1], pumpFlow1.port_b) annotation (Line(
      points={{-78,-60},{-88,-60},{-88,0},{-82,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(threeWayValveMotor.port_1, hot.ports[1]) annotation (Line(
      points={{10,0},{58,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cold.ports[1], threeWayValveMotor.port_3) annotation (Line(
      points={{60,-60},{0,-60},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ctrl.y, threeWayValveMotor.ctrl) annotation (Line(
      points={{-11,68},{0,68},{0,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pumpFlow1.port_a, temperature.port_b) annotation (Line(
      points={{-62,0},{-44,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature.port_a, threeWayValveMotor.port_2) annotation (Line(
      points={{-24,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flow_pump.y, pumpFlow1.m_flow_in) annotation (Line(points={{-77,70},{-72,
          70},{-72,12}},         color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=100, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Actuators/Valves/Simplified/Examples/ThreeWayValveMotor.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
March 27, 2020 by Filip Jorissen:<br/> 
Revised implementation for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/1119\">#1119</a>.
</li>
</ul>
</html>"));
end ThreeWayValveMotor;
