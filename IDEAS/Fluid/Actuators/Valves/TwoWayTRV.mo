within IDEAS.Fluid.Actuators.Valves;
model TwoWayTRV "Two way thermostatic radiator valve"
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(
     show_T=false,
     dp(start=0,
        nominal=6000),
     m_flow(
        nominal=if m_flow_nominal_pos > Modelica.Constants.eps
          then m_flow_nominal_pos else 1),
     final m_flow_small = 1E-4*abs(m_flow_nominal));

  extends IDEAS.Fluid.Actuators.BaseClasses.ValveParameters(
    rhoStd=Medium.density_pTX(101325, 273.15+4, Medium.X_default));

  parameter Modelica.SIunits.Temperature TSet = 294.15 "Temperature set point";
  parameter Modelica.SIunits.Temperature P(displayUnit="K") = 2 "Proportional band of valve";

  parameter Boolean use_inputFilter=true
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Filtered opening"));
  parameter Modelica.SIunits.Time riseTime=1200
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
  parameter Real y_start=1 "Initial value of control signal"
    annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa", min=0) = 0
    "Pressure drop of pipe and other resistances that are in series"
     annotation(Dialog(group = "Nominal condition"));

  parameter Real l(min=1e-10, max=1) = 0.0001
    "Valve leakage, l=Kv(y=0)/Kv(y=1)";

  parameter Boolean from_dp = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

  final parameter Modelica.SIunits.PressureDifference dp_nominal(displayUnit="Pa")=dpValve_nominal + dpFixed_nominal
    "Pressure drop at nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  final parameter Modelica.SIunits.MassFlowRate m_flow_turbulent(min=0)=deltaM * abs(m_flow_nominal)
    "Turbulent flow if |m_flow| >= m_flow_turbulent";

  IDEAS.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    allowFlowReversal=allowFlowReversal,
    show_T=show_T,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    deltaM=deltaM,
    rhoStd=rhoStd,
    use_inputFilter=use_inputFilter,
    riseTime=riseTime,
    init=init,
    y_start=y_start,
    dpFixed_nominal=dpFixed_nominal,
    l=l,
    CvData=IDEAS.Fluid.Types.CvTypes.OpPoint) "Linear valve"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Interfaces.RealInput T(unit="K") "Temperature measurement" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,106})));
  Modelica.Blocks.Sources.RealExpression yExp(y=
    IDEAS.Utilities.Math.Functions.smoothHeaviside(
      (TSet - T)/P - 0.5,
      0.5))
      "Smooth control signal"
    annotation (Placement(transformation(extent={{-46,36},{-8,54}})));
  Modelica.Blocks.Interfaces.RealOutput y "Valve set point"
    annotation (Placement(transformation(extent={{40,60},{60,80}}),
        iconTransformation(extent={{40,60},{60,80}})));

protected
  parameter Medium.ThermodynamicState sta_default=
     Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  parameter Modelica.SIunits.DynamicViscosity eta_default=Medium.dynamicViscosity(sta_default)
    "Dynamic viscosity, used to compute transition to turbulent flow regime";

  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_pos = abs(m_flow_nominal)
    "Absolute value of nominal flow rate";
  final parameter Modelica.SIunits.PressureDifference dp_nominal_pos(displayUnit="Pa") = abs(dp_nominal)
    "Absolute value of nominal pressure difference";

equation
  connect(yExp.y, val.y)
    annotation (Line(points={{-6.1,45},{0,45},{0,12}}, color={0,0,127}));
  connect(val.y_actual, y)
    annotation (Line(points={{5,7},{20,7},{20,70},{50,70}}, color={0,0,127}));
  connect(port_a, val.port_a)
    annotation (Line(points={{-100,0},{-56,0},{-10,0}}, color={0,127,255}));
  connect(val.port_b, port_b)
    annotation (Line(points={{10,0},{56,0},{100,0}}, color={0,127,255}));
annotation (
defaultComponentName="val",
Documentation(info="<html>
<p>
Two way valve with thermostatic radiator knob. 
This model assumes no hysteresis and an 
ideal opening characteristic with a proportional band of <code>P</code> K.
The default value of <code>riseTime</code> has been set
to reflect the typical delay of radiator knobs.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 31, 2020 by Filip Jorissen:<br/>
Revised implementation using <code>smoothHeaviside</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1022\">#1022</a>.
</li>
<li>
October 26, 2018 by Filip Jorissen:<br/>
Using <code>smoothLimit</code> for P controller.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/948\">#948</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Modified displayUnit of proportional band P to Kelvin to avoid displaying -271.15C.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/919\">#919</a>.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-100,40},{100,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,22},{100,-24}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{2,-2},{-76,60},{-76,-60},{2,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,40},{0,-2},{54,40},{54,40},{-50,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-2},{82,60},{82,-60},{0,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,40},{0,-4}}),
        Polygon(
          points={{-60,44},{0,-2},{60,40},{-60,44}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-2},{-76,60},{-76,-60},{0,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-2},{82,60},{82,-60},{0,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,88},{0,-4}}),
        Line(
          points={{0,40},{0,100}}),
        Line(
          points={{0,70},{40,70}}),
        Rectangle(
          visible=use_inputFilter,
          extent={{-32,40},{32,100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{-32,100},{32,40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          visible=use_inputFilter,
          extent={{-20,92},{20,48}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold})}));
end TwoWayTRV;
