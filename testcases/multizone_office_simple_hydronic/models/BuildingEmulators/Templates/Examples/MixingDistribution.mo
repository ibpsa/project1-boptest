within BuildingEmulators.Templates.Examples;

model MixingDistribution
    extends .Modelica.Icons.Example;
    .BuildingEmulators.Components.MixingReal mixing(m_flow_nominal = 1,dp_nominal = 1e5) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-50.0,30.0},rotation = -90.0)));
    .Modelica.Blocks.Sources.Constant dp(k = 1e5) annotation(Placement(transformation(extent = {{84.0,58.0},{64.0,78.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Ramp ramp(height = -1,duration = 3600,offset = 1) annotation(Placement(transformation(extent = {{84.0,10.0},{64.0,30.0}},origin = {0.0,0.0},rotation = 0.0)));
    .BuildingEmulators.Components.MixingReal mixing2(dp_nominal = 1e5,m_flow_nominal = 1) annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-4.0,30.0},rotation = -90.0)));
    .IDEAS.Fluid.Sources.Boundary_pT source(redeclare package Medium = IDEAS.Media.Water,nPorts = 1) annotation(Placement(transformation(extent = {{88.0,-60.0},{68.0,-40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Sources.Boundary_pT sink(redeclare package Medium = .IDEAS.Media.Water,nPorts = 1) annotation(Placement(transformation(extent = {{88.0,-92.0},{68.0,-72.0}},origin = {0.0,0.0},rotation = 0.0)));
    .BuildingEmulators.Components.CollectorPair collectorPair(m_flow_nominal = {2},dp_nominal = {1e5}) annotation(Placement(transformation(extent = {{-19.0,-66.0},{-41.0,-46.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Movers.FlowControlled_dp pum(redeclare package Medium=IDEAS.Media.Water, use_inputFilter = false,energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState,allowFlowReversal = false,m_flow_nominal = 2,dp_nominal = 1e5,addPowerToMedium = false) annotation(Placement(transformation(extent = {{53.28583617882133,-59.28583617882133},{34.71416382117867,-40.71416382117867}},origin = {0.0,0.0},rotation = 0.0)));

equation
    connect(mixing.port_b1,mixing.port_a2) annotation(Line(points = {{-44,40},{-44,46},{-56,46},{-56,40}},color = {0,127,255}));
    connect(mixing2.port_b1,mixing2.port_a2) annotation(Line(points = {{2,40},{2,46},{-10.000000000000002,46},{-10.000000000000002,40}},color = {0,127,255}));
    connect(ramp.y,mixing.y) annotation(Line(points = {{63,20},{30.5,20},{30.5,25},{-40,25}},color = {0,0,127}));
    connect(ramp.y,mixing2.y) annotation(Line(points = {{63,20},{30,20},{30,25},{6.000000000000002,25}},color = {0,0,127}));
    connect(mixing.port_a1,collectorPair.portsDistSup[1]) annotation(Line(points = {{-44,20},{-44,-14},{-25,-14},{-25,-46}},color = {0,127,255}));
    connect(mixing.port_b2,collectorPair.portsDistRet[1]) annotation(Line(points = {{-56,20},{-56,-24},{-35.2,-24},{-35.2,-46}},color = {0,127,255}));
    connect(mixing2.port_a1,collectorPair.portsDistSup[2]) annotation(Line(points = {{2.0000000000000018,20},{2.0000000000000018,-28},{-25,-28},{-25,-46}},color = {0,127,255}));
    connect(mixing2.port_b2,collectorPair.portsDistRet[2]) annotation(Line(points = {{-9.999999999999998,20},{-9.999999999999998,0},{-56,0},{-56,-24},{-35.2,-24},{-35.2,-46}},color = {0,127,255}));
    connect(pum.port_b,collectorPair.portsProdSup[1]) annotation(Line(points = {{34.71416382117867,-50},{17.5,-50},{17.5,-50.8},{-19,-50.8}},color = {0,127,255}));
    connect(pum.port_a,source.ports[1]) annotation(Line(points = {{53.28583617882133,-50},{68,-50}},color = {0,127,255}));
    connect(sink.ports[1:1],collectorPair.portsProdRet) annotation(Line(points = {{68,-82},{24.5,-82},{24.5,-60.8},{-19,-60.8}},color = {0,127,255}));
    connect(dp.y,mixing2.dp_in) annotation(Line(points = {{63,68},{44,68},{44,29.000000000000004},{6,29.000000000000004}},color = {0,0,127}));
    connect(dp.y,mixing.dp_in) annotation(Line(points = {{63,68},{44,68},{44,52},{-24,52},{-24,29.000000000000004},{-40,29.000000000000004}},color = {0,0,127}));
    connect(dp.y,pum.dp_in) annotation(Line(points = {{63,68},{44,68},{44,-38.85699658541441}},color = {0,0,127}));

    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end MixingDistribution;
