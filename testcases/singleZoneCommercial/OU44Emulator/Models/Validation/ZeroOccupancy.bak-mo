within OU44Emulator.Models.Validation;
model ZeroOccupancy
  extends BuildingControl;
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-230,114},{-210,134}})));
equation
  connect(firstOrder.u, const.y)
    annotation (Line(points={{-194,124},{-209,124}}, color={0,0,127}));
  annotation (experiment(StopTime=2678400, Interval=3600));
end ZeroOccupancy;
