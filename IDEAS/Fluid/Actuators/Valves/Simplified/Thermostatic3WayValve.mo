within IDEAS.Fluid.Actuators.Valves.Simplified;
model Thermostatic3WayValve "Thermostatic 3-way valve with hot and cold side"
  extends BaseClasses.Partial3WayValve(
      idealSource(m_flow(start=m_flow_nominal*0.5)),
      allowFlowReversal=true);
  parameter Boolean dynamicValve = false
    "Set to true to simulate a valve opening delay: typically slower but more robust"
    annotation(Dialog(tab="Dynamics", group="Filter"));
  parameter Real y_min(min=0, max=1) = 0.001 "Minimum valve opening/leakage"
    annotation(Dialog(tab="Advanced"));
  parameter Real y_max(min=0, max=1) = 0.999 "Maximum valve opening/leakage"
    annotation(Dialog(tab="Advanced"));
  parameter Real y_start(min=0, max=1) = 0 "Initial valve opening"
    annotation(Dialog(enable=dynamicValve,tab="Dynamics", group="Filter"));
  parameter Modelica.SIunits.Temperature dT_nominal = 50
    "Nominal/maximum temperature difference between inlet ports, used for regularization";

  Modelica.Blocks.Interfaces.RealInput TMixedSet
    "Mixed outlet temperature setpoint" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,106}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,100})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_a2)
    "Fraction of nominal mass flow rate"
    annotation (Placement(transformation(extent={{74,-60},{34,-40}})));

  Modelica.SIunits.MassFlowRate m_flow_a2(min=0)
    "mass flowrate of part_a2 to the mixing point";
protected
  Modelica.SIunits.SpecificEnthalpy h_set = Medium.specificEnthalpy(Medium.setState_pTX(port_b.p, TMixedSet, vol.Xi))
    "Specific enthalpy of the temperature setpoint";
  Real k(start=0.5)
    "Unbounded help variable for determining fraction of each flow";
  Real k_state(start=y_start) "Variable for introducing a state";
  Real delta_h "Enthalpy difference between port_a2 and port_a1";
  Real inv_delta_h "Regularized inverse of delta_h";

  parameter Real delta_h_reg=dT_nominal/25*Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default,Medium.T_default,Medium.X_default))
    "Enthalpy difference where regularization starts";
initial equation
  k_state=y_start;

equation
  der(k_state) = if dynamicValve then (k-k_state)/tau else 0;
  delta_h=inStream(port_a2.h_outflow)-inStream(port_a1.h_outflow);
  inv_delta_h = IDEAS.Utilities.Math.Functions.inverseXRegularized(delta_h, delta=delta_h_reg);

  k = IDEAS.Utilities.Math.Functions.spliceFunction(x=abs(delta_h)-delta_h_reg, pos=(h_set-inStream(port_a1.h_outflow))*inv_delta_h, neg=0.5, deltax=delta_h_reg);
  m_flow_a2=-port_b.m_flow*IDEAS.Utilities.Math.Functions.smoothMin(IDEAS.Utilities.Math.Functions.smoothMax(if dynamicValve then k_state else k,y_min,0.001),y_max,0.001);
  connect(realExpression.y, idealSource.m_flow_in) annotation (Line(
      points={{32,-50},{8,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
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
          fillPattern=FillPattern.Solid,
          fillColor={0,127,255}),
        Ellipse(extent={{-20,80},{20,40}}, lineColor={100,100,100}),
        Line(
          points={{0,0},{0,40}},
          color={100,100,100},
          smooth=Smooth.None),
        Line(
          points={{-70,30},{-70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,30},{70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-30,-70},{30,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>This model provides an ideal implementation of a thermostatic three way valve. The mass flow rates are adjusted so that the desired temperature is reached as close as possible. Pressure drops are not considered.</p>
<p><b>Main equations</b> </p>
<p>Water with enthalpy h needs to be mixed such that:</p>
<p>h_out = k * h_in1 + (1-k) * h_in2</p>
<p>this equation defines the mass flow rates:</p>
<p>m_flow_in1 = k * m_flow_out</p>
<p>m_flow_in2 = (1-k) * m_flow_out</p>
<h4>Assumptions and limitations </h4>
<p>No pressure drops are calculated by this model!</p>
<p>Ideally h_out equals h_set, the enthalpy corresponding to the temperature setpoint. However, if the desired temperature can not be reached through mixing then water from only one stream is used: the stream with the temperature closest to the desired temperature.</p>
<p>The model is not exact around h_in1 = h_in2. Regularization functions are used to ensure smooth behaviour through this transition and to avoid chattering.</p>
<h4>Typical use and important parameters</h4>
<ol>
<li>The parameter m sets the mass of the fluid contained by the valve. </li>
<li>Parameter dT_nominal sets the nominal temperature difference of the inlet ports. It provides an estimate for when to start regularization: when the temperature difference across the inlet ports is smaller than dT/10. Small dT_nominal values may lead to convergence errors, large dT_nominal values cause a greater error when the inlet temperatures are almost equal.</li>
</ol>
<h4>Options</h4>
<ol>
<li>Typical options inherited through lumpedVolumeDeclarations can be used.</li>
<li>A delayed valve opening can be simulated by setting dynamicValve tot true.</li>
<li>The minimum and maximum valve opening can be adjusted.</li>
</ol>
<h4>Validation</h4>
<p>Only verification was performed.</p>
<p>Examples of this model can be found in<a href=\"modelica://IDEAS.Thermal.Components.Examples.TempMixingTester\"> IDEAS.Thermal.Components.Examples.TempMixingTester</a> and<a href=\"modelica://IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve\"> IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve</a></p>
</html>", revisions="<html>
<ul>
<li>
May 15, 2018, by Filip Jorissen:<br/>
Changes for setting unique initial conditions.
</li>
<li>2014 October, Filip Jorissen, Added parameter for regularization range</li>
<li>2014 October, Filip Jorissen, Regularized implementation and documentation </li>
<li>2014 May, Filip Jorissen, Both legs can be hot or cold</li>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
<li>2013 May, Roel De Coninck, documentation</li>
<li>2013 March, Ruben Baetens, graphics</li>
<li>2010, Roel De Coninck, first version</li>
</ul>
</html>"));
end Thermostatic3WayValve;
