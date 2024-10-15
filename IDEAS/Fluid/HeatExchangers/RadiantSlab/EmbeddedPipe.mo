within IDEAS.Fluid.HeatExchangers.RadiantSlab;
model EmbeddedPipe
  "Embedded pipe model based on prEN 15377 and (Koschenz, 2000), water capacity lumped to TOut"
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;
  replaceable parameter
    IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar RadSlaCha constrainedby
    IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar
    "Properties of the floor heating or TABS, if present"
    annotation (choicesAllMatching=true);
  final parameter Modelica.SIunits.Length pipeDiaInt = RadSlaCha.d_a - 2*RadSlaCha.s_r
    "Pipe internal diameter";
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=false);
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    dp_nominal=Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed.pressureLoss_m_flow(
      m_flow=m_flow_nominal/nParCir,
      rho_a=rho_default,
      rho_b=rho_default,
      mu_a=mu_default,
      mu_b=mu_default,
      length=pipeEqLen/nParCir,
      diameter=pipeDiaInt,
      roughness=roughness,
      m_flow_small=m_flow_small/nParCir));
  parameter Modelica.SIunits.Area A_floor "Floor/tabs surface area";
  parameter Integer nDiscr(min=1) = 1
    "Number of series discretisations along the flow direction"
    annotation(Evaluate=true);
  parameter Real nParCir(min=1) = 1 "Number of parallel circuits in the tabs"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe"
    annotation(Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Length L_floor = A_floor^(1/2)
    "Floor length - along the pipe direction"
    annotation(Dialog(tab="Flow resistance"));
  parameter Real N_pipes = A_floor/L_floor/RadSlaCha.T - 1
    "Number of parallel pipes in the slab"
annotation(Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Length pipeBendEqLen = 2*(N_pipes-1)*(2.267*RadSlaCha.T/2/pipeDiaInt+6.18)*pipeDiaInt
    "Pipe bends equivalent length, default according to Fox and McDonald (chapter 8.7, twice the linearized losses of a 90 degree bend)"
annotation(Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Length pipeEqLen = pipeBendEqLen + (L_floor-2*RadSlaCha.T)*N_pipes
    "Total pipe equivalent length, default assuming 180 dg turns starting at RadSlaCha.T from the end of the slab"
annotation(Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.MassFlowRate m_flowMin = m_flow_nominal*0.5
    "Minimal flowrate when in operation - used for validity check"
    annotation(Dialog(group="Nominal condition"));

  final parameter Modelica.SIunits.ThermalInsulance R_r_val=RadSlaCha.T*log(RadSlaCha.d_a
      /pipeDiaInt)/(2*Modelica.Constants.pi*RadSlaCha.lambda_r)
    "Fix resistance value of thermal conduction through pipe wall * surface of floor between 2 pipes (see RadSlaCha documentation)";
  //Calculation of the resistance from the outer pipe wall to the center of the tabs / floorheating. eqn 4-25 Koschenz
  final parameter Modelica.SIunits.ThermalInsulance R_x_val=RadSlaCha.T*(log(RadSlaCha.T
      /(3.14*RadSlaCha.d_a)) + corr)/(2*Modelica.Constants.pi*RadSlaCha.lambda_b)
    "Fix resistance value of thermal conduction from pipe wall to layer";
  final parameter Real corr = if RadSlaCha.tabs then 0 else
    sum( -(RadSlaCha.alp2/RadSlaCha.lambda_b * RadSlaCha.T - 2*3.14*s)/(RadSlaCha.alp2/RadSlaCha.lambda_b * RadSlaCha.T + 2*3.14*s)*exp(-4*3.14*s/RadSlaCha.T*RadSlaCha.S_2)/s for s in 1:10) "correction factor for the floor heating according to Multizone Building modeling with Type56 and TRNBuild (see documentation). 
    If tabs is used, corr=0 - fixme: deprecated?";

  parameter Boolean from_dp = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.ThermalInsulance R_c = 1/(RadSlaCha.lambda_b/RadSlaCha.S_1 + RadSlaCha.lambda_b/RadSlaCha.S_2)
    "Specific thermal resistivity of (parallel) slabs connected to top and bottom of tabs"
    annotation(Dialog(group="Thermal"));

  Modelica.SIunits.Temperature[nDiscr] Tin = cat(1, {senTemIn.T}, vol[1:nDiscr-1].heatPort.T);
  Modelica.SIunits.Power[nDiscr] Q "Thermal power going into tabs";
  //For high flow rates see [Koshenz, 2000] eqn 4.37 in between
  // for laminar flow Nu_D = 4 is assumed: correlation for heat transfer constant heat flow and constant wall temperature
  Modelica.SIunits.ThermalInsulance R_w_val= IDEAS.Utilities.Math.Functions.spliceFunction(
    x=rey-(reyHi+reyLo)/2,
    pos=RadSlaCha.T^0.13/8/Modelica.Constants.pi*abs((pipeDiaInt/(m_flowSpLimit*L_r)))^0.87,
    neg=RadSlaCha.T/(4*Medium.thermalConductivity(sta_default)*Modelica.Constants.pi),
    deltax=(reyHi-reyLo)/2)
    "Flow dependent resistance value of convective heat transfer inside pipe for both turbulent and laminar heat transfer.";
  Modelica.SIunits.ThermalInsulance R_t
    "Total equivalent specific resistivity as defined by Koschenz in eqn 4-59";
  Modelica.SIunits.ThermalConductance G_t
    "Equivalent thermal conductance";
  Modelica.SIunits.ThermalConductance G_max
    "Maximum thermal conductance based on mass flow rate";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nDiscr] heatPortEmb
    "Port to the core of a floor heating/concrete activation"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));
  //Reynold number Re = ( (m_flow / rho / A) * D * rho )  / mu / numParCir.
  Modelica.SIunits.ReynoldsNumber rey=
    m_flow/nParCir/A_pipe*pipeDiaInt/mu_default "Reynolds number";

  IDEAS.Fluid.MixingVolumes.MixingVolume[nDiscr] vol(each nPorts=2, each m_flow_nominal = m_flow_nominal, each V=m/nDiscr/rho_default,
    redeclare each package Medium = Medium,
    each p_start=p_start,
    each T_start=T_start,
    each X_start=X_start,
    each C_start=C_start,
    each C_nominal=C_nominal,
    each allowFlowReversal=allowFlowReversal,
    each mSenFac=mSenFac,
    each m_flow_small=m_flow_small,
    each final prescribedHeatFlowRate=true,
    each energyDynamics=energyDynamics,
    each massDynamics=massDynamics)
    annotation (Placement(transformation(extent={{-50,0},{-70,20}})));

  FixedResistances.ParallelPressureDrop          res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal,
    allowFlowReversal=allowFlowReversal,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    dp(nominal=L_r*10),
    computeFlowResistance=abs(dp_nominal)> 1e-5 and computeFlowResistance,
    final nParCir=nParCir,
    final dh=pipeDiaInt,
    final ReC=reyHi)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nDiscr] heatFlowWater(
    each final alpha=0) "Heat flow rate that is extracted from the fluid"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nDiscr] heatFlowSolid(
    each final alpha=0)
    "Heat flow rate that is injected in the solid material"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Math.Gain[nDiscr] negate(each k=-1)
    annotation (Placement(transformation(extent={{-56,36},{-48,44}})));
  Modelica.Blocks.Sources.RealExpression[nDiscr] Q_tabs(y=Q)
    annotation (Placement(transformation(extent={{-100,50},{-72,70}})));

  Modelica.Blocks.Math.Sum sumQTabs(nin=nDiscr, k=ones(nDiscr))
  "Block that sums the volume heat flow rates"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Interfaces.RealOutput QTot
    "Total thermal power going into the heat port"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    tau=0) "Sensor for inlet temperature"
           annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
