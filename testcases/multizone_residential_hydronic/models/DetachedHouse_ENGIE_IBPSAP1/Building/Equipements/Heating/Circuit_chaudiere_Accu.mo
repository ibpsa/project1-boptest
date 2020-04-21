within DetachedHouse_ENGIE_IBPSAP1.Building.Equipements.Heating;
model Circuit_chaudiere_Accu
  import Buildings;
  import Cyclage_chaudiere;
  import Construction;

protected
 package MediumW = Buildings.Media.Water "Medium model";
 parameter Real m_flow_in = 0.05;

 // Général
 parameter Modelica.SIunits.Area S = 100 "Surface chauffée du bâtiment";

 // Production ECS

 parameter Modelica.SIunits.Temperature T_EF = 273.15+15 "Température de l'eau froide" annotation(Dialog(group="ECS"));
 parameter Boolean Profil_ECS_M = true "Profil ECS M ou L" annotation(Dialog(group="ECS"));
 parameter Modelica.SIunits.Volume V = 0.1 "Volume du rservoir" annotation(Dialog(group="ECS"));
 parameter Modelica.SIunits.Power Pmin_ECS = 0 "Puissance minimale de la chaudière en mode ECS" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Power Pmax_ECS = 25000 "Puissance maximale de la chaudière en mode ECS" annotation(Dialog(group = "Chauffage"));

 // Production chauffage
 parameter Real scaFacRad = 1.5
    "Scaling factor to scale the power (and mass flow rate) of the radiator loop" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Temperature TSup_nominal=273.15 + 80
    "Nominal supply temperature for radiators" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Temperature TRet_nominal=273.15 + 60
    "Nominal return temperature for radiators" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Power P_rad = 6600 "Puissance maximale du radiateur" annotation(Dialog(group = "Chauffage"));//100*S
 parameter Modelica.SIunits.Power Pmin_Ch = 10000 "Puissance minimale de la chaudière en mode chauffage" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Power Pmax_Ch = 25000 "Puissance maximale de la chaudière en mode chauffage" annotation(Dialog(group = "Chauffage"));

 // Chaudiere
 parameter Real a1 = 0.9 "Coefficient de l'efficacité de la chaudière";
 parameter Real a2 = 0.9 "Coefficient de l'efficacité de la chaudière";
 parameter Boolean Regul_loiEau = true "Régulation loi d'eau ou aquastat" annotation(Dialog(group="Chaudière"));
 parameter Modelica.SIunits.Time t_anticourtcycle=1500 "Temps d'anti-cour-cycle de la chaudière" annotation(Dialog(group="Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power Q_flow_nominal = Pmax_Ch
    "Nominal power of heating plant" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Temperature dTBoi_nominal = TSup_nominal-TRet_nominal
    "Nominal temperature difference for boiler loop" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal = scaFacRad*Q_flow_nominal/dTBoi_nominal/4200
    "Nominal mass flow rate of boiler loop" annotation(Dialog(group = "Cractristiques de la chaudire"));
parameter Modelica.SIunits.MassFlowRate m_flow_nominal_rad= P_rad/dTBoi_nominal/4200   "Nominal mass flow rate of radiator loop";
 parameter Modelica.SIunits.Power P_Pompe_nominal = 45 "Puissance de la pompe" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power ConsoElec_Ventilateur = 25 "Consommation électrique du ventilateur" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power ConsoElec_VannesGaz = 7 "Consommation électrique des vannes gaz" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power[5,2] ConsoElec_PompeCirculation = [0,0;7/60,0;9.65/60,63;11.35/60,105;12/60,105] "Consommation électrique de la pompe de circulation" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power ConsoElec_PompeECS = 45 "Consommation électrique de la pompe ECS" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Modelica.SIunits.Power ConsoElec_Veille = 4 "Consommation électrique en veille" annotation(Dialog(group = "Cractristiques de la chaudire"));
 parameter Boolean Mode_PompePWM = false "Fonctionnement en pompe à débit variable" annotation(Dialog(group="Chaudière"));

 // Régulations
 parameter Modelica.SIunits.Temperature Consigne_ONOFFChaudiere_ECS = TSup_nominal "Température de consigne pour la régulation de l'allumage chaudière en mode ECS" annotation(Dialog(group="Cractristiques des régulations"));
 parameter Modelica.SIunits.Temperature Consigne_Chaudiere_ECS = TSup_nominal "Température de consigne pour la régulation de la chaudière en mode ECS" annotation(Dialog(group="Cractristiques des régulations"));
 parameter Modelica.SIunits.Temperature Consigne_Chaudiere_Ch = TSup_nominal "Température de consigne pour la régulation de la chaudière en mode chauffage" annotation(Dialog(group="Cractristiques des régulations"));
 parameter Real eOn_chaudiere=0.5 "Hystrsis haut chaudire (reprise)" annotation(Dialog(group="Cractristiques des régulations"));
 parameter Real eOff_chaudiere=0.1 "Hystrsis bas chaudire (arrt)" annotation(Dialog(group="Cractristiques des régulations"));

  // Sorties nécessaires
public
  Modelica.SIunits.Power ConsoGaz_Chaudiere "Consommation de gaz de la chaudière";
  Modelica.SIunits.Energy Total_ConsoGaz_Chaudiere "Total de la consommation gaz de la chaudière sur la durée de simulation";
  Modelica.SIunits.Power Production_Chaudiere "Production de la chaudière";
  Modelica.SIunits.Energy Total_Production_Chaudiere "Total de la production de la chaudière sur la durée de simulation";
  Modelica.SIunits.Power Production_Chaudiere_Ch "Production de la chaudière en mode chauffage";
  Modelica.SIunits.Energy Total_Production_Chaudiere_Ch "Total de la production de la chaudière en mode chauffage sur la durée de simulation";
  Modelica.SIunits.Power Production_Chaudiere_ECS "Production de la chaudière en mode ECS";
  Modelica.SIunits.Energy Total_Production_Chaudiere_ECS "Total de la production de la chaudière en mode ECS sur la durée de simulation";
  Modelica.SIunits.Temperature T_ballon "Température du ballon";
  Modelica.SIunits.Temperature Tdepart "Température de départ de la chaudière";
  Modelica.SIunits.Temperature Tretour "Température de retour de la chaudière";
  Modelica.SIunits.MassFlowRate m_Ch "Débit d'eau dans le circuit de chauffage";
  Modelica.SIunits.MassFlowRate m_ECS "Débit d'eau dans le circuit d'ECS";
  Modelica.SIunits.Energy Conso_Elec "Consommation électrique totale";
  Modelica.SIunits.MassFlowRate Puisage_ECS "Puisage d'ECS";
  Boolean ModeECS "Mode ECS ou chauffage";
  Modelica.SIunits.Time Cycles "Durée des cycles";

protected
  Construction.Equipements.Chaud.Chaudiere.chaudiere_2 chaudiere(
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    m_flow_nominal=fan1.m_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    redeclare package MediumW = MediumW,
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Polynomial,
    a={a1,a2},
    dp_nominal=300) annotation (Placement(transformation(extent={{-170,
            -28},{-136,6}})));

  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(
    use_inputFilter=false,
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-28,-66},{-50,-90}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-414,-6},{-402,6}})));

  Buildings.Controls.Continuous.PIDHysteresis regul_Chaudiere_ModeECS(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    Td=1,
    eOff=eOff_chaudiere,
    eOn=eOn_chaudiere,
    yMin=0,
    yMax=Pmax_ECS/Pmax_Ch,
    strict=true,
    k=1e-1,
    Ti=2e2)
    annotation (Placement(transformation(extent={{-440,24},{-428,36}})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{14,-66},{-10,-90}})));

  Buildings.Fluid.Sensors.Temperature        T_depart(
    redeclare package Medium = MediumW)            annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-83,9})));
  Buildings.Fluid.Sensors.Temperature        T_retour(
    redeclare package Medium = MediumW)
                            annotation (
      Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=0,
        origin={-80,-96})));

  Construction.Regulation.Regul_Ch_1_bis regul_Ch(Khea=1,
    k=1,
    Ti=60)
    annotation (Placement(transformation(extent={{-42,20},{-28,28}})));

