within BuildingControlEmulator.Subsystems.AirHanUnit.BaseClasses;
model OccCon "Occupied Controller"

  parameter Real start_time;
  parameter Real end_time;

  Modelica.Blocks.Sources.BooleanExpression
                                         booleanExpression(y=(mod(time,86400) > start_time*3600) and (mod(time,86400) < end_time*3600))
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput Occ annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  connect(booleanExpression.y, Occ) annotation (Line(points={{9,0},{120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-42,38},{44,-46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Occ")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end OccCon;
