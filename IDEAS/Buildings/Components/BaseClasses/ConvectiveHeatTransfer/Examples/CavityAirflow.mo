within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.Examples;
model CavityAirflow
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Specialized.DryAir;

  Real m_flow_door = cavityAirFlow.G/cavityAirFlow.c_p
    "Derived mass flow rate for easier comparison to detailed model";
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow cavityAirFlow(h=doo.hOpe, w=doo.wOpe)
    "Model for flow through a cavity or open door"
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Airflow.Multizone.DoorDiscretizedOpen doo(redeclare package Medium = Medium,
    forceErrorControlOnFlow=false,
    hA=doo.hOpe/2,
    hB=doo.hOpe/2)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for zone 1"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

  IDEAS.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium,
    nPorts=2,
    use_T_in=true) "Boundary representing zone 1"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Ramp TZon1(
    duration=1,
    height=4,
    offset=TZon2.k - 2) "Ramp temperature input"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  IDEAS.Fluid.Sources.Boundary_pT bou2(         redeclare package Medium =
        Medium,
    use_T_in=true,
    nPorts=2) "Boundary representing zone 2"
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem2
    "Prescribed temperature for zone 2"
    annotation (Placement(transformation(extent={{72,-10},{52,10}})));
  Modelica.Blocks.Sources.Constant TZon2(k=273.15 + 22) "Temperature of zone 2"
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  IDEAS.Fluid.Sensors.EnthalpyFlowRate senEnt2(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    tau=0) "Enthalpy flow rate sensor"
    annotation (Placement(transformation(extent={{26,-30},{14,-42}})));
  IDEAS.Fluid.Sensors.EnthalpyFlowRate senEnt1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    tau=0) "Enthalpy flow rate sensor"
    annotation (Placement(transformation(extent={{18,-18},{30,-30}})));
  Modelica.Blocks.Math.Add Q_flow(k2=-1)
    "Heat flow rate through detailed door model"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow cavityAirFlowLin(
    h=doo.hOpe,
    w=doo.wOpe,
    linearise=true) "Linear version of open door model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(preTem1.port, cavityAirFlow.port_a) annotation (Line(points={{-50,0},{
          -32,0},{-32,30},{-10,30}},color={191,0,0}));
  connect(TZon1.y, preTem1.T)
    annotation (Line(points={{-79,0},{-72,0}}, color={0,0,127}));
  connect(doo.port_a1, bou1.ports[1]) annotation (Line(points={{-10,-24},{-16,-24},
          {-16,-28},{-40,-28}}, color={0,127,255}));
  connect(doo.port_b2, bou1.ports[2]) annotation (Line(points={{-10,-36},{-16,-36},
          {-16,-32},{-40,-32}}, color={0,127,255}));
  connect(bou1.T_in, preTem1.T)
    annotation (Line(points={{-62,-26},{-72,-26},{-72,0}}, color={0,0,127}));
  connect(preTem2.port, cavityAirFlow.port_b)
    annotation (Line(points={{52,0},{30,0},{30,30},{10,30}}, color={191,0,0}));
  connect(senEnt1.port_a, doo.port_b1)
    annotation (Line(points={{18,-24},{10,-24}}, color={0,127,255}));
  connect(senEnt2.port_b, doo.port_a2)
    annotation (Line(points={{14,-36},{10,-36}}, color={0,127,255}));
  connect(senEnt1.port_b, bou2.ports[1]) annotation (Line(points={{30,-24},{32,
          -24},{32,-28},{40,-28}}, color={0,127,255}));
  connect(senEnt2.port_a, bou2.ports[2]) annotation (Line(points={{26,-36},{32,
          -36},{32,-32},{40,-32}}, color={0,127,255}));
  connect(bou2.T_in, preTem2.T)
    annotation (Line(points={{62,-26},{74,-26},{74,0}}, color={0,0,127}));
  connect(TZon2.y, preTem2.T)
    annotation (Line(points={{79,0},{74,0}}, color={0,0,127}));
  connect(senEnt2.H_flow, Q_flow.u2)
    annotation (Line(points={{20,-42.6},{20,-76},{38,-76}}, color={0,0,127}));
  connect(Q_flow.u1, senEnt1.H_flow)
    annotation (Line(points={{38,-64},{24,-64},{24,-30.6}}, color={0,0,127}));
  connect(cavityAirFlowLin.port_a, preTem1.port)
    annotation (Line(points={{-10,0},{-50,0}}, color={191,0,0}));
  connect(cavityAirFlowLin.port_b, preTem2.port)
    annotation (Line(points={{10,0},{52,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      Tolerance=1e-06,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This model compares the implementation of 
<a href=\"IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow\">
IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow</a>
to the more detailed version of IDEAS.
</p>
<p>
Result differences may be larger when the simplified assumptions of
<a href=\"IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow\">
IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.CavityAirflow</a>
are not obtained.
</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/BaseClasses/ConvectiveHeatTransfer/Examples/CavityAirflow.mos"
        "Simulate and plot"));
end CavityAirflow;