public
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-288,198},{-212,274}}), iconTransformation(
          extent={{-304,112},{-284,132}})));
protected
  Buildings.Fluid.Sources.MassFlowSource_T
                                        EauFroide(
    T=T_EF,
    redeclare package Medium = MediumW,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{130,-44},{110,-24}})));
public
  Modelica.Blocks.Interfaces.RealInput Profil_ECS
    "Connector of Real input signal 2" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={28,250})));
  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-128,254})));
  Modelica.Blocks.Interfaces.RealInput ConsigneCh annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-186,256})));

  Modelica.Fluid.Interfaces.FluidPort_a port_1(redeclare package Medium =
        MediumW)
    "Third port, can be either inlet or outlet"
    annotation (Placement(transformation(extent={{130,114},{150,134}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_2(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{130,60},{150,80}})));

protected
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear                val_ECS_Ch(
    dpValve_nominal=1e-3,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=mBoi_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=false,
    redeclare package Medium = MediumW,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
    annotation (Placement(transformation(
        extent={{12,-11},{-12,11}},
        rotation=180,
        origin={-42,-11})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2
    annotation (Placement(transformation(extent={{-66,-54},{-46,-34}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS3(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-96,-54},{-76,-34}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS1(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-458,-8},{-438,12}})));
  Buildings.Fluid.Sources.FixedBoundary PuisageECS(          redeclare package
      Medium =         MediumW, nPorts=1)
    annotation (Placement(transformation(extent={{124,8},{104,28}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_Chaudiere_ModeECS(y=
        Consigne_ONOFFChaudiere_ECS)
    annotation (Placement(transformation(extent={{-460,26},{-446,42}})));
  Modelica.Blocks.Sources.Sine T_eauFroide(
    freqHz=1/31536000,
    y(unit="K"),
    offset=273.15 + 17,
    amplitude=1,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{106,-70},{126,-50}})));
  Modelica.Blocks.Logical.Switch switch_5
    annotation (Placement(transformation(extent={{-122,106},{-110,118}})));
  Modelica.Blocks.Logical.Switch Consigne_regul_ByPass_Chaudiere
    annotation (Placement(transformation(extent={{-104,134},{-92,146}})));
  Modelica.Blocks.Math.Gain gain(k=mBoi_flow_nominal)
    annotation (Placement(transformation(extent={{-252,-92},{-232,-72}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-138,186},{-150,198}})));
  Buildings.Controls.Continuous.OffTimer
           offHys
    annotation (Placement(transformation(extent={{-250,-8},{-240,2}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       t_anticourtcycle)
    annotation (Placement(transformation(extent={{-234,-8},{-224,2}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-218,-8},{-208,2}})));
  Modelica.Blocks.Sources.RealExpression Cst1(y=0)
    annotation (Placement(transformation(extent={{-250,-28},{-236,-12}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.01)
    annotation (Placement(transformation(extent={{-266,-8},{-256,2}})));
  Construction.Regulation.Regul_Ch_1_bis regul_Chaudiere_Securite(Khea=1)
    annotation (Placement(transformation(extent={{-369,-16},{-356,-9}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_Chaudiere_Securite(y=273.15
         + 90)
    annotation (Placement(transformation(extent={{-394,-18},{-380,-2}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-302,-16},{-282,4}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val_ByPass_Chaudiere(
    dpValve_nominal=1e-3,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=mBoi_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=false,
    redeclare package Medium = MediumW)
    annotation (Placement(transformation(extent={{-122,-22},{-98,0}})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-100,-66},{-124,-90}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{-330,-18},{-318,-6}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-346,-18},{-334,-6}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D_PompePWM(smoothness=
        Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0; 0.3,
        0.3; 0.6,0.6; 1,1])
    annotation (Placement(transformation(extent={{-312,-96},{-292,-76}})));

  Modelica.Blocks.Logical.Switch switch_PompePWM
    annotation (Placement(transformation(extent={{-276,-106},{-264,-94}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_PompePWM(y=
        Mode_PompePWM)
    annotation (Placement(transformation(extent={{-312,-116},{-292,-96}})));
  Buildings.Controls.SetPoints.HotWaterTemperatureReset LoiEau(
    dTOutHeaBal=0,
    use_TRoo_in=true,
    TSup_nominal=TSup_nominal,
    TRet_nominal=TRet_nominal,
    TOut_nominal(displayUnit="degC") = 268.15)
    annotation (Placement(transformation(extent={{-224,92},{-210,106}})));
  Construction.Regulation.Regul_Ch_1_bis regul_ByPass_Chaudiere_Ch1(
    Khea=1,
    Ti=1e2,
    k=1e-1)
    annotation (Placement(transformation(extent={{-198,90},{-176,104}})));
  Modelica.Blocks.Logical.Switch switch_4
    annotation (Placement(transformation(extent={{-160,78},{-148,90}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_LoiEau(y=Regul_loiEau)
    annotation (Placement(transformation(extent={{-200,74},{-180,94}})));
  Modelica.Blocks.Logical.Switch switch_3
    annotation (Placement(transformation(extent={{-144,122},{-132,134}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS4(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-184,118},{-164,138}})));
  Construction.Regulation.Regul_Ch_1_bis regul_ByPass_Chaudiere_ECS(Khea=1,
    k=1e-2,
    Ti=1e2)
    annotation (Placement(transformation(extent={{-198,138},{-178,150}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_ByPass_Chaudiere_ECS(y=
        Consigne_Chaudiere_ECS)
    annotation (Placement(transformation(extent={{-224,140},{-208,156}})));
  Construction.Regulation.Regul_Ch_1_bis regul_ByPass_Chaudiere_Ch2(Khea=1)
    annotation (Placement(transformation(extent={{-198,66},{-178,78}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_ByPass_Chaudiere_Ch2(y=
        Consigne_Chaudiere_Ch)
    annotation (Placement(transformation(extent={{-224,68},{-210,84}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumW,
    redeclare package MediumHex = MediumW,
    hHex_a=0.995,
    hHex_b=0.1,
    hexSegMult=1,
    m_flow_nominal=m_flow_in,
    dIns=0.05,
    VTan=V,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    show_T=true,
    Q_flow_nominal=chaudiere.Q_flow_nominal,
    nSeg=4,
    hTan=1,
    THex_nominal=Consigne_ONOFFChaudiere_ECS,
    TTan_nominal=Consigne_ONOFFChaudiere_ECS - 1,
    T_start=Consigne_ONOFFChaudiere_ECS,
    mHex_flow_nominal=mBoi_flow_nominal)
    annotation (Placement(transformation(extent={{44,-44},{80,-4}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tanTempTop
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,-64})));

  Modelica.Blocks.Logical.LessEqualThreshold Mode_ECS(threshold=
        Consigne_ONOFFChaudiere_ECS - 0.5)
    annotation (Placement(transformation(extent={{102,-108},{122,-88}})));

  Buildings.Fluid.Sources.FixedBoundary exp(redeclare package Medium =
        MediumW, nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-94,-122})));
  Modelica.Blocks.Logical.Switch switch_PompePWM1
    annotation (Placement(transformation(extent={{-16,26},{-4,38}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS5(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-42,22},{-22,42}})));
  Modelica.Blocks.Sources.RealExpression Cst2(y=0.01)
    annotation (Placement(transformation(extent={{-38,32},{-24,48}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS2(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-202,-36},{-182,-16}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-208,-104},{-196,-92}})));
  Modelica.Blocks.Sources.BooleanExpression boolean_ModeECS6(y=Mode_ECS.y)
    annotation (Placement(transformation(extent={{-244,-108},{-224,-88}})));
  Modelica.Blocks.Math.Gain gain1(k=m_flow_nominal_rad)
    annotation (Placement(transformation(extent={{-252,-124},{-232,-104}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=3)
    annotation (Placement(transformation(extent={{72,-108},{92,-88}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-418,-34},{-406,-22}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual
    annotation (Placement(transformation(extent={{-450,-56},{-430,-36}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_Chaudiere_Securite1(y=0)
    annotation (Placement(transformation(extent={{-456,-80},{-442,-64}})));
  Modelica.Blocks.Continuous.LimPID           regul_Chaudiere_ModeCh(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    yMax=1,
    yMin=Pmin_Ch/Pmax_Ch,
    Td=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=60,
    k=1)
    annotation (Placement(transformation(extent={{-438,-22},{-426,-10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean2(threshold=0.1)
    annotation (Placement(transformation(extent={{-304,-126},{-292,-114}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3
    annotation (Placement(transformation(extent={{-278,-128},{-266,-116}})));
equation

 ConsoGaz_Chaudiere = chaudiere.QFue_flow;
 Production_Chaudiere = chaudiere.QWat_flow;
  if (Mode_ECS.y == true) then
   Production_Chaudiere_Ch = 0;
   Production_Chaudiere_ECS = Production_Chaudiere;
 else
   Production_Chaudiere_Ch = Production_Chaudiere;
   Production_Chaudiere_ECS = 0;
 end if;
 der(Total_ConsoGaz_Chaudiere) = ConsoGaz_Chaudiere;
 der(Total_Production_Chaudiere) = Production_Chaudiere;
 der(Total_Production_Chaudiere_Ch) = Production_Chaudiere_Ch;
 der(Total_Production_Chaudiere_ECS) = Production_Chaudiere_ECS;

 T_ballon = tanTempTop.T;
 Tdepart = T_depart.T;
 Tretour = T_retour.T;
 m_Ch = val_ECS_Ch.port_3.m_flow;
 m_ECS = val_ECS_Ch.port_2.m_flow;
 Conso_Elec = chaudiere.consoElec.y;
 Puisage_ECS = EauFroide.m_flow_in;
 ModeECS =Mode_ECS.y;
 Cycles = offHys.y;

  connect(jun1.port_2, fan1.port_a)
    annotation (Line(points={{-10,-78},{-28,-78}}, color={0,127,255}));
  connect(weaBus.TDryBul, LoiEau.TOut) annotation (Line(
      points={{-250,236},{-234,236},{-234,186},{-234,103.2},{-225.4,103.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(regul_Ch.T, T) annotation (Line(points={{-43.12,24},{-50,24},{-50,182},
          {-128,182},{-128,254}},
                       color={0,0,127}));
  connect(regul_Ch.ConsigneCh, ConsigneCh) annotation (Line(points={{-43.12,
          26.6667},{-48,26.6667},{-48,202},{-186,202},{-186,256}},
                                      color={0,0,127}));
  connect(LoiEau.TRoo_in, ConsigneCh) annotation (Line(points={{-225.33,
          94.8},{-242,94.8},{-242,96},{-242,202},{-186,202},{-186,256}},
                             color={0,0,127}));
  connect(regul_ByPass_Chaudiere_Ch1.yHea, switch_4.u1) annotation (Line(
        points={{-173.8,97},{-170,97},{-170,90},{-170,96},{-170,88.8},{
          -161.2,88.8}}, color={0,0,127}));
  connect(booleanToReal2.y, val_ECS_Ch.y) annotation (Line(points={{-45,-44},
          {-42,-44},{-42,-24.2}}, color={0,0,127}));
  connect(boolean_ModeECS3.y, booleanToReal2.u) annotation (Line(points={{-75,
          -44},{-72,-44},{-68,-44}}, color={255,0,255}));
  connect(boolean_ModeECS1.y, switch2.u2) annotation (Line(points={{-437,2},
          {-437,0},{-415.2,0}}, color={255,0,255}));
  connect(boolean_LoiEau.y, switch_4.u2)
    annotation (Line(points={{-179,84},{-161.2,84}}, color={255,0,255}));
  connect(regul_Chaudiere_ModeECS.y, switch2.u1) annotation (Line(points={{-427.4,
          30},{-424,30},{-424,16},{-424,32},{-424,6.8},{-415.2,6.8},{-415.2,
          4.8}},         color={0,0,127}));
  connect(boolean_ModeECS4.y, switch_3.u2)
    annotation (Line(points={{-163,128},{-145.2,128}}, color={255,0,255}));
  connect(regul_ByPass_Chaudiere_Ch2.yHea, switch_4.u3) annotation (Line(
        points={{-176,72},{-164,72},{-164,79.2},{-161.2,79.2}}, color={0,0,
          127}));
  connect(regul_Chaudiere_ModeECS.u_s, Consigne_regul_Chaudiere_ModeECS.y)
    annotation (Line(points={{-441.2,30},{-444,30},{-444,34},{-445.3,34}},
                                                       color={0,0,127}));
  connect(T_eauFroide.y, EauFroide.T_in) annotation (Line(points={{127,-60},
          {136,-60},{136,-30},{132,-30}}, color={0,0,127}));
  connect(regul_ByPass_Chaudiere_ECS.yHea, switch_3.u1) annotation (Line(
        points={{-176,144},{-162,144},{-162,132.8},{-145.2,132.8}}, color={
          0,0,127}));
  connect(regul_ByPass_Chaudiere_Ch2.T, T_depart.T) annotation (Line(points={{-199.6,
          72},{-206,72},{-206,48},{-75.3,48},{-75.3,9}},       color={0,0,
          127}));
  connect(switch_5.y, Consigne_regul_ByPass_Chaudiere.u3) annotation (Line(
        points={{-109.4,112},{-108,112},{-108,135.2},{-105.2,135.2}}, color=
         {0,0,127}));
  connect(Consigne_regul_ByPass_Chaudiere_ECS.y,
    Consigne_regul_ByPass_Chaudiere.u1) annotation (Line(points={{-207.2,
          148},{-204,148},{-204,154},{-138,154},{-138,144.8},{-105.2,144.8}},
        color={0,0,127}));
  connect(Consigne_regul_ByPass_Chaudiere.u2, switch_3.u2) annotation (Line(
        points={{-105.2,140},{-158,140},{-158,128},{-145.2,128}}, color={
          255,0,255}));
  connect(switch_5.u2, switch_4.u2) annotation (Line(points={{-123.2,112},{
          -168,112},{-168,84},{-161.2,84}}, color={255,0,255}));
  connect(switch_5.u3, regul_ByPass_Chaudiere_Ch2.ConsigneCh) annotation (
      Line(points={{-123.2,107.2},{-166,107.2},{-166,76},{-199.6,76}},
        color={0,0,127}));

  connect(prescribedTemperature.T, T) annotation (Line(points={{-136.8,192},
          {-128,192},{-128,210},{-128,254}},           color={0,0,127}));
  connect(regul_ByPass_Chaudiere_ECS.T, T_depart.T) annotation (Line(points={{-199.6,
          144},{-230,144},{-230,48},{-75.3,48},{-75.3,9}},       color={0,0,
          127}));
  connect(regul_ByPass_Chaudiere_ECS.ConsigneCh,
    Consigne_regul_ByPass_Chaudiere_ECS.y)
    annotation (Line(points={{-199.6,148},{-207.2,148}}, color={0,0,127}));
  connect(LoiEau.TSup, regul_ByPass_Chaudiere_Ch1.ConsigneCh) annotation (
      Line(points={{-209.3,103.2},{-205.65,103.2},{-205.65,101.667},{-199.76,
          101.667}},         color={0,0,127}));
  connect(regul_ByPass_Chaudiere_Ch1.T, T_depart.T) annotation (Line(points={{-199.76,
          97},{-206,97},{-206,48},{-75.3,48},{-75.3,9}},        color={0,0,
          127}));
  connect(switch_5.u1, regul_ByPass_Chaudiere_Ch1.ConsigneCh) annotation (
      Line(points={{-123.2,116.8},{-206,116.8},{-206,110},{-206,107.2},{-206,
          101.667},{-199.76,101.667}},      color={0,0,127}));
  connect(offHys.y, greaterEqualThreshold.u) annotation (Line(points={{-239.5,
          -3},{-237.75,-3},{-235,-3}},        color={0,0,127}));
  connect(greaterEqualThreshold.y, switch1.u2)
    annotation (Line(points={{-223.5,-3},{-219,-3}}, color={255,0,255}));
  connect(Cst1.y, switch1.u3) annotation (Line(points={{-235.3,-20},{-220,
          -20},{-220,-7},{-219,-7}}, color={0,0,127}));
  connect(greaterThreshold.y, offHys.u) annotation (Line(points={{-255.5,-3},
          {-255.5,-3},{-251,-3}},  color={255,0,255}));
  connect(product1.u2, product1.u2)
    annotation (Line(points={{-304,-12},{-304,-12}}, color={0,0,127}));
  connect(product1.u1, switch2.y) annotation (Line(points={{-304,0},{-360,0},
          {-372,0},{-401.4,0}}, color={0,0,127}));
  connect(switch1.y, chaudiere.y) annotation (Line(points={{-207.5,-3},{
          -176,-3},{-176,-1.48},{-166.26,-1.48}}, color={0,0,127}));
  connect(val_ByPass_Chaudiere.port_1, chaudiere.port_b) annotation (Line(
        points={{-122,-11},{-130,-11},{-135.66,-11}}, color={0,127,255}));
  connect(jun2.port_3, val_ByPass_Chaudiere.port_3) annotation (Line(points=
         {{-112,-66},{-112,-22},{-110,-22}}, color={0,127,255}));
  connect(jun2.port_2, chaudiere.port_a) annotation (Line(points={{-124,-78},
          {-176,-78},{-176,-11},{-170.68,-11}}, color={0,127,255}));
  connect(prescribedTemperature.port, chaudiere.heatPort) annotation (Line(
        points={{-150,192},{-150,192},{-154,192},{-154,2},{-154,0},{-154,
          0.9},{-153,0.9}},                                          color=
          {191,0,0}));
  connect(Consigne_regul_Chaudiere_Securite.y, regul_Chaudiere_Securite.ConsigneCh)
    annotation (Line(points={{-379.3,-10},{-370.04,-10},{-370.04,-10.1667}},
        color={0,0,127}));
  connect(regul_Chaudiere_Securite.T, chaudiere.T) annotation (Line(points=
          {{-370.04,-12.5},{-376,-12.5},{-376,-42},{-130,-42},{-130,-1.48},
          {-139.06,-1.48}}, color={0,0,127}));
  connect(booleanToReal1.u, realToBoolean1.y) annotation (Line(points={{
          -331.2,-12},{-333.4,-12}}, color={255,0,255}));
  connect(regul_Chaudiere_Securite.yHea, realToBoolean1.u) annotation (Line(
        points={{-354.7,-12.5},{-350.35,-12.5},{-350.35,-12},{-347.2,-12}},
        color={0,0,127}));
  connect(booleanToReal1.y, product1.u2) annotation (Line(points={{-317.4,
          -12},{-310,-12},{-304,-12}}, color={0,0,127}));
  connect(val_ByPass_Chaudiere.y, switch_3.y) annotation (Line(points={{
          -110,2.2},{-110,2},{-110,78},{-128,78},{-128,128},{-131.4,128}},
        color={0,0,127}));
  connect(boolean_PompePWM.y, switch_PompePWM.u2) annotation (Line(points={{-291,
          -106},{-280,-106},{-280,-100},{-277.2,-100}},       color={255,0,
          255}));
  connect(switch_PompePWM.y, gain.u)
    annotation (Line(points={{-263.4,-100},{-256,-100},{-256,-82},{-254,-82}},
                                                         color={0,0,127}));
  connect(combiTable1D_PompePWM.y[1], switch_PompePWM.u1) annotation (Line(
        points={{-291,-86},{-277.2,-86},{-277.2,-95.2}}, color={0,0,127}));
  connect(product1.y, greaterThreshold.u) annotation (Line(points={{-281,-6},
          {-272,-6},{-272,-3},{-267,-3}}, color={0,0,127}));
  connect(product1.y, switch1.u1) annotation (Line(points={{-281,-6},{-272,
          -6},{-272,10},{-219,10},{-219,1}}, color={0,0,127}));
  connect(Consigne_regul_ByPass_Chaudiere_Ch2.y, regul_ByPass_Chaudiere_Ch2.ConsigneCh)
    annotation (Line(points={{-209.3,76},{-199.6,76}}, color={0,0,127}));
  connect(val_ECS_Ch.port_2, tan.portHex_a) annotation (Line(points={{-30,
          -11},{-14,-11},{-14,-14},{-14,-26},{-14,-31.6},{44,-31.6}}, color=
         {0,127,255}));
  connect(jun1.port_1, tan.portHex_b) annotation (Line(points={{14,-78},{30,
          -78},{30,-40},{44,-40}}, color={0,127,255}));
  connect(tan.port_a, PuisageECS.ports[1]) annotation (Line(points={{44,-24},
          {44,18},{104,18}}, color={0,127,255}));
  connect(tan.port_b, EauFroide.ports[1]) annotation (Line(points={{80,-24},{88,
          -24},{88,-26},{88,-34},{110,-34}},              color={0,127,255}));
  connect(tanTempTop.port, tan.heaPorVol[2]) annotation (Line(points={{62,
          -54},{62,-54},{62,-24.3}}, color={191,0,0}));
  connect(regul_Chaudiere_ModeECS.u_m, tanTempTop.T) annotation (Line(
        points={{-434,22.8},{-434,20},{-466,20},{-466,-138},{62,-138},{62,
          -74}}, color={0,0,127}));
  connect(switch_4.y, switch_3.u3) annotation (Line(points={{-147.4,84},{
          -146,84},{-146,123.2},{-145.2,123.2}}, color={0,0,127}));
  connect(regul_Ch.yHea, switch_PompePWM1.u3) annotation (Line(points={{-26.6,24},
          {-17.2,24},{-17.2,27.2}}, color={0,0,127}));
  connect(boolean_ModeECS5.y, switch_PompePWM1.u2)
    annotation (Line(points={{-21,32},{-17.2,32}}, color={255,0,255}));
  connect(Cst2.y, switch_PompePWM1.u1) annotation (Line(points={{-23.3,40},{-17.2,
          40},{-17.2,36.8}}, color={0,0,127}));
  connect(boolean_ModeECS2.y, chaudiere.Mode_ECS) annotation (Line(points={{-181,
          -26},{-173.4,-26},{-173.4,-25.62}}, color={255,0,255}));
  connect(boolean_ModeECS6.y, switch3.u2) annotation (Line(points={{-223,-98},{-223,
          -98},{-209.2,-98}}, color={255,0,255}));
  connect(switch3.u1, gain.y) annotation (Line(points={{-209.2,-93.2},{
          -219.6,-93.2},{-219.6,-82},{-231,-82}},
                                    color={0,0,127}));
  connect(switch3.y, chaudiere.m_PompeCirc) annotation (Line(points={{-195.4,-98},
          {-173.4,-98},{-173.4,-19.5}}, color={0,0,127}));
  connect(switch3.y, fan1.m_flow_in) annotation (Line(points={{-195.4,-98},{-39,
          -98},{-39,-92.4}},    color={0,0,127}));
  connect(gain1.y, switch3.u3) annotation (Line(points={{-231,-114},{-214,-114},
          {-214,-102.8},{-209.2,-102.8}}, color={0,0,127}));
  connect(exp.ports[1], jun2.port_1) annotation (Line(points={{-94,-112},{-94,-96},
          {-100,-96},{-100,-78}}, color={0,127,255}));
  connect(Mode_ECS.u, firstOrder.y)
    annotation (Line(points={{100,-98},{96,-98},{93,-98}},
                                                  color={0,0,127}));
  connect(firstOrder.u, tanTempTop.T)
    annotation (Line(points={{70,-98},{62,-98},{62,-74}}, color={0,0,127}));
  connect(val_ByPass_Chaudiere.port_2, val_ECS_Ch.port_1) annotation (Line(
        points={{-98,-11},{-75,-11},{-75,-11},{-54,-11}}, color={0,127,255}));
  connect(T_depart.port, val_ByPass_Chaudiere.port_2) annotation (Line(
        points={{-83,-2},{-82,-2},{-82,-10},{-82,-11},{-98,-11}}, color={0,
          127,255}));
  connect(jun2.port_1, fan1.port_b) annotation (Line(points={{-100,-78},{
          -75,-78},{-50,-78}}, color={0,127,255}));
  connect(T_retour.port, fan1.port_b) annotation (Line(points={{-80,-84},{
          -80,-78},{-50,-78}}, color={0,127,255}));
  connect(regul_Chaudiere_ModeCh.y, switch4.u1) annotation (Line(points={{-425.4,
          -16},{-422.7,-16},{-422.7,-23.2},{-419.2,-23.2}}, color={0,0,127}));
  connect(switch4.y, switch2.u3) annotation (Line(points={{-405.4,-28},{-404,-28},
          {-404,-10},{-422,-10},{-422,-4.8},{-415.2,-4.8}}, color={0,0,127}));
  connect(switch4.u3, Consigne_regul_Chaudiere_Securite1.y) annotation (Line(
        points={{-419.2,-32.8},{-424,-32.8},{-424,-72},{-441.3,-72}}, color={0,0,
          127}));
  connect(greaterEqual.y, switch4.u2) annotation (Line(points={{-429,-46},{-424,
          -46},{-424,-28},{-419.2,-28}}, color={255,0,255}));
  connect(regul_Chaudiere_ModeCh.u_s, ConsigneCh) annotation (Line(points={{-439.2,
          -16},{-454,-16},{-454,200},{-188,200},{-188,202},{-186,202},{-186,256}},
        color={0,0,127}));
  connect(regul_Chaudiere_ModeCh.u_m, T) annotation (Line(points={{-432,-23.2},{
          -432,-26},{-462,-26},{-462,192},{-128,192},{-128,254}}, color={0,0,127}));
  connect(greaterEqual.u1, ConsigneCh) annotation (Line(points={{-452,-46},{-458,
          -46},{-458,-16},{-454,-16},{-454,200},{-188,200},{-188,202},{-186,202},
          {-186,256}}, color={0,0,127}));
  connect(greaterEqual.u2, T) annotation (Line(points={{-452,-54},{-462,-54},{-462,
          192},{-128,192},{-128,254}}, color={0,0,127}));
  connect(realToBoolean2.y,booleanToReal3. u) annotation (Line(points={{-291.4,
          -120},{-285.7,-120},{-285.7,-122},{-279.2,-122}},
                                                   color={255,0,255}));
  connect(booleanToReal3.y, gain1.u) annotation (Line(points={{-265.4,-122},
          {-258,-122},{-258,-114},{-254,-114}}, color={0,0,127}));
  connect(realToBoolean2.u, switch_PompePWM1.y) annotation (Line(points={{
          -305.2,-120},{-320,-120},{-344,-120},{-344,-134},{-3.4,-134},{
          -3.4,32}}, color={0,0,127}));
  connect(combiTable1D_PompePWM.u[1], chaudiere.y) annotation (Line(points=
          {{-314,-86},{-336,-86},{-336,-84},{-354,-84},{-354,-44},{-166.26,
          -44},{-166.26,-1.48}}, color={0,0,127}));
  connect(switch_PompePWM.u3, chaudiere.y) annotation (Line(points={{-277.2,
          -104.8},{-354,-104.8},{-354,-44},{-166.26,-44},{-166.26,-1.48}},
        color={0,0,127}));
  connect(val_ECS_Ch.port_3, port_1) annotation (Line(points={{-42,0},{-44,0},{-44,
          124},{140,124}}, color={0,127,255}));
  connect(jun1.port_3, port_2) annotation (Line(points={{2,-66},{8,-66},{8,72},{
          140,72},{140,70}}, color={0,127,255}));
  connect(EauFroide.m_flow_in, Profil_ECS) annotation (Line(points={{132,-26},{132,
          184},{28,184},{28,250}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-480,-140},{140,240}}), graphics={
        Rectangle(
          extent={{-37,61},{37,-61}},
          lineColor={0,0,0},
          origin={-435,13},
          rotation=360,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,39},{60,-39}},
          lineColor={0,0,0},
          origin={-338,3},
          rotation=360,
          lineThickness=0.5),
        Rectangle(
          extent={{-38,33},{38,-33}},
          lineColor={0,0,0},
          origin={-240,5},
          rotation=360,
          lineThickness=0.5),
        Text(
          extent={{-466,68},{-400,52}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Régulation de
la puissance de la chaudière
(Mode ECS ou Ch)
"),     Text(
          extent={{-382,40},{-290,22}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Régulation de
 la température de sortie de la chaudière
(sécurité)"),
        Text(
          extent={{-270,34},{-210,28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Temps d'anti court-cycle"),
        Rectangle(
          extent={{-49,40},{49,-40}},
          lineColor={0,0,0},
          origin={-277,-96},
          rotation=360,
          lineThickness=0.5),
        Text(
          extent={{-308,-58},{-246,-68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Fonctionnement de la pompe
(Normal ou PWM)"),
        Rectangle(
          extent={{-34,40},{34,-40}},
          lineColor={0,0,0},
          origin={54,178},
          rotation=360,
          lineThickness=0.5),
        Text(
          extent={{28,214},{80,204}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Profil de puisage ECS
(M ou L)"),
        Rectangle(
          extent={{-81,57},{81,-57}},
          lineColor={0,0,0},
          origin={-169,119},
          rotation=360,
          lineThickness=0.5),
        Text(
          extent={{-198,166},{-140,156}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Régulation du
bypass de la chaudière
(Mode ECS ou Ch)
"),     Text(
          extent={{66,50},{118,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Production ECS"),
        Rectangle(
          extent={{-50,66},{50,-66}},
          lineColor={0,0,0},
          origin={90,-12},
          rotation=360,
          lineThickness=0.5),
        Text(
          extent={{-50,104},{2,94}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Production Ch"),
        Rectangle(
          extent={{-50,44},{50,-44}},
          lineColor={0,0,0},
          origin={-22,62},
          rotation=360,
          lineThickness=0.5)}),
    Icon(coordinateSystem(extent={{-480,-140},{140,240}})),
    Documentation(info="<html>
<h4>Etude cyclage chaudi&egrave;re</h4>
<p>Ce groupe chaud produit de la chaleur par l&apos;interm&eacute;diaire d&apos;un fluide &agrave; l&apos;aide d&apos;une chaudi&egrave;re accumul&eacute;e.</p>
<p>Cette chaleur est utilis&eacute;e pour produire l&apos;ECS en priorit&eacute; et du chauffage aussi.</p>
<p>But : compter le nombre de cyclage de la chaudi&egrave;re</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end Circuit_chaudiere_Accu;
