within IDEAS.Airflow.AHU;
model Adsolair58 "Menerga Adsolair type 58 air handling unit"
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(
    redeclare final package Medium = MediumAir,
    final mSenFac=1);
  extends IDEAS.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = MediumAir,
    redeclare final package Medium2 = MediumAir,
    final m1_flow_nominal=per.m1_flow_nominal,
    final m2_flow_nominal=per.m2_flow_nominal,
    final allowFlowReversal1=allowFlowReversal,
    final allowFlowReversal2=allowFlowReversal);
  replaceable package MediumAir =
      IDEAS.Media.Air
      "Air medium model" annotation (
      __Dymola_choicesAllMatching=true);

  replaceable parameter IDEAS.Airflow.AHU.BaseClasses.Adsolair14200 per
    constrainedby IDEAS.Airflow.AHU.BaseClasses.AdsolairData
    "Adsolair performance data" annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-138,82},{-122,
            98}})));

  //PARAMETERS
  parameter Boolean use_onOffSignal = true
    "Set to true to switch device on/off using external signal";
  parameter Boolean onOff=true "Set to true if device is on"
  annotation (Dialog(enable= not use_onOffSignal));
  final parameter Boolean allowFlowReversal=false
    "Flow reversal is not supported"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small=m1_flow_nominal/50
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=60
    "Thermal time constant of evaporator, condensor and heat recovery unit at nominal flow rate"
    annotation(Dialog(group="Advanced"));
  parameter Modelica.SIunits.Pressure dp_fouling_top=0
    "Nominal pressure drop in top channel due to filter fouling";
  parameter Modelica.SIunits.Pressure dp_fouling_bot=0
    "Nominal pressure drop in bottom channel due to filter fouling";
  parameter Real alpha = 0.5
    "Pressure recovery factor for fixed pressure drop in bottom bypass channel"
    annotation(Dialog(group="Advanced"));
  parameter Real k1=0.45
    "Flow coefficient for y=1, k1 = pressure drop divided by dynamic pressure"
    annotation(Dialog(group="Advanced"));

  //EQUATIONS
  Modelica.SIunits.Energy E=IEH.E + eva.U + con.U;
  Real BPF=min(1, max(0, IDEAS.Utilities.Math.Functions.spliceFunction(
      x=abs(IEH.TOutBot - eva.heatPort.T) - 0.2,
      pos=(eva.heatPort.T - com.Teva)*
        IDEAS.Utilities.Math.Functions.inverseXRegularized(x=IEH.TOutBot - com.Teva,
        delta=0.1),
      neg=1,
      deltax=0.1))) "Fraction of air that is bypassed in the evaporator";
  Real X_sat_evap=IDEAS.Utilities.Psychrometrics.Functions.X_pSatpphi(
      pSat=IDEAS.Media.Air.saturationPressure(com.Teva),
      p=eva.ports[1].p,
      phi=1)
    "Water fraction at saturation in evaporator at refrigerant temperature";
  Real x_out=BPF*IEH.port_b2.Xi_outflow[1] + (1 - BPF)*min(X_sat_evap, IEH.port_b2.Xi_outflow[
      1]) "Outlet water mass fraction based on BPF";
  Modelica.SIunits.MassFlowRate m_condens=IEH.port_a2.m_flow*(IEH.port_b2.Xi_outflow[
      1] - x_out) "Water condensation mass flow rate in the evaporator.";

  // PORTS
  Modelica.Blocks.Interfaces.BooleanInput on if use_onOffSignal annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,108})));
  Modelica.Blocks.Interfaces.RealInput Tset "Setpoints of the valves"
    annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=270,
        origin={8,-102}),  iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={60,102})));
  Modelica.Blocks.Interfaces.RealInput[2] dpSet
    "Top and bottom fan pressure set points" annotation (Placement(
        transformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={-38,104}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={20,102})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{96,80},{116,100}})));

  //COMPONENTS
  replaceable IDEAS.Airflow.AHU.BaseClasses.AdsolairController adsCon(tau=tau)
    constrainedby IDEAS.Airflow.AHU.BaseClasses.AdsolairControllerInterface
    "Adsolair controller model"
    annotation (Dialog(group="Advanced"),Placement(transformation(extent={{-44,56},{-24,76}})));
  replaceable IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger hexSupOut(
    m1_flow_nominal=m2_flow_nominal,
    m2_flow_nominal=1,
    dp1_nominal=0,
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp2_nominal=1,
    vol2(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial))
    constrainedby IDEAS.Fluid.Interfaces.PartialFourPortInterface
    "Replaceable model for adding heat exchanger at supply outlet"
    annotation (Dialog(group="Advanced"),Placement(transformation(extent={{-72,-36},{-92,-16}})));
  replaceable IDEAS.Airflow.AHU.BaseClasses.SimpleCompressorTable com(
    fraPmin=per.fraPmin,
    C=tau/4*per.G_condensor)
  constrainedby BaseClasses.SimpleCompressorInterface
    "Simple compressor model for active chiller"
    annotation (Dialog(group="Advanced"),Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,42})));

  Modelica.Blocks.Sources.BooleanExpression onExp(y=on_internal)
    "AHU control signal"
    annotation (Placement(transformation(extent={{-84,66},{-64,82}})));
  Modelica.Blocks.Sources.RealExpression TEvaExp(y=eva.heatPort.T)
    "Evaporator outlet temperature"
    annotation (Placement(transformation(extent={{-86,64},{-60,48}})));

  IDEAS.Fluid.HeatExchangers.IndirectEvaporativeHex IEH(
    p1_start=p_start,
    T1_start=T_start,
    X1_start=X_start,
    C1_start=C_start,
    C1_nominal=C_nominal,
    p2_start=p_start,
    T2_start=T_start,
    X2_start=X_start,
    C2_start=C_start,
    C2_nominal=C_nominal,
    m_flow_small=m_flow_small,
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    eps_adia_on=per.eps_adia_on,
    eps_adia_off=per.eps_adia_off,
    final massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    tau=tau,
    UA_adia_on=per.UA_adia_on,
    UA_adia_off=per.UA_adia_off,
    use_eNTU=true,
    mSenFac=mSenFac,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                   "Indirect evaporative heat exchanger"
    annotation (Placement(transformation(extent={{10,-36},{64,18}})));
  IDEAS.Fluid.MixingVolumes.MixingVolume con(
    nPorts=2,
    redeclare package Medium = MediumAir,
    m_flow_nominal=m1_flow_nominal,
    mSenFac=mSenFac,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_small=m_flow_small,
    allowFlowReversal=allowFlowReversal,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    V=m1_flow_nominal/rho_default*tau,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Simple condensor model for active chiller" annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={65,35})));
  IDEAS.Fluid.Movers.FlowControlled_dp fanTop(
    redeclare package Medium = MediumAir,
    allowFlowReversal=allowFlowReversal,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    addPowerToMedium=true,
    per(
      speed_rpm_nominal=per.speed_rpm_nominal,
      hydraulicEfficiency=per.hydraulicEfficiency,
      motorEfficiency=per.motorEfficiency,
      power=per.power,
      use_powerCharacteristic=per.use_powerCharacteristic,
      pressure=per.pressure),
    init=Modelica.Blocks.Types.Init.NoInit,
    m_flow_small=m1_flow_nominal/50,
    riseTime=600,
    use_inputFilter=false,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=m1_flow_nominal,
    prescribeSystemPressure=true)   "Top fan"
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  IDEAS.Fluid.MixingVolumes.MixingVolumeMoistAir eva(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    mSenFac=mSenFac,
    m_flow_small=m_flow_small,
    allowFlowReversal=allowFlowReversal,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2,
    V=m2_flow_nominal/rho_default*tau,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Simple evaporator model for active chiller"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={10,-52})));
  IDEAS.Fluid.Movers.FlowControlled_dp fanBot(
    redeclare package Medium = MediumAir,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    allowFlowReversal=allowFlowReversal,
    addPowerToMedium=true,
    per(
      speed_rpm_nominal=per.speed_rpm_nominal,
      motorEfficiency=per.motorEfficiency,
      hydraulicEfficiency=per.hydraulicEfficiency,
      power=per.power,
      use_powerCharacteristic=per.use_powerCharacteristic,
      pressure=per.pressure),
    init=Modelica.Blocks.Types.Init.NoInit,
    m_flow_small=m2_flow_nominal/50,
    riseTime=600,
    use_inputFilter=false,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=m2_flow_nominal,
    prescribeSystemPressure=true)   "Bottom fan"
    annotation (Placement(transformation(extent={{-30,-30},{-50,-10}})));
  Modelica.Blocks.Math.Sum sum(nin=5) "Total electrical power consumption"
    annotation (Placement(transformation(extent={{78,82},{94,98}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort TSupIn(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    T_start=293,
    allowFlowReversal=allowFlowReversal,
    tau=0) "Supply inlet air temperature" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={28,-68})));
  Modelica.Blocks.Sources.RealExpression m_condens_exp(y=-m_condens)
    "Real expression for setting water condensation mass flow rate"
    annotation (Placement(transformation(extent={{60,-66},{40,-46}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conCon(G=
        per.G_condensor)
    "Conductor describing the temperature drop in the condensor" annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={50,42})));
  Modelica.Blocks.Sources.RealExpression fan_flow_set[2](y=if on_internal then
        dpSet else {0.1,0.1})
                         "Fan flow set points"
    annotation (Placement(transformation(extent={{-140,48},{-72,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        273.15 + 20)
    annotation (Placement(transformation(extent={{-112,0},{-100,12}})));
  Modelica.Blocks.Interfaces.RealOutput TFanSupOut
    "Temperature measured behind supply fan"
    annotation (Placement(transformation(extent={{96,-102},{116,-82}})));
  IDEAS.Fluid.FixedResistances.PressureDrop resTop(
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m1_flow_nominal,
    redeclare package Medium = MediumAir,
    from_dp=false,
    dp_nominal=per.dp_nominal_top + dp_fouling_top)
    "Top pressure drop component"
    annotation (Placement(transformation(extent={{-20,30},{0,10}})));
  IDEAS.Fluid.FixedResistances.PressureDrop resBot(
    allowFlowReversal=allowFlowReversal,
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    from_dp=false,
    dp_nominal=per.dp_nominal_bottom + dp_fouling_bot)
    "Bottom pressure drop component"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,-20})));
  TwoWayEqualPercentageAdd                  valBypassBottom(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    allowFlowReversal=allowFlowReversal,
    use_inputFilter=false,
    from_dp=true,
    l=0.001,
    dpAdd=1,
    A=per.A_dam_byp_bot,
    dpFixed_nominal=(1 - alpha)*(m2_flow_nominal/(per.A_byp_bot_min))
        ^2/rho_default/2,
    k1=k1)
    annotation (Placement(transformation(extent={{88,-76},{72,-60}})));
  TwoWayEqualPercentageAdd                  valRecupBot(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    dpFixed_nominal=per.dp_nominal_bottom_recup,
    allowFlowReversal=allowFlowReversal,
    use_inputFilter=false,
    from_dp=true,
    l=0.001,
    dpAdd=1,
    A=per.A_dam_rec_bot,
    k1=k1)
    annotation (Placement(transformation(extent={{88,-34},{72,-18}})));
  TwoWayEqualPercentageAdd                  valBypassTop(
    redeclare package Medium = MediumAir,
    allowFlowReversal=allowFlowReversal,
    use_inputFilter=false,
    from_dp=true,
    l=0.001,
    m_flow_nominal=m1_flow_nominal,
    dpAdd=1,
    dpFixed_nominal=(m1_flow_nominal/per.A_byp_top_min)^2
        /rho_default/2,
    A=per.A_dam_byp_top,
    k1=k1)
    annotation (Placement(transformation(extent={{78,58},{94,74}})));
  TwoWayEqualPercentageAdd                  valRecupTop(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    dpFixed_nominal=per.dp_nominal_top_recup,
    allowFlowReversal=allowFlowReversal,
    use_inputFilter=false,
    from_dp=true,
    l=0.001,
    dpAdd=per.dp_adiabatic,
    A=per.A_dam_rec_top,
    k1=k1)
    annotation (Placement(transformation(extent={{78,36},{94,52}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemFanSupOut(
    redeclare package Medium = MediumAir,
    m_flow_nominal=m2_flow_nominal,
    TAmb=fixedTemperature.T,
    tauHeaTra=3600,
    allowFlowReversal=allowFlowReversal,
    transferHeat=false,
    tau=0)                               "Inlet temperature of the heater"
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-60,-20})));

  Modelica.Blocks.Sources.RealExpression PPum(y=if adsCon.onAdia then 770 else 0)
    "Electrical power consumption of circulation pump"
    annotation (Placement(transformation(extent={{40,98},{60,78}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{50,70},{60,80}})));
  Modelica.Blocks.Sources.RealExpression PUnit(y=if on_internal then 780 else 150)
    "Remaing electrical power consumption from unit"
    annotation (Placement(transformation(extent={{40,86},{60,106}})));

protected
  final parameter Modelica.SIunits.Density rho_default=MediumAir.density(
     MediumAir.setState_pTX(
      T=MediumAir.T_default,
      p=MediumAir.p_default,
      X=MediumAir.X_default[1:MediumAir.nXi]))
    "Density, used to compute condensor/evaporator volume";
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConEva(G=100)
    "Required for simulating heat losses in evaporator" annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-70,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConCon(G=100)
    "Required for simulating heat losses in condenser" annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-70,10})));
  Modelica.Blocks.Interfaces.BooleanInput on_internal
    "Needed to connect to conditional connector";

model TwoWayEqualPercentageAdd
    "Damper with possibility for adding fixed pressure drop using boolean input"
  extends IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValveKv(
    dpValve_nominal= k1^2*m_flow_nominal^2/2/Medium.density(sta_default)/A^2,
    phi=sqrt(1/(1/((l+(1-l)*(c*{y_actual^3, y_actual^2, y_actual}))^2) + (if addPreDro then 1/yAdd^2 else 0))));
  parameter Modelica.SIunits.Pressure dpAdd
      "Additional pressure drop when addPreDro is true";
  parameter Real k1(min=0)= 0.45
      "Flow coefficient for y=1, k1 = pressure drop divided by dynamic pressure"
  annotation(Dialog(tab="Damper coefficients"));
  parameter Modelica.SIunits.Area A "Damper face area";
  Modelica.Blocks.Interfaces.BooleanInput addPreDro
      "Add additional pressure drop"
                                   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,106})));
  protected
  constant Real[3] c= {0.582675,0.222823,0.192212}
      "Polynomial coefficients for pressure drop curve based on ASHRAE fundamentals, 2009, P134, fig 13B, A=1";
  parameter Medium.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";
  parameter Real yAdd(unit="", min=0) = if dpAdd > Modelica.Constants.eps
    then m_flow_nominal / sqrt(dpAdd)/Kv_SI else 9999999;
