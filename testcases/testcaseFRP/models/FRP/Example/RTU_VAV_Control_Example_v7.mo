within FRP.Example;
model RTU_VAV_Control_Example_v7 "update to 8.1"
    extends Modelica.Icons.Example;
    package MediumA = Buildings.Media.Air "Medium model";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1.86; // kg/s
    parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=44000; // Rated cooling capacity
    parameter Modelica.SIunits.HeatFlowRate H_Q_flow_nominal=44000;  //Rated Heating capacity
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+22; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+22; // zone cooling setpoint setback 75.2F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+18; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+18; // zone heating setpoint setback 64.4F
    parameter Real NumOfRoo = 10;
    //parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal=m_flow_nominal/NumOfRoo;
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
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_102= 0.091;  //kg/s
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_103= 0.123;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_104= 0.199;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_105= 0.238;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_106= 0.227;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_202= 0.159;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_203= 0.093;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_204= 0.268;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_205= 0.231;
    parameter Modelica.SIunits.MassFlowRate VAV_m_flow_nominal_206= 0.235;

    parameter Modelica.SIunits.PressureDifference dp_nominal=1 "nominal pressure loss";
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox=(220+20)/2 "VAV box pressure loss";
    parameter Modelica.SIunits.PressureDifference dp_nominal_fan=1000 "nominal pressure rise";
    parameter Modelica.SIunits.PressureDifference dp_nominal_fan_max=dp_nominal_fan/0.6 "maximum dP for zero-flow for a fan";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_max=m_flow_nominal/0.4 "maximum air flow rate for zero-pressure loss for a fan";

    parameter Boolean allowFlowReversal=true;
  FRP.Envelope.FRPMultiZone_Envelope_Icon fRPMultiZone_Envelope_Icon
    annotation (Placement(transformation(extent={{470,-134},{946,358}})));
  Buildings.Fluid.Sources.Outside out(redeclare package Medium = MediumA,
      nPorts=2)
    annotation (Placement(transformation(extent={{-972,-38},{-932,2}})));

  Buildings.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = MediumA,
    allowFlowReversal=true,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per(pressure(V_flow=
           m_flow_nominal_max*{0,0.2,0.4,0.6,0.8}/1.2, dp=dp_nominal_fan_max*{1,
            0.9,0.85,0.6,0.2})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-790,-50},{-720,12}})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed
                                                               DX(
    datCoi=datCoi,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=dp_nominal,
    minSpeRat=0) "multi-stage DX unit"
    annotation (Placement(transformation(extent={{-636,-78},{-512,46}})));
  Buildings.Fluid.Sensors.Pressure senPreSup(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-308,-20},{-260,28}})));
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
    annotation (Placement(transformation(extent={{-898,-84},{-814,0}})));
  Modelica.Blocks.Sources.RealExpression OA_actuator(y=0)
    annotation (Placement(transformation(extent={{-950,26},{-910,84}})));
  Buildings.Applications.DataCenters.ChillerCooled.Equipment.ElectricHeater eleHea(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    QMax_flow(displayUnit="kW") = H_Q_flow_nominal,
    dp_nominal=200 + 200 + 100 + 40,
    eta=0.81)
    "Electric heater"
    annotation (Placement(transformation(extent={{-444,-56},{-378,14}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSPHeating(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-596,152},{-496,220}})));
    // use FRP performance curve

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.DXCoil datCoi(
    minSpeRat=0,
    nSta=3,
    sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=600/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21871/39724/2*Q_flow_nominal,
          COP_nominal=3.56,
          SHR_nominal=0.8,
          m_flow_nominal=21871/39724/2*m_flow_nominal),
        perCur=FRP.RTUVAV.Performance_Stage0()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21871/39724*Q_flow_nominal,
          COP_nominal=3.559,
          SHR_nominal=0.8,
          m_flow_nominal=21871/39724*m_flow_nominal),
        perCur=FRP.RTUVAV.Performance_Stage1()),
        Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.Stage(
        spe=3600/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-Q_flow_nominal,
          COP_nominal=3.223,
          SHR_nominal=0.713,
          m_flow_nominal=m_flow_nominal),
        perCur=FRP.RTUVAV.Performance_Stage2())})                                                                                                   "Coil data"
    annotation (Placement(transformation(extent={{-982,466},{-920,528}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_1(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{48,-26},{100,24}})));

  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_3(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_204,
    Q_flow_nominal=VAV_Heater_nominal_204,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{40,274},{96,334}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_4(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_203,
    Q_flow_nominal=VAV_Heater_nominal_203,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{220,274},{276,334}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_5(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{-14,170},{42,230}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_6(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_202,
    Q_flow_nominal=VAV_Heater_nominal_202,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{138,164},{194,224}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_7(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_206,
    Q_flow_nominal=VAV_Heater_nominal_206,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{322,158},{378,218}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_8(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_102,
    Q_flow_nominal=VAV_Heater_nominal_102,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{220,-20},{272,30}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_9(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_105,
    Q_flow_nominal=VAV_Heater_nominal_105,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{-26,-136},{26,-86}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_10(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_103,
    Q_flow_nominal=VAV_Heater_nominal_103,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{136,-128},{188,-78}})));
  RTUVAV.Component.VAVReHeat_withCtrl_TRooCon_v2  vAVReHeat_withCtrl_TRooCon_v2_2(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_106,
    Q_flow_nominal=VAV_Heater_nominal_106,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{318,-130},{370,-80}})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-28,28},{28,-28}},
        rotation=0,
        origin={-200,-20})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,4/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={-60,517})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={28,515})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={120,515})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{26,26},{-26,-26}},
        rotation=180,
        origin={210,515})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,4/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={-54,-208})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={34,-206})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={128,-206})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply" annotation (Placement(transformation(
        extent={{-26,26},{26,-26}},
        rotation=0,
        origin={212,-206})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={679,507})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={765,507})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={845,507})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={925,505})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={681,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={767,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={847,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={927,-209})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for return"      annotation (Placement(transformation(
        extent={{-28,28},{28,-28}},
        rotation=90,
        origin={1074,122})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooSec
    annotation (Placement(transformation(extent={{-298,336},{-236,398}})));
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
  Buildings.Controls.Continuous.LimPID conDX(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=false)
                        "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{-582,412},{-510,484}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSP(y=273.15 + 12.78)
    "Supply air temperature setpoint [K]"
    annotation (Placement(transformation(extent={{-760,406},{-632,488}})));
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
    k=0.01,
    Ti=60,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit)
                         "Controller for fan"
    annotation (Placement(transformation(extent={{-848,280},{-776,352}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP2(
    table=[0,SP_TCSP_setback; 3600*8,SP_TCSP; 3600*18,SP_TCSP_setback],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature-second floor [K]"
    annotation (Placement(transformation(extent={{-150,442},{-116,476}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP1(
    table=[0,SP_TCSP_setback; 3600*8,SP_TCSP; 3600*18,SP_TCSP_setback],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature-first floor [K]"
    annotation (Placement(transformation(extent={{-140,112},{-106,146}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP2(
    table=[0,SP_THSP_setback; 3600*8,SP_THSP; 3600*18,SP_THSP_setback],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature-second floor [K]"
    annotation (Placement(transformation(extent={{-148,390},{-114,424}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP1(
    table=[0,SP_THSP_setback; 3600*8,SP_THSP; 3600*18,SP_THSP_setback],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature-first floor [K]"
    annotation (Placement(transformation(extent={{-140,62},{-106,96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_before_CC(redeclare package
      Medium =                                                                      MediumA,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-700,-46},{-666,8}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort T_after_CC(redeclare package
      Medium = MediumA, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-496,-42},{-462,12}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Supply air temperature"
    annotation (Placement(transformation(extent={{-358,-48},{-324,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRA(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Return air temperature"
    annotation (Placement(transformation(extent={{-204,-328},{-170,-274}})));
equation
  connect(out.ports[1],mixBox. port_Out) annotation (Line(points={{-932,-14},{
          -916,-14},{-916,-16.8},{-898,-16.8}},
                                           color={0,127,255}));
  connect(mixBox.port_Sup, fan.port_a) annotation (Line(points={{-814,-16.8},{
          -788,-16.8},{-788,-19},{-790,-19}},
                                         color={0,127,255}));
  connect(senMret.port_b,mixBox. port_Ret) annotation (Line(points={{-574,-298},
          {-814,-298},{-814,-67.2}},                         color={0,127,255}));
  connect(mixBox.port_Exh,out. ports[2]) annotation (Line(points={{-898,-67.2},
          {-932,-67.2},{-932,-22}},color={0,127,255}));
  connect(OA_actuator.y, mixBox.y) annotation (Line(points={{-908,55},{-882,55},
          {-882,8.4},{-856,8.4}}, color={0,0,127}));
  connect(SupAirTemSPHeating.y, eleHea.TSet) annotation (Line(points={{-491,186},
          {-450,186},{-450,98},{-450.6,98},{-450.6,7}}, color={0,0,127}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_3.port_b, fRPMultiZone_Envelope_Icon.port_204
    [1]) annotation (Line(points={{96,305.2},{98,305.2},{98,396},{608,396},{608,
          267.8},{627.162,267.8}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_1.port_b, fRPMultiZone_Envelope_Icon.port_104
    [1]) annotation (Line(points={{100,0},{124,0},{124,66},{590,66},{590,40.66},
          {605.003,40.66}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.weaBus1, out.weaBus) annotation (Line(
      points={{602.952,-120.88},{602.952,-398},{-972,-398},{-972,-17.6}},
      color={255,204,51},
      thickness=0.5));
  connect(vAVReHeat_withCtrl_TRooCon_v2_4.port_b, fRPMultiZone_Envelope_Icon.port_203
    [1]) annotation (Line(points={{276,305.2},{276,388},{740,388},{740,346},{
          736.314,346},{736.314,301.42}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_5.port_b, fRPMultiZone_Envelope_Icon.port_205
    [1]) annotation (Line(points={{42,201.2},{44,201.2},{44,180},{50,180},{50,
          222},{604,222},{604,206},{602.952,206},{602.952,205.48}}, color={0,
          127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_6.port_b, fRPMultiZone_Envelope_Icon.port_202
    [1]) annotation (Line(points={{194,195.2},{200,195.2},{200,178},{204,178},{
          204,238},{698,238},{698,256},{710,256},{710,253.86},{716.207,253.86}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_7.port_b, fRPMultiZone_Envelope_Icon.port_206
    [1]) annotation (Line(points={{378,189.2},{388,189.2},{388,178},{794.993,
          178},{794.993,190.72}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_8.port_b, fRPMultiZone_Envelope_Icon.port_102
    [1]) annotation (Line(points={{272,6},{298,6},{298,70},{740,70},{740,65.26},
          {739.186,65.26}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_9.port_b, fRPMultiZone_Envelope_Icon.port_105
    [1]) annotation (Line(points={{26,-110},{44,-110},{44,-46},{558,-46},{558,
          -30},{600,-30},{600,-33.14},{611.979,-33.14}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_10.port_b, fRPMultiZone_Envelope_Icon.port_103
    [1]) annotation (Line(points={{188,-102},{196,-102},{196,-52},{716,-52},{
          716,16},{714.976,16},{714.976,13.6}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon_v2_2.port_b, fRPMultiZone_Envelope_Icon.port_106
    [1]) annotation (Line(points={{370,-104},{384,-104},{384,-60},{732,-60},{
          732,-42.98},{800.738,-42.98}}, color={0,127,255}));
  connect(senPreSup.port, splSupRoo.port_1)
    annotation (Line(points={{-284,-20},{-228,-20}}, color={0,127,255}));
  connect(splSupRoo1.port_3, vAVReHeat_withCtrl_TRooCon_v2_5.port_a)
    annotation (Line(points={{-60,491},{-56,491},{-56,201.2},{-14,201.2}},
        color={0,127,255}));
  connect(splSupRoo1.port_2, splSupRoo2.port_1) annotation (Line(points={{-34,517},
          {-24,517},{-24,510},{-14,510},{-14,515},{2,515}},
                                        color={0,127,255}));
  connect(splSupRoo2.port_3, vAVReHeat_withCtrl_TRooCon_v2_3.port_a)
    annotation (Line(points={{28,489},{28,305.2},{40,305.2}}, color={0,127,255}));
  connect(splSupRoo2.port_2, splSupRoo3.port_1) annotation (Line(points={{54,515},
          {66,515},{66,508},{76,508},{76,515},{94,515}},
                                       color={0,127,255}));
  connect(splSupRoo3.port_3, vAVReHeat_withCtrl_TRooCon_v2_6.port_a)
    annotation (Line(points={{120,489},{120,195.2},{138,195.2}}, color={0,127,
          255}));
  connect(splSupRoo3.port_2, splSupRoo4.port_1) annotation (Line(points={{146,515},
          {158,515},{158,508},{168,508},{168,515},{184,515}},
                                          color={0,127,255}));
  connect(splSupRoo4.port_3, vAVReHeat_withCtrl_TRooCon_v2_4.port_a)
    annotation (Line(points={{210,489},{210,305.2},{220,305.2}}, color={0,127,
          255}));
  connect(splSupRoo4.port_2, vAVReHeat_withCtrl_TRooCon_v2_7.port_a)
    annotation (Line(points={{236,515},{302,515},{302,189.2},{322,189.2}},
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
  connect(splSupRoo5.port_3, vAVReHeat_withCtrl_TRooCon_v2_9.port_a)
    annotation (Line(points={{-54,-182},{-54,-110},{-26,-110}}, color={0,127,
          255}));
  connect(splSupRoo6.port_3, vAVReHeat_withCtrl_TRooCon_v2_1.port_a)
    annotation (Line(points={{34,-180},{32,-180},{32,0},{48,0}}, color={0,127,
          255}));
  connect(splSupRoo7.port_3, vAVReHeat_withCtrl_TRooCon_v2_10.port_a)
    annotation (Line(points={{128,-180},{128,-102},{136,-102}}, color={0,127,
          255}));
  connect(splSupRoo8.port_3, vAVReHeat_withCtrl_TRooCon_v2_8.port_a)
    annotation (Line(points={{212,-180},{212,6},{220,6}}, color={0,127,255}));
  connect(splSupRoo8.port_2, vAVReHeat_withCtrl_TRooCon_v2_2.port_a)
    annotation (Line(points={{238,-206},{302,-206},{302,-104},{318,-104}},
        color={0,127,255}));
  connect(splSupRoo.port_3, splSupRoo1.port_1) annotation (Line(points={{-200,8},
          {-198,8},{-198,517},{-86,517}},  color={0,127,255}));
  connect(splRetRoo1.port_1, fRPMultiZone_Envelope_Icon.port_205[2])
    annotation (Line(points={{654,507},{632.497,507},{632.497,205.48}}, color={0,
          127,255}));
  connect(splRetRoo1.port_3, fRPMultiZone_Envelope_Icon.port_204[2])
    annotation (Line(points={{679,482},{679,267.8},{655.886,267.8}}, color={0,127,
          255}));
  connect(splRetRoo1.port_2, splRetRoo2.port_1) annotation (Line(points={{704,507},
          {716,507},{716,506},{724,506},{724,507},{740,507}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_202[2], splRetRoo2.port_3)
    annotation (Line(points={{742.469,253.86},{765,253.86},{765,482}}, color={0,
          127,255}));
  connect(splRetRoo2.port_2, splRetRoo3.port_1) annotation (Line(points={{790,507},
          {800,507},{800,506},{808,506},{808,507},{820,507}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_203[2], splRetRoo3.port_3)
    annotation (Line(points={{760.114,301.42},{845,301.42},{845,482}}, color={0,
          127,255}));
  connect(splRetRoo3.port_2, splRetRoo4.port_1) annotation (Line(points={{870,507},
          {880,507},{880,506},{888,506},{888,505},{900,505}},
                                          color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_206[2], splRetRoo4.port_3)
    annotation (Line(points={{817.972,190.72},{925,190.72},{925,480}}, color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_105[2], splRetRoo5.port_1)
    annotation (Line(points={{636.6,-33.14},{636.6,-209},{656,-209}}, color={0,127,
          255}));
  connect(fRPMultiZone_Envelope_Icon.port_104[2], splRetRoo5.port_3)
    annotation (Line(points={{632.086,40.66},{681,40.66},{681,-184}}, color={0,127,
          255}));
  connect(splRetRoo5.port_2, splRetRoo6.port_1) annotation (Line(points={{706,-209},
          {718,-209},{718,-210},{726,-210},{726,-209},{742,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_103[2], splRetRoo6.port_3)
    annotation (Line(points={{738.776,13.6},{767,13.6},{767,-184}}, color={0,127,
          255}));
  connect(splRetRoo6.port_2, splRetRoo7.port_1) annotation (Line(points={{792,-209},
          {802,-209},{802,-210},{810,-210},{810,-209},{822,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_102[2], splRetRoo7.port_3)
    annotation (Line(points={{762.166,65.26},{847,65.26},{847,-184}}, color={0,127,
          255}));
  connect(splRetRoo7.port_2, splRetRoo8.port_1) annotation (Line(points={{872,-209},
          {882,-209},{882,-210},{890,-210},{890,-209},{902,-209}},
                                             color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_106[2], splRetRoo8.port_3)
    annotation (Line(points={{825.359,-42.98},{927,-42.98},{927,-184}}, color={0,
          127,255}));
  connect(splRetRoo8.port_2, splRetRoo.port_3) annotation (Line(points={{952,-209},
          {1006,-209},{1006,122},{1046,122}}, color={0,127,255}));
  connect(splRetRoo4.port_2, splRetRoo.port_2) annotation (Line(points={{950,505},
          {1074,505},{1074,150}}, color={0,127,255}));

  connect(TRooSec.u, fRPMultiZone_Envelope_Icon.TrooVecSec) annotation (Line(
        points={{-304.2,367},{-350,367},{-350,566},{1112,566},{1112,231.72},{
          962.414,231.72}},
                    color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.u, fRPMultiZone_Envelope_Icon.TrooVecFir) annotation (Line(
        points={{-300.2,-147},{-350,-147},{-350,-336},{1112,-336},{1112,31.64},
          {964.055,31.64}},color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y5[1], vAVReHeat_withCtrl_TRooCon_v2_9.TRoo) annotation (Line(
      points={{-228.9,-163.74},{-76,-163.74},{-76,-66},{-6.93333,-66},{-6.93333,
          -82.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(HeaterControl.y, eleHea.on) annotation (Line(points={{-518.2,130},{
          -450.6,130},{-450.6,-10.5}}, color={255,0,255}));
  connect(TRooFir.y4[1], vAVReHeat_withCtrl_TRooCon_v2_1.TRoo) annotation (Line(
      points={{-228.9,-152.58},{-68,-152.58},{-68,40},{67.0667,40},{67.0667,
          27.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y3[1], vAVReHeat_withCtrl_TRooCon_v2_10.TRoo) annotation (
      Line(
      points={{-228.9,-141.42},{-82,-141.42},{-82,-62},{155.067,-62},{155.067,
          -74.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y2[1], vAVReHeat_withCtrl_TRooCon_v2_8.TRoo) annotation (Line(
      points={{-228.9,-130.26},{-86,-130.26},{-86,44},{239.067,44},{239.067,
          33.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y6[1], vAVReHeat_withCtrl_TRooCon_v2_2.TRoo) annotation (Line(
      points={{-228.9,-174.9},{296,-174.9},{296,-64},{337.067,-64},{337.067,
          -76.5}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y5[1], vAVReHeat_withCtrl_TRooCon_v2_5.TRoo) annotation (Line(
      points={{-232.9,350.26},{6.53333,350.26},{6.53333,234.2}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y4[1], vAVReHeat_withCtrl_TRooCon_v2_3.TRoo) annotation (Line(
      points={{-232.9,361.42},{60.5333,361.42},{60.5333,338.2}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y2[1], vAVReHeat_withCtrl_TRooCon_v2_6.TRoo) annotation (Line(
      points={{-232.9,383.74},{158.533,383.74},{158.533,228.2}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y3[1], vAVReHeat_withCtrl_TRooCon_v2_4.TRoo) annotation (Line(
      points={{-232.9,372.58},{240.533,372.58},{240.533,338.2}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y6[1], vAVReHeat_withCtrl_TRooCon_v2_7.TRoo) annotation (Line(
      points={{-232.9,339.1},{342.533,339.1},{342.533,222.2}},
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
  connect(TOA,DX. TConIn) annotation (Line(points={{-734,159},{-660,159},{-660,2.6},
          {-642.2,2.6}},              color={0,0,127}));
  connect(SupAirTemSP.y, conDX.u_s) annotation (Line(
      points={{-625.6,447},{-610,447},{-610,448},{-589.2,448}},
      color={217,67,180},
      pattern=LinePattern.Dash));

  connect(conDX.y, DX.speRat) annotation (Line(points={{-506.4,448},{-468,448},{
          -468,230},{-642,230},{-642,128},{-642.2,128},{-642.2,33.6}},
                                                       color={0,0,0},
      pattern=LinePattern.Dash));
  connect(mixBox.port_Sup, senPreMix.port) annotation (Line(points={{-814,-16.8},
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
          -914.8,309},{-914.8,316},{-855.2,316}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(minus.y, confan.u_m) annotation (Line(
      points={{-921.9,225},{-862.95,225},{-862.95,272.8},{-812,272.8}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(confan.y, fan.y) annotation (Line(points={{-772.4,316},{-756,316},{
          -756,18.2},{-755,18.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_5.TRooCooSet)
    annotation (Line(points={{-112.6,459},{18.6667,459},{18.6667,233.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_3.TRooCooSet)
    annotation (Line(points={{-112.6,459},{72.6667,459},{72.6667,337.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_6.TRooCooSet)
    annotation (Line(points={{-112.6,459},{170.667,459},{170.667,227.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_4.TRooCooSet)
    annotation (Line(points={{-112.6,459},{252.667,459},{252.667,337.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_7.TRooCooSet)
    annotation (Line(points={{-112.6,459},{354.667,459},{354.667,221.6}}, color
        ={0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_9.TRooCooSet)
    annotation (Line(points={{-102.6,129},{4.33333,129},{4.33333,-83}}, color={
          0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_1.TRooCooSet)
    annotation (Line(points={{-102.6,129},{78.3333,129},{78.3333,27}}, color={0,
          0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_10.TRooCooSet)
    annotation (Line(points={{-102.6,129},{166.333,129},{166.333,-75}}, color={
          0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_8.TRooCooSet)
    annotation (Line(points={{-102.6,129},{250.333,129},{250.333,33}}, color={0,
          0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_2.TRooCooSet)
    annotation (Line(points={{-102.6,129},{348.333,129},{348.333,-77}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_5.TRooHeaSet)
    annotation (Line(points={{-110.6,407},{-10.7333,407},{-10.7333,233}}, color
        ={0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_3.TRooHeaSet)
    annotation (Line(points={{-110.6,407},{43.2667,407},{43.2667,337}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_6.TRooHeaSet)
    annotation (Line(points={{-110.6,407},{141.267,407},{141.267,227}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_4.TRooHeaSet)
    annotation (Line(points={{-110.6,407},{223.267,407},{223.267,337}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon_v2_7.TRooHeaSet)
    annotation (Line(points={{-110.6,407},{325.267,407},{325.267,221}}, color={
          0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_9.TRooHeaSet)
    annotation (Line(points={{-102.6,79},{-22.9667,79},{-22.9667,-83.5}}, color
        ={0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_1.TRooHeaSet)
    annotation (Line(points={{-102.6,79},{51.0333,79},{51.0333,26.5}}, color={0,
          0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_10.TRooHeaSet)
    annotation (Line(points={{-102.6,79},{139.033,79},{139.033,-75.5}}, color={
          0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_8.TRooHeaSet)
    annotation (Line(points={{-102.6,79},{223.033,79},{223.033,32.5}}, color={0,
          0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon_v2_2.TRooHeaSet)
    annotation (Line(points={{-102.6,79},{321.033,79},{321.033,-77.5}}, color={
          0,0,127}));
  connect(fan.port_b, T_before_CC.port_a) annotation (Line(points={{-720,-19},{-700,
          -19}},                       color={0,127,255}));
  connect(T_before_CC.port_b, DX.port_a) annotation (Line(points={{-666,-19},{-648,
          -19},{-648,-16},{-636,-16}}, color={0,127,255}));
  connect(DX.port_b, T_after_CC.port_a) annotation (Line(points={{-512,-16},{-504,
          -16},{-504,-15},{-496,-15}},      color={0,127,255}));
  connect(T_after_CC.port_b, eleHea.port_a) annotation (Line(points={{-462,-15},
          {-452,-15},{-452,-21},{-444,-21}}, color={0,127,255}));
  connect(conDX.u_m, T_after_CC.T) annotation (Line(
      points={{-546,404.8},{-546,266},{-482,266},{-482,14.7},{-479,14.7}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(eleHea.port_b, TSA.port_a) annotation (Line(points={{-378,-21},{-358,
          -21}},                       color={0,127,255}));
  connect(TSA.port_b, senPreSup.port) annotation (Line(points={{-324,-21},{-295,
          -21},{-295,-20},{-284,-20}}, color={0,127,255}));
  connect(senMret.port_a, TRA.port_a) annotation (Line(points={{-510,-298},{
          -359,-298},{-359,-301},{-204,-301}}, color={0,127,255}));
  connect(TRA.port_b, splRetRoo.port_1) annotation (Line(points={{-170,-301},{
          1074,-301},{1074,94}}, color={0,127,255}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-1160,-420},{1160,620}})),
    experiment(
      StartTime=15552000,
      StopTime=15724800,
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
end RTU_VAV_Control_Example_v7;
