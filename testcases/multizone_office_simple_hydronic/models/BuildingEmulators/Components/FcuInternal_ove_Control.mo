within BuildingEmulators.Components;

model FcuInternal_ove_Control


    .IDEAS.Controls.Continuous.LimPID pidFCUHea(k = 1,Ti = 120) annotation(Placement(transformation(extent = {{-42.673400656512115,65.32659934348789},{-29.326599343487885,78.67340065651211}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID pidFCUCoo(k = 1,Ti = 120,reverseActing = false,controllerType = .Modelica.Blocks.Types.SimpleController.PI) annotation(Placement(transformation(extent = {{-42.433269153984476,21.566730846015524},{-29.566730846015524,34.433269153984476}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosFCUHea annotation(Placement(transformation(extent = {{99.33333333333333,-36.444444444444436},{119.33333333333333,-16.444444444444436}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosFCUCoo annotation(Placement(transformation(extent = {{100.0,-66.0},{120.0,-46.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZonMax annotation(Placement(transformation(extent = {{-110.73112214086746,17.268877859132544},{-89.26887785913254,38.731122140867456}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZonMin annotation(Placement(transformation(extent = {{-110.73112214086746,61.268877859132544},{-89.26887785913254,82.73112214086746}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TZon annotation(Placement(transformation(extent = {{-110.73112214086746,79.26887785913254},{-89.26887785913254,100.73112214086746}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput speFanHea annotation(Placement(transformation(extent = {{100.0,44.0},{120.0,64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput speFanCoo annotation(Placement(transformation(extent = {{100.0,18.0},{120.0,38.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerInput prfEmiHea annotation(Placement(transformation(extent = {{-112.36070971046043,-52.360709710460426},{-87.63929028953957,-27.639290289539574}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerInput prfEmiCoo annotation(Placement(transformation(extent = {{-111.3438497914323,-91.3438497914323},{-88.6561502085677,-68.6561502085677}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Switch ovespeFanHea annotation(Placement(transformation(extent = {{30.0,44.0},{50.0,64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Switch ovespeFanCoo annotation(Placement(transformation(extent = {{30.0,-12.0},{50.0,8.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.IntegerToReal integerToReal annotation(Placement(transformation(extent = {{-40.25869637564481,-84.2586963756448},{-31.74130362435519,-75.7413036243552}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.IntegerToReal integerToReal2 annotation(Placement(transformation(extent = {{-40.25869637564481,-44.2586963756448},{-31.74130362435519,-35.7413036243552}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.BooleanInput Occ annotation(Placement(transformation(extent = {{-111.10203464894639,-21.102034648946383},{-88.89796535105361,1.1020346489463826}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(TZon,pidFCUHea.u_m) annotation(Line(points = {{-100,90},{-60,90},{-60,50},{-36,50},{-36,63.991919212185465}},color = {0,0,127}));
    connect(TZon,pidFCUCoo.u_m) annotation(Line(points = {{-100,90},{-60,90},{-60,8},{-36,8},{-36,20.28007701521863}},color = {0,0,127}));
    connect(TZonMin,pidFCUHea.u_s) annotation(Line(points = {{-100,72},{-44.008080787814535,72}},color = {0,0,127}));
    connect(TZonMax,pidFCUCoo.u_s) annotation(Line(points = {{-100,28},{-43.71992298478137,28}},color = {0,0,127}));
    connect(ovespeFanHea.y,speFanHea) annotation(Line(points = {{51,54},{110,54}},color = {0,0,127}));
    connect(ovespeFanHea.y,valPosFCUHea) annotation(Line(points = {{51,54},{80.16666666666666,54},{80.16666666666666,-26.444444444444436},{109.33333333333333,-26.444444444444436}},color = {0,0,127}));
    connect(ovespeFanCoo.y,speFanCoo) annotation(Line(points = {{51,-2},{79.5,-2},{79.5,28},{110,28}},color = {0,0,127}));
    connect(ovespeFanCoo.y,valPosFCUCoo) annotation(Line(points = {{51,-2},{79.5,-2},{79.5,-56},{110,-56}},color = {0,0,127}));
    connect(pidFCUCoo.y,ovespeFanCoo.u1) annotation(Line(points = {{-28.923403930617077,28},{28,28},{28,6}},color = {0,0,127}));
    connect(prfEmiCoo,integerToReal.u) annotation(Line(points = {{-100,-80},{-41.11043565077377,-80}},color = {255,127,0}));
    connect(integerToReal.y,ovespeFanCoo.u3) annotation(Line(points = {{-31.31543398679071,-80},{28,-80},{28,-10}},color = {0,0,127}));
    connect(prfEmiHea,integerToReal2.u) annotation(Line(points = {{-100,-40},{-41.11043565077377,-40}},color = {255,127,0}));
    connect(Occ,ovespeFanCoo.u2) annotation(Line(points = {{-100,-10},{-36,-10},{-36,-2},{28,-2}},color = {255,0,255}));
    connect(Occ,ovespeFanHea.u2) annotation(Line(points = {{-100,-10},{10,-10},{10,54},{28,54}},color = {255,0,255}));
    connect(integerToReal2.y,ovespeFanHea.u3) annotation(Line(points = {{-31.31543398679071,-40},{28,-40},{28,46}},color = {0,0,127}));
    connect(pidFCUHea.y,ovespeFanHea.u1) annotation(Line(points = {{-28.659259277836675,72},{28,72},{28,62}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name"),Ellipse(origin={-56,86},extent={{-10,10},{10,-10}}),Ellipse(origin={-16,16},extent={{-10,10},{10,-10}}),Ellipse(origin={24,66},extent={{-10,10},{10,-10}}),Ellipse(origin={64,-14},extent={{-10,10},{10,-10}}),Line(origin={-56,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={-16,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={24,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={64,0},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Rectangle(extent={{-100,100},{100,-100}})}), uses(
        Modelica(version="4.0.0")));
end FcuInternal_ove_Control;
