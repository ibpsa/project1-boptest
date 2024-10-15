within IDEAS.Fluid.HeatPumps.Examples;
model HeatPump_AirWater
  "General example and tester for a modulating air-to-water heat pump"
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);

    IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    tau=30,
    m_flow_nominal=m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-14,-24},{-34,-4}})));
  HP_AirWater_TSet heater(
    tauHeatLoss=3600,
    cDry=10000,
    mWater=4,
    QNom=12000,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-74,14},{-56,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-94,-20},{-80,-6}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/5000,
    startTime=5000,
    amplitude=4,
    offset=273.15 + 30)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Sources.Boundary_pT bou(          redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  constant Modelica.SIunits.MassFlowRate m_flow_nominal=0.2
    "Nominal mass flow rate";
  inner BoundaryConditions.SimInfoManager
                       sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 35) "Temperature set point"
    annotation (Placement(transformation(extent={{-22,44},{-42,64}})));
equation

  connect(heater.heatPort, fixedTemperature.port) annotation (Line(
      points={{-65,14},{-70,14},{-70,-12},{-76,-12},{-76,-13},{-80,-13}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sine.y, TReturn.T) annotation (Line(
      points={{-79,-50},{-62,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pump.port_b, heater.port_a) annotation (Line(
      points={{-34,-14},{-56,-14},{-56,18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Tset.y, heater.TSet) annotation (Line(points={{-43,54},{-70.4,54},{-70.4,
          36}}, color={0,0,127}));
  connect(pump.port_a, heater.port_b) annotation (Line(points={{-14,-14},{12,
          -14},{12,30},{-56,30}}, color={0,127,255}));
  connect(bou.ports[1], pump.port_a) annotation (Line(points={{20,-10},{4,-10},
          {4,-14},{-14,-14}}, color={0,127,255}));
  connect(TReturn.port, pump.heatPort) annotation (Line(points={{-40,-50},{-24,
          -50},{-24,-20.8}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=15000, Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump_AirWater.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example shows the modulation behaviour of an inverter controlled air-to-water heat pump when the inlet water temperature is changed. </p>
<p>The modulation level can be seen from heater.heatSource.modulation.</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end HeatPump_AirWater;
