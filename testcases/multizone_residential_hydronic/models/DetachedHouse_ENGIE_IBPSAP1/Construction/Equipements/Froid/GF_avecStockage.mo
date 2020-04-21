within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Froid;
model GF_avecStockage

    replaceable package Refrigerant =
      Construction.Media.MG30_simplified
    "Medium in the component"
      annotation (choicesAllMatching = true);
  replaceable package Medium =
  Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  parameter Modelica.SIunits.SpecificHeatCapacity Cp = 3790
    "Specific heat capacity of the fluid";

  parameter Modelica.SIunits.Density rho = 1054;
  parameter Modelica.SIunits.MassFlowRate m_a=64876*1.225/3600;
  parameter Modelica.SIunits.MassFlowRate mf_1=47.1*rho/3600;
  parameter Modelica.SIunits.MassFlowRate mf_2=59.2*rho/3600;
  parameter Modelica.SIunits.Temperature T_fi_1 = 273.15+10;
  parameter Modelica.SIunits.Temperature T_fi_2 = 273.15-2.4;
  parameter Modelica.SIunits.Temperature T_fo_1 = 273.15+5;
  parameter Modelica.SIunits.Temperature T_fo_2 = 273.15-5.8;
  parameter Modelica.SIunits.Temperature T_ai_1 = 273.15+35;
  parameter Modelica.SIunits.Temperature T_ai_2 = 273.15+20;
  parameter Modelica.SIunits.MassFlowRate ms = 44*rho/3600;
  parameter Modelica.SIunits.MassFlowRate md = 86*rho/3600;

  Modelica.SIunits.MassFlowRate mf_voulu;
  Modelica.SIunits.MassFlowRate ms_voulu;
  Modelica.SIunits.Temperature T_fi_voulu;
  Modelica.SIunits.Temperature T_fo_voulu;
  Modelica.SIunits.Temperature T_ai_voulu;

  Modelica.SIunits.Temperature T_fi "Refrigerator inlet fluid temperature";
  Modelica.SIunits.Temperature T_fo "Refrigerator outlet fluid temperature";
  Modelica.SIunits.MassFlowRate m_f
    "Mass flow rate of the fluid across the refrigerator";
  parameter Modelica.SIunits.MassFlowRate m_fnom = 1
    "Nominal mass flow rate of the refrigerator";
  Modelica.SIunits.Power P_f "Power produced by the refrigerator";
  Modelica.SIunits.Power P_fnom
    "Nominal power production of the refrigerator";

  Modelica.SIunits.Temperature T_di "Distribution inlet fluid temperature";
  Modelica.SIunits.Temperature T_do "Distribution outlet fluid temperature";
  Modelica.SIunits.MassFlowRate m_d
    "Mass flow rate of the fluid across the distribution";
  Modelica.SIunits.Power P_dem "Power demand";

  Modelica.SIunits.Temperature T_si "Storage inlet fluid temperature";
  Modelica.SIunits.Temperature T_so "Storage outlet fluid temperature";
  Modelica.SIunits.MassFlowRate m_s
    "Mass flow rate of the fluid across the storage";
  Modelica.SIunits.Power P_s "Power charged/discharged by the storage";

  Real mode_sto;
  Real x;
  Real chi_on;
  Real Pf2;
  Real P_reel;

   import Construction.Equipements.Froid.ModeTypes;
   Construction.Equipements.Froid.ModeTypes mode
    "operating mode of the network";

  Modelica.Fluid.Machines.ControlledPump
                          pump1(
    use_m_flow_set=true,
    redeclare package Medium = Refrigerant,
    m_flow_nominal=mf_1,
    m_flow_start=mf_1,
    allowFlowReversal=false,
    rho_nominal=rho,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=0.8),
    p_a_start=110000,
    p_b_start=130000,
    T_start=278.15,
    p_a_nominal=110000,
    p_b_nominal=130000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=0,
        origin={-140,-62})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=T_fo_voulu)
    annotation (Placement(transformation(extent={{-250,30},{-236,46}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    use_T_in=true,
    nPorts=1,
    m_flow=m_a)
    annotation (Placement(transformation(extent={{-242,62},{-222,82}})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, nPorts=1)
    annotation (Placement(transformation(extent={{-250,-26},{-230,-6}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Refrigerant,
    eps=0.717,
    dp2_nominal=0,
    from_dp1=true,
    dp1_nominal=200,
    m1_flow_nominal=md,
    m2_flow_nominal=mf_1)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={28,16})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=mode_sto)
    annotation (Placement(transformation(extent={{-164,28},{-150,44}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-120,30},{-108,42}})));
  Stockage.LatentHeatStorage latentHeatStorage(
    V=22,
    L=4.91,
    f=0.28,
    CpL_pcm=7071,
    rho_pcm=560,
    T_0(displayUnit="degC") = 273.15,
    T_qzero(displayUnit="degC") = 273.15,
    redeclare package Medium = Refrigerant,
    h_sat=311143,
    CpS_pcm=4564,
    Cp_htf=3370,
    rho_htf=1033,
    k_htf=0.486417,
    v_htf=2.225e-6,
    T_sat=273.15) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-95,17})));
  Modelica.Fluid.Sensors.Temperature To_e(redeclare package Medium =
        Refrigerant)
    annotation (Placement(transformation(extent={{-192,26},{-172,46}})));
  Profils.ProfilHPHC_Jaune profilHPHC_Jaune
    annotation (Placement(transformation(extent={{-42,76},{-22,92}})));
  Buildings.Fluid.Chillers.ElectricEIR refrigerator(
    redeclare package Medium1 = Modelica.Media.Air.SimpleAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    show_T=true,
    redeclare package Medium2 = Refrigerant,
    per=datChi1,
    m2_flow_nominal=mf_1,
    m1_flow_nominal=m_a,
    allowFlowReversal1=false,
    from_dp1=true,
    from_dp2=true,
    dp1_nominal=200,
    dp2_nominal=0) "Chiller model"
                            annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-208,12})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean2
    annotation (Placement(transformation(extent={{-248,18},{-236,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=chi_on)
    annotation (Placement(transformation(extent={{-276,16},{-262,32}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)     annotation (Placement(transformation(rotation=0, extent={{92,-48},
            {112,-28}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)     annotation (Placement(transformation(rotation=0, extent={{92,62},
            {112,82}})));
  parameter
    Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_McQuay_PEH_819kW_8_11COP_Vanes
    datChi1(
    COP_nominal=2.48,
    PLRMax=1,
    QEva_flow_nominal=-260700,
    EIRFunPLR={1.7359,0.2641,-1},
    mEva_flow_nominal=mf_1,
    mCon_flow_nominal=m_a,
    TEvaLvgMin=T_fo_2 - 5,
    TEvaLvgMax=T_fo_1 + 5,
    TConEnt_nominal=T_ai_1,
    TConEntMin=T_ai_2 - 5,
    TConEntMax=T_ai_1 + 5,
    EIRFunT={6.3925,-1.961,0.1275,-0.5,0.001,0.1},
    capFunT={7.594375,0.03,-0.005,0.03,-0.01,0.026175},
    TEvaLvg_nominal=278.15)
    annotation (Placement(transformation(extent={{-84,76},{-64,96}})));
  Buildings.Fluid.FixedResistances.Junction valLin(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare package Medium = Refrigerant,
    m_flow_nominal={-1,-1,-1},
    dp_nominal={0,0,0},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    T_start=278.15)
    "Valve model, linear opening characteristics"
    annotation (Placement(transformation(extent={{-124,50},{-104,70}})));
  Modelica.Fluid.Machines.ControlledPump
                          pump2(
    use_m_flow_set=true,
    m_flow_start=ms,
    m_flow_nominal=ms,
    redeclare package Medium = Refrigerant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    rho_nominal=rho,
    p_a_start=110000,
    p_b_start=130000,
    T_start=278.15,
    p_a_nominal=110000,
    p_b_nominal=130000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0,
        origin={-86,-22})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=ms_voulu)
    annotation (Placement(transformation(extent={{-158,-14},{-144,2}})));
  Buildings.Fluid.FixedResistances.Junction valLin1(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare package Medium = Refrigerant,
    m_flow_nominal={-1,-1,-1},
    dp_nominal={0,0,0},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    T_start=278.15)
    "Valve model, linear opening characteristics" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-62})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
                                         V_start=2, redeclare package Medium =
        Refrigerant,
    T_start=278.15)
    annotation (Placement(transformation(extent={{-78,-78},{-94,-94}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=mf_voulu)
    annotation (Placement(transformation(extent={{-178,-44},{-164,-28}})));
  Modelica.Fluid.Sensors.Temperature Temperature_di1(redeclare package Medium
      = Refrigerant)
    annotation (Placement(transformation(extent={{-2,22},{18,42}})));
  Modelica.Fluid.Sensors.Temperature Temperature_di2(redeclare package Medium
      = Refrigerant)
    annotation (Placement(transformation(extent={{-10,-32},{10,-12}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temperature_di(
    redeclare package Medium = Medium,
    m_flow_nominal=md,
    allowFlowReversal=false,
    tau=1e-3)                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,72})));

  Buildings.Controls.Continuous.LimPID conPID(
    Td=1,
    yMax=ms,
    strict=true,
    yMin=0.001,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    reverseAction=true,
    k=1e-3,
    Ti=1)       "Controller for cooling"
    annotation (Placement(transformation(extent={{-178,-76},{-170,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Pf2)
    annotation (Placement(transformation(extent={{-208,-80},{-194,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=P_dem)
    annotation (Placement(transformation(extent={{-208,-100},{-194,-84}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(                                                 T=1, initType=
       Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-126,-16},{-106,4}})));
  Modelica.Fluid.Sensors.Temperature Temperature_do(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{54,-28},{74,-8}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Refrigerant,
    m_flow_nominal=mf_1,
    dp_nominal=50)
    annotation (Placement(transformation(extent={{-180,50},{-160,70}})));
  Buildings.Controls.Continuous.LimPID conPID1(
    Td=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    strict=true,
    yMax=273.15 + 40,
    Ti=1e1,
    y_start=T_ai_1,
    xi_start=T_ai_1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=1e-2,
    yMin=273.15 + 15)
                "Controller for cooling"
    annotation (Placement(transformation(extent={{-242,116},{-234,124}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=2.48)
    annotation (Placement(transformation(extent={{-274,100},{-260,116}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=abs(refrigerator.COP))
    annotation (Placement(transformation(extent={{-274,114},{-260,130}})));
  Buildings.Controls.Continuous.LimPID conPID3(
    Td=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    strict=true,
    yMax=273.15 + 40,
    Ti=1e1,
    y_start=T_ai_1,
    xi_start=T_ai_1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=1e-2,
    yMin=273.15 + 20)
                "Controller for cooling"
    annotation (Placement(transformation(extent={{-232,146},{-224,154}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=2.9)
    annotation (Placement(transformation(extent={{-264,130},{-250,146}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(
                                                         y=abs(refrigerator.COP))
    annotation (Placement(transformation(extent={{-264,144},{-250,160}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-204,116},{-184,136}})));
  Modelica.Fluid.Sensors.Temperature Temperature_entree_stockage(redeclare
      package Medium = Refrigerant)
    annotation (Placement(transformation(extent={{-80,32},{-60,52}})));
  Modelica.Fluid.Sensors.Temperature Temperature_sortie_stockage(redeclare
      package Medium = Refrigerant)
    annotation (Placement(transformation(extent={{-64,-4},{-44,16}})));
  Modelica.Fluid.Sensors.Temperature Ti_e(redeclare package Medium =
        Refrigerant)
    annotation (Placement(transformation(extent={{-192,-12},{-172,8}})));
  Buildings.Controls.Continuous.LimPID conPID2(
    Td=1,
    strict=true,
    yMin=0.001,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=1,
    yMax=mf_1,
    reverseAction=false)
                "Controller for cooling"
    annotation (Placement(transformation(extent={{-234,-76},{-226,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=Pf2)
    annotation (Placement(transformation(extent={{-264,-80},{-250,-64}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=P_dem)
    annotation (Placement(transformation(extent={{-264,-100},{-250,-84}})));
equation
  T_fi = Ti_e.T;
  T_fo = To_e.T;
  m_f = refrigerator.port_a2.m_flow;
  P_f = m_f * Cp * (T_fi-T_fo);

  T_di = 273.15+7;
  T_do = Temperature_do.T;
  m_d = port_a.m_flow;
  P_dem = m_d * Cp * (T_do-T_di);

  T_si = latentHeatStorage.TI_htf;
  T_so = latentHeatStorage.TO_htf;
  m_s = latentHeatStorage.m_htf;
  P_s = m_s * Cp * (T_si-T_so);

  // Mode de fonctionnement

  if (profilHPHC_Jaune.y <= 1.5) then
    if latentHeatStorage.N_stock < 0.99 then
      mode = ModeTypes.c;
    else
      mode = ModeTypes.pc;
    end if;
  elseif (m_d > 0.01) then
    if (profilHPHC_Jaune.y > 2.5) then
      if latentHeatStorage.N_stock < 0.01 then
         mode = ModeTypes.p;
       else
         mode = ModeTypes.d;
       end if;
    else
      if latentHeatStorage.N_stock > 0.01 then
          if P_reel < P_fnom then
            mode = ModeTypes.d;
          else
            mode = ModeTypes.pd;
          end if;
        else
        mode = ModeTypes.p;
      end if;
    end if;
  else
    mode = ModeTypes.pc;
  end if;

  // Spcificits de chaque mode de fonctionnement
  if mode == ModeTypes.c then
    x = 0.001;
    mode_sto = 1;
    mf_voulu = mf_2;
    ms_voulu = -(1-x)*mf_voulu;
    T_fi_voulu = T_fi_2;
    T_fo_voulu = T_fo_2;
    T_ai_voulu = T_ai_2;
    chi_on = 1;
    P_fnom = mf_voulu*Cp*5;
   elseif mode == ModeTypes.pc then
    x = 0.001;
    mode_sto = 1;
    mf_voulu = mf_2;
    ms_voulu = -(1-x)*mf_voulu;
    T_fi_voulu = T_fi_2;
    T_fo_voulu = T_fo_2;
    T_ai_voulu = T_ai_2;
    chi_on = 0;
    P_fnom = mf_voulu*Cp*5;
  elseif mode == ModeTypes.p then
    x = 0.999;
    mode_sto = 0;
    mf_voulu = mf_1;
    ms_voulu = 0.001;
    T_fi_voulu = T_fi_1;
    T_fo_voulu = T_fo_1;
    T_ai_voulu = T_ai_1;
    chi_on = 1;
    P_fnom = mf_voulu*Cp*5;
  elseif mode == ModeTypes.pd then
    x = 1;
    mode_sto = 0;
    mf_voulu = conPID2.y;
    ms_voulu = ms;
    T_fi_voulu = T_fi_1;
    T_fo_voulu = T_fo_1;
    T_ai_voulu = T_ai_1;
    chi_on = 1;
    P_fnom = (mf_1+ms)*Cp*5;
  else
    x = 1;
    mode_sto = 0;
    mf_voulu = 0.001;
    ms_voulu = conPID.y;
    T_fi_voulu = T_fi_1;
    T_fo_voulu = T_fo_1;
    T_ai_voulu = T_ai_1;
    chi_on = 0;
    P_fnom = ms*Cp*5;
  end if;

Pf2 = hex.m2_flow*Cp*(Temperature_di2.T-Temperature_di1.T);

P_reel = abs(m_d*4185*(Temperature_do.T-Temperature_di.T));

  connect(latentHeatStorage.charge, realToBoolean1.y) annotation (Line(points={{-95,
          26.36},{-95,36},{-107.4,36}},      color={255,0,255}));
  connect(bou.ports[1], refrigerator.port_b1) annotation (Line(points={{-230,-16},
          {-214,-16},{-214,2}}, color={0,127,255}));
  connect(refrigerator.port_a1, boundary.ports[1]) annotation (Line(points={{-214,22},
          {-214,22},{-214,56},{-214,72},{-222,72}},     color={0,127,255}));
  connect(refrigerator.TSet, realExpression2.y) annotation (Line(points={{-205,24},
          {-205,38},{-235.3,38}}, color={0,0,127}));
  connect(To_e.port, refrigerator.port_b2) annotation (Line(points={{-182,26},{-190,
          26},{-190,24},{-202,24},{-202,22}}, color={0,127,255}));
  connect(realToBoolean2.y, refrigerator.on) annotation (Line(points={{-235.4,
          24},{-211,24}},       color={255,0,255}));
  connect(port_b,port_b)
    annotation (Line(points={{102,72},{102,72}}, color={0,127,255}));
  connect(port_a,port_a)
    annotation (Line(points={{102,-38},{102,-38}}, color={0,127,255}));
  connect(valLin.port_3, latentHeatStorage.port_a) annotation (Line(points={{-114,50},
          {-114,17},{-104.9,17}},     color={0,127,255}));
  connect(valLin.port_2, hex.port_a2) annotation (Line(points={{-104,60},{
          -44,60},{22,60},{22,26}},  color={0,127,255}));
  connect(valLin1.port_3, pump2.port_a) annotation (Line(points={{-100,-52},{-100,
          -22},{-96,-22}}, color={0,127,255}));
  connect(valLin1.port_1, hex.port_b2) annotation (Line(points={{-90,-62},{
          -52,-62},{22,-62},{22,6}},  color={0,127,255}));
  connect(pump1.port_a, valLin1.port_2) annotation (Line(points={{-130,-62},
          {-130,-62},{-128,-62},{-110,-62}},                 color={0,127,255}));
  connect(Temperature_di1.port, hex.port_a2) annotation (Line(points={{8,22},{16,
          22},{16,26},{22,26}}, color={0,127,255}));
  connect(Temperature_di2.port, hex.port_b2) annotation (Line(points={{0,-32},{12,
          -32},{12,6},{22,6}}, color={0,127,255}));
  connect(hex.port_b1, Temperature_di.port_a)
    annotation (Line(points={{34,26},{34,72},{52,72}}, color={0,127,255}));
  connect(Temperature_di.port_b, port_b)
    annotation (Line(points={{72,72},{102,72}}, color={0,127,255}));
  connect(realExpression1.y, conPID.u_s) annotation (Line(points={{-193.3,
          -72},{-178.8,-72}},            color={0,0,127}));
  connect(realExpression4.y, conPID.u_m) annotation (Line(points={{-193.3,-92},{
          -174,-92},{-174,-76.8}},       color={0,0,127}));
  connect(realExpression12.y, firstOrder.u) annotation (Line(points={{-143.3,-6},
          {-128,-6}},           color={0,0,127}));
  connect(firstOrder.y, pump2.m_flow_set) annotation (Line(points={{-105,-6},{-105,
          -6},{-91,-6},{-91,-13.8}}, color={0,0,127}));
  connect(exp2.port_a, pump2.port_b) annotation (Line(points={{-86,-78},{
          -68,-78},{-68,-22},{-76,-22}}, color={0,127,255}));
  connect(port_a, hex.port_a1) annotation (Line(points={{102,-38},{74,-38},
          {74,-40},{34,-40},{34,6}}, color={0,127,255}));
  connect(Temperature_do.port, hex.port_a1) annotation (Line(points={{64,
          -28},{64,-40},{34,-40},{34,6}}, color={0,127,255}));
  connect(valLin.port_1, res.port_b)
    annotation (Line(points={{-124,60},{-160,60}}, color={0,127,255}));
  connect(res.port_a, refrigerator.port_b2) annotation (Line(points={{-180,
          60},{-202,60},{-202,22}}, color={0,127,255}));
  connect(latentHeatStorage.port_b, pump2.port_b) annotation (Line(points={
          {-85.1,17},{-68,17},{-68,-22},{-76,-22}}, color={0,127,255}));
  connect(realExpression7.y,conPID1. u_m) annotation (Line(points={{-259.3,
          108},{-238,108},{-238,110},{-238,115.2}},color={0,0,127}));
  connect(realExpression9.y, conPID1.u_s) annotation (Line(points={{-259.3,
          122},{-250,122},{-250,120},{-242.8,120}}, color={0,0,127}));
  connect(switch1.y, boundary.T_in) annotation (Line(points={{-183,126},{
          -170,126},{-170,128},{-162,128},{-162,96},{-256,96},{-256,76},{
          -244,76}}, color={0,0,127}));
  connect(realToBoolean1.y, switch1.u2) annotation (Line(points={{-107.4,36},
          {-94,36},{-94,146},{-222,146},{-222,126},{-206,126}}, color={255,
          0,255}));
  connect(conPID1.y, switch1.u3) annotation (Line(points={{-233.6,120},{
          -222,120},{-222,118},{-206,118}}, color={0,0,127}));
  connect(conPID3.y, switch1.u1) annotation (Line(points={{-223.6,150},{
          -218,150},{-218,134},{-206,134}}, color={0,0,127}));
  connect(realExpression11.y, conPID3.u_s) annotation (Line(points={{-249.3,
          152},{-242,152},{-242,150},{-232.8,150}}, color={0,0,127}));
  connect(realExpression5.y, conPID3.u_m) annotation (Line(points={{-249.3,
          138},{-228,138},{-228,145.2}}, color={0,0,127}));
  connect(realExpression14.y, realToBoolean1.u) annotation (Line(points={{-149.3,
          36},{-121.2,36},{-121.2,36}}, color={0,0,127}));
  connect(realExpression10.y, realToBoolean2.u)
    annotation (Line(points={{-261.3,24},{-249.2,24}}, color={0,0,127}));
  connect(Temperature_entree_stockage.port, latentHeatStorage.port_a)
    annotation (Line(points={{-70,32},{-114,32},{-114,17},{-104.9,17}}, color={0,
          127,255}));
  connect(Temperature_sortie_stockage.port, pump2.port_b) annotation (Line(
        points={{-54,-4},{-68,-4},{-68,-22},{-76,-22}}, color={0,127,255}));
  connect(realExpression3.y, pump1.m_flow_set) annotation (Line(points={{-163.3,
          -36},{-135,-36},{-135,-53.8}}, color={0,0,127}));
  connect(pump1.port_b, refrigerator.port_a2) annotation (Line(points={{
          -150,-62},{-202,-62},{-202,2}}, color={0,127,255}));
  connect(Ti_e.port, refrigerator.port_a2) annotation (Line(points={{-182,
          -12},{-192,-12},{-192,-2},{-192,2},{-202,2}}, color={0,127,255}));
  connect(realExpression6.y, conPID2.u_s)
    annotation (Line(points={{-249.3,-72},{-234.8,-72}}, color={0,0,127}));
  connect(realExpression8.y, conPID2.u_m) annotation (Line(points={{-249.3,-92},
          {-230,-92},{-230,-76.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},
            {100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-100},{100,100}})));
end GF_avecStockage;
