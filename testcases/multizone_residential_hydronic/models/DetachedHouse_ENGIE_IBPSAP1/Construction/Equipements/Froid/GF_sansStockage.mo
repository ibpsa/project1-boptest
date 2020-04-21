within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Froid;
model GF_sansStockage

    replaceable package Refrigerant =
      Construction.Media.MG30_simplified
    "Medium in the component"
      annotation (choicesAllMatching = true);
  replaceable package Medium =
  Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  parameter Modelica.SIunits.SpecificHeatCapacity Cp = 3350
    "Specific heat capacity of the fluid";

  parameter Modelica.SIunits.Density rho = 1054;
  parameter Modelica.SIunits.MassFlowRate m_a = 194628*1.225/3600;
  parameter Modelica.SIunits.MassFlowRate mf = 92.8*1054/3600;
  parameter Modelica.SIunits.MassFlowRate md = 86*rho/3600;
  parameter Modelica.SIunits.Temperature Tfi = 273.15+10;
  parameter Modelica.SIunits.Temperature Tfo = 273.15+5;
  parameter Modelica.SIunits.Temperature Tai = 273.15+35;

  Modelica.SIunits.MassFlowRate mf_voulu;
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
  Modelica.SIunits.Power Pf2 "Power produced by the refrigerator";
  Modelica.SIunits.Power P_fnom
    "Nominal power production of the refrigerator";

  Modelica.SIunits.Temperature T_di "Distribution inlet fluid temperature";
  Modelica.SIunits.Temperature T_do "Distribution outlet fluid temperature";
  Modelica.SIunits.MassFlowRate m_d
    "Mass flow rate of the fluid across the distribution";
  Modelica.SIunits.Power P_dem "Power demand";
  Modelica.SIunits.Power P_reel "Power produced";

  Real chi_on;

  Modelica.Fluid.Machines.ControlledPump
                          pump1(
    N_nominal=1500,
    use_m_flow_set=true,
    redeclare package Medium = Refrigerant,
    p_a_start=110000,
    p_b_start=130000,
    m_flow_start=mf,
    p_a_nominal=110000,
    p_b_nominal=130000,
    m_flow_nominal=mf)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=0,
        origin={-82,-50})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=T_fo_voulu)
    annotation (Placement(transformation(extent={{-250,30},{-236,46}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    use_T_in=true,
    nPorts=1,
    m_flow=m_a,
    use_m_flow_in=false)
    annotation (Placement(transformation(extent={{-240,62},{-220,82}})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, nPorts=1)
    annotation (Placement(transformation(extent={{-250,-24},{-230,-4}})));
  Buildings.Fluid.Storage.ExpansionVessel exp(
                                         V_start=2, redeclare package Medium =
        Refrigerant)
    annotation (Placement(transformation(extent={{2,2},{-14,-14}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true,
    homotopyInitialization=false,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Refrigerant,
    m1_flow_nominal=mf,
    m2_flow_nominal=md,
    dp1_nominal=300,
    dp2_nominal=300,
    eps=0.717)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={28,16})));
  Modelica.Fluid.Sensors.Temperature Temperature_do(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{50,-14},{70,6}})));
  Modelica.Fluid.Sensors.Temperature To_e(redeclare package Medium =
        Refrigerant)
    annotation (Placement(transformation(extent={{-192,26},{-172,46}})));
  Modelica.Fluid.Sensors.Temperature Ti_e(redeclare package Medium =
        Refrigerant)
    annotation (Placement(transformation(extent={{-188,-2},{-168,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=T_ai_voulu)
    annotation (Placement(transformation(extent={{-268,68},{-254,84}})));
  Buildings.Fluid.Chillers.ElectricEIR refrigerator(
    redeclare package Medium1 = Modelica.Media.Air.SimpleAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    show_T=true,
    redeclare package Medium2 = Refrigerant,
    per=datChi1,
    m2_flow_nominal=mf,
    m1_flow_nominal=m_a,
    dp1_nominal=6000,
    dp2_nominal=6000)    "Chiller model"
                            annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-208,8})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean2
    annotation (Placement(transformation(extent={{-250,16},{-238,28}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=chi_on)
    annotation (Placement(transformation(extent={{-276,-8},{-262,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)     annotation (Placement(transformation(rotation=0, extent={{92,-48},
            {112,-28}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)     annotation (Placement(transformation(rotation=0, extent={{92,62},
            {112,82}})));
  parameter
    Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_McQuay_PEH_819kW_8_11COP_Vanes
    datChi1(
    PLRMax=1,
    mCon_flow_nominal=m_a,
    mEva_flow_nominal=mf,
    QEva_flow_nominal=-514000,
    COP_nominal=2.91,
    TEvaLvgMin=Tfo - 5,
    TEvaLvgMax=Tfo + 5,
    TConEnt_nominal=Tai,
    TConEntMin=Tai - 5,
    TConEntMax=Tai + 5,
    TEvaLvg_nominal(displayUnit="degC") = 278.15,
    capFunT={7.594375,0.03,-0.005,0.03,-0.01,0.026175},
    EIRFunT=1/1.2*{6.3925,-1.961,0.1275,-0.5,0.001,0.1},
    EIRFunPLR=1/1.2*{1.7359,0.2641,-1})
    annotation (Placement(transformation(extent={{-168,76},{-148,96}})));
  Modelica.Fluid.Sensors.Temperature Temperature_di1(redeclare package Medium
      = Refrigerant)
    annotation (Placement(transformation(extent={{-18,20},{2,40}})));
  Modelica.Fluid.Sensors.Temperature Temperature_di2(redeclare package Medium
      = Refrigerant)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=mf)
    annotation (Placement(transformation(extent={{-130,20},{-116,36}})));
  Profils.ProfilHPHC_Jaune profilHPHC_Jaune
    annotation (Placement(transformation(extent={{-38,76},{-18,92}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-82,4},{-62,24}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.001)
    annotation (Placement(transformation(extent={{-138,-50},{-124,-34}})));
  Buildings.Controls.Continuous.LimPID conPID2(
    Td=1,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    strict=true,
    yMax=273.15 + 40,
    xi_start=Tai,
    yMin=273.15 + 15,
    Ti=1e-2,
    k=1)        "Controller for cooling"
    annotation (Placement(transformation(extent={{-238,108},{-230,116}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=datChi1.COP_nominal)
    annotation (Placement(transformation(extent={{-270,92},{-256,108}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=abs(refrigerator.COP))
    annotation (Placement(transformation(extent={{-270,104},{-256,120}})));
  Modelica.Fluid.Sensors.Temperature Temperature_di(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{52,30},{72,50}})));
equation

  T_fi = Ti_e.T;
  T_fo = To_e.T;
  m_f = refrigerator.port_a2.m_flow;
  P_f = m_f * Cp * (T_fi-T_fo)/3750*4185;

  Pf2 = hex.m2_flow*Cp*(Temperature_di2.T-Temperature_di1.T);
  P_fnom = mf_voulu * Cp * (T_fi_voulu-T_fo_voulu);

  T_di = 273.15+7;
  T_do = Temperature_do.T;
  m_d = port_a.m_flow;
  P_dem = m_d * Cp * (T_do-T_di);
  P_reel = abs(m_d * 4185 * (Temperature_do.T-Temperature_di.T));

  // Spcifits de fonctionnement
  T_fi_voulu = Tfi;
  T_fo_voulu = Tfo;
  T_ai_voulu = Tai;
  mf_voulu = mf;

  if (profilHPHC_Jaune.y <= 1.5) then
    chi_on = 0;
  elseif (m_d > 0.01) then
    chi_on = 1;
  else
    chi_on = 0;
  end if;

  connect(Temperature_do.port, hex.port_a1)
    annotation (Line(points={{60,-14},{34,-14},{34,6}}, color={0,127,255}));
  connect(Ti_e.port, pump1.port_b) annotation (Line(points={{-178,-2},{-192,-2},
          {-202,-2},{-202,-50},{-92,-50}},            color={0,127,255}));
  connect(refrigerator.port_a2, pump1.port_b) annotation (Line(points={{-202,-2},
          {-202,-2},{-202,-24},{-202,-50},{-92,-50}}, color={0,127,255}));
  connect(bou.ports[1], refrigerator.port_b1) annotation (Line(points={{-230,
          -14},{-214,-14},{-214,-2}},
                                color={0,127,255}));
  connect(refrigerator.port_a1, boundary.ports[1]) annotation (Line(points={{-214,18},
          {-214,18},{-214,56},{-214,72},{-220,72}},     color={0,127,255}));
  connect(refrigerator.TSet, realExpression2.y) annotation (Line(points={{-205,20},
          {-205,38},{-235.3,38}}, color={0,0,127}));
  connect(To_e.port, refrigerator.port_b2) annotation (Line(points={{-182,26},
          {-190,26},{-190,24},{-202,24},{-202,18}},
                                              color={0,127,255}));
  connect(realToBoolean2.y, refrigerator.on) annotation (Line(points={{-237.4,
          22},{-211,22},{-211,20}},
                                color={255,0,255}));
  connect(port_b,port_b)
    annotation (Line(points={{102,72},{102,72}}, color={0,127,255}));
  connect(port_a,port_a)
    annotation (Line(points={{102,-38},{102,-38}}, color={0,127,255}));
  connect(hex.port_a1, port_a)
    annotation (Line(points={{34,6},{34,-38},{102,-38}}, color={0,127,255}));
  connect(pump1.port_a, hex.port_b2) annotation (Line(points={{-72,-50},{-72,-50},
          {22,-50},{22,6}},          color={0,127,255}));
  connect(realExpression10.y, realToBoolean2.u) annotation (Line(points={{-261.3,
          0},{-256,0},{-256,22},{-251.2,22}},
                                        color={0,0,127}));
  connect(Temperature_di2.port, hex.port_b2) annotation (Line(points={{-32,-40},
          {22,-40},{22,6}},        color={0,127,255}));
  connect(Temperature_di1.port, hex.port_a2) annotation (Line(points={{-8,20},{8,
          20},{8,26},{22,26}}, color={0,127,255}));
  connect(Ti_e.port, refrigerator.port_a2)
    annotation (Line(points={{-178,-2},{-202,-2}}, color={0,127,255}));
  connect(refrigerator.port_b2, hex.port_a2) annotation (Line(points={{-202,18},
          {-202,18},{-202,64},{22,64},{22,26}},           color={0,127,255}));
  connect(exp.port_a, hex.port_b2) annotation (Line(points={{-6,2},{8,2},{8,
          6},{22,6}}, color={0,127,255}));
  connect(realToBoolean2.y, switch1.u2) annotation (Line(points={{-237.4,22},
          {-154,22},{-154,14},{-84,14}}, color={255,0,255}));
  connect(realExpression1.y, switch1.u3) annotation (Line(points={{-123.3,
          -42},{-110,-42},{-110,-26},{-84,-26},{-84,6}}, color={0,0,127}));
  connect(realExpression4.y,conPID2. u_s) annotation (Line(points={{-255.3,
          112},{-246,112},{-238.8,112}},
                                      color={0,0,127}));
  connect(realExpression3.y,conPID2. u_m) annotation (Line(points={{-255.3,
          100},{-234,100},{-234,102},{-234,107.2}},color={0,0,127}));
  connect(conPID2.y, boundary.T_in) annotation (Line(points={{-229.6,112},{
          -206,112},{-206,92},{-242,92},{-242,76}}, color={0,0,127}));
  connect(switch1.y, pump1.m_flow_set) annotation (Line(points={{-61,14},{
          -52,14},{-52,12},{-52,-22},{-77,-22},{-77,-41.8}}, color={0,0,127}));
  connect(Temperature_di.port, hex.port_b1) annotation (Line(points={{62,30},
          {48,30},{48,26},{34,26}}, color={0,127,255}));
  connect(hex.port_b1, port_b) annotation (Line(points={{34,26},{36,26},{36,
          58},{36,72},{102,72}}, color={0,127,255}));
  connect(realExpression6.y, switch1.u1) annotation (Line(points={{-115.3,
          28},{-100,28},{-100,22},{-84,22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},
            {100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-100},{100,100}})));
end GF_sansStockage;
