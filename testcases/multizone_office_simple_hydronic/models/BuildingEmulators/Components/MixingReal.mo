within BuildingEmulators.Components;
model MixingReal
    
    
   extends BuildingEmulators.Components.PartialMixing;
    .Modelica.Blocks.Math.Gain hp_nominal(k = dp_nominal) annotation(Placement(transformation(extent = {{-4.755183555579496,-4.755183555579507},{4.755183555579496,4.755183555579507}},origin = {-10.0,80.0},rotation = -90.0)));
    .Modelica.Blocks.Interfaces.RealInput prfPum annotation(Placement(transformation(extent = {{-11.637361465788274,-11.637361465788274},{11.637361465788274,11.637361465788274}},origin = {-10.0,100.0},rotation = -90.0)));
equation
    connect(hp_nominal.u,prfPum) annotation(Line(points = {{-10.000000000000002,85.7062202666954},{-10.000000000000002,100},{-10,100}},color = {0,0,127}));
    connect(hp_nominal.y,pum.dp_in) annotation(Line(points = {{-9.999999999999998,74.76929808886256},{-9.999999999999998,72}},color = {0,0,127}));
    
end MixingReal;
