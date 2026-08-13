within BuildingEmulators.Components;
partial model PartialMixing
    
    
   extends .IDEAS.Fluid.Interfaces.PartialFourPortInterface(final m1_flow_nominal = m_flow_nominal_emi, 
                                                           final m2_flow_nominal = m_flow_nominal_emi,
                                                           redeclare final package Medium1 = Medium,
                                                           redeclare final package Medium2 = Medium,
                                                           final allowFlowReversal1 = allowFlowReversal,
                                                           final allowFlowReversal2 = allowFlowReversal);
    
    replaceable package Medium = .IDEAS.Media.Water;
    parameter .Modelica.Units.SI.MassFlowRate m_flow_nominal_emi "Nominal mass flow of the heating coil";
    parameter .Modelica.Units.SI.PressureDifference dp_nominal "Nominal pressure drop";

    parameter Boolean allowFlowReversal = false "if false flow reversal not allowed";    
    .IDEAS.Fluid.FixedResistances.Junction jun(energyDynamics = .Modelica.Fluid.Types.Dynamics.SteadyState,dp_nominal = {0,0,0},m_flow_nominal = {1,1,1},redeclare package Medium = Medium,portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,from_dp = true,linearized = false) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 180.0,origin = {-50.0,-60.0})));
    .IDEAS.Fluid.Movers.FlowControlled_dp pum(addPowerToMedium = false,allowFlowReversal = false,energyDynamics = .Modelica.Fluid.Types.Dynamics.SteadyState,use_inputFilter = false,m_flow_nominal = m_flow_nominal_emi,redeclare package Medium = Medium,dp_nominal = dp_nominal) "Pump for emmision cooling" annotation(Placement(transformation(extent = {{10.0,10.0},{-10.0,-10.0}},origin = {-10.0,60.0},rotation = 180.0)));
    .IDEAS.Fluid.FixedResistances.PressureDrop preDroEmi(linearized = false,dp_nominal = dp_nominal,m_flow_nominal = m_flow_nominal_emi,allowFlowReversal = false,redeclare package Medium = Medium,from_dp = false) "Flow resistance to decouple pressure state from boundary" annotation(Placement(transformation(extent = {{20.765580811518994,50.0},{39.234419188481006,70.0}},rotation = 0.0,origin = {0.0,0.0})));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTSup(tau = 0,allowFlowReversal = allowFlowReversal,m_flow_nominal = m_flow_nominal_emi,redeclare package Medium = Medium) annotation(Placement(transformation(extent = {{7.0,8.0},{-7.0,-8.0}},rotation = -180.0,origin = {70.0,60.0})));
    .IDEAS.Fluid.Sensors.TemperatureTwoPort senTRet(tau = 0,allowFlowReversal = allowFlowReversal,m_flow_nominal = m_flow_nominal_emi,redeclare package Medium = Medium) annotation(Placement(transformation(extent = {{-7.0,8.0},{7.0,-8.0}},rotation = -180.0,origin = {50.0,-60.0})));
    .Modelica.Blocks.Interfaces.RealInput valPos annotation(Placement(transformation(extent = {{-11.637361465788274,-11.637361465788274},{11.637361465788274,11.637361465788274}},origin = {-50.0,100.0},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.RealOutput TSup annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {70.0,110.0},rotation = 90.0)));
    .Modelica.Blocks.Interfaces.RealOutput TRet annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {50.0,110.0},rotation = 90.0)));
    .IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor val(
        redeclare package Medium=Medium,
        m_flow_nominal = m_flow_nominal_emi,
        portFlowDirection_1 = .Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2 = .Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3 = .Modelica.Fluid.Types.PortFlowDirection.Entering,from_dp = true,tau = 60,energyDynamics = .Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(Placement(transformation(extent = {{-60.0,50.0},{-40.0,70.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput P annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {20.0,110.0},rotation = 90.0)));
equation
    connect(jun.port_2,port_b2) annotation(Line(points = {{-60,-60},{-100,-60}},color = {0,127,255}));
    connect(senTSup.port_b,port_b1) annotation(Line(points = {{77,60},{100,60}},color = {0,127,255}));
    connect(port_a2,senTRet.port_a) annotation(Line(points = {{100,-60},{57,-60}},color = {0,127,255}));
    connect(senTRet.port_b,jun.port_1) annotation(Line(points = {{43,-60},{-40,-60}},color = {0,127,255}));
    connect(senTSup.T,TSup) annotation(Line(points = {{70,68.8},{70,110}},color = {0,0,127}));
    connect(senTRet.T,TRet) annotation(Line(points = {{50,-51.2},{50,110}},color = {0,0,127}));
    connect(val.port_2,pum.port_a) annotation(Line(points = {{-40,60},{-20,60}},color = {0,127,255}));
    connect(val.ctrl,valPos) annotation(Line(points = {{-50,70.8},{-50,100}},color = {0,0,127}));
    connect(val.port_3,jun.port_3) annotation(Line(points = {{-50,50},{-50,-50}},color = {0,127,255}));
    connect(pum.port_b,preDroEmi.port_a) annotation(Line(points = {{0,60},{20.765580811518994,60}},color = {0,127,255}));
    connect(preDroEmi.port_b,senTSup.port_a) annotation(Line(points = {{39.234419188481006,60},{63,60}},color = {0,127,255}));
    connect(val.port_1,port_a1) annotation(Line(points = {{-60,60},{-100,60}},color = {0,127,255}));
    connect(pum.P,P) annotation(Line(points = {{1.0000000000000018,69},{20,69},{20,110}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Line(origin={-0.5177091095380106,59.446963128145086},points={{-100.07841607675113,0.15605616176264903},{100.07841607675113,-0.15605616176264903}},color={74,144,226}),Line(origin={-2,-60},points={{-100.07841607675113,0.15605616176264903},{100.07841607675113,-0.15605616176264903}},color={74,144,226}),Line(origin={0.1563711127035602,-0.913286126320525},points={{-58.991702203071654,-0.00031495094090852604},{58.991702203071654,0.0003149509409085538}},color={74,144,226},rotation=90),Ellipse(origin={50,60},extent={{-14,14},{14,-14}},fillPattern=FillPattern.Solid,fillColor={255,255,255}),Polygon(origin={54,60},points={{-10,-12.001304658593085},{-10.181510510888536,12.001304658593085},{10.181510510888536,-0.1334509480617072}}),Polygon(origin={0,50},points={{-10.419418924003594,-10.238453406651512},{10,-10},{0,10}},fillPattern=FillPattern.Solid),Polygon(origin={-10,60},points={{-10.419418924003594,-10.238453406651512},{10,-10},{0,10}},rotation=270,fillPattern=FillPattern.Solid),Polygon(origin={10,60},points={{-10.419418924003594,-10.238453406651512},{10,-10},{0,10}},rotation=90,fillPattern=FillPattern.Solid,fillColor={255,255,255})}));
end PartialMixing;
