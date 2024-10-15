within IDEAS.Fluid.Actuators.Valves.Simplified;
model ThreeWayValveMotor
  "Ideal three way valve with a krane controlled with a Real input with value between 0 and 1"
  extends IDEAS.Fluid.BaseClasses.PartialThreeWayResistance(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_small = m_flow_nominal*1e-4,
    final mDyn_flow_nominal = m_flow_nominal,
    redeclare IDEAS.Fluid.FixedResistances.LosslessPipe res1(m_flow_nominal=m_flow_nominal),
    redeclare IDEAS.Fluid.FixedResistances.LosslessPipe res2(m_flow_nominal=m_flow_nominal),
    redeclare IdealSource res3(
      final m_flow_nominal=m_flow_nominal,
      final m_flow_small=m_flow_small,
      final control_m_flow=false,
      final control_dp=false,
      final show_T=show_T));

  parameter Boolean show_T = false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Real l(min=1e-10, max=1) = 0.0001
    "Valve leakage, l=Kv(y=0)/Kv(y=1)";

  Modelica.Blocks.Interfaces.RealInput ctrl(min=0, max=1)
    "procentage of flow through flowPort_a1" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={10,118}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,108})));

  // IdealSource with extra parameters from IDEAS.Fluid.Interfaces.PartialTwoPortInterface
  // to avoid warnings since the template requires a PartialTwoPortInterface
protected
  model IdealSource
    extends IDEAS.Fluid.Movers.BaseClasses.IdealSource;

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal
      "Nominal mass flow rate"
      annotation(Dialog(group = "Nominal condition"));
    parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
      "Small mass flow rate for regularization of zero flow"
      annotation(Dialog(tab = "Advanced"));
    parameter Boolean show_T = false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));

    Medium.ThermodynamicState sta_a=
        Medium.setState_phX(port_a.p,
                            noEvent(actualStream(port_a.h_outflow)),
                            noEvent(actualStream(port_a.Xi_outflow))) if
           show_T "Medium properties in port_a";

    Medium.ThermodynamicState sta_b=
        Medium.setState_phX(port_b.p,
                            noEvent(actualStream(port_b.h_outflow)),
                            noEvent(actualStream(port_b.Xi_outflow))) if
            show_T "Medium properties in port_b";
  protected
    final parameter Modelica.SIunits.MassFlowRate _m_flow_start = 0
      "Start value for m_flow, used to avoid a warning if not set in m_flow, and to avoid m_flow.start in parameter window";
    final parameter Modelica.SIunits.PressureDifference _dp_start(displayUnit="Pa") = 0
      "Start value for dp, used to avoid a warning if not set in dp, and to avoid dp.start in parameter window";
  end IdealSource;

equation
  port_3.m_flow=-(l + (1 - ctrl)*(1 - 2*l))*port_2.m_flow;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}),
                                      graphics={
        Polygon(
          points={{-60,30},{-60,-30},{0,0},{-60,30}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,30},{-30,-30},{30,0},{-30,30}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          origin={0,-30},
          rotation=90,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,-70},{30,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-100,-56},{100,-100}},
          lineColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{0,0},{60,30},{60,-30},{0,0}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
July 29, 2020, by Filip Jorissen:<br/>
Removed duplicate definition of <code>LumpedVolumeDeclarations</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1158\">
#1158</a>
</li>
<li>
March 27, 2020 by Filip Jorissen:<br/> 
Revised implementation such that flow reversal options are integrated.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1119\">#1119</a>.
</li>
<li>
March 26, 2018 by Filip Jorissen:<br/> 
Implemented valve leakage,
see <a href=\"https://github.com/open-ideas/IDEAS/issues/782\">#782</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
<li>January 2014, Damien Picard:<br/> 
First implementation
</li>
</ul>
</html>
"));
end ThreeWayValveMotor;
