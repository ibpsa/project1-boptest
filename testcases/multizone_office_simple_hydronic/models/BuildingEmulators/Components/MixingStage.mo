within BuildingEmulators.Components;
model MixingStage


   extends .BuildingEmulators.Components.PartialMixing(pum(inputType = IDEAS.Fluid.Types.InputType.Stages));
    .Modelica.Blocks.Interfaces.IntegerInput prfPum annotation(Placement(transformation(extent = {{-11.637361465788274,-11.637361465788274},{11.637361465788274,11.637361465788274}},origin = {-10.0,100.0},rotation = -90.0)));
equation
    connect(prfPum,pum.stage) annotation(Line(points = {{-10,100},{-10,72},{-9.999999999999998,72}},color = {255,127,0}));

end MixingStage;
