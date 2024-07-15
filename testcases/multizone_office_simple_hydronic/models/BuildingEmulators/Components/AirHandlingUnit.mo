within BuildingEmulators.Components;
model AirHandlingUnit
  "Idealised ventilation System with constant airflow rate and heat recovery unit with constant efficiency"

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_sup(min=0)
    "Supply ventilation mass flow rate";
    parameter .Modelica.Units.SI.PressureDifference dp_nominal_air_sup(min=0)
    "Supply nominal pressure drop" annotation (Dialog(group="Nominal condition"));
    parameter .Modelica.Units.SI.PressureDifference hp_nominal_air_sup(min=0)
    "Supply nominal pressure head" annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_ret(min=0)
    "Return ventilation mass flow rate";
    parameter .Modelica.Units.SI.PressureDifference dp_nominal_air_ret(min=0)
    "Return nominal pressure drop" annotation (Dialog(group="Nominal condition"));
    parameter .Modelica.Units.SI.PressureDifference hp_nominal_air_ret(min=0)
    "Return nominal pressure head" annotation (Dialog(group="Nominal condition"));

   parameter .Modelica.Units.SI.MassFlowRate m_flow_nominal_wat_hea(min=0)=
       m_flow_nominal_air_sup*(cp_air*dT_air_nominal_hea)/(MediumWater.cp_const*dT_wat_nominal_hea)
     "Nominal water mass flow rate in the heating coil" annotation (Dialog(group="Nominal condition"));

    parameter .Modelica.Units.SI.MassFlowRate m_flow_nominal_wat_coo(min=0)=
       m_flow_nominal_air_sup*(cp_air*dT_air_nominal_coo)/(MediumWater.cp_const*dT_wat_nominal_coo)
     "Nominal water mass flow rate in the cooling coil" annotation (Dialog(group="Nominal condition"));

    parameter .Modelica.Units.SI.HeatFlowRate Q_flow_nominal_hea = m_flow_nominal_wat_hea*MediumWater.cp_const*dT_wat_nominal_hea
     "Nominal heat flow rate in the heating coil" annotation (Dialog(group="Nominal condition"));

    parameter .Modelica.Units.SI.HeatFlowRate Q_flow_nominal_coo = m_flow_nominal_wat_coo*MediumWater.cp_const*dT_wat_nominal_coo
     "Nominal heat flow rate in the cooling coil" annotation (Dialog(group="Nominal condition"));

    parameter .Modelica.Units.SI.TemperatureDifference dT_air_nominal_hea = 30
     "Nominal air temperature difference in the heating coil";

    parameter .Modelica.Units.SI.TemperatureDifference dT_air_nominal_coo = 15
     "Nominal air temperature difference in the cooling coil";

    parameter .Modelica.Units.SI.TemperatureDifference dT_wat_nominal_hea = 5
     "Nominal water temperature difference in the heating coil";

    parameter .Modelica.Units.SI.TemperatureDifference dT_wat_nominal_coo = 5
     "Nominal water temperature difference in the cooling coil";

    package MediumAir = .IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Medium air";
    package MediumWater = .IDEAS.Media.Water "Medium water";

  parameter Modelica.Units.SI.Efficiency recEff(
    min=0,
    max=1) = 0.84 "Efficiency of heat recuperation";

  IDEAS.Fluid.Movers.FlowControlled_dp fanRet(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_air_ret,
    addPowerToMedium=false,
    use_inputFilter=false,redeclare replaceable .IDEAS.Examples.PPD12.Data.FanCurvePP12 per(motorEfficiency(V_flow = {3.25},eta = {0.7}))) annotation (Placement(visible=true, transformation(
        origin={-10,26},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  IDEAS.Fluid.FixedResistances.PressureDrop preDroRet(
    redeclare final package Medium = MediumAir,
    allowFlowReversal=false,
    dp_nominal=dp_nominal_air_ret,
    m_flow_nominal=m_flow_nominal_air_ret) annotation (Placement(visible=true,
        transformation(
        origin={-144,26},
        extent={{-29.5742,-7.57416},{-14.4258,7.57416}},
        rotation=0)));
  Buildings.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoi(
//            IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU cooCoi(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    allowFlowReversal1 = false,
    allowFlowReversal2 = false,
    dp1_nominal = 0,
    dp2_nominal = 0,
    m1_flow_nominal = m_flow_nominal_wat_coo,
    m2_flow_nominal=m_flow_nominal_air_sup,
    use_Q_flow_nominal = true,
    Q_flow_nominal = -Q_flow_nominal_coo,
    w_a2_nominal = 0.01,
    T_a1_nominal = 273.15 + 9,
    T_a2_nominal = 273.15 + 30,
    configuration = Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow
    //UA_nominal = 2000,energyDynamics = Modelica.Fluid.Types.Dynamics.DynamicFreeInitial) // -Q_flow_nominal_coo / (Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(273.15 + 12,273.15 + 15,273.15 + 30,273.15 + 20))
)                                         annotation (
    Placement(visible = true, transformation(origin={-46,-16},    extent = {{-57.7991, 3.79906}, {-38.2009, -15.7991}}, rotation = 0)));
  IDEAS.Fluid.Movers.FlowControlled_dp fanSup(
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_air_sup,
    addPowerToMedium=false,
    use_inputFilter=false,redeclare replaceable .IDEAS.Examples.PPD12.Data.FanCurvePP12 per(motorEfficiency(V_flow = {3.75},eta = {0.7}))) annotation (Placement(visible=true, transformation(
          extent={{16,-26},{-4,-6}},  rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a portHea_a(redeclare final package
      Medium = MediumWater) annotation (Placement(
      visible=true,
      transformation(
        origin={-48,-100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-30,-98},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  IDEAS.Fluid.FixedResistances.PressureDrop preDroSup(
    redeclare final package Medium = MediumAir,
    allowFlowReversal=false,
    dp_nominal=dp_nominal_air_sup,
    m_flow_nominal=m_flow_nominal_air_sup) annotation (Placement(visible=true,
        transformation(
        origin={-144,-16},
        extent={{-14.4258,-7.57416},{-29.5742,7.57416}},
        rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a portCoo_a(redeclare final package
      Medium = MediumWater) annotation (Placement(
      visible=true,
      transformation(
        origin={-112,-100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-130,-98},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b portCoo_b(redeclare final package
      Medium = MediumWater) annotation (Placement(
      visible=true,
      transformation(
        origin={-78,-100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-88,-98},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTSupAhu(
    redeclare final package Medium = MediumAir,
    allowFlowReversal = false,
    m_flow_nominal = m_flow_nominal_air_sup,
    tau = 60,
    transferHeat = false) annotation (
    Placement(visible = true, transformation(origin={-60,-16},    extent = {{-69, -7.00003}, {-83, 7.00003}}, rotation = 0)));
  IDEAS.Fluid.HeatExchangers.ConstantEffectiveness rec(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    dp1_nominal = 0,
    dp2_nominal = 0,
    eps=recEff,
    m1_flow_nominal=m_flow_nominal_air_sup,
    m2_flow_nominal=m_flow_nominal_air_ret)                                                                                                                                                                                                         annotation (
    Placement(visible = true, transformation(extent={{91.0,39.0},{65.0,-31.0}},     rotation = 0.0,origin = {0.0,0.0})));
  Modelica.Blocks.Interfaces.RealInput prfAhuRet annotation (
    Placement(visible = true, transformation(origin={-10.0,100.0},    extent={{-14.0,-14.0},{14.0,14.0}},                                                                             rotation = -90.0), iconTransformation(origin = {-14, 100}, extent = {{-20, -20}, {20, 20}}, rotation=270)));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTRetAhu(
    redeclare final package Medium = MediumAir,
    allowFlowReversal = false,
    m_flow_nominal = m_flow_nominal_air_ret,
    tau = 0,
    transferHeat = false) annotation (
    Placement(visible = true, transformation(origin={-20,26},    extent = {{-83, -7.00003}, {-69, 7.00003}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b portHea_b(redeclare final package
      Medium = MediumWater) annotation (Placement(
      visible=true,
      transformation(
        origin={-12,-100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={12,-98},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    allowFlowReversal1 = false,
    allowFlowReversal2 = false,
    dp1_nominal = 0,
    dp2_nominal = 0,
    m1_flow_nominal = m_flow_nominal_wat_hea,
    m2_flow_nominal = m_flow_nominal_air_sup,
    Q_flow_nominal = Q_flow_nominal_hea,
    T_a1_nominal = 273.15 + 50,
    T_a2_nominal = 273.15 - 10,
    configuration = IDEAS.Fluid.Types.HeatExchangerConfiguration.CounterFlow) annotation (
    Placement(visible = true, transformation(origin={-34,-16},    extent = {{-5.79906, 3.79906}, {13.7991, -15.7991}}, rotation = 0)));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTExhAhu(
    redeclare final package Medium = MediumAir,
    allowFlowReversal = false,
    m_flow_nominal = m_flow_nominal_air_ret,
    tau = 0,
    transferHeat = false) annotation (
    Placement(visible = true, transformation(origin={0.0,0.0},   extent = {{115.0,18.999969999999998},{129.0,33.00003}}, rotation = 0.0)));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTRecAhu(
    redeclare final package Medium = MediumAir,
    allowFlowReversal = false,
    m_flow_nominal = m_flow_nominal_air_sup,
    tau = 0,
    transferHeat = false) annotation (
    Placement(visible = true, transformation(origin={110,-16},    extent = {{-69, -7.00003}, {-83, 7.00003}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput TExhAhu annotation (
    Placement(visible = true, transformation(origin={92,110},    extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin={190,110},    extent = {{-10, -10}, {10, 10}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput TRecAhu annotation (
    Placement(visible = true, transformation(origin={50.0,110.0},    extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 90.0), iconTransformation(origin={92,-110},    extent = {{-10, -10}, {10, 10}}, rotation=270)));
  IDEAS.Fluid.Sources.OutsideAir outsideAir(
    redeclare package Medium = MediumAir,
    nPorts=2, azi=0)    annotation (
    Placement(visible = true, transformation(origin={144,4},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package Medium = MediumAir) annotation (
    Placement(visible = true, transformation(origin={-198,-16},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-202, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package Medium = MediumAir) annotation (
    Placement(visible = true, transformation(origin={-200,26},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-198, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTInAhu(
    redeclare final package Medium = MediumAir,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_air_sup,
    tau=0,
    transferHeat=false) annotation (Placement(visible=true, transformation(
        origin={0.0,0.0},
        extent={{131.0,-23.00003},{117.0,-8.999970000000001}},
        rotation=0.0)));
  Modelica.Blocks.Interfaces.RealOutput TInAhu annotation (Placement(
      visible=true,
      transformation(
        origin={160,-110},
        extent={{10,-10},{-10,10}},
        rotation=90),
      iconTransformation(
        origin={188,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Blocks.Math.Gain preHeaSup(k=hp_nominal_air_sup)
                                      annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={20,48})));
  Modelica.Blocks.Math.Gain preHeaRet(k=hp_nominal_air_ret)
                                      annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-10,60})));
  .IDEAS.Fluid.FixedResistances.Junction junHea(
            redeclare package Medium = MediumWater,
            energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
            m_flow_nominal = {1,1,1},
            dp_nominal = {0,0,0},
            portFlowDirection_1 = Modelica.Fluid.Types.PortFlowDirection.Entering,
            portFlowDirection_2 = Modelica.Fluid.Types.PortFlowDirection.Leaving,
            portFlowDirection_3 = Modelica.Fluid.Types.PortFlowDirection.Entering,from_dp = false,tau = 60) annotation(Placement(transformation(extent = {{-7.372587688383533,-7.372587688383533},{7.372587688383533,7.372587688383533}},origin = {-12.0,-60.0},rotation = -90.0)));
    .IDEAS.Fluid.FixedResistances.Junction junCoo(
            portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
            portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
            portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
            dp_nominal = {0,0,0},
            m_flow_nominal = {1,1,1},
            energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
            redeclare package Medium = MediumWater,from_dp = false,tau = 60) annotation(Placement(transformation(extent = {{-7.372587688383533,-7.372587688383533},{7.372587688383533,7.372587688383533}},origin = {-78.0,-60.0},rotation = -90.0)));
    .IDEAS.Fluid.FixedResistances.Junction junRec(
            portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
            portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
            portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
            dp_nominal = {0,0,0},
            m_flow_nominal = {1,1,1},
            energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
            redeclare package Medium = MediumAir,tau = 60) annotation(Placement(transformation(extent = {{113.37258768838353,-23.372587688383533},{98.62741231161647,-8.627412311616467}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveSwitch threeWayRec(
            redeclare package Medium = MediumAir,
            m_flow_nominal = m_flow_nominal_air_sup,
            mFlowMin = 0.01 * m_flow_nominal_air_sup,tau = 60,energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(Placement(transformation(extent = {{59.01209177503719,-23.01209177503719},{44.98790822496281,-8.987908224962808}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor threeWayCoo(
            redeclare package Medium=MediumWater,
            m_flow_nominal = m_flow_nominal_wat_coo,
            portFlowDirection_1 = Modelica.Fluid.Types.PortFlowDirection.Leaving,
            portFlowDirection_2 = Modelica.Fluid.Types.PortFlowDirection.Entering,
            portFlowDirection_3 = Modelica.Fluid.Types.PortFlowDirection.Leaving,from_dp = false,tau = 60) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-112.0,-60.0},rotation = 90.0)));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor threeWayHea(
            redeclare package Medium=MediumWater,
            m_flow_nominal = m_flow_nominal_wat_hea,
            portFlowDirection_1 = Modelica.Fluid.Types.PortFlowDirection.Leaving,
            portFlowDirection_2 = Modelica.Fluid.Types.PortFlowDirection.Entering,
            portFlowDirection_3 = Modelica.Fluid.Types.PortFlowDirection.Leaving,from_dp = false,tau = 60) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-48.0,-60.0},rotation = 90.0)));
    .BuildingEmulators.Components.AhuInternalControl ahuInternalControl annotation(Placement(transformation(extent = {{94.0,-84.0},{74.0,-64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TSupAhuSet annotation(Placement(visible = true,transformation(origin = {160.0,100.0},extent = {{-14.0,-14.0},{14.0,14.0}},rotation = -90.0),iconTransformation(origin = {-14,100},extent = {{-20,-20},{20,20}},rotation = 270)));
    .Modelica.Blocks.Interfaces.RealInput prfAhuSup annotation(Placement(visible = true,transformation(origin = {20.0,100.0},extent = {{-14.0,-14.0},{14.0,14.0}},rotation = -90.0),iconTransformation(origin = {-14,100},extent = {{-20,-20},{20,20}},rotation = 270)));
    .Modelica.Blocks.Interfaces.BooleanInput oveByPass annotation(Placement(transformation(extent = {{14.00146458515826,-14.001464585158274},{-14.00146458515826,14.001464585158274}},origin = {194.0,100.0},rotation = 90.0)));
    .Modelica.Blocks.Interfaces.RealOutput PSupAhu annotation(Placement(visible = true,transformation(origin = {0.0,0.0},extent = {{-200.0,64.0},{-220.0,84.0}},rotation = 0.0),iconTransformation(origin = {-180,-110},extent = {{-10,-10},{10,10}},rotation = 270)));
    .Modelica.Blocks.Interfaces.RealOutput PRetAhu annotation(Placement(transformation(extent = {{-200.0,42.0},{-220.0,62.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput TRetAhu annotation(Placement(visible = true,transformation(origin = {-96,110},extent = {{-10,-10},{10,10}},rotation = 90),iconTransformation(origin = {-180,110},extent = {{-10,-10},{10,10}},rotation = 90)));
    .Modelica.Blocks.Interfaces.RealOutput TSupAhu annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {-136.0,110.0},rotation = 90.0)));
protected
   parameter .Modelica.Units.SI.SpecificHeatCapacity cp_air = 1004;

equation
  connect(cooCoi.port_b2, senTSupAhu.port_a) annotation (
    Line(points={{-103.799,-16.1206},{-115,-16.1206},{-115,-16},{-129,-16}},
                                              color = {0, 127, 255}));
  connect(senTSupAhu.port_b, preDroSup.port_a)
    annotation (Line(points={{-143,-16},{-158.426,-16}}, color={0,127,255}));
  connect(senTRetAhu.T, TRetAhu) annotation (
    Line(points={{-96,33.7},{-96,110}},                 color = {0, 0, 127}));
  connect(heaCoi.port_b2, cooCoi.port_a2) annotation (
    Line(points={{-39.7991,-16.1206},{-50,-16.1206},{-50,-16},{-60.2009,-16},{
          -60.2009,-16.1206},{-84.2009,-16.1206}},
                                            color = {0, 127, 255}));
  connect(senTRetAhu.port_b, fanRet.port_a)
    annotation (Line(points={{-89,26},{-20,26}}, color={0,127,255}));
  connect(fanSup.port_b, heaCoi.port_a2) annotation (Line(points={{-4,-16},{-12,
          -16},{-12,-16.1206},{-20.2009,-16.1206}}, color={0,127,255}));
  connect(senTSupAhu.port_b, preDroSup.port_a)
    annotation (Line(points={{-143,-16},{-158.426,-16}}, color={0,127,255}));
  connect(preDroRet.port_b, senTRetAhu.port_a)
    annotation (Line(points={{-158.426,26},{-103,26}}, color={0,127,255}));
  connect(preDroSup.port_b, port_a)
    annotation (Line(points={{-173.574,-16},{-198,-16}}, color={0,127,255}));
  connect(preDroRet.port_a, port_b)
    annotation (Line(points={{-173.574,26},{-200,26}}, color={0,127,255}));
  connect(rec.port_a2, fanRet.port_b) annotation (Line(points={{65,25},{65,26},{1.77636e-15,26}},        color={0,127,255}));
  connect(preHeaRet.y, fanRet.dp_in)
    annotation (Line(points={{-10,51.2},{-10,38}}, color={0,0,127}));
  connect(preHeaSup.y, fanSup.dp_in) annotation (Line(points={{20,39.2},{20,18},
          {6,18},{6,-4}}, color={0,0,127}));
    connect(heaCoi.port_b1,junHea.port_1) annotation(Line(points = {{-20.200900000000004,-27.879468},{-12.000000000000002,-27.879468},{-12.000000000000002,-52.62741231161647}},color = {0,127,255}));
    connect(junHea.port_2,portHea_b) annotation(Line(points = {{-11.999999999999998,-67.37258768838353},{-12,-100}},color = {0,127,255}));
    connect(portCoo_b,junCoo.port_2) annotation(Line(points = {{-78,-100},{-78,-67.37258768838353}},color = {0,127,255}));
    connect(junCoo.port_1,cooCoi.port_b1) annotation(Line(points = {{-78,-52.62741231161647},{-78,-27.879468},{-84.20089999999999,-27.879468}},color = {0,127,255}));
    connect(threeWayCoo.port_1,cooCoi.port_a1) annotation(Line(points = {{-112,-50},{-112,-27.879468},{-103.79910000000001,-27.879468}},color = {0,127,255}));
    connect(threeWayCoo.port_2,portCoo_a) annotation(Line(points = {{-112,-70},{-112,-100}},color = {0,127,255}));
    connect(threeWayCoo.port_3,junCoo.port_3) annotation(Line(points = {{-102,-60},{-85.37258768838353,-60}},color = {0,127,255}));
    connect(threeWayHea.port_1,heaCoi.port_a1) annotation(Line(points = {{-48,-50},{-48,-27.879468},{-39.79906,-27.879468}},color = {0,127,255}));
    connect(threeWayHea.port_2,portHea_a) annotation(Line(points = {{-48,-70},{-48,-100}},color = {0,127,255}));
    connect(junHea.port_3,threeWayHea.port_3) annotation(Line(points = {{-19.372587688383533,-60},{-38,-60}},color = {0,127,255}));
    connect(junRec.port_2,rec.port_a1) annotation(Line(points = {{98.62741231161647,-16},{91,-16},{91,-17}},color = {0,127,255}));
    connect(threeWayRec.port_a1,rec.port_b1) annotation(Line(points = {{59.01209177503719,-16},{65,-16},{65,-17}},color = {0,127,255}));
    connect(threeWayRec.port_a2,junRec.port_3) annotation(Line(points = {{52,-23.01209177503719},{52,-46},{106,-46},{106,-23.372587688383533}},color = {0,127,255}));
    connect(ahuInternalControl.valPosRec,threeWayRec.switch) annotation(Line(points = {{73,-66},{62,-66},{62,-4.390326579970246},{52,-4.390326579970246},{52,-10.390326579970246}},color = {255,0,255}));
    connect(ahuInternalControl.valPosAhuHea,threeWayHea.ctrl) annotation(Line(points = {{73.06666666666666,-76.64444444444445},{-64.8,-76.64444444444445},{-64.8,-60},{-58.8,-60}},color = {0,0,127}));
    connect(ahuInternalControl.valPosAhuCoo,threeWayCoo.ctrl) annotation(Line(points = {{73.06666666666666,-79.67777777777778},{-128.8,-79.67777777777778},{-128.8,-60},{-122.8,-60}},color = {0,0,127}));
    connect(ahuInternalControl.TSupAhu,senTSupAhu.T) annotation(Line(points = {{94.06666666666666,-82.07777777777778},{100.06666666666666,-82.07777777777778},{100.06666666666666,-90},{-148,-90},{-148,-4},{-136,-4},{-136,-8.299967000000002}},color = {0,0,127}));
    connect(ahuInternalControl.TRetAhu,senTRetAhu.T) annotation(Line(points = {{94,-70},{184,-70},{184,84},{-96,84},{-96,33.700033}},color = {0,0,127}));
    connect(ahuInternalControl.TSupAhuSet,TSupAhuSet) annotation(Line(points = {{94.06666666666666,-75.67777777777778},{160,-75.67777777777778},{160,100}},color = {0,0,127}));
    connect(prfAhuSup,preHeaSup.u) annotation(Line(points = {{20,100},{20,79.8},{20.000000000000004,79.8},{20.000000000000004,57.6}},color = {0,0,127}));
    connect(preHeaRet.u,prfAhuRet) annotation(Line(points = {{-10,69.6},{-10,100}},color = {0,0,127}));
    connect(prfAhuRet,ahuInternalControl.prfAhu) annotation(Line(points = {{-10,100},{-10,80},{172,80},{172,-77.6},{94,-77.6}},color = {0,0,127}));
    connect(oveByPass,ahuInternalControl.oveByPass) annotation(Line(points = {{194,100},{194,-54},{79,-54},{79,-64}},color = {255,0,255}));
    connect(senTExhAhu.port_b,outsideAir.ports[1]) annotation(Line(points = {{129,26},{134,26},{134,3}},color = {0,127,255}));
    connect(rec.port_b2,senTExhAhu.port_a) annotation(Line(points = {{91,25},{91,26},{115,26}},color = {0,127,255}));
    connect(senTExhAhu.T,TExhAhu) annotation(Line(points = {{122,33.700033},{122,66},{92,66},{92,110}},color = {0,0,127}));
    connect(senTInAhu.port_a,outsideAir.ports[2]) annotation(Line(points = {{131,-16},{134,-16},{134,5}},color = {0,127,255}));
    connect(junRec.port_1,senTInAhu.port_b) annotation(Line(points = {{113.37258768838353,-16},{117,-16}},color = {0,127,255}));
    connect(ahuInternalControl.TInAhu,senTInAhu.T) annotation(Line(points = {{94.05333333333334,-65.97555555555556},{132,-65.97555555555556},{132,-8.299967000000002},{124,-8.299967000000002}},color = {0,0,127}));
    connect(senTInAhu.T,TInAhu) annotation(Line(points = {{124,-8.299967000000002},{132,-8.299967000000002},{132,-92},{160,-92},{160,-110}},color = {0,0,127}));
    connect(fanSup.port_a,senTRecAhu.port_b) annotation(Line(points = {{16,-16},{27,-16}},color = {0,127,255}));
    connect(threeWayRec.port_b,senTRecAhu.port_a) annotation(Line(points = {{44.98790822496281,-16},{41,-16}},color = {0,127,255}));
    connect(senTRecAhu.T,TRecAhu) annotation(Line(points = {{34,-8.29997},{34,12},{50,12},{50,110}},color = {0,0,127}));
    connect(senTSupAhu.T,TSupAhu) annotation(Line(points = {{-136,-8.29997},{-136,110}},color = {0,0,127}));
    connect(fanSup.P,PSupAhu) annotation(Line(points = {{-5,-7},{-118,-7},{-118,74},{-210,74}},color = {0,0,127}));
    connect(fanRet.P,PRetAhu) annotation(Line(points = {{1.0000000000000018,35},{1.0000000000000018,46},{-70,46},{-70,52},{-210,52}},color = {0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}})),           Icon(coordinateSystem(extent={{-200,
            -100},{200,100}}), graphics={
        Rectangle(
          extent={{-60,0},{40,-100}},
          lineColor={0,0,0},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{100,100},{200,-100}}, lineColor={0,0,0}),
        Line(points={{100,-100},{200,100}}, color={0,0,0}),
        Line(points={{100,100},{200,-100}}, color={0,0,0}),
        Line(points={{200,0},{-200,0}}, color={0,0,0}),
        Rectangle(extent={{-200,100},{100,-100}}, lineColor={0,0,0}),
        Line(points={{40,100},{40,-100}}, color={0,0,0}),
        Rectangle(
          extent={{-160,0},{-60,-100}},
          lineColor={0,0,0},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-130,-28},{-88,-72}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-30,-28},{12,-72}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-128,-26},{-90,-70}},
          textColor={0,0,0},
          textString="-"),
        Text(
          extent={{-28,-28},{10,-72}},
          textColor={0,0,0},
          textString="+"),
        Polygon(
          points={{40,-50},{80,0},{80,-100},{40,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Polygon(
          points={{100,50},{60,100},{60,0},{100,50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Rectangle(
          extent={{-200,100},{-160,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Line(points={{-170,-10},{-190,-32},{-168,-50},{-190,-72},{-170,-92}},
            color={0,0,0}),
        Line(points={{-188,92},{-168,70},{-190,52},{-168,30},{-188,10}}, color=
              {0,0,0})}),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end AirHandlingUnit;
