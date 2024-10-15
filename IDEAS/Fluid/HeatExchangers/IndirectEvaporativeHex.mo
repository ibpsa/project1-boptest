within IDEAS.Fluid.HeatExchangers;
model IndirectEvaporativeHex "Indirect evaporative heat exchanger"
  extends IDEAS.Fluid.Interfaces.PartialFourPortInterface(
    final allowFlowReversal1=false,
    final allowFlowReversal2=false);
  parameter Real eps_adia_on
    "Heat exchanger efficiency when adiabatic heat exchange is on, used when not use_eNTU"
    annotation(Dialog(enable=not use_eNTU));
  parameter Real eps_adia_off
    "Heat exchanger efficiency when adiabatic heat exchange is off, used when not use_eNTU"
    annotation(Dialog(enable=not use_eNTU));
  parameter Boolean use_eNTU = true "Use NTU method for efficiency calculation"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Time tau = 60
    "Thermal time constant of the heat exchanger";
  parameter Real UA_adia_on
    "UA value when using evaporative cooling, used when use_eNTU = true"
    annotation(Dialog(enable=use_eNTU));
  parameter Real UA_adia_off
    "UA value when not using evaporative cooling, used when use_eNTU = true"
    annotation(Dialog(enable=use_eNTU));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Formulation of mass balance"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Real mSenFac(min=1)=1
    "Factor for scaling the sensible thermal mass of the volume"
    annotation(Dialog(tab="Dynamics"));
  // Initialization
  parameter Medium1.AbsolutePressure p1_start = Medium1.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization", group = "Medium 1"));
  parameter Medium1.Temperature T1_start = Medium1.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", group = "Medium 1"));
  parameter Medium1.MassFraction X1_start[Medium1.nX] = Medium1.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nXi > 0));
  parameter Medium1.ExtraProperty C1_start[Medium1.nC](
       quantity=Medium1.extraPropertiesNames)=fill(0, Medium1.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
  parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](
       quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
  parameter Medium2.AbsolutePressure p2_start = Medium2.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization", group = "Medium 2"));
  parameter Medium2.Temperature T2_start = Medium2.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", group = "Medium 2"));
  parameter Medium2.MassFraction X2_start[Medium2.nX] = Medium2.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nXi > 0));
  parameter Medium2.ExtraProperty C2_start[Medium2.nC](
       quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
  parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](
       quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
  parameter Modelica.SIunits.MassFlowRate m_flow_small=1E-4*abs(volTop.m_flow_nominal)
    "Small mass flow rate for regularization of zero flow";

  parameter Boolean simplifiedMassBalance=true
    "Use simplified evaporation model to determine outlet humidity of dumped air stream when evaporative cooling is on";
  constant Boolean prescribeTBot = false
    "=True, for validation. Need this option to avoid warnings.";

  Modelica.SIunits.Power Q;
  Modelica.SIunits.Energy E=volTop.U+volBot.U;
  Modelica.Blocks.Interfaces.BooleanInput adiabaticOn
    "Activate adiabatic cooling"
    annotation (Placement(transformation(extent={{120,-16},{88,16}})));

  IDEAS.Fluid.MixingVolumes.MixingVolumeMoistAir     volBot(
    redeclare package Medium = Medium2,
    m_flow_nominal=m2_flow_nominal,
    prescribedHeatFlowRate=true,
    m_flow_small=m_flow_small,
    nPorts=2,
    p_start=p2_start,
    T_start=T2_start,
    X_start=X2_start,
    C_start=C2_start,
    C_nominal=C2_nominal,
    allowFlowReversal=allowFlowReversal2,
    mSenFac=mSenFac,
    V=m2_flow_nominal/rho_default*tau,
    energyDynamics=if prescribeTBot then Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
 else
     energyDynamics,
    massDynamics = massDynamics)
    annotation (Placement(transformation(extent={{10,-60},{-10,-40}})));
  IDEAS.Fluid.MixingVolumes.MixingVolumeMoistAir volTop(
    nPorts=2,
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    prescribedHeatFlowRate=true,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    m_flow_small=m_flow_small,
    p_start=p1_start,
    T_start=T1_start,
    X_start=X1_start,
    C_start=C1_start,
    C_nominal=C1_nominal,
    simplify_mWat_flow=true,
    allowFlowReversal=allowFlowReversal1,
    mSenFac=mSenFac,
    V=m1_flow_nominal/rho_default*tau) "Top heat exchanger volume"
    annotation (Placement(transformation(extent={{10,60},{-10,40}})));
   Modelica.Blocks.Interfaces.RealOutput TOutBot "Bottom outlet temperature"
    annotation (Placement(transformation(extent={{98,-98},{118,-78}}),
        iconTransformation(extent={{98,-98},{118,-78}})));
   Modelica.Blocks.Sources.RealExpression mFloAdiBot(y=(Xw_out_bot - Xw_in_bot)*
        port_a2.m_flow)
    "Realexpression for setting condensation mass flow rate"
    annotation (Placement(transformation(extent={{118,-52},{50,-32}})));
   Real Xw_in_bot= Xi_bot_in[1] "Water mass fraction of bottom stream";

protected
  final parameter Modelica.SIunits.Density rho_default=Medium1.density(
     Medium1.setState_pTX(
      T=Medium1.T_default,
      p=Medium1.p_default,
      X=Medium1.X_default[1:Medium1.nXi]))
    "Density, used to compute fluid mass";
  Modelica.SIunits.Temperature T_bot_in=Medium2.temperature_phX(p=port_a2.p, h=inStream(port_a2.h_outflow), X=inStream(port_a2.Xi_outflow));
  Modelica.SIunits.Temperature T_top_in=Medium1.temperature_phX(p=port_a1.p, h=inStream(port_a1.h_outflow), X=inStream(port_a1.Xi_outflow));
  Medium1.MassFraction Xi_top_in[Medium1.nXi] = inStream(port_a1.Xi_outflow)
    "Species vector, needed because indexed argument for the operator inStream is not supported";
  Medium1.MassFraction Xi_bot_in[Medium2.nXi] = inStream(port_a2.Xi_outflow)
    "Species vector, needed because indexed argument for the operator inStream is not supported";
  Real Xw_in_top= Xi_top_in[1] "Water mass fraction of top stream";
  Real Xw_80_Tout_top = if simplifiedMassBalance
                        then IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(pSat=IDEAS.Media.Air.saturationPressure(volTop.heatPort.T), p=port_a1.p, phi=0.8)
                        else Xw_in_top + (Xw_sat_Tout_top-Xw_in_top)*eps_NTU
    "Absolute humidity of top outlet air with a relative humidity of 80%.";
  Real Xw_sat_Tin_top=IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
     pSat=IDEAS.Media.Air.saturationPressure(T_top_in), p=port_a1.p, phi=1)
    "Absolute humidity for saturated top inlet air";
  Real Xw_sat_Tout_top=IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
     pSat=IDEAS.Media.Air.saturationPressure(volTop.heatPort.T), p=port_b1.p, phi=1)
    "Absolute humidity for saturated top outlet air";
  Real Xw_sat_Tin_bot=IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
     pSat=IDEAS.Media.Air.saturationPressure(T_bot_in), p=port_a2.p, phi=1)
    "Absolute humidity for saturated bottom inlet air";
  Real Xw_sat_Tout_bot=IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
     pSat=IDEAS.Media.Air.saturationPressure(volBot.heatPort.T), p=port_b2.p, phi=1)
    "Absolute humidity for saturated bottom outlet air";
  Real Xw_out_top=min(if adiabaticOn then max(Xw_80_Tout_top,Xw_in_top) else Xw_in_top, Xw_sat_Tout_top);
  Real Xw_out_bot=min(Xw_in_bot, Xw_sat_Tout_bot);
  Modelica.SIunits.Temperature T_top_in_wet =  if adiabaticOn then  wetBulIn.TWetBul else T_top_in
    "Temperature of the wet/dry HEX at extracted air inlet";
  //splicefunction required for disabling heat transfer for low mass flow rates
  Modelica.SIunits.Power Qmax "Maximum heat transfer, including latent heat";
  Real C_top "Heat capacity rate of top stream";
  Real C_bot "Heat capacity rate of bottom stream";
  Real C_min = min(C_top,C_bot);
  Real C_max = max(C_top,C_bot);
  Real C_star = min(C_min*IDEAS.Utilities.Math.Functions.inverseXRegularized(C_max,1),0.9999999); //avoids division by zero
  Real NTU=(if adiabaticOn then UA_adia_on else UA_adia_off) /max(1,C_min);
  Real eps_NTU_half = 1-exp((exp(-C_star*(NTU/2)^0.78)-1)*IDEAS.Utilities.Math.Functions.inverseXRegularized(C_star*(NTU/2)^(-0.22),0.01));
  Real eps_NTU = (((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-1)/(((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-C_star);
  Modelica.Blocks.Sources.RealExpression mFloAdiTop(y=(Xw_out_top - Xw_in_top)*
        port_a1.m_flow) "Realexpression for setting evaporation mass flow rate"
    annotation (Placement(transformation(extent={{110,32},{42,52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloTop(final
      alpha=0) "Prescribed heat flow rate for top volume"
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloBot(final
      alpha=0) "Prescribed heat flow rate for bottom volume"
    annotation (Placement(transformation(extent={{-14,-30},{6,-10}})));
  Modelica.Blocks.Sources.RealExpression Qexp(y=Q)
    "Expression for heat flow rate"
    annotation (Placement(transformation(extent={{-76,-10},{-64,10}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{40,-98},{60,-78}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=(volBot.V*
        rho_default*IDEAS.Utilities.Psychrometrics.Constants.cpAir*mSenFac)/tau/
        50)
    "Temperature difference will settle after 3*50 time constants tau if m_flow=0"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,-4})));
  Modelica.Blocks.Math.Gain negate(k=-1) "For minus sign"
    annotation (Placement(transformation(extent={{-46,-26},{-34,-14}})));
  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulXi  wetBulIn(
    approximateWetBulb=false,
    TDryBul=T_top_in,
    p=port_a1.p,
    Xi=Xi_top_in[1:Medium1.nXi],
    redeclare package Medium = Medium1)
    "Wet bulb temperature based on wet channel inlet conditions";
  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulXi  wetBulOut(
    approximateWetBulb=false,
    TDryBul=volTop.heatPort.T,
    p=port_a1.p,
    Xi=volTop.ports[1].Xi_outflow[1:Medium1.nXi],
    redeclare package Medium = Medium1)
    "Wet bulb temperature based on wet channel outlet conditions";

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tbot(T=273.15 + 21.4) if prescribeTBot
    "This override the temperature of the IEH outlet for validation purposes";
equation
  assert(port_a1.m_flow>-m_flow_small or allowFlowReversal1, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");
  assert(port_a2.m_flow>-m_flow_small or allowFlowReversal2, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");

    // model from: Liu, Z., Allen, W., & Modera, M. (2013). Simplified thermal modeling of indirect evaporative heat exchangers. HVAC&R Research, 19(March), 37–41. doi:10.1080/10789669.2013.763653
    Qmax=C_min*(T_bot_in-T_top_in_wet);
    C_top = port_a1.m_flow*(if adiabaticOn
                            then (Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulOut.TWetBul, {wetBulOut.XiSat,1-wetBulOut.XiSat}))-Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulIn.TWetBul,  {wetBulIn.XiSat,1-wetBulIn.XiSat})))*IDEAS.Utilities.Math.Functions.inverseXRegularized(wetBulOut.TWetBul-wetBulIn.TWetBul,0.01)
                            else Medium1.specificHeatCapacityCp(Medium1.setState_pTX(Medium1.p_default, Medium1.T_default, Medium1.X_default)));
    C_bot = port_a2.m_flow*Medium2.specificHeatCapacityCp(Medium2.setState_pTX(Medium2.p_default, Medium2.T_default, Medium2.X_default));
    Q = Qmax*(if use_eNTU then eps_NTU else (if adiabaticOn then eps_adia_on else eps_adia_off));

  connect(preHeaFloTop.port, volTop.heatPort) annotation (Line(
      points={{6,0},{10,0},{10,50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(preHeaFloBot.port, volBot.heatPort) annotation (Line(
      points={{6,-20},{10,-20},{10,-50}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Qexp.y, preHeaFloTop.Q_flow) annotation (Line(
      points={{-63.4,0},{-14,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor.port, volBot.heatPort)
    annotation (Line(points={{40,-88},{10,-88},{10,-50}},
                                                        color={191,0,0}));
  connect(temperatureSensor.T, TOutBot)
    annotation (Line(points={{60,-88},{108,-88}}, color={0,0,127}));
  connect(theCon.port_a, volBot.heatPort) annotation (Line(points={{32,-14},{32,
          -14},{32,-50},{10,-50}}, color={191,0,0}));
  connect(theCon.port_b, volTop.heatPort)
    annotation (Line(points={{32,6},{32,6},{32,50},{10,50}}, color={191,0,0}));

  connect(port_a2, volBot.ports[1])
    annotation (Line(points={{100,-60},{2,-60}},         color={0,127,255}));
  connect(volBot.ports[2], port_b2) annotation (Line(points={{-2,-60},{-2,-60},
          {-100,-60}}, color={0,127,255}));
  connect(negate.y, preHeaFloBot.Q_flow)
    annotation (Line(points={{-33.4,-20},{-14,-20}}, color={0,0,127}));
  connect(negate.u, Qexp.y) annotation (Line(points={{-47.2,-20},{-56,-20},{-56,
          0},{-63.4,0}},   color={0,0,127}));
  connect(port_a1, volTop.ports[1])
    annotation (Line(points={{-100,60},{2,60}}, color={0,127,255}));
  connect(volTop.ports[2], port_b1)
    annotation (Line(points={{-2,60},{-2,60},{100,60}}, color={0,127,255}));
  connect(mFloAdiTop.y, volTop.mWat_flow)
    annotation (Line(points={{38.6,42},{12,42}}, color={0,0,127}));
  connect(mFloAdiBot.y, volBot.mWat_flow)
    annotation (Line(points={{46.6,-42},{12,-42}}, color={0,0,127}));
  connect(Tbot.port, volBot.heatPort);
 annotation (
      __Dymola_choicesAllMatching=true,
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-56,40},{4,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,40},{0,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-20},{-60,40}},
          color={255,255,255},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{0,40},{-60,-20}},
          color={255,255,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{60,-20},{0,40}},
          color={255,255,255},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{60,40},{0,-20}},
          color={255,255,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{8,50},{-60,50},{-60,-28},{72,-28}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-56,-22},{-50,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-50,-28},{-44,-22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-50,-22},{-50,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-28,-22},{-22,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-22,-28},{-16,-22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-22,-22},{-22,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{6,-22},{12,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{12,-28},{18,-22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{12,-22},{12,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{38,-22},{44,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{44,-28},{50,-22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{44,-22},{44,-28}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-46,44},{-40,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-40,50},{-34,44}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-40,44},{-40,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-18,50},{-24,44}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-12,44},{-18,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-18,50},{-18,44}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{30,40},{90,58}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Open},
          pattern=LinePattern.Dash),
        Line(
          points={{100,-48},{100,10},{60,10}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-64,10},{-100,10},{-100,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-90,56},{-30,40}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Open},
          pattern=LinePattern.Dash),
        Line(
          points={{-72,50}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-74,98}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{58,10},{-56,10}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{-30,32},{-30,-10}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Open},
          pattern=LinePattern.Dash),
        Line(
          points={{30,-10},{30,32}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Open},
          pattern=LinePattern.Dash),
        Line(
          points={{-28,-10},{28,-10}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Open},
          pattern=LinePattern.Dash)}),
    Documentation(revisions="<html>
<ul>
<li>
April 7, 2020, by Filip Jorissen:<br/>
Replaced thermal resistor by thermal conductor to avoid division.
See <a href=https://github.com/open-ideas/IDEAS/issues/1129>#1129</a>.
</li>
<li>
October 1, 2019, by Filip Jorissen:<br/>
Revised computation of <code>C_star</code>
to avoid division by zero for balanced flow.
</li>
<li>
May 15, 2018, by Filip Jorissen:<br/>
Changes for setting unique initial conditions.
</li>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end IndirectEvaporativeHex;
