within BuildingEmulators.Components;
model FanCoilUnit
  replaceable package MediumAir = IDEAS.Media.Air;
  replaceable package MediumHeating = IDEAS.Media.Water;
  replaceable package MediumCooling = IDEAS.Media.Water;
  Modelica.Units.SI.Temperature TMax "Maximum temperature" annotation (
    Dialog(tab = "General"));
  Modelica.Units.SI.Temperature TMin "Minimum temperature" annotation (
    Dialog(tab = "General"));
  parameter Boolean allowFlowReversal = false "";
  parameter Modelica.Units.SI.MassFlowRate mWatHea_flow_nominal = heaCoi.Q_flow_nominal / 4180 / deltaTHea_nominal "Nominal mass flow of the heating coil";
  parameter Modelica.Units.SI.MassFlowRate mWatCoo_flow_nominal = -cooCoi.Q_flow_nominal / 4180 / deltaTCoo_nominal "Nominal mass flow of the cooling coil";
  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal "Nominal mass flow of the cooling coil";
  parameter Modelica.Units.SI.PressureDifference dpAir_nominal = 40 * 0.49 / (485 / 3600) "Nominal air pressure difference";
  parameter Modelica.Units.SI.TemperatureDifference deltaTCoo_nominal = 5 "Nominal temperature difference in water side in the cooling coil" annotation (
    Dialog(group = "Cooling coil parameters"));
  parameter Modelica.Units.SI.TemperatureDifference deltaTHea_nominal = 10 "Nominal temperature difference in water side in the heating coil" annotation (
    Dialog(group = "Heating coil parameters"));
  parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal "Nominal heat transfer of the heating coil" annotation (
    Dialog(group = "Heating coil parameters"));
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal "Nominal heat transfer of the cooling coil" annotation (
    Dialog(group = "Cooling coil parameters"));
  parameter Modelica.Units.SI.Temperature THea_a1_nominal "Nominal temperature of inlet air in the heating coil" annotation (
    Dialog(group = "Heating coil parameters"));
  parameter Modelica.Units.SI.Temperature THea_a2_nominal "Nominal temperature of water inlet in the heating coil" annotation (
    Dialog(group = "Heating coil parameters"));
  parameter Modelica.Units.SI.Temperature TCoo_a1_nominal "Nominal temperature of inlet air in the cooling coil" annotation (
    Dialog(group = "Cooling coil parameters"));
  parameter Modelica.Units.SI.Temperature TCoo_a2_nominal "Nominal temperature of water inlet in the cooling coil" annotation (
    Dialog(group = "Cooling coil parameters"));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = MediumAir, addPowerToMedium = false, allowFlowReversal = allowFlowReversal, dp_nominal = dpAir_nominal, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mAir_flow_nominal, tau = 0, use_inputFilter = false,redeclare replaceable .IDEAS.Fluid.Movers.Data.Generic per) "Fan recirculating the air in the zone through the fan coil unit" annotation (
    Placement(transformation(extent = {{-50, -10}, {-30, 10}})));

    Buildings.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoi(
   //         IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU cooCoi(
    redeclare package Medium2 = MediumAir,
    redeclare package Medium1 = MediumCooling,
        Q_flow_nominal = QCoo_flow_nominal,
        T_a1_nominal = TCoo_a1_nominal,
        T_a2_nominal = TCoo_a2_nominal,
        allowFlowReversal1 = false,
        allowFlowReversal2 = false,
        configuration = Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        dp1_nominal = 0,
        dp2_nominal = dpAir_nominal / (2),
        from_dp1 = false,
        m2_flow_nominal = mAir_flow_nominal,
        show_T = true,
        use_Q_flow_nominal = true,
        w_a2_nominal = 0.01,
        m1_flow_nominal = mWatCoo_flow_nominal
        //UA_nominal = QCoo_flow_nominal / (Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(TCoo_a1_nominal,TCoo_a1_nominal + 5,TCoo_a2_nominal,TCoo_a2_nominal - 10))
        ) annotation (
    Placement(visible = true, transformation(origin = {-10, -6}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
    redeclare package Medium1 = MediumHeating,
    configuration = IDEAS.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    m1_flow_nominal = mWatHea_flow_nominal,
    m2_flow_nominal = mAir_flow_nominal,
    Q_flow_nominal = QHea_flow_nominal,
    T_a1_nominal = THea_a1_nominal,
    T_a2_nominal = THea_a2_nominal,
    show_T = true,
    allowFlowReversal1 = false,
    allowFlowReversal2 = false,
    redeclare package Medium2 = MediumAir,
    dp2_nominal = dpAir_nominal / (2),
    use_Q_flow_nominal = true,
    dp1_nominal = 0) annotation (
    Placement(transformation(extent = {{66, 4}, {46, -16}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_coo_a(redeclare final package Medium =
        MediumCooling,                                                                             m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) "Cooling coil inlet" annotation (
    Placement(transformation(extent = {{0, -110}, {20, -90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_coo_b(redeclare final package Medium =
        MediumCooling,                                                                             m_flow(max = if allowFlowReversal then Modelica.Constants.inf else 0)) "Cooling coil outlet" annotation (
    Placement(transformation(extent = {{-40, -110}, {-20, -90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_hea_a(redeclare final package Medium =
        MediumHeating,                                                                             m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) "Heating coil outlet" annotation (
    Placement(transformation(extent = {{70, -110}, {90, -90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_hea_b(redeclare final package Medium =
        MediumHeating,                                                                             m_flow(max = if allowFlowReversal then Modelica.Constants.inf else 0)) "Heating coil outlet" annotation (
    Placement(transformation(extent = {{30.0,-110.0},{50.0,-90.0}},rotation = 0.0,origin = {0.0,0.0})));
  Modelica.Fluid.Interfaces.FluidPort_b port_air_b(redeclare final package Medium = MediumAir, m_flow(max = if allowFlowReversal then Modelica.Constants.inf else 0)) "Air outlet" annotation (
    Placement(transformation(extent = {{60, 90}, {80, 110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_air_a(redeclare final package Medium = MediumAir, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) "Air inlet" annotation (
    Placement(transformation(extent = {{-70, 90}, {-50, 110}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumAir, m_flow_nominal = mAir_flow_nominal, allowFlowReversal = allowFlowReversal, tau = 0) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-60, 50})));
  Modelica.Blocks.Math.Add3 add3_1(k1 = mAir_flow_nominal, k2 = mAir_flow_nominal) annotation (
    Placement(transformation(extent = {{-56, 24}, {-46, 34}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power use" annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-100, -110})));
  Modelica.Blocks.Sources.RealExpression minSpe(y = 0) annotation (
    Placement(transformation(extent = {{-93.58448171086141,16.415518289138582},{-78.41551828913859,31.584481710861418}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Sources.RealExpression realExpression(y = heaCoi.Q2_flow) annotation(Placement(transformation(extent = {{0.0,84.0},{-20.0,64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.RealExpression realExpression2(y = cooCoi.Q2_flow) annotation(Placement(transformation(extent = {{0.0,66.0},{-20.0,46.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput QHea "Electrical power use" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = -180.0,origin = {-110.0,74.0})));
    .Modelica.Blocks.Interfaces.RealOutput QCoo "Electrical power use" annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = -180.0,origin = {-110.0,56.0})));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor threeWayCoo(
        tau = 60,
        from_dp = false,
        portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        m_flow_nominal = mWatCoo_flow_nominal,
        redeclare package Medium = MediumCooling) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {10.0,-48.0},rotation = -90.0)));
    .IDEAS.Fluid.FixedResistances.Junction junCoo(
        from_dp = false,redeclare package Medium = MediumCooling,
        energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
        m_flow_nominal = {1,1,1},
        dp_nominal = {0,0,0},
        portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Entering,tau = 60) annotation(Placement(transformation(extent = {{7.372587688383533,-7.372587688383533},{-7.372587688383533,7.372587688383533}},origin = {-30.0,-48.0},rotation = 90.0)));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor threeWayHea(
        tau = 60,
        from_dp = false,
        portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        m_flow_nominal = mWatHea_flow_nominal,
        redeclare package Medium = MediumHeating) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {80.0,-50.0},rotation = -90.0)));
    .IDEAS.Fluid.FixedResistances.Junction junHea(
        from_dp = false,
        portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        dp_nominal = {0,0,0},
        m_flow_nominal = {1,1,1},
        energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare package Medium = MediumHeating,tau = 60) annotation(Placement(transformation(extent = {{7.372587688383533,-7.372587688383533},{-7.372587688383533,7.372587688383533}},origin = {40.0,-50.0},rotation = 90.0)));
    .BuildingEmulators.Components.FcuInternalControl fcuInternalControl annotation(Placement(transformation(extent = {{-92.0,-76.0},{-72.0,-56.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort TSupFCU(
    tau = 0,
    allowFlowReversal = allowFlowReversal,
    m_flow_nominal = mAir_flow_nominal,
    redeclare package Medium = MediumAir) annotation(Placement(transformation(extent = {{10.0,10.0},{-10.0,-10.0}},rotation = -90.0,origin = {72.0,48.0})));
equation
  fcuInternalControl.TZonMax = TMax;
  fcuInternalControl.TZonMin = TMin;

  connect(fan.port_a, senTem.port_b) annotation (
    Line(points = {{-50, 0}, {-60, 0}, {-60, 40}}, color = {0, 127, 255}));
  connect(senTem.port_a, port_air_a) annotation (
    Line(points = {{-60, 60}, {-60, 100}}, color = {0, 127, 255}));
  connect(add3_1.y, fan.m_flow_in) annotation (
    Line(points = {{-45.5, 29}, {-40, 29}, {-40, 12}}, color = {0, 0, 127}));
  connect(fan.P, P) annotation (
    Line(points = {{-29, 9}, {-29, -90}, {-100, -90}, {-100, -110}}, color = {0, 0, 127}));
  connect(fan.port_b, cooCoi.port_a2) annotation (
    Line(points = {{-30, 0}, {-20, 0}}, color = {0, 127, 255}));
  connect(cooCoi.port_b2, heaCoi.port_a2) annotation (
    Line(points = {{0, 0}, {46, 0}}, color = {0, 127, 255}));
    connect(realExpression2.y,QCoo) annotation(Line(points = {{-21,56},{-110,56}},color = {0,0,127}));
    connect(realExpression.y,QHea) annotation(Line(points = {{-21,74},{-110,74}},color = {0,0,127}));
    connect(minSpe.y,add3_1.u3) annotation(Line(points = {{-77.65707011805245,24},{-57,24},{-57,25}},color = {0,0,127}));
    connect(threeWayCoo.port_3,junCoo.port_3) annotation(Line(points = {{0,-48},{-22.627412311616467,-48}},color = {0,127,255}));
    connect(junHea.port_3,threeWayHea.port_3) annotation(Line(points = {{47.37258768838353,-50},{70,-50}},color = {0,127,255}));
    connect(junCoo.port_2,port_coo_b) annotation(Line(points = {{-30,-55.37258768838353},{-30,-100}},color = {0,127,255}));
    connect(junCoo.port_1,cooCoi.port_b1) annotation(Line(points = {{-30,-40.62741231161647},{-30,-12},{-20,-12}},color = {0,127,255}));
    connect(threeWayCoo.port_2,port_coo_a) annotation(Line(points = {{10.000000000000002,-58},{10,-100}},color = {0,127,255}));
    connect(threeWayCoo.port_1,cooCoi.port_a1) annotation(Line(points = {{9.999999999999998,-38},{9.999999999999998,-12},{0,-12}},color = {0,127,255}));
    connect(junHea.port_2,port_hea_b) annotation(Line(points = {{40,-57.37258768838353},{40,-100}},color = {0,127,255}));
    connect(junHea.port_1,heaCoi.port_b1) annotation(Line(points = {{40,-42.62741231161647},{40,-12},{46,-12}},color = {0,127,255}));
    connect(heaCoi.port_a1,threeWayHea.port_1) annotation(Line(points = {{66,-12},{80,-12},{80,-40}},color = {0,127,255}));
    connect(threeWayHea.port_2,port_hea_a) annotation(Line(points = {{80,-60},{80,-100}},color = {0,127,255}));
    connect(fcuInternalControl.valPosFCUHea,threeWayHea.ctrl) annotation(Line(points = {{-71.06666666666666,-68.64444444444445},{96.8,-68.64444444444445},{96.8,-50},{90.8,-50}},color = {0,0,127}));
    connect(fcuInternalControl.valPosFCUCoo,threeWayCoo.ctrl) annotation(Line(points = {{-71,-71.6},{26.8,-71.6},{26.8,-48},{20.8,-48}},color = {0,0,127}));
    connect(senTem.T,fcuInternalControl.TZon) annotation(Line(points = {{-71,50},{-98,50},{-98,-57},{-92,-57}},color = {0,0,127}));
    connect(heaCoi.port_b2,TSupFCU.port_a) annotation(Line(points = {{66,0},{72,0},{72,38}},color = {0,127,255}));
    connect(TSupFCU.port_b,port_air_b) annotation(Line(points = {{72,58},{72,100},{70,100}},color = {0,127,255}));
    connect(fcuInternalControl.speFanHea,add3_1.u1) annotation(Line(points = {{-71,-60.6},{-64,-60.6},{-64,33},{-57,33}},color = {0,0,127}));
    connect(fcuInternalControl.speFanCoo,add3_1.u2) annotation(Line(points = {{-71,-63.2},{-66,-63.2},{-66,29},{-57,29}},color = {0,0,127}));
  annotation (
    Documentation(revisions = "<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>", info = "<html>
<p>
Model of a four-pipe fan-coil unit for heating
and cooling detached from the zone model. The
FCU has a heat port to be connected into the
zone convective port.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={
        Rectangle(
          extent={{-100,66},{100,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          radius=5),
        Rectangle(
          extent={{-80,54},{-8,22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          radius=5),
        Rectangle(
          extent={{6,54},{82,22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          radius=5),
        Rectangle(
          extent={{-80,-16},{82,-44}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=1,
          radius=5),
        Line(
          points={{-76,50},{-12,50}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-76,44},{-12,44}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-76,38},{-12,38}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-76,32},{-12,32}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-76,26},{-12,26}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,26},{76,26}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,32},{76,32}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,38},{76,38}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,44},{76,44}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,50},{76,50}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-74,-38},{-60,-22},{-48,-38},{-34,-22},{-22,-38},{-8,-22},{4,
              -38},{16,-22},{28,-36},{38,-24},{52,-38},{62,-22},{72,-36}},
          color={0,0,0},
          thickness=1)}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end FanCoilUnit;
