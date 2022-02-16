within FRP.Example;
model RTU_VAV_Control_Example_v3 "setpoint schedule added"
    extends Modelica.Icons.Example;
    package MediumA = Buildings.Media.Air "Medium model";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1.86; // kg/s
    parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=44000; // Rated cooling capacity
    parameter Modelica.SIunits.HeatFlowRate H_Q_flow_nominal=44000;  //Rated Heating capacity
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+22; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
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
    parameter Modelica.SIunits.PressureDifference dp_nominal_VAVbox=220+20 "VAV box pressure loss";
    parameter Modelica.SIunits.PressureDifference dp_nominal_fan=1000 "nominal pressure rise";
    parameter Modelica.SIunits.PressureDifference dp_nominal_fan_max=dp_nominal_fan/0.6 "maximum dP for zero-flow for a fan";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_max=m_flow_nominal/0.4 "maximum air flow rate for zero-pressure loss for a fan";

    parameter Boolean allowFlowReversal=true;
  FRP.Envelope.FRPMultiZone_Envelope_Icon fRPMultiZone_Envelope_Icon
    annotation (Placement(transformation(extent={{472,-134},{948,358}})));
  Buildings.Fluid.Sources.Outside out(redeclare package Medium = MediumA,
      nPorts=2)
    annotation (Placement(transformation(extent={{-972,-38},{-932,2}})));

  Buildings.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = MediumA,
    allowFlowReversal=false,
    redeclare parameter Buildings.Fluid.Movers.Data.Generic per(pressure(V_flow=
           m_flow_nominal_max*{0, 0.2,0.4,0.6,0.8}/1.2,
           dp=dp_nominal_fan_max*{1, 0.9,0.85,0.6,
            0.2})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-790,-50},{-720,12}})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed
                                                               DX(
    datCoi=datCoi,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=dp_nominal,
    minSpeRat=0) "multi-stage DX unit"
    annotation (Placement(transformation(extent={{-632,-84},{-508,40}})));
  Buildings.Fluid.Sensors.Pressure senPreSup(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-312,-20},{-264,28}})));
  Buildings.Fluid.Sensors.Temperature TSA(redeclare package Medium = MediumA)
    "Supply air temperature"
    annotation (Placement(transformation(extent={{-376,-20},{-338,26}})));
  Buildings.Fluid.Sensors.MassFlowRate senMret(redeclare package Medium =
        MediumA) annotation (Placement(transformation(
        extent={{-32,-36},{32,36}},
        rotation=180,
        origin={-542,-298})));
  Buildings.Fluid.Sensors.Temperature TRA(redeclare package Medium = MediumA)
    annotation (Placement(transformation(
        extent={{-22,-29},{22,29}},
        rotation=180,
        origin={-120,-327})));
  Buildings.Fluid.Actuators.Dampers.MixingBox
                                    mixBox(
    dpOut_nominal=0.467,
    dpRec_nominal=0.665,
    mOut_flow_nominal=0.1*m_flow_nominal,
    mRec_flow_nominal=0.9*m_flow_nominal,
    mExh_flow_nominal=0.1*m_flow_nominal,
    redeclare package Medium = MediumA,
    dpExh_nominal=0.467,
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
    eta=0.95)
    "Electric heater"
    annotation (Placement(transformation(extent={{-450,-56},{-384,14}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSPHeating(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-596,152},{-496,220}})));
  Buildings.Fluid.Sensors.Temperature T_after_CC(redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{-510,-18},{-462,60}})));
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
    annotation (Placement(transformation(extent={{-982,464},{-920,526}})));

  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon104(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{48,-30},{100,20}})));

  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon204(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_204,
    Q_flow_nominal=VAV_Heater_nominal_204,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{38,264},{94,324}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon203(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_203,
    Q_flow_nominal=VAV_Heater_nominal_203,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{218,264},{274,324}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon205(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_104,
    Q_flow_nominal=VAV_Heater_nominal_104,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{-16,156},{40,216}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon202(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_202,
    Q_flow_nominal=VAV_Heater_nominal_202,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{136,154},{192,214}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon206(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_206,
    Q_flow_nominal=VAV_Heater_nominal_206,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{322,150},{378,210}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon102(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_102,
    Q_flow_nominal=VAV_Heater_nominal_102,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{220,-26},{272,24}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon105(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_105,
    Q_flow_nominal=VAV_Heater_nominal_105,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{-26,-136},{26,-86}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon103(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_103,
    Q_flow_nominal=VAV_Heater_nominal_103,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{136,-132},{188,-82}})));
  FRP.RTUVAV.Component.VAVReHeat_withCtrl_TRooCon vAVReHeat_withCtrl_TRooCon106(
    redeclare package Medium = MediumA,
    m_flow_nominal=VAV_m_flow_nominal_106,
    Q_flow_nominal=VAV_Heater_nominal_106,
    dp_nominal=dp_nominal_VAVbox)
    annotation (Placement(transformation(extent={{318,-134},{370,-84}})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={-58,509})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={30,509})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={122,509})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={212,509})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,4/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={34,-208})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={130,-208})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,1/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
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
        origin={214,-208})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={681,501})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo2(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={767,501})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo3(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={847,501})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo4(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,25},{-25,-25}},
        rotation=180,
        origin={927,501})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo5(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,2/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={683,-213})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo6(
    redeclare package Medium = MediumA,
    m_flow_nominal={2/5*0.5*m_flow_nominal,3/5*0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={769,-213})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo7(
    redeclare package Medium = MediumA,
    m_flow_nominal={1/5*0.5*m_flow_nominal,4/5*0.5*m_flow_nominal,3/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={849,-213})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo8(
    redeclare package Medium = MediumA,
    m_flow_nominal={4/5*0.5*m_flow_nominal,0.5*m_flow_nominal,1/5*0.5*
        m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return" annotation (Placement(transformation(
        extent={{25,-25},{-25,25}},
        rotation=180,
        origin={929,-213})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,0.5*m_flow_nominal,0.5*m_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for return"      annotation (Placement(transformation(
        extent={{-28,28},{28,-28}},
        rotation=90,
        origin={1076,118})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooSec
    annotation (Placement(transformation(extent={{-298,336},{-236,398}})));
  Modelica.Blocks.Routing.DeMultiplex6 TRooFir
    annotation (Placement(transformation(extent={{-294,-178},{-232,-116}})));
  Modelica.Blocks.Sources.BooleanConstant HeaterControl(k=false)
    "heater on-off control"
    annotation (Placement(transformation(extent={{-556,112},{-520,148}})));
  Buildings.Fluid.Sensors.Temperature T_before_CC(redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{-706,-20},{-670,34}})));
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
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseAction=true) "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{-582,410},{-510,482}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSP(y=273.15 + 15)
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
    k=0.0001,
    Ti=60,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseAction=false) "Controller for fan"
    annotation (Placement(transformation(extent={{-848,272},{-776,344}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP2(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature-second floor [K]"
    annotation (Placement(transformation(extent={{-150,440},{-116,474}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP1(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature-first floor [K]"
    annotation (Placement(transformation(extent={{-140,112},{-106,146}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP2(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature-second floor [K]"
    annotation (Placement(transformation(extent={{-150,390},{-116,424}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP1(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature-first floor [K]"
    annotation (Placement(transformation(extent={{-140,62},{-106,96}})));
equation
  connect(fan.port_b, DX.port_a) annotation (Line(points={{-720,-19},{-632,
          -19},{-632,-22}}, color={0,127,255}));
  connect(senMret.port_a,TRA. port)
    annotation (Line(points={{-510,-298},{-120,-298}}, color={0,127,255}));
  connect(out.ports[1],mixBox. port_Out) annotation (Line(points={{-932,-14},{
          -916,-14},{-916,-18.8},{-898,-18.8}},
                                           color={0,127,255}));
  connect(mixBox.port_Sup, fan.port_a) annotation (Line(points={{-814,-18.8},{-788,
          -18.8},{-788,-19},{-790,-19}}, color={0,127,255}));
  connect(senMret.port_b,mixBox. port_Ret) annotation (Line(points={{-574,-298},
          {-814,-298},{-814,-69.2}},                         color={0,127,255}));
  connect(mixBox.port_Exh,out. ports[2]) annotation (Line(points={{-898,-69.2},
          {-932,-69.2},{-932,-22}},color={0,127,255}));
  connect(OA_actuator.y, mixBox.y) annotation (Line(points={{-908,55},{-882,55},
          {-882,6.4},{-856,6.4}}, color={0,0,127}));
  connect(DX.port_b,eleHea. port_a) annotation (Line(points={{-508,-22},{-472,
          -22},{-472,-21},{-450,-21}},      color={0,127,255}));
  connect(eleHea.port_b,TSA. port) annotation (Line(points={{-384,-21},{-357,
          -21},{-357,-20}},            color={0,127,255}));
  connect(TSA.port, senPreSup.port)
    annotation (Line(points={{-357,-20},{-288,-20}}, color={0,127,255}));
  connect(SupAirTemSPHeating.y, eleHea.TSet) annotation (Line(points={{-491,186},
          {-456,186},{-456,98},{-456.6,98},{-456.6,7}}, color={0,0,127}));
  connect(DX.port_b,T_after_CC. port) annotation (Line(points={{-508,-22},
          {-496,-22},{-496,-18},{-486,-18}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon204.port_b, fRPMultiZone_Envelope_Icon.port_204
    [1]) annotation (Line(points={{94,295.2},{98,295.2},{98,396},{608,396},{608,
          267.8},{629.162,267.8}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon104.port_b, fRPMultiZone_Envelope_Icon.port_104
    [1]) annotation (Line(points={{100,-4},{124,-4},{124,66},{590,66},{590,
          40.66},{607.003,40.66}},
                            color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.weaBus1, out.weaBus) annotation (Line(
      points={{604.952,-120.88},{604.952,-400},{-972,-400},{-972,-17.6}},
      color={255,204,51},
      thickness=0.5));
  connect(vAVReHeat_withCtrl_TRooCon203.port_b, fRPMultiZone_Envelope_Icon.port_203
    [1]) annotation (Line(points={{274,295.2},{274,388},{740,388},{740,346},{
          738.314,346},{738.314,301.42}},
                                  color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon205.port_b, fRPMultiZone_Envelope_Icon.port_205
    [1]) annotation (Line(points={{40,187.2},{44,187.2},{44,180},{50,180},{50,
          222},{604,222},{604,206},{604.952,206},{604.952,205.48}},
                                                               color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon202.port_b, fRPMultiZone_Envelope_Icon.port_202
    [1]) annotation (Line(points={{192,185.2},{200,185.2},{200,178},{204,178},{
          204,238},{698,238},{698,256},{710,256},{710,253.86},{718.207,253.86}},
        color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon206.port_b, fRPMultiZone_Envelope_Icon.port_206
    [1]) annotation (Line(points={{378,181.2},{388,181.2},{388,178},{796.993,
          178},{796.993,190.72}},               color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon102.port_b, fRPMultiZone_Envelope_Icon.port_102
    [1]) annotation (Line(points={{272,0},{298,0},{298,70},{740,70},{740,65.26},
          {741.186,65.26}}, color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon105.port_b, fRPMultiZone_Envelope_Icon.port_105
    [1]) annotation (Line(points={{26,-110},{44,-110},{44,-46},{558,-46},{558,
          -30},{600,-30},{600,-33.14},{613.979,-33.14}},
                                                    color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon103.port_b, fRPMultiZone_Envelope_Icon.port_103
    [1]) annotation (Line(points={{188,-106},{196,-106},{196,-52},{716,-52},{
          716,16},{716.976,16},{716.976,13.6}},
                                            color={0,127,255}));
  connect(vAVReHeat_withCtrl_TRooCon106.port_b, fRPMultiZone_Envelope_Icon.port_106
    [1]) annotation (Line(points={{370,-108},{384,-108},{384,-60},{732,-60},{
          732,-42.98},{802.738,-42.98}},
                                     color={0,127,255}));
  connect(senPreSup.port, splSupRoo.port_1)
    annotation (Line(points={{-288,-20},{-228,-20}}, color={0,127,255}));
  connect(splSupRoo1.port_3, vAVReHeat_withCtrl_TRooCon205.port_a) annotation (
      Line(points={{-58,483},{-56,483},{-56,187.2},{-16,187.2}}, color={0,127,255}));
  connect(splSupRoo1.port_2, splSupRoo2.port_1) annotation (Line(points={{-32,509},
          {-24,509},{-24,508},{-14,508},{-14,509},{4,509}},
                                        color={0,127,255}));
  connect(splSupRoo2.port_3, vAVReHeat_withCtrl_TRooCon204.port_a) annotation (
      Line(points={{30,483},{30,295.2},{38,295.2}}, color={0,127,255}));
  connect(splSupRoo2.port_2, splSupRoo3.port_1) annotation (Line(points={{56,509},
          {66,509},{66,508},{76,508},{76,509},{96,509}},
                                       color={0,127,255}));
  connect(splSupRoo3.port_3, vAVReHeat_withCtrl_TRooCon202.port_a) annotation (
      Line(points={{122,483},{122,185.2},{136,185.2}}, color={0,127,255}));
  connect(splSupRoo3.port_2, splSupRoo4.port_1) annotation (Line(points={{148,509},
          {158,509},{158,508},{168,508},{168,509},{186,509}},
                                          color={0,127,255}));
  connect(splSupRoo4.port_3, vAVReHeat_withCtrl_TRooCon203.port_a) annotation (
      Line(points={{212,483},{212,295.2},{218,295.2}}, color={0,127,255}));
  connect(splSupRoo4.port_2, vAVReHeat_withCtrl_TRooCon206.port_a) annotation (
      Line(points={{238,509},{302,509},{302,181.2},{322,181.2}}, color={0,127,255}));
  connect(splSupRoo.port_2, splSupRoo5.port_1) annotation (Line(points={{-172,
          -20},{-136,-20},{-136,-208},{-80,-208}},
                                              color={0,127,255}));
  connect(splSupRoo5.port_2, splSupRoo6.port_1)
    annotation (Line(points={{-28,-208},{8,-208}}, color={0,127,255}));
  connect(splSupRoo6.port_2, splSupRoo7.port_1)
    annotation (Line(points={{60,-208},{104,-208}}, color={0,127,255}));
  connect(splSupRoo7.port_2, splSupRoo8.port_1)
    annotation (Line(points={{156,-208},{188,-208}}, color={0,127,255}));
  connect(splSupRoo5.port_3, vAVReHeat_withCtrl_TRooCon105.port_a) annotation (
      Line(points={{-54,-182},{-54,-110},{-26,-110}}, color={0,127,255}));
  connect(splSupRoo6.port_3, vAVReHeat_withCtrl_TRooCon104.port_a) annotation (
      Line(points={{34,-182},{32,-182},{32,-4},{48,-4}}, color={0,127,255}));
  connect(splSupRoo7.port_3, vAVReHeat_withCtrl_TRooCon103.port_a) annotation (
      Line(points={{130,-182},{130,-106},{136,-106}}, color={0,127,255}));
  connect(splSupRoo8.port_3, vAVReHeat_withCtrl_TRooCon102.port_a) annotation (
      Line(points={{214,-182},{214,0},{220,0}},   color={0,127,255}));
  connect(splSupRoo8.port_2, vAVReHeat_withCtrl_TRooCon106.port_a) annotation (
      Line(points={{240,-208},{302,-208},{302,-108},{318,-108}}, color={0,127,255}));
  connect(splSupRoo.port_3, splSupRoo1.port_1) annotation (Line(points={{-200,8},
          {-198,8},{-198,509},{-84,509}},  color={0,127,255}));
  connect(splRetRoo1.port_1, fRPMultiZone_Envelope_Icon.port_205[2])
    annotation (Line(points={{656,501},{634.497,501},{634.497,205.48}}, color={0,
          127,255}));
  connect(splRetRoo1.port_3, fRPMultiZone_Envelope_Icon.port_204[2])
    annotation (Line(points={{681,476},{681,267.8},{657.886,267.8}}, color={0,127,
          255}));
  connect(splRetRoo1.port_2, splRetRoo2.port_1) annotation (Line(points={{706,501},
          {724,501},{724,501},{742,501}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_202[2], splRetRoo2.port_3)
    annotation (Line(points={{744.469,253.86},{767,253.86},{767,476}}, color={0,
          127,255}));
  connect(splRetRoo2.port_2, splRetRoo3.port_1) annotation (Line(points={{792,501},
          {808,501},{808,501},{822,501}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_203[2], splRetRoo3.port_3)
    annotation (Line(points={{762.114,301.42},{847,301.42},{847,476}}, color={0,
          127,255}));
  connect(splRetRoo3.port_2, splRetRoo4.port_1) annotation (Line(points={{872,501},
          {885,501},{885,501},{902,501}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_206[2], splRetRoo4.port_3)
    annotation (Line(points={{819.972,190.72},{927,190.72},{927,476}}, color={0,
          127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_105[2], splRetRoo5.port_1)
    annotation (Line(points={{638.6,-33.14},{638.6,-213},{658,-213}}, color={0,127,
          255}));
  connect(fRPMultiZone_Envelope_Icon.port_104[2], splRetRoo5.port_3)
    annotation (Line(points={{634.086,40.66},{683,40.66},{683,-188}}, color={0,127,
          255}));
  connect(splRetRoo5.port_2, splRetRoo6.port_1) annotation (Line(points={{708,-213},
          {727,-213},{727,-213},{744,-213}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_103[2], splRetRoo6.port_3)
    annotation (Line(points={{740.776,13.6},{769,13.6},{769,-188}}, color={0,127,
          255}));
  connect(splRetRoo6.port_2, splRetRoo7.port_1) annotation (Line(points={{794,-213},
          {810,-213},{810,-213},{824,-213}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_102[2], splRetRoo7.port_3)
    annotation (Line(points={{764.166,65.26},{849,65.26},{849,-188}}, color={0,127,
          255}));
  connect(splRetRoo7.port_2, splRetRoo8.port_1) annotation (Line(points={{874,-213},
          {889,-213},{889,-213},{904,-213}}, color={0,127,255}));
  connect(fRPMultiZone_Envelope_Icon.port_106[2], splRetRoo8.port_3)
    annotation (Line(points={{827.359,-42.98},{929,-42.98},{929,-188}}, color={0,
          127,255}));
  connect(splRetRoo8.port_2, splRetRoo.port_3) annotation (Line(points={{954,-213},
          {1006,-213},{1006,118},{1048,118}}, color={0,127,255}));
  connect(splRetRoo4.port_2, splRetRoo.port_2) annotation (Line(points={{952,501},
          {1076,501},{1076,146}}, color={0,127,255}));
  connect(splRetRoo.port_1, TRA.port) annotation (Line(points={{1076,90},{1076,
          -298},{-120,-298}},
                        color={0,127,255}));

  connect(TRooSec.u, fRPMultiZone_Envelope_Icon.TrooVecSec) annotation (Line(
        points={{-304.2,367},{-350,367},{-350,566},{1112,566},{1112,231.72},{
          964.414,231.72}},
                    color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.u, fRPMultiZone_Envelope_Icon.TrooVecFir) annotation (Line(
        points={{-300.2,-147},{-350,-147},{-350,-338},{1112,-338},{1112,31.64},
          {966.055,31.64}},color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y5[1], vAVReHeat_withCtrl_TRooCon105.TRoo) annotation (Line(
        points={{-228.9,-163.74},{-76,-163.74},{-76,-66},{-6.93333,-66},{-6.93333,
          -82.5}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(HeaterControl.y, eleHea.on) annotation (Line(points={{-518.2,130},{
          -456.6,130},{-456.6,-10.5}}, color={255,0,255}));
  connect(TRooFir.y4[1], vAVReHeat_withCtrl_TRooCon104.TRoo) annotation (Line(
        points={{-228.9,-152.58},{-68,-152.58},{-68,40},{67.0667,40},{67.0667,
          23.5}},
        color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y3[1], vAVReHeat_withCtrl_TRooCon103.TRoo) annotation (Line(
        points={{-228.9,-141.42},{-82,-141.42},{-82,-62},{155.067,-62},{155.067,
          -78.5}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y2[1], vAVReHeat_withCtrl_TRooCon102.TRoo) annotation (Line(
        points={{-228.9,-130.26},{-86,-130.26},{-86,44},{239.067,44},{239.067,
          27.5}},
        color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooFir.y6[1], vAVReHeat_withCtrl_TRooCon106.TRoo) annotation (Line(
        points={{-228.9,-174.9},{296,-174.9},{296,-64},{337.067,-64},{337.067,
          -80.5}},
        color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y5[1], vAVReHeat_withCtrl_TRooCon205.TRoo) annotation (Line(
        points={{-232.9,350.26},{4.53333,350.26},{4.53333,220.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y4[1], vAVReHeat_withCtrl_TRooCon204.TRoo) annotation (Line(
        points={{-232.9,361.42},{58.5333,361.42},{58.5333,328.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y2[1], vAVReHeat_withCtrl_TRooCon202.TRoo) annotation (Line(
        points={{-232.9,383.74},{156.533,383.74},{156.533,218.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y3[1], vAVReHeat_withCtrl_TRooCon203.TRoo) annotation (Line(
        points={{-232.9,372.58},{238.533,372.58},{238.533,328.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(TRooSec.y6[1], vAVReHeat_withCtrl_TRooCon206.TRoo) annotation (Line(
        points={{-232.9,339.1},{342.533,339.1},{342.533,214.2}}, color={0,0,0},
      pattern=LinePattern.Dash));

  connect(fan.port_b, T_before_CC.port) annotation (Line(points={{-720,-19},{-711,
          -19},{-711,-20},{-688,-20}}, color={0,127,255}));
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
  connect(TOA,DX. TConIn) annotation (Line(points={{-734,159},{-660,159},{
          -660,-3.4},{-638.2,-3.4}},  color={0,0,127}));
  connect(SupAirTemSP.y, conDX.u_s) annotation (Line(
      points={{-625.6,447},{-610,447},{-610,446},{-589.2,446}},
      color={217,67,180},
      pattern=LinePattern.Dash));
  connect(T_after_CC.T, conDX.u_m) annotation (Line(points={{-469.2,21},{-469.2,
          22},{-450,22},{-450,222},{-546,222},{-546,402.8}}, color={0,0,0},
      pattern=LinePattern.Dash));

  connect(conDX.y, DX.speRat) annotation (Line(points={{-506.4,446},{-464,446},
          {-464,230},{-638,230},{-638,128},{-638.2,128},{-638.2,27.6}},
                                                       color={0,0,0},
      pattern=LinePattern.Dash));
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
          -914.8,309},{-914.8,308},{-855.2,308}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(minus.y, confan.u_m) annotation (Line(
      points={{-921.9,225},{-862.95,225},{-862.95,264.8},{-812,264.8}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(confan.y, fan.y) annotation (Line(points={{-772.4,308},{-756,308},{
          -756,18.2},{-755,18.2}}, color={0,0,0},
      pattern=LinePattern.Dash));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon205.TRooCooSet)
    annotation (Line(points={{-114.3,457},{16.6667,457},{16.6667,219.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon204.TRooCooSet)
    annotation (Line(points={{-114.3,457},{70.6667,457},{70.6667,327.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon202.TRooCooSet)
    annotation (Line(points={{-114.3,457},{168.667,457},{168.667,217.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon203.TRooCooSet)
    annotation (Line(points={{-114.3,457},{250.667,457},{250.667,327.6}}, color
        ={0,0,127}));
  connect(CoolingSP2.y[1], vAVReHeat_withCtrl_TRooCon206.TRooCooSet)
    annotation (Line(points={{-114.3,457},{354.667,457},{354.667,213.6}}, color
        ={0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon105.TRooCooSet)
    annotation (Line(points={{-104.3,129},{4.33333,129},{4.33333,-83}}, color={
          0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon104.TRooCooSet)
    annotation (Line(points={{-104.3,129},{78.3333,129},{78.3333,23}}, color={0,
          0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon103.TRooCooSet)
    annotation (Line(points={{-104.3,129},{166.333,129},{166.333,-79}}, color={
          0,0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon102.TRooCooSet)
    annotation (Line(points={{-104.3,129},{250.333,129},{250.333,27}}, color={0,
          0,127}));
  connect(CoolingSP1.y[1], vAVReHeat_withCtrl_TRooCon106.TRooCooSet)
    annotation (Line(points={{-104.3,129},{348.333,129},{348.333,-81}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon205.TRooHeaSet)
    annotation (Line(points={{-114.3,407},{-12.7333,407},{-12.7333,219}}, color
        ={0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon204.TRooHeaSet)
    annotation (Line(points={{-114.3,407},{41.2667,407},{41.2667,327}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon202.TRooHeaSet)
    annotation (Line(points={{-114.3,407},{139.267,407},{139.267,217}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon203.TRooHeaSet)
    annotation (Line(points={{-114.3,407},{221.267,407},{221.267,327}}, color={
          0,0,127}));
  connect(HeatingSP2.y[1], vAVReHeat_withCtrl_TRooCon206.TRooHeaSet)
    annotation (Line(points={{-114.3,407},{325.267,407},{325.267,213}}, color={
          0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon105.TRooHeaSet)
    annotation (Line(points={{-104.3,79},{-22.9667,79},{-22.9667,-83.5}}, color
        ={0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon104.TRooHeaSet)
    annotation (Line(points={{-104.3,79},{51.0333,79},{51.0333,22.5}}, color={0,
          0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon103.TRooHeaSet)
    annotation (Line(points={{-104.3,79},{139.033,79},{139.033,-79.5}}, color={
          0,0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon102.TRooHeaSet)
    annotation (Line(points={{-104.3,79},{223.033,79},{223.033,26.5}}, color={0,
          0,127}));
  connect(HeatingSP1.y[1], vAVReHeat_withCtrl_TRooCon106.TRooHeaSet)
    annotation (Line(points={{-104.3,79},{321.033,79},{321.033,-81.5}}, color={
          0,0,127}));
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
end RTU_VAV_Control_Example_v3;
