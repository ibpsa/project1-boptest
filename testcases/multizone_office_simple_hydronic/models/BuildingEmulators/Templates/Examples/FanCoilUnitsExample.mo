within BuildingEmulators.Templates.Examples;
model FanCoilUnitsExample
    extends .Modelica.Icons.Example;
    .BuildingEmulators.Components.FanCoilUnit fanCoilUnit(
        mAir_flow_nominal = 10,
        QCoo_flow_nominal = -1e5,
        TCoo_a1_nominal = 273.15 + 7,
        TCoo_a2_nominal = 273.15 + 26,
        QHea_flow_nominal = 1e5,
        THea_a1_nominal = 273.15 + 70,
        THea_a2_nominal = 273.15 + 15) annotation(Placement(transformation(extent = {{-10,24},{10,44}},origin = {0,0},rotation = 0)));
    .Buildings.Fluid.Sources.Boundary_pT zon(
        redeclare package Medium = IDEAS.Media.Air,
        use_T_in = true,
        nPorts = 2) annotation(Placement(transformation(extent = {{-62.0,72.0},{-42.0,92.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Sine sine(
        offset = 273.15 + 23,
        amplitude = 5,
        f = 1 / 900) annotation(Placement(transformation(extent = {{-100.0,60.0},{-80.0,80.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Fluid.Sources.MassFlowSource_T cooSup(nPorts = 1,T = 280.15,m_flow = 10,redeclare package Medium = .IDEAS.Media.Water) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0,origin = {-32.0,-38.0})));
    .IDEAS.Fluid.Sources.MassFlowSource_T heaSup(redeclare package Medium = .IDEAS.Media.Water,m_flow = 10,T = 313.15,nPorts = 1) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},rotation = 90.0,origin = {8.0,-38.0})));
    .Buildings.Fluid.Sources.Boundary_pT sinkHea(nPorts = 1,use_T_in = false,redeclare package Medium = .IDEAS.Media.Water) annotation(Placement(transformation(extent = {{62.0,0.0},{42.0,20.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sources.Boundary_pT sinkCoo(redeclare package Medium = .IDEAS.Media.Water,use_T_in = false,nPorts = 1) annotation(Placement(transformation(extent = {{62.0,-26.0},{42.0,-6.0}},origin = {0.0,0.0},rotation = 0.0)));

equation
    fanCoilUnit.TMax = 273.15+26;
    fanCoilUnit.TMin = 273.15+21;
    connect(heaSup.ports[1],fanCoilUnit.port_hea_a) annotation(Line(points = {{8.000000000000002,-28},{8,24}},color = {0,127,255}));
    connect(cooSup.ports[1],fanCoilUnit.port_coo_a) annotation(Line(points = {{-31.999999999999996,-28},{-31.999999999999996,5},{1,5},{1,24}},color = {0,127,255}));
    connect(zon.ports[1],fanCoilUnit.port_air_a) annotation(Line(points = {{-42,82},{-6,82},{-6,44}},color = {0,127,255}));
    connect(zon.ports[2],fanCoilUnit.port_air_b) annotation(Line(points = {{-42,82},{7,82},{7,44}},color = {0,127,255}));
    connect(sine.y,zon.T_in) annotation(Line(points = {{-79,70},{-71.5,70},{-71.5,86},{-64,86}},color = {0,0,127}));
    connect(sinkHea.ports[1],fanCoilUnit.port_hea_b) annotation(Line(points = {{42,10},{4,10},{4,24}},color = {0,127,255}));
    connect(sinkCoo.ports[1],fanCoilUnit.port_coo_b) annotation(Line(points = {{42,-16},{-3,-16},{-3,24}},color = {0,127,255}));

    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end FanCoilUnitsExample;
