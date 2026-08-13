within BuildingEmulators.Components;

model FcuInternalControl


    .IDEAS.Controls.Continuous.LimPID pidFCUHea(k = 1,Ti = 120) annotation(Placement(transformation(extent = {{-42.673400656512115,65.32659934348789},{-29.326599343487885,78.67340065651211}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID pidFCUCoo(k = 1,Ti = 120,reverseActing = false,controllerType = .Modelica.Blocks.Types.SimpleController.PI) annotation(Placement(transformation(extent = {{-42.433269153984476,21.566730846015524},{-29.566730846015524,34.433269153984476}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosFCUHea annotation(Placement(transformation(extent = {{99.33333333333333,-36.444444444444436},{119.33333333333333,-16.444444444444436}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosFCUCoo annotation(Placement(transformation(extent = {{100.0,-66.0},{120.0,-46.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZonMax annotation(Placement(transformation(extent = {{-110.73112214086746,17.268877859132544},{-89.26887785913254,38.731122140867456}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZonMin annotation(Placement(transformation(extent = {{-110.73112214086746,61.268877859132544},{-89.26887785913254,82.73112214086746}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZon annotation(Placement(transformation(extent = {{-110.73112214086746,79.26887785913254},{-89.26887785913254,100.73112214086746}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput speFanHea annotation(Placement(transformation(extent = {{100.0,44.0},{120.0,64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput speFanCoo annotation(Placement(transformation(extent = {{100.0,18.0},{120.0,38.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(pidFCUCoo.y,valPosFCUCoo) annotation(Line(points = {{-28.923403930617077,28},{6,28},{6,-56},{110,-56}},color = {0,0,127}));
    connect(pidFCUHea.y,valPosFCUHea) annotation(Line(points = {{-28.659259277836675,72},{40,72},{40,-26.444444444444436},{109.33333333333331,-26.444444444444436}},color = {0,0,127}));
    connect(TZon,pidFCUHea.u_m) annotation(Line(points = {{-100,90},{-60,90},{-60,50},{-36,50},{-36,63.991919212185465}},color = {0,0,127}));
    connect(TZon,pidFCUCoo.u_m) annotation(Line(points = {{-100,90},{-60,90},{-60,8},{-36,8},{-36,20.28007701521863}},color = {0,0,127}));
    connect(TZonMin,pidFCUHea.u_s) annotation(Line(points = {{-100,72},{-44.008080787814535,72}},color = {0,0,127}));
    connect(TZonMax,pidFCUCoo.u_s) annotation(Line(points = {{-100,28},{-43.71992298478137,28}},color = {0,0,127}));
    connect(pidFCUHea.y,speFanHea) annotation(Line(points = {{-28.659259277836675,72},{40,72},{40,54},{110,54}},color = {0,0,127}));
    connect(pidFCUCoo.y,speFanCoo) annotation(Line(points = {{-28.923403930617077,28},{110,28}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name"),Ellipse(origin={-56,86},extent={{-10,10},{10,-10}}),Ellipse(origin={-16,16},extent={{-10,10},{10,-10}}),Ellipse(origin={24,66},extent={{-10,10},{10,-10}}),Ellipse(origin={64,-14},extent={{-10,10},{10,-10}}),Line(origin={-56,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={-16,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={24,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={64,0},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Rectangle(extent={{-100,100},{100,-100}})}), uses(
        Modelica(version="4.0.0")));
end FcuInternalControl;
