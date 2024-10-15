within IDEAS.Fluid.Actuators.Valves.Simplified.Examples;
model ThreeWayValveSwitch "Test the new component ThreeWayValveSwitch"
  import IDEAS;
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

    IDEAS.Fluid.Movers.FlowControlled_m_flow pumpEmission(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    tau=30,
    use_inputFilter=false,
    dp_nominal = 0,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Blocks.Sources.Pulse pulse(period=10) "Valve control signal"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.5)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveSwitch
    threeWayValveSwitch(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=2,          redeclare package
      Medium =                                                                      Medium,
    T=293.15)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort T_mix(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort T_leg0(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort T_leg1(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));

  IDEAS.Fluid.Sources.Boundary_pT bouHot(
    nPorts=1,
    redeclare package Medium = Medium,
    T=273.15 + 40)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(pulse.y, realToBoolean.u) annotation (Line(
      points={{-39,50},{-22,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(threeWayValveSwitch.switch, realToBoolean.y) annotation (Line(
      points={{20,18},{20,50},{1,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(threeWayValveSwitch.port_b, T_mix.port_a) annotation (Line(
      points={{30,10},{40,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_mix.port_b, pumpEmission.port_a) annotation (Line(
      points={{60,10},{70,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_leg0.port_b, threeWayValveSwitch.port_a1) annotation (Line(
      points={{0,10},{10,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], T_leg1.port_a) annotation (Line(
      points={{-40,-48},{-32,-48},{-32,-30},{-20,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_leg1.port_b, threeWayValveSwitch.port_a2) annotation (Line(
      points={{0,-30},{20,-30},{20,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bouHot.ports[1], T_leg0.port_a)
    annotation (Line(points={{-40,10},{-20,10}}, color={0,127,255}));
  connect(pumpEmission.port_b, bou.ports[2]) annotation (Line(points={{90,10},{
          96,10},{96,-52},{-40,-52}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=100, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Actuators/Valves/Simplified/Examples/ThreeWayValveSwitch.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end ThreeWayValveSwitch;
