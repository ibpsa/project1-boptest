within IDEAS.Fluid.Actuators.Valves.Examples;
model TwoWayValveTRV "Two way thermostatic radiator valve"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water "Medium";

  IDEAS.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p(displayUnit="Pa") = 306000,
    T=293.15,
    nPorts=2) "Boundary condition for flow source"
    annotation (Placement(
        transformation(extent={{-60,-10},{-40,10}})));
  IDEAS.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 3E5,
    T=293.15,
    nPorts=2) "Boundary condition for flow sink"
    annotation (Placement(
        transformation(extent={{60,-10},{40,10}})));

  TwoWayTRV valSte(
    redeclare package Medium = Medium,
    CvData=IDEAS.Fluid.Types.CvTypes.Kv,
    Kv=0.5,
    use_inputFilter=false,
    m_flow_nominal=0.03) "Valve without dynamics"
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  TwoWayTRV valDyn(
    redeclare package Medium = Medium,
    CvData=IDEAS.Fluid.Types.CvTypes.Kv,
    Kv=0.5,
    use_inputFilter=true,
    m_flow_nominal=0.03) "Valve with dynamics"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=5,
    offset=273.15 + 18,
    duration=7200)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(valSte.port_b, sin.ports[1]) annotation (Line(points={{10,20},{20,20},
          {20,2},{40,2}}, color={0,127,255}));
  connect(valSte.port_a, sou.ports[1]) annotation (Line(points={{-10,20},{-20,
          20},{-20,2},{-40,2}}, color={0,127,255}));
  connect(valDyn.port_a, sou.ports[2]) annotation (Line(points={{-10,-20},{-20,
          -20},{-20,-2},{-40,-2}}, color={0,127,255}));
  connect(valDyn.port_b, sin.ports[2]) annotation (Line(points={{10,-20},{20,
          -20},{20,-2},{40,-2}}, color={0,127,255}));
  connect(ramp1.y, valSte.T)
    annotation (Line(points={{-59,70},{0,70},{0,30.6}}, color={0,0,127}));
  connect(valDyn.T, valSte.T)
    annotation (Line(points={{0,-9.4},{0,30.6}}, color={0,0,127}));
    annotation (experiment(StopTime=7200, Tolerance=1e-06),
__Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Actuators/Valves/Examples/TwoWayValveTRV.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Test model for two way valves.
The instance <code>valTab</code> has a linear opening characteristics
based on a table, while <code>valLin</code> also has a linear opening
characteristics that is directly implemented in the model.
For practical applications in which valves with linear opening characteristics
are used, one should use <code>valLin</code> rather
than <code>valTab</code> as <code>valLin</code> is a more efficient
implementation.
</p>
<p>
This test demonstrates that both valves have, as expected, the same
mass flow rate for the whole range of the opening signal.
</p>
<p>
The parameter <code>filterOpening</code> is set to <code>false</code>,
as this model is used to plot the flow at different opening signals
without taking into account the travel time of the actuator.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end TwoWayValveTRV;