protected
  final parameter Modelica.SIunits.Length L_r=A_floor/RadSlaCha.T/nParCir
    "Length of one of the parallel circuits";
  final parameter Modelica.SIunits.Area A_pipe=
    Modelica.Constants.pi/4*pipeDiaInt^2
    "Pipe internal cross section surface area";
  final parameter Medium.ThermodynamicState sta_default=
     Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  final parameter Modelica.SIunits.Density rho_default = Medium.density(sta_default);
  final parameter Modelica.SIunits.DynamicViscosity mu_default = Medium.dynamicViscosity(sta_default)
    "Dynamic viscosity at nominal condition";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default = Medium.specificHeatCapacityCp(sta_default)
    "Heat capacity at nominal condition";
  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_pos = abs(m_flow_nominal)
    "Absolute value of nominal flow rate";
  final parameter Modelica.SIunits.MassFlowRate m_flow_turbulent =  mu_default*pipeDiaInt/4*Modelica.Constants.pi*reyHi
    "Turbulent flow if |m_flow| >= m_flow_turbulent";
  final parameter Modelica.SIunits.Pressure dp_nominal_pos = abs(dp_nominal)
    "Absolute value of nominal pressure";
  final parameter Modelica.SIunits.ReynoldsNumber reyLo=2700
    "Reynolds number where transition to turbulence starts"
    annotation(Evaluate=true);
  final parameter Modelica.SIunits.ReynoldsNumber reyHi=4000
    "Reynolds number where transition to turbulence ends"
    annotation(Evaluate=true);
  final parameter Real deltaXR = m_flow_nominal/A_floor*cp_default/1000
    "Transition threshold for regularization function";
  final parameter Modelica.SIunits.ThermalInsulance R_w_val_min=
    IDEAS.Utilities.Math.Functions.spliceFunction(x=m_flowMin/nParCir/A_pipe*pipeDiaInt/mu_default-(reyHi+reyLo)/2,
      pos=RadSlaCha.T^0.13/8/Modelica.Constants.pi*abs((pipeDiaInt/(m_flow_nominal/A_floor*L_r)))^0.87,
      neg=RadSlaCha.T/(4*Medium.thermalConductivity(sta_default)*Modelica.Constants.pi),
      deltax=(reyHi-reyLo)/2)
    "Lowest value for R_w that is expected for the set mass flow rate";
  final parameter Modelica.SIunits.Mass m(start=1) = A_pipe*L_r*rho_default*nParCir
    "Mass of medium for the complete circuit";
  Real m_flowSp(unit="kg/(m2.s)")=port_a.m_flow/(A_floor/nDiscr)
    "mass flow rate per unit floor area";
  Real m_flowSpLimit
    "Specific mass flow rate regularized for no flow conditions";
