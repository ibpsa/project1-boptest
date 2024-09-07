within FRP.Example;
model RTU_VAV_Control_Example_FRP "v8. 0107.2024"
    extends Modelica.Icons.Example;
    package MediumA = Buildings.Media.Air "Medium model";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=2.543; // kg/s
    parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=44000; // Rated cooling capacity
    parameter Modelica.SIunits.HeatFlowRate H_Q_flow_nominal=44000;  //Rated Heating capacity
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+24; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+24; // zone cooling setpoint setback 75F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+18; // zone heating setpoint setback 64.4F
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
  Envelope.FRPMultiZone_Envelope_Icon_v1  fRPMultiZone_Envelope_Icon_v1_1
    annotation (Placement(transformation(extent={{470,-136},{946,356}})));
  Buildings.Fluid.Sources.Outside out(redeclare package Medium = MediumA,
      nPorts=2)
    annotation (Placement(transformation(extent={{-972,-38},{-932,2}})));

  Buildings.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = MediumA,
    allowFlowReversal=true,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per(pressure(V_flow=
           m_flow_nominal_max*{0, 0.2,0.4,0.6,0.8}/1.2,
           dp=dp_nominal_fan_max*{1, 0.9,0.85,0.6,
            0.2})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-790,-46},{-720,16}})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed
                                                               DX(
    datCoi=datCoi,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=dp_nominal,
    minSpeRat=0,
    speRatDeaBan=0.1)
                 "multi-stage DX unit"
    annotation (Placement(transformation(extent={{-638,-72},{-514,52}})));
  Buildings.Fluid.Sensors.Pressure senPreSup(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-300,-20},{-252,28}})));
  Buildings.Fluid.Sensors.MassFlowRate senMret(redeclare package Medium =
        MediumA) annotation (Placement(transformation(
        extent={{-32,-36},{32,36}},
        rotation=180,
        origin={-542,-298})));
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
    annotation (Placement(transformation(extent={{-898,-86},{-814,-2}})));
  Modelica.Blocks.Sources.RealExpression OA_actuator(y=0)
    annotation (Placement(transformation(extent={{-950,26},{-910,84}})));
  Buildings.Applications.DataCenters.ChillerCooled.Equipment.ElectricHeater eleHea(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    QMax_flow(displayUnit="kW") = H_Q_flow_nominal,
    dp_nominal=200 + 200 + 100 + 40,
    eta=0.81)
    "Electric heater"
    annotation (Placement(transformation(extent={{-444,-54},{-378,16}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSPHeating(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-596,152},{-496,220}})));
    // use FRP performance curve

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi(
    minSpeRat=0, nSta=3,
      sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=600/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21871/39724/2*Q_flow_nominal,
          COP_nominal=3.56,
          SHR_nominal=0.8,
          m_flow_nominal=21871/39724/2*m_flow_nominal),
        perCur=
          FRP.RTUVAV.Performance_Stage0()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21871/39724*Q_flow_nominal,
          COP_nominal=3.56,
          SHR_nominal=0.8,
          m_flow_nominal=21871/39724*m_flow_nominal),
        perCur=
          FRP.RTUVAV.Performance_Stage1()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=3600/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Q_flow_nominal,
          COP_nominal=3.218,
          SHR_nominal=0.8,
          m_flow_nominal=m_flow_nominal),
        perCur=
          FRP.RTUVAV.Performance_Stage2())})                                                                                                        "Coil data"
    annotation (Placement(transformation(extent={{-1062,518},{-1000,580}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_4(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox_104)
    annotation (Placement(transformation(extent={{48,-30},{100,20}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_1(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_204,
    Q_flow_nominal=VAV_Heater_nominal_204,
    dp_nominal=dp_nominal_VAVbox_204)
    annotation (Placement(transformation(extent={{38,264},{94,324}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_9(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_203,
    Q_flow_nominal=VAV_Heater_nominal_203,
    dp_nominal=dp_nominal_VAVbox_203)
    annotation (Placement(transformation(extent={{218,264},{274,324}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_5(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_205,
    Q_flow_nominal=VAV_Heater_nominal_205,
    dp_nominal=dp_nominal_VAVbox_205)
    annotation (Placement(transformation(extent={{-40,168},{36,230}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_6(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_202,
    Q_flow_nominal=VAV_Heater_nominal_202,
    dp_nominal=dp_nominal_VAVbox_202)
    annotation (Placement(transformation(extent={{136,154},{192,214}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_10(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_206,
    Q_flow_nominal=VAV_Heater_nominal_206,
    dp_nominal=dp_nominal_VAVbox_206)
    annotation (Placement(transformation(extent={{322,150},{378,210}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_8(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_102,
    Q_flow_nominal=VAV_Heater_nominal_102,
    dp_nominal=dp_nominal_VAVbox_102)
    annotation (Placement(transformation(extent={{220,-26},{272,24}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_3(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_105,
    Q_flow_nominal=VAV_Heater_nominal_105,
    dp_nominal=dp_nominal_VAVbox_105)
    annotation (Placement(transformation(extent={{-26,-134},{26,-84}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_7(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_103,
    Q_flow_nominal=VAV_Heater_nominal_103,
    dp_nominal=dp_nominal_VAVbox_103)
    annotation (Placement(transformation(extent={{136,-132},{188,-82}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon_v2_2(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_106,
    Q_flow_nominal=VAV_Heater_nominal_106,
    dp_nominal=dp_nominal_VAVbox_106)
    annotation (Placement(transformation(extent={{318,-134},{370,-84}})));
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
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={-68,519})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={18,517})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={112,517})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={202,517})));
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
        origin={-54,-208})));
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
        origin={34,-206})));
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
        origin={128,-206})));
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
        origin={212,-206})));
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
        origin={671,509})));
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
        origin={757,507})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={843,507})));
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
        origin={923,505})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={681,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={767,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={847,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={927,-209})));
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
        origin={1072,122})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooSec
    annotation (Placement(transformation(extent={{-298,338},{-236,400}})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooFir
    annotation (Placement(transformation(extent={{-294,-178},{-232,-116}})));
  Modelica.Blocks.Sources.BooleanConstant HeaterControl(k=false)
    "heater on-off control"
    annotation (Placement(transformation(extent={{-556,112},{-520,148}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
                                                      "Bus with weather data"
    annotation (Placement(transformation(extent={{-850,126},{-786,194}})));
  Modelica.Blocks.Interfaces.RealOutput TOA
    annotation (Placement(transformation(extent={{-752,132},{-716,186}})));
  Modelica.Blocks.Sources.RealExpression StaPre_SP(y=124)
    "Static pressure setpoint [pa]"
    annotation (Placement(transformation(extent={{-978,274},{-900,344}})));
  Buildings.Fluid.Sensors.Pressure senPreMix(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-834,-14},{-786,34}})));
  Modelica.Blocks.Math.Add minus(k2=-1)
    annotation (Placement(transformation(extent={{-966,204},{-924,246}})));
  Modelica.Blocks.Sources.RealExpression senPreSup_(y=senPreSup.p)
    annotation (Placement(transformation(extent={{-1146,204},{-1018,286}})));
  Modelica.Blocks.Sources.RealExpression Pat(y=101325)
    "atmospheric pressure [pa]"
    annotation (Placement(transformation(extent={{-1146,162},{-1018,236}})));
  Buildings.Controls.Continuous.LimPID confan(
    yMax=1,
    Td=60,
    k=0.1/100,
    Ti=60,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0.5,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=true)  "Controller for fan"
    annotation (Placement(transformation(extent={{-848,276},{-776,348}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_before_CC(redeclare package
      Medium =                                                                      MediumA,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-700,-46},{-666,8}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_after_CC(redeclare package
      Medium = MediumA, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-496,-42},{-462,12}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Supply air temperature"
    annotation (Placement(transformation(extent={{-348,-48},{-314,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Return air temperature"
    annotation (Placement(transformation(extent={{-204,-328},{-170,-274}})));
  RTUVAV.Component.supplyTempCon supplyTempCon
    annotation (Placement(transformation(extent={{-710,314},{-588,368}})));
  RTUVAV.Component.thermostat_T thermostat_T
    annotation (Placement(transformation(extent={{-378,220},{-232,322}})));
equation
  connect(out.ports[1],mixBox. port_Out) annotation (Line(points={{-932,-14},{
          -916,-14},{-916,-18.8},{-898,-18.8}},
                                           color={0,127,255}));
  connect(mixBox.port_Sup, fan.port_a) annotation (Line(points={{-814,-18.8},{
          -788,-18.8},{-788,-15},{-790,-15}},
                                         color={0,127,255}));
  connect(senMret.port_b,mixBox. port_Ret) annotation (Line(points={{-574,-298},
          {-814,-298},{-814,-69.2}},                         color={0,127,255}));
  connect(mixBox.port_Exh,out. ports[2]) annotation (Line(points={{-898,-69.2},
          {-932,-69.2},{-932,-22}},color={0,127,255}));
  connect(OA_actuator.y, mixBox.y) annotation (Line(points={{-908,55},{-882,55},
          {-882,6.4},{-856,6.4}}, color={0,0,127}));
  connect(SupAirTemSPHeating.y, eleHea.TSet) annotation (Line(points={{-491,186},
          {-450,186},{-450,98},{-450.6,98},{-450.6,9}}, color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_1.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_204[1]) annotation (Line(points={{93.72,
          291.545},{98,291.545},{98,396},{608,396},{608,265.8},{627.162,265.8}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_4.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_104[1]) annotation (Line(points={{99.74,
          -7.04545},{124,-7.04545},{124,66},{590,66},{590,38.66},{605.003,38.66}},
                                                                       color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.weaBus1, out.weaBus) annotation (Line(
      points={{602.952,-122.88},{602.952,-400},{-972,-400},{-972,-17.6}},
      color={255,204,51},
      thickness=0.5));
  connect(vAVReHeat_withCtrl_TRooCon_v2_9.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_203[1]) annotation (Line(points={{273.72,
          291.545},{273.72,388},{740,388},{740,346},{736.314,346},{736.314,
          299.42}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_5.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_205[1]) annotation (Line(points={{35.62,
          196.464},{44,196.464},{44,200},{52,200},{52,222},{604,222},{604,206},
          {602.952,206},{602.952,203.48}},color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_6.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_202[1]) annotation (Line(points={{191.72,
          181.545},{200,181.545},{200,184},{202,184},{202,238},{698,238},{698,
          256},{710,256},{710,251.86},{716.207,251.86}},
                                                    color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_10.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_206[1]) annotation (Line(points={{377.72,
          177.545},{388,177.545},{388,178},{794.993,178},{794.993,188.72}},
                                                                        color={
          0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_8.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_102[1]) annotation (Line(points={{271.74,
          -3.04545},{298,-3.04545},{298,70},{740,70},{740,63.26},{739.186,63.26}},
                                                                     color={0,
          127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_3.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_105[1]) annotation (Line(points={{25.74,
          -111.045},{44,-111.045},{44,-46},{558,-46},{558,-30},{600,-30},{600,
          -35.14},{611.979,-35.14}},
                            color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_7.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_103[1]) annotation (Line(points={{187.74,
          -109.045},{196,-109.045},{196,-52},{716,-52},{716,16},{714.976,16},{
          714.976,11.6}},
                  color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_2.port_b,
    fRPMultiZone_Envelope_Icon_v1_1.port_106[1]) annotation (Line(points={{369.74,
          -111.045},{384,-111.045},{384,-60},{732,-60},{732,-44.98},{800.738,
          -44.98}},
        color={0,127,255}));
  connect(senPreSup.port, splSupRoo.port_1)
    annotation (Line(points={{-276,-20},{-228,-20}}, color={0,127,255}));
  connect(splSupRoo1.port_3, vAVReHeat_withCtrl_TRooCon_v2_5.port_a)
    annotation (Line(points={{-68,493},{-54,493},{-54,197.309},{-39.62,197.309}},
        color={0,127,255}));
  connect(splSupRoo1.port_2, splSupRoo2.port_1) annotation (Line(points={{-42,519},
          {-24,519},{-24,510},{-14,510},{-14,517},{-8,517}},
                                        color={0,127,255}));
  connect(splSupRoo2.port_3, vAVReHeat_withCtrl_TRooCon_v2_1.port_a)
    annotation (Line(points={{18,491},{18,292.364},{38.28,292.364}},
                                                              color={0,127,255}));
  connect(splSupRoo2.port_2, splSupRoo3.port_1) annotation (Line(points={{44,517},
          {66,517},{66,508},{76,508},{76,517},{86,517}},
                                       color={0,127,255}));
  connect(splSupRoo3.port_3, vAVReHeat_withCtrl_TRooCon_v2_6.port_a)
    annotation (Line(points={{112,491},{112,182.364},{136.28,182.364}},
                                                                 color={0,127,
          255}));
  connect(splSupRoo3.port_2, splSupRoo4.port_1) annotation (Line(points={{138,517},
          {158,517},{158,508},{168,508},{168,517},{176,517}},
                                          color={0,127,255}));
  connect(splSupRoo4.port_3, vAVReHeat_withCtrl_TRooCon_v2_9.port_a)
    annotation (Line(points={{202,491},{202,292.364},{218.28,292.364}},
                                                                 color={0,127,
          255}));
  connect(splSupRoo4.port_2, vAVReHeat_withCtrl_TRooCon_v2_10.port_a)
    annotation (Line(points={{228,517},{302,517},{302,178.364},{322.28,178.364}},
        color={0,127,255}));
  connect(splSupRoo.port_2, splSupRoo5.port_1) annotation (Line(points={{-172,
          -20},{-136,-20},{-136,-208},{-80,-208}},
                                              color={0,127,255}));
  connect(splSupRoo5.port_2, splSupRoo6.port_1)
    annotation (Line(points={{-28,-208},{-10,-208},{-10,-206},{8,-206}},
                                                   color={0,127,255}));
  connect(splSupRoo6.port_2, splSupRoo7.port_1)
    annotation (Line(points={{60,-206},{72,-206},{72,-204},{82,-204},{82,-206},{
          102,-206}},                               color={0,127,255}));
  connect(splSupRoo7.port_2, splSupRoo8.port_1)
    annotation (Line(points={{154,-206},{164,-206},{164,-204},{172,-204},{172,-206},
          {186,-206}},                               color={0,127,255}));
  connect(splSupRoo5.port_3, vAVReHeat_withCtrl_TRooCon_v2_3.port_a)
    annotation (Line(points={{-54,-182},{-54,-110.364},{-25.74,-110.364}},
                                                                color={0,127,
          255}));
  connect(splSupRoo6.port_3, vAVReHeat_withCtrl_TRooCon_v2_4.port_a)
    annotation (Line(points={{34,-180},{32,-180},{32,-6.36364},{48.26,-6.36364}},
                                                                   color={0,127,
          255}));
  connect(splSupRoo7.port_3, vAVReHeat_withCtrl_TRooCon_v2_7.port_a)
    annotation (Line(points={{128,-180},{128,-108.364},{136.26,-108.364}},
                                                                color={0,127,
          255}));
  connect(splSupRoo8.port_3, vAVReHeat_withCtrl_TRooCon_v2_8.port_a)
    annotation (Line(points={{212,-180},{212,-2.36364},{220.26,-2.36364}},
                                                          color={0,127,255}));
  connect(splSupRoo8.port_2, vAVReHeat_withCtrl_TRooCon_v2_2.port_a)
    annotation (Line(points={{238,-206},{302,-206},{302,-110.364},{318.26,
          -110.364}},
        color={0,127,255}));
  connect(splSupRoo.port_3, splSupRoo1.port_1) annotation (Line(points={{-200,8},
          {-198,8},{-198,519},{-94,519}},  color={0,127,255}));
  connect(splRetRoo1.port_1, fRPMultiZone_Envelope_Icon_v1_1.port_205[2])
    annotation (Line(points={{646,509},{632.497,509},{632.497,203.48}}, color={
          0,127,255}));
  connect(splRetRoo1.port_3, fRPMultiZone_Envelope_Icon_v1_1.port_204[2])
    annotation (Line(points={{671,484},{671,265.8},{655.886,265.8}}, color={0,
          127,255}));
  connect(splRetRoo1.port_2, splRetRoo2.port_1) annotation (Line(points={{696,509},
          {716,509},{716,506},{724,506},{724,507},{732,507}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_202[2], splRetRoo2.port_3)
    annotation (Line(points={{742.469,251.86},{757,251.86},{757,482}}, color={0,
          127,255}));
  connect(splRetRoo2.port_2, splRetRoo3.port_1) annotation (Line(points={{782,507},
          {800,507},{800,506},{808,506},{808,507},{818,507}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_203[2], splRetRoo3.port_3)
    annotation (Line(points={{760.114,299.42},{843,299.42},{843,482}}, color={0,
          127,255}));
  connect(splRetRoo3.port_2, splRetRoo4.port_1) annotation (Line(points={{868,507},
          {880,507},{880,506},{888,506},{888,505},{898,505}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_206[2], splRetRoo4.port_3)
    annotation (Line(points={{817.972,188.72},{923,188.72},{923,480}}, color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_105[2], splRetRoo5.port_1)
    annotation (Line(points={{636.6,-35.14},{636.6,-209},{656,-209}}, color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_104[2], splRetRoo5.port_3)
    annotation (Line(points={{632.086,38.66},{681,38.66},{681,-184}}, color={0,
          127,255}));
  connect(splRetRoo5.port_2, splRetRoo6.port_1) annotation (Line(points={{706,-209},
          {718,-209},{718,-210},{726,-210},{726,-209},{742,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_103[2], splRetRoo6.port_3)
    annotation (Line(points={{738.776,11.6},{767,11.6},{767,-184}}, color={0,
          127,255}));
  connect(splRetRoo6.port_2, splRetRoo7.port_1) annotation (Line(points={{792,-209},
          {802,-209},{802,-210},{810,-210},{810,-209},{822,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_102[2], splRetRoo7.port_3)
    annotation (Line(points={{762.166,63.26},{847,63.26},{847,-184}}, color={0,
          127,255}));
  connect(splRetRoo7.port_2, splRetRoo8.port_1) annotation (Line(points={{872,-209},
          {882,-209},{882,-210},{890,-210},{890,-209},{902,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon_v1_1.port_106[2], splRetRoo8.port_3)
    annotation (Line(points={{825.359,-44.98},{927,-44.98},{927,-184}}, color={
          0,127,255}));
  connect(splRetRoo8.port_2, splRetRoo.port_3) annotation (Line(points={{952,
          -209},{1006,-209},{1006,122},{1044,122}},
                                              color={0,127,255}));
  connect(splRetRoo4.port_2, splRetRoo.port_2) annotation (Line(points={{948,505},
          {1072,505},{1072,150}}, color={0,127,255}));

  connect(TRooSec.u, fRPMultiZone_Envelope_Icon_v1_1.TrooVecSec) annotation (
      Line(
      points={{-304.2,369},{-350,369},{-350,566},{1112,566},{1112,229.72},{
          962.414,229.72}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.u, fRPMultiZone_Envelope_Icon_v1_1.TrooVecFir) annotation (
      Line(
      points={{-300.2,-147},{-350,-147},{-350,-336},{1112,-336},{1112,29.64},{
          964.055,29.64}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y5[1], vAVReHeat_withCtrl_TRooCon_v2_3.TRoo) annotation (Line(
      points={{-228.9,-163.74},{-76,-163.74},{-76,-66},{-6.5,-66},{-6.5,-84}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(HeaterControl.y, eleHea.on) annotation (Line(points={{-518.2,130},{
          -450.6,130},{-450.6,-8.5}},  color={255,0,255}));
  connect(TRooFir.y4[1], vAVReHeat_withCtrl_TRooCon_v2_4.TRoo) annotation (Line(
      points={{-228.9,-152.58},{-68,-152.58},{-68,40},{67.5,40},{67.5,20}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y3[1], vAVReHeat_withCtrl_TRooCon_v2_7.TRoo) annotation (Line(
      points={{-228.9,-141.42},{-82,-141.42},{-82,-62},{155.5,-62},{155.5,-82}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y2[1], vAVReHeat_withCtrl_TRooCon_v2_8.TRoo) annotation (Line(
      points={{-228.9,-130.26},{-86,-130.26},{-86,44},{239.5,44},{239.5,24}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y6[1], vAVReHeat_withCtrl_TRooCon_v2_2.TRoo) annotation (Line(
      points={{-228.9,-174.9},{296,-174.9},{296,-64},{337.5,-64},{337.5,-84}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y4[1], vAVReHeat_withCtrl_TRooCon_v2_1.TRoo) annotation (Line(
      points={{-232.9,363.42},{59,363.42},{59,324}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y2[1], vAVReHeat_withCtrl_TRooCon_v2_6.TRoo) annotation (Line(
      points={{-232.9,385.74},{157,385.74},{157,214}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y3[1], vAVReHeat_withCtrl_TRooCon_v2_9.TRoo) annotation (Line(
      points={{-232.9,374.58},{239,374.58},{239,324}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y6[1], vAVReHeat_withCtrl_TRooCon_v2_10.TRoo) annotation (
      Line(
      points={{-232.9,341.1},{343,341.1},{343,210}},
      color={0,0,0},
      pattern=LinePattern.Dash));

  connect(out.weaBus, weaBus1) annotation (Line(
      points={{-972,-17.6},{-972,-18},{-1054,-18},{-1054,160},{-818,160}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus1.TDryBul, TOA) annotation (Line(
      points={{-818,160},{-782,160},{-782,159},{-734,159}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TOA,DX. TConIn) annotation (Line(points={{-734,159},{-660,159},{-660,
          8.6},{-644.2,8.6}},         color={0,0,127}));

  connect(mixBox.port_Sup, senPreMix.port) annotation (Line(points={{-814,-18.8},
          {-814,-16.4},{-810,-16.4},{-810,-14}}, color={0,127,255}));
  connect(senPreSup_.y, minus.u1) annotation (Line(
      points={{-1011.6,245},{-986.8,245},{-986.8,237.6},{-970.2,237.6}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(Pat.y, minus.u2) annotation (Line(
      points={{-1011.6,199},{-982.8,199},{-982.8,212.4},{-970.2,212.4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(StaPre_SP.y, confan.u_s) annotation (Line(points={{-896.1,309},{
          -914.8,309},{-914.8,312},{-855.2,312}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(minus.y, confan.u_m) annotation (Line(
      points={{-921.9,225},{-862.95,225},{-862.95,268.8},{-812,268.8}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(confan.y, fan.y) annotation (Line(points={{-772.4,312},{-756,312},{
          -756,22.2},{-755,22.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(fan.port_b, T_before_CC.port_a) annotation (Line(points={{-720,-15},{
          -710,-15},{-710,-19},{-700,-19}},
                                       color={0,127,255}));
  connect(T_before_CC.port_b, DX.port_a) annotation (Line(points={{-666,-19},{
          -648,-19},{-648,-10},{-638,-10}},
                                       color={0,127,255}));
  connect(DX.port_b, T_after_CC.port_a) annotation (Line(points={{-514,-10},{
          -504,-10},{-504,-15},{-496,-15}}, color={0,127,255}));
  connect(T_after_CC.port_b, eleHea.port_a) annotation (Line(points={{-462,-15},
          {-452,-15},{-452,-19},{-444,-19}}, color={0,127,255}));
  connect(eleHea.port_b, TSA.port_a) annotation (Line(points={{-378,-19},{-363,
          -19},{-363,-21},{-348,-21}}, color={0,127,255}));
  connect(TSA.port_b, senPreSup.port) annotation (Line(points={{-314,-21},{-295,
          -21},{-295,-20},{-276,-20}}, color={0,127,255}));
  connect(senMret.port_a, TRA.port_a) annotation (Line(points={{-510,-298},{
          -359,-298},{-359,-301},{-204,-301}}, color={0,127,255}));
  connect(TRA.port_b, splRetRoo.port_1) annotation (Line(points={{-170,-301},{
          1072,-301},{1072,94}}, color={0,127,255}));
  connect(supplyTempCon.TSupSet_out, DX.speRat) annotation (Line(
      points={{-584.611,338.686},{-584.611,268},{-600,268},{-600,64},{-644.2,64},
          {-644.2,39.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(T_after_CC.T, supplyTempCon.u_m1) annotation (Line(
      points={{-479,14.7},{-479,150},{-480,150},{-480,284},{-619.856,284},{
          -619.856,310.914}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_5.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-28.6,291.4},{-28.6,230}}, color
        ={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_1.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-24,291.4},{-24,352},{46.4,352},
          {46.4,324}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_6.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-22,291.4},{-22,402},{144.4,402},
          {144.4,214}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_9.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-22,291.4},{-22,402},{226.4,402},
          {226.4,324}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_10.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-22,291.4},{-22,402},{330.4,402},
          {330.4,210}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_3.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-60,291.4},{-60,100},{-18.2,100},
          {-18.2,-84}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_4.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-58,291.4},{-58,100},{55.8,100},
          {55.8,20}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_7.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-58,291.4},{-58,100},{143.8,100},
          {143.8,-82}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_8.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-142,291.4},{-142,292},{-58,292},
          {-58,100},{232,100},{232,64},{227.8,64},{227.8,24}}, color={0,0,127}));
  connect(thermostat_T.TZonHeatingSet_out, vAVReHeat_withCtrl_TRooCon_v2_2.TRooHeaSet)
    annotation (Line(points={{-226.385,291.4},{-144,291.4},{-144,292},{-60,292},
          {-60,100},{325.8,100},{325.8,-84}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_5.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{20,260.8},{20,250},{1.8,250},{
          1.8,230}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_9.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{20,260.8},{20,386},{248.8,386},{
          248.8,324}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_10.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{20,260.8},{20,386},{352.8,386},{
          352.8,210}}, color={0,0,127}));
  connect(TRooSec.y5[1], vAVReHeat_withCtrl_TRooCon_v2_5.TRoo) annotation (Line(
      points={{-232.9,352.26},{-11.5,352.26},{-11.5,230}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_6.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{20,260.8},{20,386},{166.8,386},{
          166.8,214}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_3.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{-76,260.8},{-76,80},{2.6,80},{
          2.6,-84}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_4.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{-74,260.8},{-74,78},{76.6,78},{
          76.6,20}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_7.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{-74,260.8},{-74,78},{164.6,78},{
          164.6,-82}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_8.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{-76,260.8},{-76,78},{248.6,78},{
          248.6,24}}, color={0,0,127}));
  connect(thermostat_T.TZonCoolingSet_out, vAVReHeat_withCtrl_TRooCon_v2_2.TRooCooSet)
    annotation (Line(points={{-226.385,260.8},{-76,260.8},{-76,78},{346.6,78},{
          346.6,-84}}, color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_1.TRooCooSet, thermostat_T.TZonCoolingSet_out)
    annotation (Line(points={{68.8,324},{68.8,370},{6,370},{6,260.8},{-226.385,
          260.8}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-1160,-420},{1160,620}})),
    experiment(
      StopTime=31536000,
      Interval=300,
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
end RTU_VAV_Control_Example_FRP;
