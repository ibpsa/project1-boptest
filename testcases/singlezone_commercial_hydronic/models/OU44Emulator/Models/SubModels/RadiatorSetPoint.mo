within OU44Emulator.Models.SubModels;
model RadiatorSetPoint
  extends Modelica.Blocks.Icons.Block;
  Buildings.Controls.SetPoints.OccupancySchedule Occupancy_schedule(period=
        604800, occupancy=3600*{3,19,29,43,53,67,77,91,101,115})
    annotation (Placement(transformation(extent={{-20,70},{-4,86}})));
  Modelica.Blocks.Sources.Constant TsetOcc(k=294.15) "temperature setpoint"
    annotation (Placement(transformation(extent={{38,10},{24,24}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{4,-2},{-16,18}})));
  Modelica.Blocks.Sources.Constant TsetUnocc(k=290.15) "temperature setpoint"
    annotation (Placement(transformation(extent={{42,-16},{28,-2}})));
  Modelica.Blocks.Interfaces.RealOutput y1
                                 "Connector of Real output signal"
    annotation (Placement(transformation(extent={{-94,-2},{-114,18}})));
equation
  connect(Occupancy_schedule.occupied,switch1. u2) annotation (Line(points={{-3.2,
          73.2},{14,73.2},{14,8},{6,8}},               color={255,0,255}));
  connect(TsetOcc.y,switch1. u1) annotation (Line(points={{23.3,17},{22,17},{22,
          16},{6,16}},          color={0,0,127}));
  connect(TsetUnocc.y,switch1. u3) annotation (Line(points={{27.3,-9},{8,-9},{8,
          0},{6,0}},                 color={0,0,127}));
  connect(switch1.y, y1)
    annotation (Line(points={{-17,8},{-104,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadiatorSetPoint;
