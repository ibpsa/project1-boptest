within FRP.Example;
model RTU_VAV_Control_Example_FRP_v3
  "v9. 0907.2024_based on FRP_v2 plus overwritting blocks"
    extends Modelica.Icons.Example;
    package MediumA = Buildings.Media.Air "Medium model";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=2.543; // kg/s
    parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=44000; // Rated cooling capacity
    parameter Modelica.SIunits.HeatFlowRate H_Q_flow_nominal=44000;  //Rated Heating capacity
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+24; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+24; // zone cooling setpoint setback 75F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+20; // zone heating setpoint setback 64.4F
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_102= 1000; //W
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_103= 1000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_104= 5000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_105= 5000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_106= 5000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_202= 2000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_203= 1500;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_204= 5000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_205= 5000;
    parameter Modelica.SIunits.HeatFlowRate VAV_Heater_nominal_206= 5000;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_102= 0.108;  //kg/s
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_103= 0.108;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_104= 0.334;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_105= 0.334;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_106= 0.334;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_202= 0.189;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_203= 0.135;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_204= 0.334;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_205= 0.334;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_206= 0.334;

    parameter Modelica.SIunits.PressureDifference dp_nominal=1 "nominal pressure loss";
   // parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox=(220+20)/2 "VAV box pressure loss";
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_102=47.28;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_103=17.42;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_104=9.95;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_105=9.95;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_106=9.95;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_202=19.91;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_203=39.81;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_204=9.95;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_205=9.95;
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox_206=9.95;

    parameter Modelica.SIunits.PressureDifference dp_nominal_fan=1000 "nominal pressure rise";
    parameter Modelica.SIunits.PressureDifference dp_nominal_fan_max=dp_nominal_fan/0.6 "maximum dP for zero-flow for a fan";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_max=m_flow_nominal/0.4 "maximum air flow rate for zero-pressure loss for a fan";

    parameter Boolean allowFlowReversal=true;
  Envelope.FRPMultiZone_Envelope_Icon_v2  fRPMultiZone_Envelope_Icon_v2_1
    annotation (Placement(transformation(extent={{466,40},{942,532}})));
  Buildings.Fluid.Sources.Outside out(redeclare package Medium = MediumA,
      nPorts=3)
    annotation (Placement(transformation(extent={{-1192,-52},{-1158,-18}})));

  Buildings.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = MediumA,
    allowFlowReversal=true,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per(pressure(V_flow=
           m_flow_nominal_max*{0, 0.2,0.4,0.6,0.8}/1.2,
           dp=dp_nominal_fan_max*{1, 0.9,0.85,0.6,
            0.2})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-910,-54},{-842,14}})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed
                                                               DX(
    datCoi=datCoi,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=dp_nominal,
    minSpeRat=0,
    speRatDeaBan=0.1)
                 "multi-stage DX unit"
    annotation (Placement(transformation(extent={{-638,-82},{-514,42}})));
  Buildings.Fluid.Sensors.Pressure senPreSup(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-302,-20},{-258,26}})));
  Buildings.Fluid.Actuators.Dampers.MixingBox
                                    mixBox(
    dpDamOut_nominal=10,
    dpDamRec_nominal=10,
    dpDamExh_nominal=10,
    mOut_flow_nominal=0.1*m_flow_nominal,
    mRec_flow_nominal=0.9*m_flow_nominal,
    mExh_flow_nominal=0.1*m_flow_nominal,
    redeclare package Medium = MediumA,
    allowFlowReversal=true,
    from_dp=false,
    use_inputFilter=false) "mixing box"
    annotation (Placement(transformation(extent={{-1022,-84},{-938,0}})));
  Buildings.Applications.DataCenters.ChillerCooled.Equipment.ElectricHeater NatHea(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    QMax_flow(displayUnit="kW") = H_Q_flow_nominal,
    dp_nominal=200 + 200 + 100 + 40,
    eta=0.81) "Natural gas heater"
    annotation (Placement(transformation(extent={{-444,-54},{-380,14}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSPHeating(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-596,152},{-496,220}})));
    // use FRP performance curve

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi(
    minSpeRat=0,
    nSta=2,
    sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21871/39724*Q_flow_nominal,
          COP_nominal=3.56,
          SHR_nominal=0.8,
          m_flow_nominal=21871/39724*m_flow_nominal),
        perCur=FRP.RTUVAV.Performance_Stage1()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=3600/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Q_flow_nominal,
          COP_nominal=3.218,
          SHR_nominal=0.713,
          m_flow_nominal=m_flow_nominal),
        perCur=FRP.RTUVAV.Performance_Stage2())})                                                                                                   "Coil data"
    annotation (Placement(transformation(extent={{-1112,660},{-1050,722}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_104(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox_104)
    annotation (Placement(transformation(extent={{40,0},{100,60}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_204(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_204,
    Q_flow_nominal=VAV_Heater_nominal_204,
    dp_nominal=dp_nominal_VAVbox_204)
    annotation (Placement(transformation(extent={{20,406},{80,466}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_203(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_203,
    Q_flow_nominal=VAV_Heater_nominal_203,
    dp_nominal=dp_nominal_VAVbox_203)
    annotation (Placement(transformation(extent={{200,404},{260,464}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_205(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_205,
    Q_flow_nominal=VAV_Heater_nominal_205,
    dp_nominal=dp_nominal_VAVbox_205)
    annotation (Placement(transformation(extent={{-40,298},{20,358}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_202(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_202,
    Q_flow_nominal=VAV_Heater_nominal_202,
    dp_nominal=dp_nominal_VAVbox_202)
    annotation (Placement(transformation(extent={{140,296},{200,356}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_206(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_206,
    Q_flow_nominal=VAV_Heater_nominal_206,
    dp_nominal=dp_nominal_VAVbox_206)
    annotation (Placement(transformation(extent={{320,296},{380,356}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_102(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_102,
    Q_flow_nominal=VAV_Heater_nominal_102,
    dp_nominal=dp_nominal_VAVbox_102)
    annotation (Placement(transformation(extent={{220,0},{280,60}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_105(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_105,
    Q_flow_nominal=VAV_Heater_nominal_105,
    dp_nominal=dp_nominal_VAVbox_105)
    annotation (Placement(transformation(extent={{-40,-120},{20,-60}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_103(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_103,
    Q_flow_nominal=VAV_Heater_nominal_103,
    dp_nominal=dp_nominal_VAVbox_103)
    annotation (Placement(transformation(extent={{140,-120},{200,-60}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_106(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_106,
    Q_flow_nominal=VAV_Heater_nominal_106,
    dp_nominal=dp_nominal_VAVbox_106)
    annotation (Placement(transformation(extent={{320,-120},{380,-60}})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-28,28},{28,-28}},
        rotation=0,
        origin={-200,-20})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,4/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{22,22.5},{-22,-22.5}},
        rotation=180,
        origin={-74,735.5})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{20,20.5},{-20,-20.5}},
        rotation=180,
        origin={14,735.5})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{20,20.5},{-20,-20.5}},
        rotation=180,
        origin={100,735.5})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{20,20.5},{-20,-20.5}},
        rotation=180,
        origin={192,735.5})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,4/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={-54,-268})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={34,-268})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={128,-268})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={214,-268})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={667,683})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={753,683})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{23,23},{-23,-23}},
        rotation=180,
        origin={839,683})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={919,683})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{26,-26},{-26,26}},
        rotation=180,
        origin={686,-210})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{24,-24},{-24,24}},
        rotation=180,
        origin={768,-210})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{24,-24},{-24,24}},
        rotation=180,
        origin={848,-210})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{24,-24},{-24,24}},
        rotation=180,
        origin={928,-210})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for return"      annotation (Placement(transformation(
        extent={{-28,28},{28,-28}},
        rotation=90,
        origin={1068,296})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooSec
    annotation (Placement(transformation(extent={{-294,652},{-232,714}})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooFir
    annotation (Placement(transformation(extent={{-294,-178},{-232,-116}})));
  Modelica.Blocks.Sources.BooleanConstant HeaterControl(k=false)
    "heater on-off control"
    annotation (Placement(transformation(extent={{-556,112},{-520,148}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
                                                      "Bus with weather data"
    annotation (Placement(transformation(extent={{-1300,134},{-1236,202}})));
  Modelica.Blocks.Interfaces.RealOutput TOA
    annotation (Placement(transformation(extent={{-1278,218},{-1242,272}})));
  Buildings.Fluid.Sensors.Pressure senPreMix(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-958,46},{-916,104}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_before_CC(redeclare package
      Medium =                                                                      MediumA,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-700,-46},{-668,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_after_CC(redeclare package
      Medium = MediumA, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-494,-46},{-462,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Supply air temperature"
    annotation (Placement(transformation(extent={{-348,-46},{-316,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Return air temperature"
    annotation (Placement(transformation(extent={{-864,-344},{-834,-294}})));
  RTUVAV.Component.supplyTempCon supplyTempCon
    annotation (Placement(transformation(extent={{-692,342},{-570,414}})));
  RTUVAV.Component.staticPressureCon staticPressureCon
    annotation (Placement(transformation(extent={{-1000,342},{-888,416}})));
  RTUVAV.Component.readZone readZone205
    annotation (Placement(transformation(extent={{36,236},{80,280}})));
  RTUVAV.Component.readZone readZone202
    annotation (Placement(transformation(extent={{220,236},{262,280}})));
  RTUVAV.Component.readZone readZone206
    annotation (Placement(transformation(extent={{380,236},{424,280}})));
  RTUVAV.Component.readZone readZone204
    annotation (Placement(transformation(extent={{100,366},{140,406}})));
  RTUVAV.Component.readZone readZone203
    annotation (Placement(transformation(extent={{280,366},{320,406}})));
  RTUVAV.Component.readZone readZone105
    annotation (Placement(transformation(extent={{40,-164},{84,-120}})));
  RTUVAV.Component.readZone readZone103
    annotation (Placement(transformation(extent={{220,-162},{262,-120}})));
  RTUVAV.Component.readZone readZone104
    annotation (Placement(transformation(extent={{120,-40},{160,0}})));
  RTUVAV.Component.readZone readZone106
    annotation (Placement(transformation(extent={{400,-164},{444,-120}})));
  RTUVAV.Component.readZone readZone102
    annotation (Placement(transformation(extent={{300,-40},{340,0}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{-758,-42},{-716,2}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senRetFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Sensor for return flow rate"
    annotation (Placement(transformation(extent={{-934,-344},{-886,-294}})));
  Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package Medium
      = MediumA) "Supply fan static discharge pressure" annotation (Placement(
        transformation(
        extent={{-18,16},{18,-16}},
        rotation=90,
        origin={-812,54})));
  RTUVAV.Component.readAHU readAHU
    annotation (Placement(transformation(extent={{-298,240},{-234,336}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weaSta
    "BOPTEST weather station"
    annotation (Placement(transformation(extent={{-1278,92},{-1312,124}})));
  RTUVAV.Component.thermostat_T_1stfloor thermostat_T2_1
    annotation (Placement(transformation(extent={{-196,86},{-96,240}})));
  RTUVAV.Component.thermostat_T_2ndtfloor thermostat_T_2ndtfloor
    annotation (Placement(transformation(extent={{-196,498},{-98,646}})));
  RTUVAV.Component.outdoorAirCon outdoorAirCon
    annotation (Placement(transformation(extent={{-1116,40},{-1042,96}})));
equation
  connect(out.ports[1],mixBox. port_Out) annotation (Line(points={{-1158,
          -30.4667},{-1158,-20},{-1108,-20},{-1108,-16.8},{-1022,-16.8}},
                                           color={0,127,255}));
  connect(mixBox.port_Sup, fan.port_a) annotation (Line(points={{-938,-16.8},{
          -910,-16.8},{-910,-20}},       color={0,127,255}));
  connect(mixBox.port_Exh,out. ports[2]) annotation (Line(points={{-1022,-67.2},
          {-1158,-67.2},{-1158,-35}},
                                   color={0,127,255}));
  connect(SupAirTemSPHeating.y,NatHea. TSet) annotation (Line(points={{-491,186},
          {-450,186},{-450,98},{-450.4,98},{-450.4,7.2}},
                                                        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_204.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_204[1]) annotation (Line(points={{79.7,
          433.545},{94,433.545},{94,540},{604,540},{604,413.92},{642.197,413.92}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_104.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_104[1]) annotation (Line(points={{99.7,
          27.5455},{124,27.5455},{124,66},{590,66},{590,189.709},{623.003,
          189.709}},
        color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.weaBus1, out.weaBus) annotation (Line(
      points={{621.084,51.2457},{621.084,-398},{-1224,-398},{-1224,-32},{-1192,
          -32},{-1192,-34.66}},
      color={255,204,51},
      thickness=0.5));
  connect(vAVReHeat_withCtrl_TRooCon_203.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_203[1]) annotation (Line(points={{259.7,
          431.545},{259.7,436},{274,436},{274,526},{742,526},{742,492},{742.771,
          492},{742.771,417.434}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_205.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_205[1]) annotation (Line(points={{19.7,
          325.545},{94,325.545},{94,286},{620,286},{620,336},{621.084,336},{
          621.084,330.983}},               color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_202.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_202[1]) annotation (Line(points={{199.7,
          323.545},{200,323.545},{200,324},{286,324},{286,290},{582,290},{582,
          372.451},{727.032,372.451}},                color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_206.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_206[1]) annotation (Line(points={{379.7,
          323.545},{386,323.545},{386,316},{794.594,316},{794.594,339.417}},
                                                                         color=
          {0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_102.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_102[1]) annotation (Line(points={{279.7,
          27.5455},{298,27.5455},{298,70},{740,70},{740,210.794},{748.529,
          210.794}},                                                     color=
          {0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_105.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_105[1]) annotation (Line(points={{19.7,
          -92.4545},{44,-92.4545},{44,-46},{604,-46},{604,126.451},{629.529,
          126.451}},           color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_103.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_103[1]) annotation (Line(points={{199.7,
          -92.4545},{266,-92.4545},{266,-54},{716,-54},{716,-8},{725.881,-8},{
          725.881,166.514}},
                      color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_106.port_b,
    fRPMultiZone_Envelope_Icon_v2_1.port_106[1]) annotation (Line(points={{379.7,
          -92.4545},{384,-92.4545},{384,-60},{732,-60},{732,118.017},{806.11,
          118.017}},
        color={0,127,255}));
  connect(senPreSup.port, splSupRoo.port_1)
    annotation (Line(points={{-280,-20},{-228,-20}}, color={0,127,255}));
  connect(splSupRoo1.port_3, vAVReHeat_withCtrl_TRooCon_205.port_a) annotation (
     Line(points={{-74,713},{-74,326.364},{-39.7,326.364}},            color={0,
          127,255}));
  connect(splSupRoo1.port_2, splSupRoo2.port_1) annotation (Line(points={{-52,
          735.5},{-6,735.5}},           color={0,127,255}));
  connect(splSupRoo2.port_3, vAVReHeat_withCtrl_TRooCon_204.port_a) annotation (
     Line(points={{14,715},{14,434.364},{20.3,434.364}},
                                                     color={0,127,255}));
  connect(splSupRoo2.port_2, splSupRoo3.port_1) annotation (Line(points={{34,
          735.5},{42,735.5},{42,736},{80,736},{80,735.5}},
                                       color={0,127,255}));
  connect(splSupRoo3.port_3, vAVReHeat_withCtrl_TRooCon_202.port_a) annotation (
     Line(points={{100,715},{100,324.364},{140.3,324.364}},
                                                        color={0,127,255}));
  connect(splSupRoo3.port_2, splSupRoo4.port_1) annotation (Line(points={{120,
          735.5},{172,735.5}},            color={0,127,255}));
  connect(splSupRoo4.port_3, vAVReHeat_withCtrl_TRooCon_203.port_a) annotation (
     Line(points={{192,715},{192,432.364},{200.3,432.364}},
                                                        color={0,127,255}));
  connect(splSupRoo4.port_2, vAVReHeat_withCtrl_TRooCon_206.port_a) annotation (
     Line(points={{212,735.5},{298,735.5},{298,324.364},{320.3,324.364}},
                                                                  color={0,127,
          255}));
  connect(splSupRoo.port_2, splSupRoo5.port_1) annotation (Line(points={{-172,
          -20},{-136,-20},{-136,-268},{-80,-268}},
                                              color={0,127,255}));
  connect(splSupRoo5.port_2, splSupRoo6.port_1)
    annotation (Line(points={{-28,-268},{8,-268}}, color={0,127,255}));
  connect(splSupRoo6.port_2, splSupRoo7.port_1)
    annotation (Line(points={{60,-268},{102,-268}}, color={0,127,255}));
  connect(splSupRoo7.port_2, splSupRoo8.port_1)
    annotation (Line(points={{154,-268},{188,-268}}, color={0,127,255}));
  connect(splSupRoo5.port_3, vAVReHeat_withCtrl_TRooCon_105.port_a) annotation (
     Line(points={{-54,-242},{-54,-91.6364},{-39.7,-91.6364}},
                                                          color={0,127,255}));
  connect(splSupRoo6.port_3, vAVReHeat_withCtrl_TRooCon_104.port_a) annotation (
     Line(points={{34,-242},{32,-242},{32,28.3636},{40.3,28.3636}},
                                                             color={0,127,255}));
  connect(splSupRoo7.port_3, vAVReHeat_withCtrl_TRooCon_103.port_a) annotation (
     Line(points={{128,-242},{128,-91.6364},{140.3,-91.6364}},
                                                         color={0,127,255}));
  connect(splSupRoo8.port_3, vAVReHeat_withCtrl_TRooCon_102.port_a) annotation (
     Line(points={{214,-242},{214,28.3636},{220.3,28.3636}},
                                                   color={0,127,255}));
  connect(splSupRoo8.port_2, vAVReHeat_withCtrl_TRooCon_106.port_a) annotation (
     Line(points={{240,-268},{302,-268},{302,-91.6364},{320.3,-91.6364}},
                                                                    color={0,
          127,255}));
  connect(splSupRoo.port_3, splSupRoo1.port_1) annotation (Line(points={{-200,8},
          {-202,8},{-202,735.5},{-96,735.5}},
                                           color={0,127,255}));
  connect(splRetRoo1.port_1,fRPMultiZone_Envelope_Icon_v2_1. port_205[2])
    annotation (Line(points={{642,683},{648.723,683},{648.723,330.983}},color={
          0,127,255}));
  connect(splRetRoo1.port_3,fRPMultiZone_Envelope_Icon_v2_1. port_204[2])
    annotation (Line(points={{667,658},{667,413.92},{669.068,413.92}},
                                                                     color={0,
          127,255}));
  connect(splRetRoo1.port_2, splRetRoo2.port_1) annotation (Line(points={{692,683},
          {728,683}},                     color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_202[2], splRetRoo2.port_3)
    annotation (Line(points={{751.6,372.451},{753,372.451},{753,658}}, color={0,
          127,255}));
  connect(splRetRoo2.port_2, splRetRoo3.port_1) annotation (Line(points={{778,683},
          {816,683}},                     color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_203[2], splRetRoo3.port_3)
    annotation (Line(points={{765.035,417.434},{839,417.434},{839,660}},
                                                                       color={0,
          127,255}));
  connect(splRetRoo3.port_2, splRetRoo4.port_1) annotation (Line(points={{862,683},
          {894,683}},                     color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_206[2], splRetRoo4.port_3)
    annotation (Line(points={{816.09,339.417},{919,339.417},{919,658}},color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_105[2], splRetRoo5.port_1)
    annotation (Line(points={{652.561,126.451},{652.561,-210},{660,-210}},
                                                                      color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_104[2], splRetRoo5.port_3)
    annotation (Line(points={{648.339,189.709},{686,189.709},{686,-184}},
                                                                      color={0,
          127,255}));
  connect(splRetRoo5.port_2, splRetRoo6.port_1) annotation (Line(points={{712,-210},
          {744,-210}},                       color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_103[2], splRetRoo6.port_3)
    annotation (Line(points={{748.145,166.514},{768,166.514},{768,-186}},
                                                                    color={0,
          127,255}));
  connect(splRetRoo6.port_2, splRetRoo7.port_1) annotation (Line(points={{792,-210},
          {824,-210}},                       color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_102[2], splRetRoo7.port_3)
    annotation (Line(points={{770.026,210.794},{848,210.794},{848,-186}},
                                                                      color={0,
          127,255}));
  connect(splRetRoo7.port_2, splRetRoo8.port_1) annotation (Line(points={{872,-210},
          {904,-210}},                       color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v2_1.port_106[2], splRetRoo8.port_3)
    annotation (Line(points={{829.142,118.017},{928,118.017},{928,-186}},
                                                                        color={
          0,127,255}));
  connect(splRetRoo8.port_2, splRetRoo.port_3) annotation (Line(points={{952,
          -210},{1010,-210},{1010,296},{1040,296}},
                                              color={0,127,255}));
  connect(splRetRoo4.port_2, splRetRoo.port_2) annotation (Line(points={{944,683},
          {1068,683},{1068,324}}, color={0,127,255}));

  connect(TRooSec.u,fRPMultiZone_Envelope_Icon_v2_1. TrooVecSec) annotation (
      Line(
      points={{-300.2,683},{-354,683},{-354,782},{1108,782},{1108,404.08},{
          955.819,404.08}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.u,fRPMultiZone_Envelope_Icon_v2_1. TrooVecFir) annotation (
      Line(
      points={{-300.2,-147},{-350,-147},{-350,-336},{1112,-336},{1112,181.977},
          {958.89,181.977}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y5[1], vAVReHeat_withCtrl_TRooCon_105.TRoo) annotation (Line(
      points={{-228.9,-163.74},{-98,-163.74},{-98,82},{-17.5,82},{-17.5,-60}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(HeaterControl.y,NatHea. on) annotation (Line(points={{-518.2,130},{-450.4,
          130},{-450.4,-9.8}},         color={255,0,255}));
  connect(TRooFir.y4[1], vAVReHeat_withCtrl_TRooCon_104.TRoo) annotation (Line(
      points={{-228.9,-152.58},{-86,-152.58},{-86,80},{58,80},{58,84},{60,84},{
          60,60},{62.5,60}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(TRooFir.y3[1], vAVReHeat_withCtrl_TRooCon_103.TRoo) annotation (Line(
      points={{-228.9,-141.42},{-100,-141.42},{-100,84},{162.5,84},{162.5,-60}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y2[1], vAVReHeat_withCtrl_TRooCon_102.TRoo) annotation (Line(
      points={{-228.9,-130.26},{-104,-130.26},{-104,88},{242.5,88},{242.5,60}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(TRooFir.y6[1], vAVReHeat_withCtrl_TRooCon_106.TRoo) annotation (Line(
      points={{-228.9,-174.9},{-96,-174.9},{-96,82},{342.5,82},{342.5,-60}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(TRooSec.y4[1], vAVReHeat_withCtrl_TRooCon_204.TRoo) annotation (Line(
      points={{-228.9,677.42},{42.5,677.42},{42.5,466}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y2[1], vAVReHeat_withCtrl_TRooCon_202.TRoo) annotation (Line(
      points={{-228.9,699.74},{162.5,699.74},{162.5,356}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y3[1], vAVReHeat_withCtrl_TRooCon_203.TRoo) annotation (Line(
      points={{-228.9,688.58},{222.5,688.58},{222.5,464}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y6[1], vAVReHeat_withCtrl_TRooCon_206.TRoo) annotation (Line(
      points={{-228.9,655.1},{342.5,655.1},{342.5,356}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(out.weaBus, weaBus1) annotation (Line(
      points={{-1192,-34.66},{-1192,-8},{-1214,-8},{-1214,168},{-1268,168}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus1.TDryBul, TOA) annotation (Line(
      points={{-1268,168},{-1216,168},{-1216,245},{-1260,245}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TOA,DX. TConIn) annotation (Line(points={{-1260,245},{-962,245},{-962,
          246},{-662,246},{-662,-1.4},{-644.2,-1.4}},
                                      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(mixBox.port_Sup, senPreMix.port) annotation (Line(points={{-938,-16.8},
          {-938,-8},{-940,-8},{-940,46},{-937,46}},
                                                 color={0,127,255}));
  connect(T_before_CC.port_b, DX.port_a) annotation (Line(points={{-668,-20},{-638,
          -20}},                       color={0,127,255}));
  connect(DX.port_b, T_after_CC.port_a) annotation (Line(points={{-514,-20},{-494,
          -20}},                            color={0,127,255}));
  connect(T_after_CC.port_b,NatHea. port_a) annotation (Line(points={{-462,-20},
          {-444,-20}},                       color={0,127,255}));
  connect(NatHea.port_b, TSA.port_a) annotation (Line(points={{-380,-20},{-348,-20}},
                                       color={0,127,255}));
  connect(TSA.port_b, senPreSup.port) annotation (Line(points={{-316,-20},{-280,
          -20}},                       color={0,127,255}));
  connect(TRA.port_b, splRetRoo.port_1) annotation (Line(points={{-834,-319},{
          1068,-319},{1068,268}},color={0,127,255}));
  connect(supplyTempCon.TSupSet_out, DX.speRat) annotation (Line(
      points={{-566.611,374.914},{-566.611,304},{-642,304},{-642,88},{-644.2,88},
          {-644.2,29.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(T_after_CC.T, supplyTempCon.u_m1) annotation (Line(
      points={{-478,8.6},{-478,272},{-601.856,272},{-601.856,337.886}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooSec.y5[1], vAVReHeat_withCtrl_TRooCon_205.TRoo) annotation (Line(
      points={{-228.9,666.26},{-17.5,666.26},{-17.5,358}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(staticPressureCon.staticPressure_out, fan.y) annotation (Line(
      points={{-884.591,373.913},{-876,373.913},{-876,20.8}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(senPreSup.p, staticPressureCon.senPreSup_in) annotation (Line(
      points={{-255.8,3},{-246,3},{-246,220},{-424,220},{-424,582},{-1066,582},
          {-1066,379},{-1002.43,379}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(vAVReHeat_withCtrl_TRooCon_205.y_actual1, readZone205.DamPosition_in)
    annotation (Line(points={{4.4,295.818},{4.4,265.92},{31.16,265.92}}, color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_205.T1, readZone205.TSupZone_in)
    annotation (Line(points={{9.5,295.818},{9.5,257.12},{31.16,257.12}}, color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_205.V_flow1, readZone205.VflowSupply_in)
    annotation (Line(points={{14,295.818},{14,246.12},{31.6,246.12}}, color={0,
          0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_202.y_actual1, readZone202.DamPosition_in)
    annotation (Line(points={{184.4,293.818},{184.4,265.92},{215.38,265.92}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_202.T1, readZone202.TSupZone_in)
    annotation (Line(points={{189.5,293.818},{189.5,257.12},{215.38,257.12}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_202.V_flow1, readZone202.VflowSupply_in)
    annotation (Line(points={{194,293.818},{194,246.12},{215.8,246.12}},
                                                                       color={0,
          0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_206.y_actual1, readZone206.DamPosition_in)
    annotation (Line(points={{364.4,293.818},{364.4,265.92},{375.16,265.92}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_206.T1, readZone206.TSupZone_in)
    annotation (Line(points={{369.5,293.818},{369.5,257.12},{375.16,257.12}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_206.V_flow1, readZone206.VflowSupply_in)
    annotation (Line(points={{374,293.818},{374,246.12},{375.6,246.12}}, color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_204.y_actual1, readZone204.DamPosition_in)
    annotation (Line(points={{64.4,403.818},{64.4,393.2},{95.6,393.2}}, color={
          0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_204.T1, readZone204.TSupZone_in)
    annotation (Line(points={{69.5,403.818},{69.5,385.2},{95.6,385.2}}, color={
          0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_204.V_flow1, readZone204.VflowSupply_in)
    annotation (Line(points={{74,403.818},{74,374},{96,374},{96,375.2}}, color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_203.y_actual1, readZone203.DamPosition_in)
    annotation (Line(points={{244.4,401.818},{244.4,393.2},{275.6,393.2}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_203.T1, readZone203.TSupZone_in)
    annotation (Line(points={{249.5,401.818},{249.5,385.2},{275.6,385.2}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_203.V_flow1, readZone203.VflowSupply_in)
    annotation (Line(points={{254,401.818},{254,375.2},{276,375.2}}, color={0,0,
          127}));
  connect(vAVReHeat_withCtrl_TRooCon_105.y_actual1, readZone105.DamPosition_in)
    annotation (Line(points={{4.4,-122.182},{4.4,-134.08},{35.16,-134.08}},
                                                                         color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_105.T1, readZone105.TSupZone_in)
    annotation (Line(points={{9.5,-122.182},{9.5,-142.88},{35.16,-142.88}},
                                                                         color=
          {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_105.V_flow1, readZone105.VflowSupply_in)
    annotation (Line(points={{14,-122.182},{14,-153.88},{35.6,-153.88}},
                                                                     color={0,0,
          127}));
  connect(vAVReHeat_withCtrl_TRooCon_103.y_actual1, readZone103.DamPosition_in)
    annotation (Line(points={{184.4,-122.182},{184.4,-133.44},{215.38,-133.44}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_103.T1, readZone103.TSupZone_in)
    annotation (Line(points={{189.5,-122.182},{189.5,-141.84},{215.38,-141.84}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_103.V_flow1, readZone103.VflowSupply_in)
    annotation (Line(points={{194,-122.182},{194,-152.34},{215.8,-152.34}},
                                                                        color={
          0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_104.y_actual1, readZone104.DamPosition_in)
    annotation (Line(points={{84.4,-2.18182},{84.4,-12.8},{115.6,-12.8}}, color=
         {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_104.T1, readZone104.TSupZone_in)
    annotation (Line(points={{89.5,-2.18182},{89.5,-20.8},{115.6,-20.8}}, color=
         {0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_104.V_flow1, readZone104.VflowSupply_in)
    annotation (Line(points={{94,-2.18182},{94,-30.8},{116,-30.8}}, color={0,0,
          127}));
  connect(vAVReHeat_withCtrl_TRooCon_106.y_actual1, readZone106.DamPosition_in)
    annotation (Line(points={{364.4,-122.182},{364.4,-134.08},{395.16,-134.08}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_106.T1, readZone106.TSupZone_in)
    annotation (Line(points={{369.5,-122.182},{369.5,-142.88},{395.16,-142.88}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_106.V_flow1, readZone106.VflowSupply_in)
    annotation (Line(points={{374,-122.182},{374,-153.88},{395.6,-153.88}},
                                                                        color={
          0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_102.y_actual1, readZone102.DamPosition_in)
    annotation (Line(points={{264.4,-2.18182},{264.4,-12.8},{295.6,-12.8}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_102.T1, readZone102.TSupZone_in)
    annotation (Line(points={{269.5,-2.18182},{269.5,-20.8},{295.6,-20.8}},
        color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_102.V_flow1, readZone102.VflowSupply_in)
    annotation (Line(points={{274,-2.18182},{274,-30.8},{296,-30.8}}, color={0,
          0,127}));
  connect(senSupFlo.port_b, T_before_CC.port_a)
    annotation (Line(points={{-716,-20},{-700,-20}}, color={0,127,255}));
  connect(TRA.port_a, senRetFlo.port_b)
    annotation (Line(points={{-864,-319},{-886,-319}}, color={0,127,255}));
  connect(senRetFlo.port_a, mixBox.port_Ret) annotation (Line(points={{-934,
          -319},{-938,-319},{-938,-67.2}}, color={0,127,255}));
  connect(fan.port_b, senSupFlo.port_a)
    annotation (Line(points={{-842,-20},{-758,-20}}, color={0,127,255}));
  connect(fan.port_b, dpDisSupFan.port_a) annotation (Line(points={{-842,-20},{
          -812,-20},{-812,36}}, color={0,127,255}));
  connect(out.ports[3], dpDisSupFan.port_b) annotation (Line(points={{-1158,
          -39.5333},{-1158,134},{-812,134},{-812,72}}, color={0,127,255}));
  connect(TSA.T, readAHU.TSup_in) annotation (Line(points={{-332,8.6},{-330,8.6},
          {-330,329.6},{-303.76,329.6}}, color={0,0,127}));
  connect(TRA.T, readAHU.TRet_in) annotation (Line(points={{-849,-291.5},{-324,
          -291.5},{-324,318.72},{-303.76,318.72}}, color={0,0,127}));
  connect(senSupFlo.V_flow, readAHU.VflowSup_in) annotation (Line(points={{-737,
          4.2},{-737,308.48},{-304.4,308.48}}, color={0,0,127}));
  connect(senRetFlo.V_flow, readAHU.VflowRet_in) annotation (Line(points={{-910,
          -291.5},{-326,-291.5},{-326,297.6},{-304.4,297.6}}, color={0,0,127}));
  connect(dpDisSupFan.p_rel, readAHU.dP_in) annotation (Line(points={{-826.4,54},
          {-826.4,287.36},{-304.4,287.36}}, color={0,0,127}));
  connect(fan.P, readAHU.pFan_in) annotation (Line(points={{-838.6,10.6},{
          -838.6,269.44},{-304.4,269.44}}, color={0,0,127}));
  connect(DX.P, readAHU.pDX_in) annotation (Line(points={{-507.8,35.8},{-334,
          35.8},{-334,256.64},{-304.4,256.64}}, color={0,0,127}));
  connect(weaBus1, weaSta.weaBus) annotation (Line(
      points={{-1268,168},{-1242,168},{-1242,107.84},{-1278.17,107.84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermostat_T2_1.TZonHeatingSet_out104, vAVReHeat_withCtrl_TRooCon_104.TRooHeaSet)
    annotation (Line(points={{-93.7778,167.813},{49,167.813},{49,60}}, color={0,
          0,127}));
  connect(thermostat_T2_1.TZonCoolingSet_out104, vAVReHeat_withCtrl_TRooCon_104.TRooCooSet)
    annotation (Line(points={{-93.7778,153.375},{73,153.375},{73,60}}, color={0,
          0,127}));
  connect(thermostat_T2_1.TZonHeatingSet_out105, vAVReHeat_withCtrl_TRooCon_105.TRooHeaSet)
    annotation (Line(points={{-93.7778,138.938},{-31,138.938},{-31,-60}}, color=
         {0,0,127}));
  connect(thermostat_T2_1.TZonCoolingSet_out105, vAVReHeat_withCtrl_TRooCon_105.TRooCooSet)
    annotation (Line(points={{-93.7778,124.5},{-7,124.5},{-7,-60}}, color={0,0,
          127}));
  connect(thermostat_T2_1.TZonHeatingSet_out106, vAVReHeat_withCtrl_TRooCon_106.TRooHeaSet)
    annotation (Line(points={{-93.7778,110.063},{329,110.063},{329,-60}}, color=
         {0,0,127}));
  connect(thermostat_T2_1.TZonCoolingSet_out106, vAVReHeat_withCtrl_TRooCon_106.TRooCooSet)
    annotation (Line(points={{-93.7778,95.625},{353,95.625},{353,-60}}, color={
          0,0,127}));
  connect(thermostat_T2_1.TZonHeatingSet_out102, vAVReHeat_withCtrl_TRooCon_102.TRooHeaSet)
    annotation (Line(points={{-93.7778,225.563},{229,225.563},{229,60}}, color=
          {0,0,127}));
  connect(thermostat_T2_1.TZonCoolingSet_out102, vAVReHeat_withCtrl_TRooCon_102.TRooCooSet)
    annotation (Line(points={{-93.7778,211.125},{253,211.125},{253,60}}, color=
          {0,0,127}));
  connect(thermostat_T2_1.TZonHeatingSet_out103, vAVReHeat_withCtrl_TRooCon_103.TRooHeaSet)
    annotation (Line(points={{-93.7778,196.688},{149,196.688},{149,-60}}, color=
         {0,0,127}));
  connect(thermostat_T2_1.TZonCoolingSet_out103, vAVReHeat_withCtrl_TRooCon_103.TRooCooSet)
    annotation (Line(points={{-93.7778,182.25},{173,182.25},{173,-60}}, color={
          0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonHeatingSet_out202,
    vAVReHeat_withCtrl_TRooCon_202.TRooHeaSet) annotation (Line(points={{
          -95.8222,632.125},{149,632.125},{149,356}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonCoolingSet_out202,
    vAVReHeat_withCtrl_TRooCon_202.TRooCooSet) annotation (Line(points={{
          -95.8222,618.25},{173,618.25},{173,356}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonHeatingSet_out203,
    vAVReHeat_withCtrl_TRooCon_203.TRooHeaSet) annotation (Line(points={{
          -95.8222,604.375},{209,604.375},{209,464}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonCoolingSet_out203,
    vAVReHeat_withCtrl_TRooCon_203.TRooCooSet) annotation (Line(points={{
          -95.8222,590.5},{233,590.5},{233,464}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonHeatingSet_out204,
    vAVReHeat_withCtrl_TRooCon_204.TRooHeaSet) annotation (Line(points={{
          -95.8222,576.625},{29,576.625},{29,466}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonCoolingSet_out204,
    vAVReHeat_withCtrl_TRooCon_204.TRooCooSet) annotation (Line(points={{
          -95.8222,562.75},{53,562.75},{53,466}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonHeatingSet_out205,
    vAVReHeat_withCtrl_TRooCon_205.TRooHeaSet) annotation (Line(points={{
          -95.8222,548.875},{-31,548.875},{-31,358}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonCoolingSet_out105,
    vAVReHeat_withCtrl_TRooCon_205.TRooCooSet) annotation (Line(points={{
          -95.8222,535},{-7,535},{-7,358}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonHeatingSet_out206,
    vAVReHeat_withCtrl_TRooCon_206.TRooHeaSet) annotation (Line(points={{
          -95.8222,521.125},{329,521.125},{329,356}}, color={0,0,127}));
  connect(thermostat_T_2ndtfloor.TZonCoolingSet_out206,
    vAVReHeat_withCtrl_TRooCon_206.TRooCooSet) annotation (Line(points={{
          -95.8222,507.25},{353,507.25},{353,356}}, color={0,0,127}));
  connect(outdoorAirCon.oAactuator, mixBox.y) annotation (Line(points={{
          -1040.56,69.2},{-980,69.2},{-980,8.4}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-1580,-620},{1360,1000}})),
    experiment(
      StartTime=15984000,
      StopTime=16243200,
      Interval=299.999808,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="Example/RTU_VAV_Control_Example.mos"),
    Documentation(info="<html>
<p><span style=\"color: #00aa00;\">Flexible Research Platform (FRP)</span></p>
<p>The two-story Flexible Research Platfor (FRP) is located in Oak Ridge, Tennessee. The FRP, with a footprint of 40x40 ft (12x12m), is an unoccupied research appratus that can be used to physically simulate light commercial buildings common in the nation&apos;s existing building stock.</p>
<p><br>The systems in the two-story FRP are multi-zone HVAC systems with 10 thermal zones that can be controlled individually.</p>
<p><br><span style=\"color: #00aa00;\">Climate data</span></p>
<p>This model uses an actual meteorological year (AMY) weather data contatining one year of weather data of Oak Ridge, TN.</p>
<p><br><span style=\"color: #00aa00;\">Building Envelope and HVAC system </span></p>
<p><br>The baseline envelope and HVAC characteristics of the FRP test building are shown in Table&nbsp;1. </p>
<p>Table1. FRP building construction characteristics and HVAC system Characteristics</p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"100%\"><tr>
<td valign=\"top\"><p><b><span style=\"font-size: 10pt;\">General characteristics</span></b> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">&nbsp;</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Location</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Oak Ridge, Tennessee</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Building width</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">40 ft (12.2 m)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Building length</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">40 ft (12.2 m)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Story height (floor to floor)</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">14 ft (4.3 m)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Number of floors</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">2</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Number of thermal zones</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">10 (8 perimeter and 2 core)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><b><span style=\"font-size: 10pt;\">Construction characteristics</span></b> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">&nbsp;</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Wall structure</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Concrete masonry units with face brick</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Wall insulation</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Fiberglass R<sub>US</sub>-11 (R<sub>SI</sub>-1.9)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Floor</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Slab-on-grade</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Roof structure</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Metal deck with polyisocyanurate and ethylene propylene diene monomer</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Roof insulation</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Polyisocyanurate R<sub>US</sub>-18(R<sub>SI</sub>-3.17)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Windows</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Aluminum frame, double-pane, clear glazing</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Window-to-wall ratio</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">28&percnt;</span> </p></td>
</tr>
<tr>
<td colspan=\"2\" valign=\"top\"><p><b><span style=\"font-size: 10pt;\">Systems and equipment characteristics</span></b> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Baseline systems</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Rooftop variable air volume unit with electric reheat, natural gas furnace</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Rooftop unit (RTU) cooling capacity</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">12.5 ton</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">RTU efficiency</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">9.7 energy efficiency rating (EER)</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">Natural gas furnace efficiency</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 10pt;\">81&percnt; annual fuel utilization efficiency (AFUE)</span> </p></td>
</tr>
</table>
<p><br><br><br><br><span style=\"color: #00aa00;\">Model outputs</span></p>
<p>The model outpus are summrized in Table 2.</p>
<p><br>Table2. Interface configuration-output</p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"623\"><tr>
<td valign=\"top\"><p align=\"center\"><br><b><span style=\"font-size: 10pt;\">Output</span></b> </p></td>
<td valign=\"top\"><p align=\"center\"><b><span style=\"font-size: 10pt;\">Description</span></b> </p></td>
<td valign=\"top\"><p align=\"center\"><b><span style=\"font-size: 10pt;\">Parameter name in the model</span></b> </p></td>
<td valign=\"top\"><p align=\"center\"><b><span style=\"font-size: 10pt;\">Unit</span></b> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">Zone temperature</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">Zone temperature of 101<sup><i>a</span></i></sup> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">TRooFir.y1</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">K</span> </p></td>
</tr>
<tr>
<td rowspan=\"3\" valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX coil</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX coil power consumption</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX.P</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">W</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX coil sensible heat flow rate</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX.QSen_flow</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">W</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX coil latent heat flow rate</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">DX.QLat_flow</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">W</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">Electric heater</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">Electric heater power consumption</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">elecHea.P</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">W</span> </p></td>
</tr>
<tr>
<td rowspan=\"3\" valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">VAV</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">VAV control output for cooling<sup><i>a</span></i></sup> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">VAVReHeat_withCtrl_TRooCon102.conCoo.y</span> </p></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><br><br><br><span style=\"font-size: 10pt;\">VAV control output for heating<sup><i>a</span></i></sup> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">VAVReHeat_withCtrl_TRooCon102.conHea.y</span> </p></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><br><br><br><span style=\"font-size: 10pt;\">VAV reheat power consumption<sup><i>a</span></i></sup> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">VAVREheat_withCtrl_TrooCon105ReHeat.Q_flow</span> </p></td>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 10pt;\">W</span> </p></td>
</tr>
</table>
<p><br><br><sup><i><span style=\"font-size: 10pt;\">a</span></i></sup> Outputs are available for all zones. </p>
</html>"));
end RTU_VAV_Control_Example_FRP_v3;
