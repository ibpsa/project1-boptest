within IDEAS.Fluid.HeatPumps.BaseClasses;
partial model PartialHeatPump "Heat pump partial"
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(
    final tau1=30,
    final tau2=30,
    m1_flow_nominal=heatPumpData.m1_flow_nominal*sca,
    m2_flow_nominal=heatPumpData.m2_flow_nominal*sca,
    dp1_nominal=if computeFlowResistance then heatPumpData.dp1_nominal else 0,
    dp2_nominal=if computeFlowResistance then heatPumpData.dp2_nominal else 0,
    vol1(mSenFac=mSenFac,
      V=heatPumpData.m1/rho1_nominal,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      prescribedHeatFlowRate=true),
    redeclare IDEAS.Fluid.MixingVolumes.MixingVolume vol2(mSenFac=mSenFac,
      V=heatPumpData.m2/rho2_nominal,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      prescribedHeatFlowRate=true));
  extends IDEAS.Fluid.HeatPumps.Interfaces.ModulationSecurity(
    T_max = heatPumpData.T_cond_max,
    T_min = heatPumpData.T_evap_min);
  extends IDEAS.Fluid.Interfaces.OnOffInterface(use_onOffSignal=true);

  replaceable parameter IDEAS.Fluid.HeatPumps.BaseClasses.HeatPumpData heatPumpData constrainedby
    HeatPumpData "Record containing heat pump performance data"
                                                   annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-98,86},{-86,98}})));
  parameter Boolean use_TSet = false
    "True if the heat pump uses a set point temperature control";
  parameter Boolean use_scaling=false
    "scale the performance data based on the nominal power"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean perfFromTout = false
    "= true, then recompute performance based on evaporator outlet temperature instead of directly using the inlet temperature"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean use_modulationSignal=false
    "enables an input for modulating the heat pump ideally (no change of COP, just scaling of the electrical and thermal power)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Power P_the_nominal=heatPumpData.P_the_nominal
    "nominal thermal power of the heat pump"
    annotation (Dialog(enable=use_scaling, tab="Advanced"));

  final parameter Real sca=if use_scaling then P_the_nominal/heatPumpData.P_the_nominal
       else 1 "scaling factor for the nominal power of the heat pump";

  parameter Real mSenFac=1
    "Factor to scale the thermal mass of the evaporator and condensor"
    annotation (Dialog(tab="Advanced"));

  parameter Boolean computeFlowResistance = true
    "=true, compute flow resistance. Set to false to assume no friction"
    annotation (Evaluate=true, Dialog(tab="Flow resistance"));

  Modelica.Blocks.Tables.CombiTable2D powerTable(table=heatPumpData.powerData,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Interpolation table for finding the electrical power"
    annotation (Placement(transformation(extent={{-74,10},{-54,30}})));
  Modelica.Blocks.Tables.CombiTable2D copTable(table=heatPumpData.copData,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-74,-16},{-54,4}})));
  Modelica.Blocks.Sources.RealExpression QEvap(y=-P_evap)
    annotation (Placement(transformation(extent={{-72,70},{-54,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatEvap
    annotation (Placement(transformation(extent={{-40,70},{-20,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatCond
    annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductorLosses(G=
        heatPumpData.G) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,-76})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss
    annotation (Placement(transformation(extent={{16,-110},{36,-90}})));

  Modelica.Blocks.Sources.RealExpression QCond(y=P_cond)
    annotation (Placement(transformation(extent={{86,-70},{66,-50}})));

  Modelica.SIunits.Power P_el "Electrical power consumption";
  Modelica.SIunits.Power P_evap "Thermal power of the evaporator (positive)";
  Modelica.SIunits.Power P_cond "Thermal power of the condensor (positive)";
  Modelica.SIunits.Temperature TEvapIn "Evaporator inlet temperature";
  Real cop "COP of the heat pump";
  Modelica.Blocks.Sources.RealExpression PElec(y=P_el)
    annotation (Placement(transformation(extent={{62,18},{82,38}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumption"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={108,28})));

initial equation
  assert(energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState, "Energy dynamics cannot be set to steady state!");

public
  constant Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Dialog(tab="Flow resistance"));


protected
  parameter Medium1.ThermodynamicState state_default1=
      Medium1.setState_pTX(
      Medium1.p_default,
      Medium1.T_default,
      Medium1.X_default);
  parameter Medium2.ThermodynamicState state_default2=
      Medium2.setState_pTX(
      Medium2.p_default,
      Medium2.T_default,
      Medium2.X_default);

  // ---------------- Control for temperature protection of evaporator and condenser

  // ---------------- Smoothing of the temperature protection control and on off control

protected
  Modelica.Blocks.Interfaces.BooleanOutput on_TSetControl_internal
    "On/off controll variable which can be used for set temperature control";
  Modelica.Blocks.Interfaces.RealOutput modulationSignal_internal
    " Internal variable for the modulation signal";

  // ----------------- Modulation of heat pump to work in partial load
public
  Modelica.Blocks.Interfaces.RealInput mod(min=0, max=1) if
                                                           use_modulationSignal
    "Modulation level" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={88,110})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_out_cond
    annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
  Modelica.Blocks.Sources.RealExpression TEvapInExp(y=(if perfFromTout then
        vol1.T + P_evap/heatPumpData.m1_flow_nominal/
        Medium1.specificHeatCapacityCp(state_default1) else TEvapIn))
    annotation (Placement(transformation(extent={{-110,4},{-90,24}})));

equation
  if allowFlowReversal1 then
    TEvapIn = IDEAS.Utilities.Math.Functions.spliceFunction(
              x=port_a1.m_flow,
              pos=Medium1.temperature(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow))),
              neg = Medium1.temperature(Medium1.setState_phX(port_b1.p, inStream(port_b1.h_outflow), inStream(port_b1.Xi_outflow))),
              deltax = m1_flow_nominal/10);
  else
    TEvapIn = Medium1.temperature(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow)));
  end if;

  connect(modulationSignal_internal,mod);
  if not use_modulationSignal then
    modulationSignal_internal = 1;
  end if;
  if not use_TSet then
    on_TSetControl_internal = true;
  end if;

  T_high = vol2.T;
  T_low = vol1.T;

  cop = copTable.y;
  P_evap = P_el*(cop - 1);
  P_cond = P_el*cop;

  P_el = powerTable.y*sca*modulationSignal_internal*modulation_security_internal*( if on_internal and on_security.y and on_TSetControl_internal then 1 else 0);

  connect(heatLoss, thermalConductorLosses.port_a) annotation (Line(
      points={{26,-100},{26,-86}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PElec.y, P) annotation (Line(
      points={{83,28},{108,28}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(powerTable.u1, copTable.u1) annotation (Line(
      points={{-76,26},{-86,26},{-86,0},{-76,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatEvap.port, vol1.heatPort) annotation (Line(
      points={{-20,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatCond.port, vol2.heatPort) annotation (Line(
      points={{40,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductorLosses.port_b, vol2.heatPort) annotation (Line(
      points={{26,-66},{26,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_out_cond.port, vol2.heatPort) annotation (Line(
      points={{-20,-40},{12,-40},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_out_cond.T, copTable.u1) annotation (Line(
      points={{-40,-40},{-86,-40},{-86,0},{-76,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvapInExp.y, powerTable.u2) annotation (Line(
      points={{-89,14},{-76,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(copTable.u2, powerTable.u2) annotation (Line(
      points={{-76,-12},{-80,-12},{-80,14},{-76,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QCond.y, prescribedHeatCond.Q_flow) annotation (Line(
      points={{65,-60},{60,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QEvap.y, prescribedHeatEvap.Q_flow) annotation (Line(
      points={{-53.1,60},{-40,60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Icon(graphics={
        Line(
          points={{-20,0},{40,2.44929e-15}},
          color={255,0,0},
          smooth=Smooth.None,
          origin={0,0},
          rotation=90,
          thickness=0.5),
        Line(
          points={{-14,21},{6,1},{-14,-23}},
          color={255,0,0},
          smooth=Smooth.None,
          origin={-1,-14},
          rotation=270,
          thickness=0.5)}),
    Documentation(revisions="<html>
    <ul>
        <li>January 2014 by Damien Picard:<br/> 
        Remove unnecessary filters + add modulation temperature security to avoid overheating and undercooling and limit number of events.
</li>
    <li>December 2014 by Damien Picard:<br/> 
    Make filter parameters final to avoid warning durings compilation.
</li>
<li>December 2014 by Damien Picard:<br/> 
Add value to internal variable modulationRate_internal to close the equations when use_modulation_security is false. Add a modulation input.
</li>
<li>November 2014 by Filip Jorissen:<br/> 
Added 'AvoidEvents' parameter, temperature protection and documentation.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>", info="<html>
<p>This partial model provides an implementation for a heat pump. Heat is drawn from the fluid at the &apos;Brine&apos; side and injected into the &apos;Fluid&apos; side. The model uses performance tables to calculate the COP and electrical power.</p>
<p><b>Main equations</b> </p>
<p>The COP and electrical power Pel are read from performance tables as a function of the evaporator inlet temperature and the condensor outlet temperature:</p>
<p>COP = f1(T_out_condensor, T_in_evaporator)</p>
<p>P_el = f2(T_out_condensor, T_in_evaporator)</p>
<p>These values are used to calculate the thermal powers:</p>
<p>Q_condensor = P_el*COP</p>
<p>Q_evaporator = P_el*(COP-1)</p>
<p>If the parameter use_scaling is true, the powers of the heat pump will be scaled with QNom / QNomRef. The nominal mass flow rate of the heat pump is also scaled to correctly scale the pressure losses.</p>
<p>The models also allows partial load if use_modulationSignal is set to true. The modulation is assumed to be ideal and it works then as a scaling input of the power.</p>
<p>The heat pump compressor will be switched off when:</p>
<ol>
<li>The external control signal is false</li>
<li>The over/under-temperature protection is activated</li>
</ol>
<p>In this case P_el will become zero. The transition from on to off can happen discretely or through a filter using the parameter &apos;avoidEvents&apos;.</p>
<h4>Assumptions and limitations </h4>
<ul>
<li>The transient behaviour of the thermodynamic cycle is not simulated.</li>
<li>The fluid mass flow rates do not have an impact on the values of COP and P_el.</li>
<li>Modulation of the power is not supported.</li>
<li>Maximum temperatures of the evaporator and minimum temperatures of the condensor are not considered.</li>
<li>Defrosting cycles etc are not considered.</li>
</ul>
<h4>Typical use and important parameters</h4>
<p>A record with the required parameters needs to be provided.</p>
<p>The parameter &apos;avoidEvents&apos; can be used to avoid an event when activating the over/under-temperature protection. When avoidEvents is true the thermal mass of the condensor and evaporator are increased to avoid undercooling/overheating the heat pump while it is switching off and the mass flow rate is zero. This factor can be quite significant and depends on the &apos;riseTime&apos;.</p>
<h4>Options</h4>
<ol>
<li>Typical options inherited through lumpedVolumeDeclarations can be used.</li>
</ol>
<h4>Validation</h4>
<p>Examples of this model can be found in<a href=\"modelica://IDEAS.Fluid.Production.Examples.HeatPump_BrineWater\"> IDEAS.Fluid.Production.Examples.HeatPump_BrineWater</a>, <a href=\"modelica://IDEAS.Fluid.Production.Examples.HeatPump_BrineWaterTset\">IDEAS.Fluid.Production.Examples.HeatPump_BrineWaterTset</a> and <a href=\"modelica://IDEAS.Fluid.Production.Examples.HeatPump_Events\">IDEAS.Fluid.Production.Examples.HeatPump_Events</a></p>
</html>"));
end PartialHeatPump;
