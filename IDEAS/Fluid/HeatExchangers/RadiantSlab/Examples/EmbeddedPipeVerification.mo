within IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples;
model EmbeddedPipeVerification
  "Verification of embedded pipe model for large flow rates"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Water;
  parameter Modelica.SIunits.Length d = 1/(1/(embeddedPipe.RadSlaCha.S_2) + 1/(embeddedPipe.RadSlaCha.S_1)) "Equivalent thickness";

  parameter Modelica.SIunits.TemperatureDifference dT = 10;

  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embeddedPipe(
    redeclare package Medium = Medium,
    redeclare
      IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_ValidationEmpa4_6
      RadSlaCha,
    m_flow_nominal=1,
    computeFlowResistance=true,
    m_flowMin=0.2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    A_floor=2,
    R_c=embeddedPipe.A_floor*(theRes1[1].R/embeddedPipe.nDiscr),
    nParCir=1,
    nDiscr=5,
    allowFlowReversal=false)
              "Embedded pipe with multiple discretisations"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = Medium,
    T=fixTem.T + dT,
    use_m_flow_in=true) "Mass flow source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=273.15 + 10)
    "Fixed temperature boundary"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

  Sources.Boundary_pT sin(          redeclare package Medium = Medium, nPorts=1) "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor theRes1[embeddedPipe.nDiscr](each R=
        d/(embeddedPipe.A_floor/embeddedPipe.nDiscr)/embeddedPipe.RadSlaCha.lambda_b)
    "Equivalent thermal resistivity of steady state concrete"
                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,44})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    height=-0.01,
    offset=0.01)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(1 - time)^(4))
    annotation (Placement(transformation(extent={{-94,-4},{-74,16}})));
equation
  for i in 1:embeddedPipe.nDiscr loop
    assert(embeddedPipe.vol[i].T> fixTem.T-1e-5, "Violation of second law");
    assert(embeddedPipe.vol[i].T< sou.T+1e-5, "Violation of second law");
  end for;

  connect(sou.ports[1], embeddedPipe.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(embeddedPipe.port_b,sin. ports[1])
    annotation (Line(points={{10,0},{35,0},{60,0}}, color={0,127,255}));

  for i in 1:embeddedPipe.nDiscr loop
    connect(fixTem.port, theRes1[i].port_b)
    annotation (Line(points={{-20,70},{0,70},{0,54}}, color={191,0,0}));
  end for;
  connect(embeddedPipe.heatPortEmb, theRes1.port_a)
    annotation (Line(points={{0,10},{0,34}}, color={191,0,0}));
  connect(realExpression.y, sou.m_flow_in) annotation (Line(points={{-73,6},{
          -66,6},{-66,8},{-62,8}},
                               color={0,0,127}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(Tolerance=1e-06),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/RadiantSlab/Examples/EmbeddedPipeVerification.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example verifies whether the result temperatures are within 
reasonable bounds for large and very small flow rates.
</p>
</html>", revisions="<html>
<ul>
<li>
April 26, 2017 by Filip Jorissen:<br/>
Revised implementation for
<a href=https://github.com/open-ideas/IDEAS/issues/717>#717</a>.
</li>
</ul>
</html>"));
end EmbeddedPipeVerification;