initial equation
  if RadSlaCha.tabs then
    assert(RadSlaCha.S_1 > 0.3*RadSlaCha.T, "Thickness of the concrete or screed layer above the tubes is smaller than 0.3 * the tube interdistance. 
    The model is not valid for this case");
    assert(RadSlaCha.S_2 > 0.3*RadSlaCha.T, "Thickness of the concrete or screed layer under the tubes is smaller than 0.3 * the tube interdistance. 
      The model is not valid for this case");
  else
    assert(RadSlaCha.alp2 < 1.212, "In order to use the floor heating model, RadSlaCha.alp2 need to be < 1.212");
    assert(RadSlaCha.d_a/2 < RadSlaCha.S_2, "In order to use the floor heating model, RadSlaCha.alp2RadSlaCha.d_a/2 < RadSlaCha.S_2 needs to be true");
    assert(RadSlaCha.S_1/RadSlaCha.T <0.3, "In order to use the floor heating model, RadSlaCha.S_1/RadSlaCha.T <0.3 needs to be true");
  end if;
equation
  assert(allowFlowReversal or port_a.m_flow>-m_flow_small, "In " + getInstanceName() + ": flow reversal detected.");
  assert(not allowFlowReversal, "In " +getInstanceName() + ": parameter allowFlowReversal=true, but the EmbeddedPipe model does not support it.", AssertionLevel.warning);
  // this need not be smooth since when active, G_max is already active
  m_flowSpLimit = max(m_flowSp, 1e-8);
  // Koschenz eq 4-59
  R_t = 1/(m_flowSpLimit*cp_default*(1-exp(-1/((R_w_val+R_r_val+R_x_val+R_c)*m_flowSpLimit*cp_default))))-R_c;
  G_t = abs(A_floor/nDiscr/R_t);
  // maximum thermal conductance based on second law
  G_max = abs(m_flow)*cp_default;
  // no smoothmin since this undershoots for near-zero values
  Q = (Tin - heatPortEmb.T)*min(G_t, G_max);

  connect(res.port_b, port_b) annotation (Line(
         points={{40,0},{100,0}},
       color={0,127,255},
       smooth=Smooth.None));
  connect(senTemIn.port_b, vol[1].ports[1]) annotation (Line(
       points={{-70,0},{-58,0}},
       color={0,127,255},
              smooth=Smooth.None));
  connect(res.port_a, vol[nDiscr].ports[2]) annotation (Line(
       points={{20,0},{-62,0}},
       color={0,127,255},
       smooth=Smooth.None));

  for i in 2:nDiscr loop
    connect(vol[i-1].ports[2], vol[i].ports[1]) annotation (Line(
      points={{-62,0},{-58,0}},
      color={0,127,255},
      smooth=Smooth.None));
  end for;

  connect(heatFlowWater.port, vol.heatPort) annotation (Line(
      points={{-20,40},{-20,10},{-50,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatFlowWater.Q_flow, negate.y) annotation (Line(
      points={{-40,40},{-47.6,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(negate.u, Q_tabs.y) annotation (Line(
      points={{-56.8,40},{-60,40},{-60,60},{-70.6,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatFlowSolid.Q_flow, Q_tabs.y) annotation (Line(
      points={{-40,80},{-60,80},{-60,60},{-70.6,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatFlowSolid.port, heatPortEmb) annotation (Line(
      points={{-20,80},{0,80},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(Q_tabs.y, sumQTabs.u)
    annotation (Line(points={{-70.6,60},{18,60}}, color={0,0,127}));
  connect(sumQTabs.y, QTot)
    annotation (Line(points={{41,60},{110,60}}, color={0,0,127}));
  connect(port_a, senTemIn.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
   annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
        Ellipse(
          extent={{-20,22},{20,-20}},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-95,6},{106,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,-4},{-2,6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,22},{20,-20}},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,60},{80,-60}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-66,60},{-66,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{66,60},{66,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-66,60},{-66,-60},{66,-60},{-66,60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward)}),
    Documentation(info="<html>
<p>
Dynamic model of an embedded pipe for a concrete core activation. 
This model is based on (Koschenz, 2000). 
In addition the model provides the options to simulate the concrete 
core activation as if there were multiple parallel branches. 
This affects the pressure drop calculation and also the thermal calculations.
</p>
<h4>Assumptions and limitations</h4>
<p>
The implementation of Koschenz mentions that a minimum
discretization (i.e. using <code>nDiscr</code>) is required to avoid violation of the
second law of thermodynamics. The model explicitly
enforces the second law even for <code>nDiscr=1</code> by upper bounding
the heat flow rate such that this minimum discretization does not apply to our implementation.
The parameter <code>nDiscr</code> thus
only affects the results at larger flow rates.
The example <a href=\"IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples.EmbeddedPipeNDiscr\">
IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples.EmbeddedPipeNDiscr</a> provides an indication
of the sensitivity of the results to the value of <code>nDiscr</code>.
</p>
<p>
The embeddedPipe model is designed to be used together with an 
<a href=\"IDEAS.Buildings.Components.InternalWall\">IDEAS.Buildings.Components.InternalWall</a>. 
When <code>nDiscr>1</code>, the wall/floor should also be discretized to be physically correct,
although the discretizations can also be connected to the same wall/floor, which gives a reasonable
approximation as illustrated by the example 
<a href=\"IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples.EmbeddedPipeNDiscr\">
IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples.EmbeddedPipeNDiscr</a>.
</p>
<h4>Typical use and important parameters</h4>
<p>
Following parameters need to be set:
</p>
<ul>
<li>RadSlaCha is a record with all the parameters of the geometry, materials and even number of discretization layers in the nakedTabs model.</li>
<li>mFlow_min is used to check the validity of the operating conditions and is by default half of the nominal mass flow rate.</li>
<li><code>A_floor</code> is the surface area of (one side of) the Thermally Activated Building part (TAB). </li>
<li><code>nDiscr</code> can be used for discretizing the EmbeddedPipe along the flow direction. See above for a more detailed discussion.</li>
<li><code>nParCir</code> can be used for calculating the pressure drops as if there were multiple EmbeddedPipes connected in parallel. The total mass flow rate is then split over multiple circuits and the pressure drop is calculated accordingly.</li>
<li><code>R_C</code> is the thermal resistivity from the center of the tabs to the zones. Note that the upper and lower resistivities need to be calculated as if they were in parallel. This parameter has a default value based on RadSlaCha but it may be improved if necessary. The impact of the value of this parameter on the model performance is low except in cases of very low mass flow rates.</li>
</ul>
<h4>Options</h4>
<p>
By default <code>dp_nominal</code> is calculated by making an estimate of the total pipe length. 
This pressure drop can be an underestimation of the real pressure drop. 
The used pipe lengths can be changed in the Pressure drop tab.
Parameter <code>dp_nominal</code> can be used to override the default calculation.
</p>
<h4>Validation </h4>
<p>
A limited verification has been performed in IDEAS.Fluid.HeatExchangers.RadiantSlab.Examples.EmbeddedPipeVerification.
</p>
<h4>References</h4>
<p>[Koshenz, 2000] - Koschenz, Markus, and Beat Lehmann. 2000. <i>Thermoaktive Bauteilsysteme - Tabs</i>. D&uuml;bendorf: EMPA D&uuml;bendorf. </p>
<p>[TRNSYS, 2007] - Multizone Building modeling with Type 56 and TRNBuild.</p>
</html>", revisions="<html>
<ul>
<li>
March 20, 2020 by Filip Jorissen:<br/>
Fixed inconsistency in the mass computation of the MixingVolume.
See <a href=https://github.com/open-ideas/IDEAS/issues/1116>#1116</a>.
</li>
<li>
January 31, 2020 by Filip Jorissen:<br/>
Propagated <code>allowFlowReversal</code> in <code>TemperatureTwoPort</code> sensor. 
See <a href=https://github.com/open-ideas/IDEAS/issues/1105>#1105</a>.
</li>
<li>
October 19, 2019 by Filip Jorissen:<br/>
Removed discretization assert since we limit the heat flow rate to physically
realistic values already using a limit on <code>G_t</code>. 
Revised documentation.
See <a href=https://github.com/open-ideas/IDEAS/issues/863>#863</a>.
</li>
<li>
October 18, 2019 by Filip Jorissen:<br/>
Using <code>TemperatureTwoPort</code> sensor. 
See <a href=https://github.com/open-ideas/IDEAS/issues/1081>#1081</a>.
</li>
<li>
October 13, 2019 by Filip Jorissen:<br/>
Bugfix for division by zero when <code>dp_nominal=0</code>,
See <a href=https://github.com/open-ideas/IDEAS/issues/1031>#1031</a>.
</li>
<li>
August 14, 2019 by Iago Cupeiro:<br/>
Added output that computes the total TABS heat flow of the <code>EmbeddedPipe</code>.
</li>
<li>
April 16, 2019 by Filip Jorissen:<br/>
Added checks for flow reversal.
See <a href=https://github.com/open-ideas/IDEAS/issues/1006>#1006</a>.
</li>
<li>
April 16, 2019 by Filip Jorissen:<br/>
Removed <code>computeFlowResistance=false</code> 
since this parameter was hidden in the advanced tab
and this setting can easily lead to singularities.
See <a href=https://github.com/open-ideas/IDEAS/issues/1014>#1014</a>.
</li>
<li>
June 21, 2018 by Filip Jorissen:<br/>
Set <code>final alpha=0</code> in <code>prescribedHeatFlow</code>
to avoid large algebraic loops in specific cases.
See <a href=https://github.com/open-ideas/IDEAS/issues/852>#852</a>.
</li>
<li>
April 26, 2017 by Filip Jorissen:<br/>
Removed <code>useSimplifiedRt</code> parameter
since this leads to a violation of the second 
law for small flow rates.
See <a href=https://github.com/open-ideas/IDEAS/issues/717>#717</a>.
</li>
<li>2015 November, Filip Jorissen: Revised implementation for small flow rates: v3: replaced SmoothMin by min function</li>
<li>2015 November, Filip Jorissen: Revised implementation for small flow rates: v2</li>
<li>2015 November, Filip Jorissen: Revised implementation for small flow rates</li>
<li>2015, Filip Jorissen: Revised implementation</li>
<li>2014 March, Filip Jorissen: IDEAS baseclasses</li>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2012 April, Roel De Coninck: rebasing on common Partial_Emission</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul>
</html>"));
end EmbeddedPipe;