initial equation
  // Since the flow model IDEAS.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow computes
  // 1/k^2, the parameter l must not be zero.
  assert(l > 0, "Valve leakage parameter l must be bigger than zero.");
  annotation (
    defaultComponentName="val",
    Documentation(info=""), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-74,20},{-36,-24}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%")}));
end TwoWayEqualPercentageAdd;
  Fluid.Sensors.RelativePressure senRelPreBot(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-90}})));
  Fluid.Sensors.RelativePressure senRelPreTop(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-38,36},{-58,56}})));
equation
  connect(on,on_internal);
  if not use_onOffSignal then
    on_internal=onOff;
  end if;
  connect(sum.y, P) annotation (Line(
      points={{94.8,90},{106,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(m_condens_exp.y, eva.mWat_flow) annotation (Line(
      points={{39,-56},{26,-56},{26,-58.4},{19.6,-58.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(com.port_b, conCon.port_a) annotation (Line(
      points={{42,42},{44,42}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(conCon.port_b, con.heatPort) annotation (Line(
      points={{56,42},{65,42}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fanTop.P, sum.u[2]) annotation (Line(
      points={{-29,29},{-58,29},{-58,76},{76.4,76},{76.4,89.36}},
      color={0,0,127},
      smooth=Smooth.None,
      visible=false));
  connect(fanBot.P, sum.u[3]) annotation (Line(
      points={{-51,-11},{-72,-11},{-72,-8},{-78,-8},{-78,90},{76.4,90}},
      color={0,0,127},
      smooth=Smooth.None,
      visible=false));
  connect(com.P, sum.u[4]) annotation (Line(
      points={{40,51.8},{26,51.8},{26,90.64},{76.4,90.64}},
      color={0,0,127},
      visible=false));
  connect(fanTop.port_b, resTop.port_a) annotation (Line(
      points={{-30,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(resBot.port_b, fanBot.port_a) annotation (Line(
      points={{-20,-20},{-30,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fan_flow_set[1].y, fanTop.dp_in) annotation (Line(
      points={{-68.6,41},{-60,41},{-60,32},{-40,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fan_flow_set[2].y, fanBot.dp_in) annotation (Line(
      points={{-68.6,41},{-60,41},{-60,-2},{-40,-2},{-40,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTemFanSupOut.port_a, fanBot.port_b) annotation (Line(
      points={{-54,-20},{-50,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemFanSupOut.T, TFanSupOut) annotation (Line(
      points={{-60,-13.4},{-60,-92},{106,-92}},
      color={0,0,127},
      smooth=Smooth.None,
      visible=false));
  connect(IEH.port_b1, con.ports[1]) annotation (Line(points={{64,7.2},{62,7.2},
          {62,8},{72,8},{72,36.4}}, color={0,127,255}));
  connect(con.ports[2], valRecupTop.port_a)
    annotation (Line(points={{72,33.6},{72,44},{78,44}}, color={0,127,255}));
  connect(valBypassTop.port_a, resTop.port_b) annotation (Line(points={{78,66},{
          0,66},{0,20}},          color={0,127,255}));
  connect(IEH.port_a1, resTop.port_b)
    annotation (Line(points={{10,7.2},{0,7.2},{0,20}}, color={0,127,255}));
  connect(IEH.port_b2, eva.ports[1]) annotation (Line(points={{10,-25.2},{10,-44},
          {11.6,-44}}, color={0,127,255}));
  connect(valRecupBot.port_b, IEH.port_a2) annotation (Line(points={{72,-26},{67,
          -26},{67,-25.2},{64,-25.2}}, color={0,127,255}));
  connect(valBypassBottom.port_b, TSupIn.port_a)
    annotation (Line(points={{72,-68},{64,-68},{34,-68}}, color={0,127,255}));
  connect(TSupIn.port_b, resBot.port_a) annotation (Line(points={{22,-68},{0,-68},
          {0,-20}},   color={0,127,255}));
  connect(eva.ports[2], resBot.port_a) annotation (Line(points={{8.4,-44},{0,-44},
          {0,-20}},        color={0,127,255}));
  connect(theConEva.port_a, fixedTemperature.port)
    annotation (Line(points={{-76,0},{-100,0},{-100,6}}, color={191,0,0}));
  connect(theConEva.port_b, eva.heatPort) annotation (Line(
      points={{-64,0},{18,0},{18,-52}},
      color={191,0,0},
      visible=false));
  connect(theConCon.port_a, theConEva.port_a)
    annotation (Line(points={{-76,10},{-76,5},{-76,0}}, color={191,0,0}));
  connect(theConCon.port_b, conCon.port_b) annotation (Line(
      points={{-64,10},{-24,10},{-24,12},{56,12},{56,42}},
      color={191,0,0},
      visible=false));
  connect(PPum.y, sum.u[5]) annotation (Line(points={{61,88},{76.4,88},{76.4,91.28}},
        color={0,0,127}));
  connect(booleanConstant.y, valBypassTop.addPreDro) annotation (Line(points={{60.5,75},
          {68,75},{68,74.48},{82.8,74.48}},        color={255,0,255}));
  connect(valBypassTop.addPreDro, valRecupBot.addPreDro) annotation (Line(
        points={{82.8,74.48},{82.8,28.24},{83.2,28.24},{83.2,-17.52}}, color={
          255,0,255}));
  connect(valBypassBottom.addPreDro, valRecupBot.addPreDro) annotation (Line(
        points={{83.2,-59.52},{83.2,-37.76},{83.2,-17.52}}, color={255,0,255}));
  connect(PUnit.y, sum.u[1]) annotation (Line(points={{61,96},{62,96},{62,88.72},
          {76.4,88.72}}, color={0,0,127}));
  connect(com.port_a, eva.heatPort)
    annotation (Line(points={{22,42},{18,42},{18,-52}}, color={191,0,0}));
  connect(IEH.TOutBot, com.TinEva) annotation (Line(points={{66.16,-32.76},{34,-32.76},
          {34,50.8}}, color={0,0,127}));
  connect(onExp.y, adsCon.on) annotation (Line(points={{-63,74},{-63,75},{-44.4,
          75}}, color={255,0,255}));
  connect(Tset, adsCon.TSet) annotation (Line(
      points={{8,-102},{-44.4,-102},{-44.4,69}},
      color={0,0,127},
      visible=false));
  connect(IEH.TOutBot, adsCon.TIehOutSup) annotation (Line(
      points={{66.16,-32.76},{-19.76,-32.76},{-19.76,63},{-44.4,63}},
      color={0,0,127},
      visible=false));
  connect(adsCon.TFanOutSup, senTemFanSupOut.T) annotation (Line(
      points={{-44.4,66},{-60,66},{-60,-13.4}},
      color={0,0,127},
      visible=false));
  connect(adsCon.TIehInSup, TSupIn.T) annotation (Line(
      points={{-44.4,60},{-110,60},{-110,-61.4},{28,-61.4}},
      color={0,0,127},
      visible=false));
  connect(adsCon.TEvaOut, TEvaExp.y)
    annotation (Line(points={{-44.4,57},{-56,57},{-58.7,57},{-58.7,56}},
                                                       color={0,0,127}));
  connect(adsCon.onChi, com.on) annotation (Line(
      points={{-22,59},{-24,59},{-24,51},{28.8,51}},
      color={255,0,255},
      visible=false));
  connect(adsCon.mod, com.mod) annotation (Line(
      points={{-22,67},{23.6,67},{23.6,51}},
      color={0,0,127},
      visible=false));
  connect(adsCon.yBypTop, valBypassTop.y) annotation (Line(
      points={{-23,75.8},{6,75.8},{6,75.6},{86,75.6}},
      color={0,0,127},
      visible=false));
  connect(adsCon.yRecTop, valRecupTop.y) annotation (Line(
      points={{-23,74},{4,74},{4,53.6},{86,53.6}},
      color={0,0,127},
      visible=false));
  connect(adsCon.yBypBot, valBypassBottom.y) annotation (Line(
      points={{-23,70},{0,70},{0,-58.4},{80,-58.4}},
      color={0,0,127},
      visible=false));
  connect(adsCon.yRecBot, valRecupBot.y) annotation (Line(
      points={{-23,72},{80,72},{80,-16.4}},
      color={0,0,127},
      visible=false));
  connect(adsCon.onAdia, valRecupTop.addPreDro) annotation (Line(
      points={{-22,63},{82.8,63},{82.8,52.48}},
      color={255,0,255},
      visible=false));
  connect(adsCon.onAdia, IEH.adiabaticOn) annotation (Line(
      points={{-22,63},{-60,63},{-60,60},{65.08,60},{65.08,-9}},
      color={255,0,255},
      visible=false));
  connect(hexSupOut.port_a1, senTemFanSupOut.port_b) annotation (Line(points={{-72,-20},
          {-66,-20}},                color={0,127,255}));
  connect(fanTop.port_a, port_a1) annotation (Line(points={{-50,20},{-100,20},{-100,
          60}}, color={0,127,255}));
  connect(hexSupOut.port_b1, port_b2) annotation (Line(points={{-92,-20},{-100,-20},
          {-100,-60}}, color={0,127,255}));
  connect(valBypassBottom.port_a, port_a2) annotation (Line(points={{88,-68},{100,
          -68},{100,-60}}, color={0,127,255}));
  connect(valRecupBot.port_a, port_a2) annotation (Line(points={{88,-26},{100,-26},
          {100,-60}}, color={0,127,255}));
  connect(valRecupTop.port_b, port_b1)
    annotation (Line(points={{94,44},{100,44},{100,60}}, color={0,127,255}));
  connect(valBypassTop.port_b, port_b1)
    annotation (Line(points={{94,66},{100,66},{100,60}}, color={0,127,255}));
  connect(senRelPreBot.p_rel, fanBot.dpMea) annotation (Line(points={{-30,-71},
          {-30,-40},{-30,-8},{-32,-8}}, color={0,0,127}));
  connect(senRelPreTop.p_rel, fanTop.dpMea)
    annotation (Line(points={{-48,37},{-48,32}}, color={0,0,127}));
  connect(senRelPreBot.port_a, port_b2) annotation (Line(points={{-40,-80},{
          -100,-80},{-100,-60}}, color={0,127,255}));
  connect(senRelPreBot.port_b, port_a2) annotation (Line(points={{-20,-80},{100,
          -80},{100,-60}}, color={0,127,255}));
  connect(senRelPreTop.port_b, port_a1) annotation (Line(points={{-58,46},{-100,
          46},{-100,60}}, color={0,127,255}));
  connect(senRelPreTop.port_a, port_b1) annotation (Line(points={{-38,46},{4,46},
          {4,60},{100,60}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-102,65},{99,55}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,-55},{99,-65}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{0,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-56,78},{-22,44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-46,76},{-46,46},{-22,60},{-46,76}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-56,-42},{-22,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-32,-44},{-32,-74},{-56,-60},{-32,-44}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-12,-40},{-2,-80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{82,80},{92,40}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{80,-80}}, color={0,0,0}),
        Line(points={{80,80},{0,-80}}, color={0,0,0})}),
    experiment(
      StopTime=3000,
      Tolerance=0.001,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(revisions="<html>
<ul>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Improved adsolair controller performance.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/751\">#751</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/730\">#730</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/729\">#729</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/754\">#754</a>.
</li>
<li>
April 27, 2017, by Filip Jorissen:<br/>
Removed thermal resistors at pumps. 
These are no longer required since movers are regularised 
such that they dissipate no power at zero flow.
</li>
<li>
April 27, 2017, by Filip Jorissen:<br/>
Made compressor model replaceable.
See <a href=https://github.com/open-ideas/IDEAS/issues/719>#719</a>.
</li>
<li>
October 11, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Validated model of Menerga type 58 air handling unit with a nominal air flow rate of 14200m3/h.
This is not a generic model, but a detailed model of a single air handling unit.
</p>
<h4>Main equations</h4>
<p>
See references.
</p>
<h4>Assumption and limitations</h4>
<p>
Flow reversal is not supported. Dynamics are simplified. The chiller contains hard-coded performance data.
</p>
<h4>Typical use and important parameters</h4>
<p>
When using the model a temperature set point and the supply/return pressure
set points need to be provided.
The unit can either be configured to be always on, or an additional boolean
input may be used to control the status of the unit.
Parameter <code>per</code> allows setting the type-specific performance data of the unit.
Additional pressure drop due to fouling of filters may be specified.
Other parameters were calibrated in the validation.
</p>
<h4>Options</h4>
<p>
Parameters k1 and alpha were calibrated.
An additional heat exchanger may be added by redeclaring <code>hexSupOut</code>.
The controller model may be changed by redeclaring <code>adsCon</code>.
</p>
<h4>Dynamics</h4>
<p>
The evaporator, condensor and indirect evaporative heat exchanger contain dynamics.
Furthermore some temperature sensors contain dynamics and the PI controllers contain a
state for the integrator.
All these states have a time constant in the order of 1 minute by default.
</p>
<h4>Validation</h4>
<p>
This model has been validated using measurement data.
See the references for a detailed discussion.
</p>
<h4>References</h4>
<p>
For more information and the model validation see
</p>
<p>
<a href=http://www.tandfonline.com/doi/full/10.1080/19401493.2016.1273391>
Jorissen, F. and Boydens, W. and Helsen, L. 
Validated Air Handling Unit Model using Indirect Evaporative Cooling. 
Journal of Building Performance Simulation (2017).
</a>
</p>
</html>"));
end Adsolair58;
